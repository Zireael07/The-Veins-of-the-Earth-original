-- Underdark
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "engine.class"
require "engine.Actor"
require "engine.Autolevel"
require "engine.interface.ActorTemporaryEffects"
require "engine.interface.ActorLife"
require "engine.interface.ActorProject"
require "engine.interface.ActorLevel"
require "engine.interface.ActorStats"
require "engine.interface.ActorTalents"
require 'engine.interface.ActorInventory'
require "engine.interface.ActorResource"
require "engine.interface.ActorFOV"
require 'engine.interface.ActorQuest'
require "mod.class.interface.Combat"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(engine.Actor,
                      engine.interface.ActorTemporaryEffects,
                      engine.interface.ActorLife,
                      engine.interface.ActorProject,
                      engine.interface.ActorLevel,
                      engine.interface.ActorStats,
                      engine.interface.ActorTalents,
                      engine.interface.ActorInventory,
                      engine.interface.ActorResource,
                      engine.interface.ActorFOV,
                      engine.interface.ActorQuest,
                      mod.class.interface.Combat))

function _M:init(t, no_default)
  -- Define some basic combat stats
  self.combat_armor = 0
  self.combat_def = 10
  self.combat_attack = 0
  self.hit_die = 4

  -- Default melee barehanded damage
  self.combat = { dam = {1,4} }

  engine.Actor.init(self, t, no_default)
  engine.interface.ActorTemporaryEffects.init(self, t)
  engine.interface.ActorLife.init(self, t)
  engine.interface.ActorProject.init(self, t)
  engine.interface.ActorTalents.init(self, t)
  engine.interface.ActorResource.init(self, t)
  engine.interface.ActorStats.init(self, t)
  engine.interface.ActorInventory.init(self, t)
  engine.interface.ActorLevel.init(self, t)
  engine.interface.ActorFOV.init(self, t)

  -- Short-ciruit the engine's initial forced level-up mechanism, which
  -- doesn't work quite the way we want.
  self.start_level = self.level

  -- Charges for spells
  self.charges = {}
  self.max_charges = {}
  self.allocated_charges = {0}

-- Use weapon damage actually
    if not self:getInven("MAINHAND") or not self:getInven("OFFHAND") then return end
   if weapon then dam = weapon.combat.dam
   end
end

function _M:getName(t)
  t = t or {}
  local name = self.name
  if t.indef_art then
    name = (name:match('^[AEIOUaeiou]') and 'an ' or 'a ') .. name
  end
  return name
end

function _M:act()
    if not engine.Actor.act(self) then return end

    self.changed = true

    -- Cooldown talents

    self:cooldownTalents()

    -- Regen resources
    self:regenLife()
    self:regenResources()
    -- Compute timed effects
    self:timedEffects()

    if self:attr("sleep") then self.energy.value = 0 end

    -- Still enough energy to act ?
    if self.energy.value < game.energy_to_act then return false end

    return true
end

function _M:move(x, y, force)
    local moved = false
    local ox, oy = self.x, self.y

    if force or self:enoughEnergy() then
        -- Check for confusion or random movement flag.
        local rand_prob = self.ai_state and self.ai_state.random_move or 0
        local rand_move = self:hasEffect(self.EFF_CONFUSED) or rng.range(1,100) <= rand_prob
        if rand_move and self.x and self.y then
            x, y = self.x + rng.range(-1,1), self.y + rng.range(-1,1)
        end

        moved = engine.Actor.move(self, x, y, force)

        if not force and moved and (self.x ~= ox or self.y ~= oy) and not self.did_energy then
            self:useEnergy()
        end
    end
    self.did_energy = nil

    -- TODO This is where we do auto-search for traps.
    return moved
end

function _M:tooltip()
    return ([[%s%s
        #ff0000#HP: %d (%d%%)
        STR %s DEX %s CON %s 
        WIS %s INT %s CHA %s]]):format(
        self:getDisplayString(),
        self.name,
        self.life, self.life * 100 / self.max_life,
        self:getStat('str'),
        self:getStat('dex'),
        self:getStat('con'),
        self:getStat('int'),
        self:getStat('wis'),
        self:getStat('cha'),
        self.desc or ""
    )
end

function _M:onTakeHit(value, src)

  --if a sleeping target is hit, it will wake up
    if self:hasEffect(self.EFF_SLEEP) then
        self:removeEffect(self.EFF_SLEEP)
        game.logSeen(self, "%s wakes up from being hit!", self.name)
    end
    return value
end

function _M:die(src)
    engine.interface.ActorLife.die(self, src)

    -- Gives the killer some exp for the kill
    if src and src.gainExp then
        src:gainExp(self:worthExp(src))
    end

  -- Drop stuff
    local dropx, dropy = self.x, self.y
    if game.level.map:checkAllEntities(dropx, dropy, 'block_move') then
        -- If our grid isn't suitable, find one nearby.
        local cands = {}
        for cx = self.x - 3, self.x + 3 do
            for cy = self.y - 3, self.y + 3 do
                local d = core.fov.distance(self.x, self.y, cx, cy)
                if game.level.map:isBound(cx, cy) and d <= 3 and not game.level.map:checkAllEntities(cx, cy, 'block_move') then
                cands[#cands+1] = {cx, cy, d}
                end
            end
        end
        if #cands > 0 then
            -- Pick nearby spots with higher probability.
            -- [Does this even work, though?]
            table.sort(cands, function(a, b) return a[3] < b[3] end)
            local cand = rng.table(cands)
            dropx, dropy = cand[1], cand[2]
        end
    end

    local invens = {}
    for id, inven in pairs(self.inven) do
        invens[#invens+1] = inven
    end
    -- [Not sure why we're sorting these; I'm following T4's Actor:die()]
    local f = function(a, b) return a.id ~= 1 and (b.id == 1 or a.id < b.id) end
    table.sort(invens, f)
    for id, inven in pairs(invens) do
        for i = #inven, 1, -1 do
            local o = inven[i]
            o.dropped_by = o.dropped_by or self.name
            self:removeObject(inven, i, true)
            game.level.map:addObject(dropx, dropy, o)
        end
    end
    self.inven = {}
    if self ~= game.player and dropx == game.player.x and dropy == game.player.y then
        game.log('You feel something roll beneath your feet.')
    end

    return true
end

function _M:levelupMsg()
  -- Subclasses handle the actual mechanics of leveling up; here we just
  -- print the message and add the flyer.
    local stale = false
    if self.level_hiwater then
        stale = self.level_hiwater >= self.level
        self.level_hiwater = math.max(self.level_hiwater, self.level)
    end

    game.logSeen(self, "#00FFFF#%s %s level %d.#LAST#", self.name, stale and 'regains' or 'gains', self.level)
    if self.x and self.y and game.level.map.seens(self.x, self.y) then
        local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
        game.flyers:add(sx, sy, 80, 0.5, -2, 'LEVEL UP!', stale and {255, 0, 255} or {0, 255, 255})
    end

    -- Return true if this is the first time we've hit this level.
    return not stale
end

--- Notifies a change of stat value
function _M:onStatChange(stat, v)
    if stat == self.STAT_CON then
        self.max_life = self.max_life + 2
    end
end

function _M:attack(target)
    self:bumpInto(target)
end

function _M:adjGold(delta)
    self.gold = math.max(0, self.gold + delta)
    self.changed = true
end

function _M:getArmor()
    local ac = self.ac
    local dex_bonus = (self.getDex()-10)/2
  
    if self:hasEffect(self.EFF_BLIND) then 
        ac = ac - 2
        dex_bonus = math.min(dex_bonus, 0) --negate dex bonus, if any
    end

    ac = self.ac + dex_bonus 
  
    return ac
end

--- Called before a talent is used
-- Check the actor can cast it
-- @param ab the talent (not the id, the table)
-- @return true to continue, false to stop
function _M:preUseTalent(ab, silent)
    if ab.is_spell and (ab.charges or 0 <= 0) then return false end

    if not self:enoughEnergy() then print("fail energy") return false end

    if ab.mode == "sustained" then
        if ab.sustain_power and self.max_power < ab.sustain_power and not self:isTalentActive(ab.id) then
            game.logPlayer(self, "You do not have enough power to activate %s.", ab.name)
            return false
        end
    else
        if ab.power and self:getPower() < ab.power then
            game.logPlayer(self, "You do not have enough power to cast %s.", ab.name)
            return false
        end
    end

    if not silent then
    -- Allow for silent talents
        if ab.message ~= nil then
            if ab.message then
                game.logSeen(self, "%s", self:useTalentMessage(ab))
            end
            elseif ab.mode == "sustained" and not self:isTalentActive(ab.id) then
                game.logSeen(self, "%s activates %s.", self.name:capitalize(), ab.name)
            elseif ab.mode == "sustained" and self:isTalentActive(ab.id) then
                game.logSeen(self, "%s deactivates %s.", self.name:capitalize(), ab.name)
            else
                game.logSeen(self, "%s uses %s.", self.name:capitalize(), ab.name)
        end
    end
    return true
end

--- Called before a talent is used
-- Check if it must use a turn, mana, stamina, ...
-- @param ab the talent (not the id, the table)
-- @param ret the return of the talent action
-- @return true to continue, false to stop
function _M:postUseTalent(ab, ret)
    if not ret then return end

    --remove charge
    if ab.charges then ab.charges = ab.charges -1 end

    self:useEnergy()

    if ab.mode == "sustained" then
        if not self:isTalentActive(ab.id) then
            if ab.sustain_power then
                self.max_power = self.max_power - ab.sustain_power
            end
        else
            if ab.sustain_power then
                self.max_power = self.max_power + ab.sustain_power
            end
        end
    else
        if ab.power then
            self:incPower(-ab.power)
        end
    end

    return true
end

--- Return the full description of a talent
-- You may overload it to add more data (like power usage, ...)
function _M:getTalentFullDescription(t)
    local d = {}

    if t.mode == "passive" then d[#d+1] = "#6fff83#Use mode: #00FF00#Passive"
    elseif t.mode == "sustained" then d[#d+1] = "#6fff83#Use mode: #00FF00#Sustained"
    else d[#d+1] = "#6fff83#Use mode: #00FF00#Activated"
    end

    if t.power or t.sustain_power then d[#d+1] = "#6fff83#Power cost: #7fffd4#"..(t.power or t.sustain_power) end
    if self:getTalentRange(t) > 1 then d[#d+1] = "#6fff83#Range: #FFFFFF#"..self:getTalentRange(t)
    else d[#d+1] = "#6fff83#Range: #FFFFFF#melee/personal"
    end
    if t.cooldown then d[#d+1] = "#6fff83#Cooldown: #FFFFFF#"..t.cooldown end

    return table.concat(d, "\n").."\n#6fff83#Description: #FFFFFF#"..t.info(self, t)
end

--- How much experience is this actor worth
-- @param target to whom is the exp rewarded
-- @return the experience rewarded
function _M:worthExp(target)
  -- TODO Don't get experience from killing friendlies.
    return (self.exp_worth)
end

--- Can the actor see the target actor
-- This does not check LOS or such, only the actual ability to see it.<br/>
-- Check for telepathy, invisibility, stealth, ...
function _M:canSee(actor, def, def_pct)
    if not actor then return false, 0 end

    -- Newsflash: blind people can't see!
    if self:hasEffect(self.EFF_BLIND) then return false,100 end --Like this, the actor actually knows where its target is. Its just bad at hitting

    -- Check for stealth. Checks against the target cunning and level
    if actor:attr("stealth") and actor ~= self then
        local def = self.level / 2 + self:getCun(25)
        local hit, chance = self:checkHit(def, actor:attr("stealth") + (actor:attr("inc_stealth") or 0), 0, 100)
        if not hit then
            return false, chance
        end
    end

    if def ~= nil then
        return def, def_pct
    else
        return true, 100
    end
end

--- Is the target concealed for us?
-- Returns false if it isn't, or a number (50%/20% concealment) if it is
function _M:isConcealed(actor)
    if self:hasEffect(self.EFF_BLIND) then return 50 end
    return false
end

--- Can the target be applied some effects
-- @param what a string describing what is being tried
function _M:canBe(what)
    if what == "poison" and rng.percent(100 * (self:attr("poison_immune") or 0)) then return false end
    if what == "cut" and rng.percent(100 * (self:attr("cut_immune") or 0)) then return false end
    if what == "confusion" and rng.percent(100 * (self:attr("confusion_immune") or 0)) then return false end
    if what == "blind" and rng.percent(100 * (self:attr("blind_immune") or 0)) then return false end
    if what == "stun" and rng.percent(100 * (self:attr("stun_immune") or 0)) then return false end
    if what == "fear" and rng.percent(100 * (self:attr("fear_immune") or 0)) then return false end
    if what == "knockback" and rng.percent(100 * (self:attr("knockback_immune") or 0)) then return false end
    if what == "instakill" and rng.percent(100 * (self:attr("instakill_immune") or 0)) then return false end
    return true
end

function _M:reflexSave(dc)
    local roll = rng.dice(1,20)
    local save = math.floor(self.level / 4) + (self:attr("reflex_save") or 0) + self:getStat("dex")
    if not roll == 1 and roll == 20 or roll + save > dc then
        return true
    else
        return false
    end
end

function _M:fortitudeSave(dc)
    local roll = rng.dice(1,20)
    local save = math.floor(self.level / 4) + (self:attr("fortitude_save") or 0) + self:getStat("end")
    if not roll == 1 and roll == 20 or roll + save > dc then
        return true
    else
        return false
    end
end

function _M:willSave(dc)
    local roll = rng.dice(1,20)
    local save = math.floor(self.level / 4) + (self:attr("will_save") or 0) + self:getStat("wis")
    if not roll == 1 and roll == 20 or roll + save > dc then
        return true
    else
        return false
    end
end


--- The max charge worth you can have in a given spell level
function _M:getMaxMaxCharges()
    local t = {
        math.min(8, 3 + self.level),
    }
    return t
end

function _M:getMaxCharges(tid)
    return self.max_charges[tid] or 0
end

function _M:getCharges(tid)
    return self.charges[tid] or 0
end

function _M:setMaxCharges(tid, v)
    self.max_charges[tid] = v
end

function _M:incCharges(tid, v)
    self.charges[tid] = (self.charges[tid] or 0) + 1 
end

--- Increases (regenerates) the charges of all spells with charges
-- Unfinished
function _M:incCharges(tid)
    for _, tid in self.talents_def do
        if self:getCharges(tid) < self:getMaxCharges(tid) then
            local t = self.talents[tid]
            t.charges = self:getMaxCharges(tid)
        end
    end
end

function _M:getAllocatedCharges()
    return self.allocated_charges
end

--Leveling up
function _M:levelup()
    engine.interface.ActorLevel.levelup(self)
    engine.interface.ActorTalents.resolveLevelTalents(self)

--Gain hp, BAB, saves (generic)
    self.max_life = self.max_life + self.hit_die
    self.combat_attack = self.combat_attack or 0 + 1
    self.fortitude_save = self.fortitude_save or 0 + 1
    self.reflex_save = self.reflex_save or 0 + 1
    self.will_save = self.will_save or 0 + 1

-- Heal up on new level
--  self:resetToFull()

  -- Auto levelup ?
    if self.autolevel then
        engine.Autolevel:autoLevel(self)
    end

    if self == game.player then game:onTickEnd(function() game:playSound("actions/levelup") end, "levelupsound") end
    end

--Encumbrance
function _M:getMaxEncumbrance()
    local add = 0
    return math.floor(40 + self:getStr() * 1.8 + (self.max_encumber or 0) + add)
end

function _M:getEncumbrance()
    local enc = 0

    local fct = function(so) enc = enc + so.encumber end

  -- Compute encumbrance
    for inven_id, inven in pairs(self.inven) do
        for item, o in ipairs(inven) do
            if not o.__transmo and not o.__transmo_pre then
                o:forAllStack(fct)
            end
        end
    end
--  print("Total encumbrance", enc)
    return math.floor(enc)
end

function _M:checkEncumbrance()
  -- Compute encumbrance
    local enc, max = self:getEncumbrance(), self:getMaxEncumbrance()

  -- We are pinned to the ground if we carry too much
    if not self.encumbered and enc > max then
        game.logPlayer(self, "#FF0000#You carry too much--you are encumbered!")
        game.logPlayer(self, "#FF0000#Drop some of your items.")
        self.encumbered = self:addTemporaryValue("never_move", 1)

    if self.x and self.y then
        local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
        game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, rng.float(-2.5, -1.5), "+ENCUMBERED!", {255,0,0}, true)
    end
    elseif self.encumbered and enc <= max then
        self:removeTemporaryValue("never_move", self.encumbered)
        self.encumbered = nil
        game.logPlayer(self, "#00FF00#You are no longer encumbered.")

        if self.x and self.y then
            local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
            game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, rng.float(-2.5, -1.5), "-ENCUMBERED!", {255,0,0}, true)
        end
    end
end


function _M:computeGlobalSpeed()
    if self.speed < 0 then
        self.global_speed = 1/(1 - self.speed/10)
    elseif self.speed <= 26 then
        self.global_speed = 1 + self.speed/10
    elseif self.speed <= 34 then
    -- Everything from here down is an asymptotic approach to 500% speed,
    -- roughly mimicking ToME2's tables.c:extract_energy[] table.  Split
    -- out into cases, as there was no obvious function that suitably
    -- reproduced the table; this only gets called by the resolver, though
    -- (and when actor speed actually changes), so this shouldn't be too
    -- expensive.
        self.global_speed = 3.6 + (self.speed - 26)/20
    elseif self.speed <= 46 then
        self.global_speed = 4 + (self.speed - 34)/30
    elseif self.speed <= 50 then
        self.global_speed = 4.4 + (self.speed - 46)/40
    elseif self.speed <= 70 then
        self.global_speed = 4.5 + (self.speed - 50)/50
    else
        self.global_speed = 5 - 1/(self.speed - 60)
    end
end

local super_added = _M.added
function _M:added()
    super_added(self)
    if self.on_add then self:on_add() end
end

function _M:has(flag)
    return self.flags and self.flags[flag] or self:hasEffect(self['EFF_'..flag])
end
