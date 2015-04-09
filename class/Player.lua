-- Veins of the Earth
-- Zireael 2013-2014
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
require "mod.class.Actor"
require "engine.interface.PlayerRest"
require "engine.interface.PlayerRun"
require "engine.interface.PlayerMouse"
require "engine.interface.PlayerHotkeys"
require "mod.class.interface.PlayerExplore"
require "mod.class.interface.PartyDeath"
local Map = require "engine.Map"
local Dialog = require "engine.Dialog"
local DeathDialog = require "mod.dialogs.DeathDialog"
local Astar = require"engine.Astar"
local DirectPath = require "engine.DirectPath"
local World = require "mod.class.World"
local PlayerLore = require "mod.class.interface.PlayerLore"
--local NameGenerator = require "engine.NameGenerator"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(mod.class.Actor,
					  engine.interface.PlayerRest,
					  engine.interface.PlayerRun,
					  engine.interface.PlayerMouse,
					  engine.interface.PlayerHotkeys,
            mod.class.interface.PlayerExplore,
            mod.class.interface.PartyDeath,
            PlayerLore))

local exp_chart = function(level)
if level==1 then return 1000
else return 500*level*(level+1)/2 end
end

function _M:init(t, no_default)
--ASCII stuff
  t.display=t.display or '@'
  t.color_r=t.color_r or 230
  t.color_g=t.color_g or 230
  t.color_b=t.color_b or 230

  --Moddable tiles stuff
  --image = "tiles/player.png"
  moddable_tile = "default"

  t.player = true
  t.type = t.type or "humanoid"
  t.subtype = t.subtype or "player"
  t.faction = t.faction or "players"

  mod.class.Actor.init(self, t, no_default)
  engine.interface.PlayerHotkeys.init(self, t)
  PlayerLore.init(self, t)

  self.lite = 0 --stealth test
  self.sight = 5
  self.ecl = 1


  self.descriptor = self.descriptor or {}
  self.died_times = self.died_times or {}
  self.race = self.descriptor.race
  self.classes = self.classes or {}
  self.max_level = 50
  self.max_exp = self.exp
  self.level_hiwater = self.level
  self.speed = 0
  self.move_others = true
  self.class_points = 1 -- Spent on leveling classes, its 1 because it "spends" one when you birth

  --Timers :D
  self.nutrition = 3000
  self.lite_counter = 5000
  self.pseudo_id_counter = 10
  self.id_counter = 50
  self.god_pulse_counter = 35
  self.god_anger_counter = 35

  self.weapon_type = {}
  self.favored_enemy = {}
  self.last_class = {}
  self.all_kills = self.all_kills or {}
  self.all_seen = self.all_seen or {}
  self.special_known = self.special_known or {}

  --Divine stuff
  self.favor = 0
  self.max_favor = 0
  self.anger = 0
  self.sacrifice_value = self.sacrifice_value or {}
  self.max_sacrifice_value = self.max_sacrifice_value or {}

  --Exercise stuff
  self.train_str = 0
  self.train_dex = 0
  self.train_con = 0
  self.train_int = 0
  self.train_wis = 0
  self.train_cha = 0
  self.train_luc = 0

  self.stat_increased = self.stat_increased or {}
  self.number_increased = self.number_increased or {}

  --timestamp for saved chars
  self.time = os.time()
end

function _M:act()
  if not mod.class.Actor.act(self) then return end

  -- Funky shader things !
  self:updateMainShader()

  self.old_life = self.life

  self:spottedMonsterXP()

  self:checkEncumbrance()

  self:playerCounters()


  -- Resting ? Running ? Otherwise pause
  if not self:restStep() and not self:runStep() and self.player then
    game.paused = true
  end
end

function _M:playerCounters()

--Count down lite turns
  local lite = (self:getInven("LITE") and self:getInven("LITE")[1])

  if lite and not lite.name == "everlasting torch" and self.lite_counter > 0 then --and not lite.name == "a lantern" then
    self.lite_counter = self.lite_counter - 1
  end

  if lite and self.lite_counter == 0 then
    self:removeObject(self:getInven("LITE")[1])
    --[[Add burnt out torch
    self:addObject]]
  end

  --Count down nutrition
  local nutrition = self.nutrition

  if not self.resting then
    if self:knowTalent(self.T_FASTING) then
      self.nutrition = self.nutrition - 0.33
    else
    self.nutrition = self.nutrition - 1
    end
  end

  if self.resting then
    --1/5th normal rate for elves
    if self:hasDescriptor{race="Drow"} or self:hasDescriptor{race="Elf"} then
      if self:knowTalent(self.T_FASTING) then
        self.nutrition = self.nutrition - 0.06
      else
        self.nutrition = self.nutrition - 0.2
      end
    else
      if self:knowTalent(self.T_FASTING) then
      self.nutrition = self.nutrition - 0.16
      else
      --Halve hunger rate when sleeping
      self.nutrition = self.nutrition - 0.5
      end
    end
  end

 --Cap nutrition
 if self.nutrition == 1 then self.nutrition = 1 end

   --Resilient feat
  if self:knowTalent(self.T_RESILLIENT) and not self.resting then

    local conbonus = self:getConMod()
    if self.life <= self.max_life - ((3 + conbonus)*0.05) then

      self.resilient_counter = 3
      self.resilient_counter = self.resilient_counter - 1

      if self.resilient_counter == 0 then
        self.life = self.life + 1
      end
    end

  end

--Maybe do it every five turns only?
--	if game.turn % 5 == 0 then
	--ID counters
	 local inven = game.player:getInven("INVEN")

	 --Don't count down ID when resting
	 if not self.resting then
	 self.id_counter = self.id_counter - 1
	 self.pseudo_id_counter = self.pseudo_id_counter - 1
	  end

  --Deity counters
  if self.descriptor.deity ~= "None" and not self.resting then
    self.god_pulse_counter = self.god_pulse_counter - 1

    if self.anger > 0 then
    self.god_anger_counter = self.god_anger_counter - 1
    end

  end

  --Random stuff
  --50% chance because Idk
  if rng.range(1,30) <= 15 then
    --Exercise CON because hungry
    if self.nutrition < 2500 then
      if self:knowTalent(self.T_FASTING) then
        self:exerciseStat("con", rng.dice(1,4), "con_hunger", 45)
      else
        if rng.range(1,4) < 2 then self:exerciseStat("con", 1, "con_hunger", 30) end
      end
    end

    --Exercise STR because load
    if self:hasEffect(self.EFF_HEAVY_LOAD) then
      self:exerciseStat("str", 2, "str_burden", 40)
    end

    --Exercise STR & CON because heavy armor
    --if wearing heavy armor then
    --self:exerciseStat("str", rng.dice(1,3), "str_armor", 50)
    --self:exerciseStat("con", 1, "con_armor", 35)
    --abuse DEX by 1

    --Exercise LUC by being deep in dungeon
    --Inc compares depth to our CR
  	end
--	end

	--Stuff every turn
	if self.pseudo_id_counter == 0 then --and inven > 0 then
	self:pseudoID()
	self:setCountID()
	end

	if self.id_counter == 0 then
	self:autoID()
	self.id_counter = 50
	end


	if self.god_pulse_counter == 0 then
      self:godPulse()
      self:setGodPulse()
    end

    if self.god_anger_counter == 0 then
      self:godAnger()
    end

end



--Birth stuff
function _M:onBirth()
  --Finish the character
  self:levelClass(self.descriptor.class)
  self:giveStartingEQ()

  self:giveStartingSpells()

  savefile_pipe:push(game.player.name, "entity", game.player, "engine.CharacterVaultSave")

  -- HACK: This forces PlayerDisplay and HotkeysDisplay to update after birth descriptors are finished.
  game.player.changed = true
  self:resetToFull()
  self:setCountID()
  self:setGodPulse()

--  game:registerDialog(require"mod.dialogs.Help".new(self.player))
end

function _M:onPremadeBirth()
    --Fixes for UI issues
 --   game.player = self
 --   Map:setViewerActor(self)
    game.uiset.hotkeys_display.actor = self
    game.uiset.npcs_display.actor = self
--    game.uiset:setupMinimap(game.level)

  --Add the basic talents
  self:learnTalent(self.T_SHOOT, true)
  self:learnTalent(self.T_POLEARM, true)
  self:learnTalent(self.T_STEALTH, true)

--  self:giveStartingSpells()

  -- HACK: This forces PlayerDisplay and HotkeysDisplay to update after birth descriptors are finished.
  game.player.changed = true
  self:resetToFull()
  self:setCountID()
  self:setGodPulse()
--  game:registerDialog(require"mod.dialogs.Help".new(self.player))
end

--From Qi Daozei
--- Sorts hotkeys in the order in which their corresponding talents are defined.
--- By default, as far as I can tell, they're sorted effectively randomly, in
--- whatever order the birth descriptors' talent hash tables happen to list them.
function _M:sortHotkeysByTalent()
    -- Make a lookup of talent IDs giving the order in which they're defined.
    local talent_order = {}
    local n = 1
    for i, tt in ipairs(Talents.talents_types_def) do
        for j, t in ipairs(tt.talents) do
            talent_order[t.id] = n
            n = n + 1
        end
    end

    -- Sort talent hotkeys by definition order, using a selection sort.
    for i = 1, 12 * self.nb_hotkey_pages do
        if self.hotkey[i] and self.hotkey[i][1] == "talent" then
            local min_at, min_value = i, talent_order[self.hotkey[i][2]]
            for j = i + 1, 12 * self.nb_hotkey_pages do
                if self.hotkey[j] and self.hotkey[j][1] == "talent" and talent_order[self.hotkey[j][2]] < min_value then
                    min_at, min_value = j, talent_order[self.hotkey[j][2]]
                end
            end
            if min_at ~= i then
                self.hotkey[i], self.hotkey[min_at] = self.hotkey[min_at], self.hotkey[i]
            end
        end
    end
end


function _M:randomPerk()
local d = rng.dice(1,6)
  if d == 1 then self:randomFeat()
  elseif d == 2 then self:randomFeat()
  elseif d == 3 then self:randomFeat()
  elseif d == 4 then self:randomSpell()
  elseif d == 5 then self:randomItem()
  else self:randomItem() end
end

function _M:equipAllItems()
  local inven = game.player:getInven("INVEN")
    for i = #inven, 1, -1 do
      local o = inven[i]
      if o.slot ~= "INVEN" then
      self:removeObject(inven, o)
      self:wearObject(o, false, false)
      self:removeObject(inven, o)
      end
    end
    self:sortInven()
end

function _M:giveStartingSpells()
  if self.descriptor.class == "Cleric" then --or self.descriptor.class == "Shaman" then
    self:setCharges(self.T_CURE_LIGHT_WOUNDS, 2)

  end

  if self.descriptor.class == "Wizard" then --or self.descriptor.class == "Sorcerer" then
    self:setCharges(self.T_MAGIC_MISSILE, 2)
    self:setCharges(self.T_MAGE_ARMOR, 1)
  end

  if self.descriptor.class == "Bard" then
    self:setCharges(self.T_MAGIC_MISSILE, 2)
  end

end

function _M:getExpChart(level)
  if not level or level < 1 then return 0 end
  local ecl = self:attr("ecl")
  if self:attr("ecl") > 1 then return exp_chart(level) + 500*ecl*(ecl+1)/2 end
  return exp_chart(level)
end

function _M:move(x, y, force)
  local moved = mod.class.Actor.move(self, x, y, force)
  if moved then
    game.level.map:moveViewSurround(self.x, self.y, 8, 8)

    game.level.map.attrs(self.x, self.y, "walked", true)
    self:describeFloor(self.x, self.y)
  end

  -- Remember not to describe this grid again.
  self.old_x, self.old_y = self.x, self.y

  return moved
end

function _M:tooltip()
 local ts = tstring{}

  ts:add({"color", "WHITE"}, ("%s"):format(self:getDisplayString()), true)

  ts:add(self.name, {"color", "WHITE"}, true)

  if self.life < 0 then ts:add({"color", 255, 0, 0}, "HP: unknown", {"color", "WHITE"}, true)
  else ts:add({"color", 255, 0, 0}, ("HP: %d (%d%%)"):format(self.life, self.life * 100 / self.max_life), {"color", "WHITE"}, true)
  end

  ts:add({"color", "WHITE"}, ("STR %s "):format(self:colorStats('str'))) ts:add({"color", "WHITE"}, ("DEX %s "):format(self:colorStats('dex'))) ts:add({"color", "WHITE"}, ("CON %s"):format(self:colorStats('con')), true)

  ts:add({"color", "WHITE"}, ("INT %s "):format(self:colorStats('int'))) ts:add({"color", "WHITE"}, ("WIS %s "):format(self:colorStats('wis'))) ts:add({"color", "WHITE"}, ("CHA %s"):format(self:colorStats('cha')), true)

  --Debugging speed stuff
--[[  ts:add(("Game turn: %s"):format(game.turn/10), true)

  ts:add(("Global speed: %d"):format(self.global_speed or 1), true)

  ts:add(("Energy remaining: %d"):format(self.energy_value or 1), true)

  ts:add(("Movement speed: %d"):format(self.movement_speed or 1), true)

  ts:add(("Movement speed bonus: %0.1f"):format(self.movement_speed_bonus or 0), true)]]

  return ts
end

--Character sheet stuff specific to player
function _M:sheetColorStats(stat)
--Basic value without increases
local basestat = self:getStat(stat, nil, nil, true)

  --Case 1: stat temporarily increased by spells
  if self:attr("stat_increase_"..stat) then return "#LIGHT_GREEN#"..self:getStat(stat).."#LAST#"
  --Case 2: stat temporarily decreased (poisons etc.)
  elseif self:attr("stat_decrease_"..stat) then return "#RED#"..self:getStat(stat).."#LAST#"
  --Case 3: magic items permanent bonus
  elseif self:getStat(stat) > basestat then return "#DARK_GREEN#"..self:getStat(stat).."#LAST#"
  else return "#YELLOW#"..self:getStat(stat).."#LAST#" end

end

function _M:describeFloor(x, y)
  if self.old_x == self.x and self.old_y == self.y then return end

  -- Auto-pickup stuff from floor.
  local i = 1
  local obj = game.level.map:getObject(x, y, i)
  while obj do
    if obj.auto_pickup and self:pickupFloor(i, true) then
      -- Nothing to do.
    else
      i = i + 1
    end
    obj = game.level.map:getObject(x, y, i)
  end

  -- i is now one higher than the number of objects on the floor.
  -- TODO Prompt to pickup, probably controlled by a setting.
  if i == 2 then
    game.log('On floor:  %s', game.level.map:getObject(x, y, 1):getName())
  elseif i > 2 then
    game.log('There are %d objects here.', i - 1)
  end
end


--- Funky shader stuff
function _M:updateMainShader()
  if game.fbo_shader then
  -- Set shader HP warning
    if self.life ~= self.old_life then
      if self.life < (self.max_life*0.2) then game.fbo_shader:setUniform("hp_warning", 1 - (self.life / self.max_life))
      else game.fbo_shader:setUniform("hp_warning", 0) end
    end


    -- Colorize shader
 --   if self.life < self.max_life / 2 then game.fbo_shader:setUniform("colorize", {0.9, 0.2, 0.2, 0.3})
    if self:attr("stealth") and self:attr("stealth") > 0 then game.fbo_shader:setUniform("colorize", {0.9,0.9,0.9,0.6})
    elseif self:attr("invisible") and self:attr("invisible") > 0 then game.fbo_shader:setUniform("colorize", {0.3,0.4,0.9,0.8})
    else game.fbo_shader:setUniform("colorize", {0,0,0,0}) -- Disable
    end

  end
end


-- Precompute FOV form, for speed
local fovdist = {}
for i = 0, 30 * 30 do
  fovdist[i] = math.max((20 - math.sqrt(i)) / 14, 0.6)
end
local wild_fovdist = {}
for i = 0, 10 * 10 do
	wild_fovdist[i] = math.max((5 - math.sqrt(i)) / 1.4, 0.6)
end

function _M:playerFOV()
  -- Clean FOV before computing it
  game.level.map:cleanFOV()

-- Do wilderness stuff, nothing else
if game.zone.worldmap then
	self:computeFOV(game.zone.worldmap_see_radius, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyLite(x, y, wild_fovdist[sqdist]) end, true, true, true)
	return
end

--[[  -- Compute ESP FOV, using cache
  if (self.esp_all and self.esp_all > 0) or next(self.esp) then
    self:computeFOV(self.esp_range or 10, "block_esp", function(x, y) game.level.map:applyESP(x, y, 0.6) end, true, true, true)
  end]]

  -- Handle detect spells, a simple FOV, using cache. Note that this means some terrain features can be made to block sensing
  if self:attr("detect_range") then
    self:computeFOV(self:attr("detect_range"), "block_sense", function(x, y)
      local ok = false
      if self:attr("detect_actor") and game.level.map(x, y, game.level.map.ACTOR) then ok = true end
      if self:attr("detect_object") and game.level.map(x, y, game.level.map.OBJECT) then ok = true end
      if self:attr("detect_trap") and game.level.map(x, y, game.level.map.TRAP) then
        game.level.map(x, y, game.level.map.TRAP):setKnown(self, true)
        game.level.map:updateMap(x, y)
        ok = true
      end

      if ok then
        if self.detect_function then self.detect_function(self, x, y) end
        game.level.map.seens(x, y, 0.6)
      end
    end, true, true, true)
  end

--if not self:attr("blind") then
  --normal stuff
  -- Apply lite from NPCs
  local uid, e = next(game.level.entities)
  while uid do
    if e ~= self and e.lite and e.lite > 0 and e.computeFOV then
      e:computeFOV(e.lite, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyExtraLite(x, y, fovdist[sqdist]) end, true, true)
    end
    uid, e = next(game.level.entities, uid)
  end

  -- Calculate our own FOV
  self:computeFOV(self.lite, "block_sight", function(x, y, dx, dy, sqdist)
      game.level.map:applyLite(x, y)
      game.level.map.remembers(x, y, true) -- Remember the tile
    end, true, true, true)

  --If our darkvision is better than our lite, check it.
  if (self:attr("infravision") or 0) > self.lite then
    self:computeFOV(self:attr("infravision"), "block_sight", function(x, y, dx, dy, sqdist)
      if not game.level.map.seens(x, y) then
        game.level.map.seens(x, y, 0.75) -- If we only see due to darkvision, it looks dark
      end
      game.level.map.remembers(x, y, true)
    end, true, true, true)
  end

  --else (so that npcs may still target us while blind)
--[[  -- Compute both the normal and the lite FOV, using cache
  self:computeFOV(self.sight or 10, "block_sight", function(x, y, dx, dy, sqdist)
    game.level.map:apply(x, y, fovdist[sqdist])
  end, true, false, true)]]

end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src)
  self:runStop("taken damage")
  self:restStop("taken damage")
  local ret = mod.class.Actor.onTakeHit(self, value, src, death_note)
  if self.life < self.max_life * 0.3 then
    local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
    game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, "LOW HEALTH!", {255,0,0}, true)
  end
  return ret
end

--From ToME (stop resting on nasty stuff)
function _M:on_set_temporary_effect(eff_id, e, p)
	local ret = mod.class.Actor.on_set_temporary_effect(self, eff_id, e, p)

	if e.status == "detrimental" and not e.no_stop_resting and p.dur > 0 then
		self:runStop("detrimental status effect")
		self:restStop("detrimental status effect")
	end

	return ret
end

function _M:die(src, death_note)
  if self.runStop then self:runStop("died") end
  if self.restStop then self:restStop("died") end

  if self.game_ender then

  mod.class.interface.ActorLife.die(self, src, death_note)
--engine.interface.ActorLife.die(self, src)

  game.paused = true
  self.energy.value = game.energy_to_act
  game:registerDialog(DeathDialog.new(self))

--  self:onPartyDeath(src, death_note)

    --Mark depth for bones
    World:boneLevel(game.level.level)

    --Taken from onPartyDeath
    -- Die
    death_note = death_note or {}

    src = src or {name="unknown"}
    game.player.killedBy = src
    game.player.died_times[#game.player.died_times+1] = {name=src.name, level=game.player.level, turn=game.turn}

    local death_mean = nil
    if death_note and death_note.damtype then
      local dt = DamageType:get(death_note.damtype)
      if dt and dt.death_message then death_mean = rng.table(dt.death_message) end
    end

    local top_killer = nil

    local msg
    if not death_note.special_death_msg then
      msg = "%s the level %d %s %s was %s to death by %s%s%s on level %s of %s."
      local srcname = src.unique and src.name or src.name:a_an()
      local killermsg = (src.killer_message and " "..src.killer_message or ""):gsub("#sex#", game.player.female and "her" or "him")
      if src.name == game.player.name then
        srcname = game.player.female and "herself" or "himself"
        killermsg = rng.table{
          " (the fool)",
          " in an act of extreme incompetence",
          " out of supreme humility",
          ", by accident of course,",
          " in some sort of fetish experiment gone wrong",
          ", providing a free meal to the wildlife",
          " (how embarrassing)",
        }
      end
      msg = msg:format(
        game.player.name, game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.class:lower(),
        death_mean or "battered",
        srcname,
        src.name == top_killer and " (yet again)" or "",
        killermsg,
        game.level.level, game.zone.name
      )
    else
      msg = "%s the level %d %s %s %s on level %s of %s."
      msg = msg:format(
        game.player.name, game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.class:lower(),
        death_note.special_death_msg,
        game.level.level, game.zone.name
      )
    end

    game.log("#{bold}#"..msg.."#{normal}#")

--  return self:onPartyDeath(src, death_note) end

  end
--[[else
    mod.class.Actor.die(self, src)
  end]]
end


function _M:setName(name)
  self.name = name
  game.save_name = name
end


--- Tries to get a target from the user
function _M:getTarget(typ)
  return game:targetGetForPlayer(typ)
end

--- Sets the current target
function _M:setTarget(target)
  return game:targetSetForPlayer(target)
end

local function spotHostiles(self)
  local seen = false
  -- Check for visible monsters, only see LOS actors, so telepathy wont prevent resting
  core.fov.calc_circle(self.x, self.y, game.level.map.w, game.level.map.h, 20, function(_, x, y) return game.level.map:opaque(x, y) end, function(_, x, y)
  local actor = game.level.map(x, y, game.level.map.ACTOR)
  if actor and self:reactionToward(actor) < 0 and self:canSee(actor) and game.level.map.seens(x, y) then seen = true end
end, nil)
return seen
end

function _M:onChat()
	self:runStop("chat started")
	self:restStop("chat started")
end

--- Can we continue resting ?
-- We can rest if no hostiles are in sight, and if we need life/mana/stamina (and their regen rates allows them to fully regen)
function _M:restCheck()
  --Implemented Light Sleeper feat; EVIL!
  if self:knowTalent(self.T_LIGHT_SLEEPER) and spotHostiles(self) then return false, "hostile spotted"
    elseif rng.percent(50) and spotHostiles(self) then return false, "hostile spotted" end


  	--Start healing after having rested for 20 turns
	if self.resting.cnt > 20 then
		--regen spell points
	    local regen = 1
	    self.mana = math.min(self.max_mana, self.mana + regen)



	end

	--Only do the stuff once
  	if self.resting.cnt == 21 then

		--normal healing
		--use Wis instead of Con if have Mind over Body feat
		local con = self:getCon()
		local heal = ((self.level +3)*con)/5

		--Heal skill
		if (self.skill_heal or 0) > 0 then
	 		heal = ((self.level + self.skill_heal +3)*con)/5
		end

		self.life = math.min(self.max_life, self.life + heal)

		--heal one wound
		if self.wounds < self.max_wounds then
			self.wounds = self.wounds + 1
		end

    	--reset the ignore wound feat flag
    	self.ignored_wound = false

    	--Refresh charges
    	for _, tid in pairs(self.talents_def) do
      		self:setCharges(tid, self:getMaxCharges(tid))
    	end
  	end

--  if self.life < self.max_life then return true end

	--quit resting after 30 turns total
	if self.resting.cnt < 30 then return true end


  self.resting.wait_cooldowns = true

  if self.resting.wait_cooldowns then
    for tid, cd in pairs(self.talents_cd) do
      if cd > 0 then return true end
    end
  end

  --Do we need to regen charges?
  for tid, _ in pairs(self.talents) do
    local c = self:getCharges(tid)
    local m = self:getMaxCharges(tid)
    if c < m then
      return true
    end
  end

  self.resting.wait_cooldowns = nil

  return false, "You feel fully rested"
end

function _M:onRestStop()
  -- Remove any repeating action.
  self.repeat_action = nil

  if self.resting.cnt > 20 then
    --Passage of time
    game.turn = game.turn + game.calendar.HOUR * 8
    --Spawn monsters
    local m = game.zone:makeEntity(game.level, "actor", {max_ood=2}, nil, true)
    if m then game.zone:addEntity(game.level, m, "actor", x, y) end
    --Passage of time
  elseif self.resting.cnt == 0 then game.turn = game.turn
  else game.turn = game.turn + game.calendar.HOUR * 4 end

  --Calendar
  game.log(game.calendar:getTimeDate(game.turn))
  --Refresh day/nite effects
  game.state:dayNightCycle()
end

function _M:cityRest()
	--Passage of time
	game.turn = game.turn + game.calendar.HOUR * 8

	--Calendar
	game.log(game.calendar:getTimeDate(game.turn))
	--Refresh day/nite effects
	game.state:dayNightCycle()

	--give full spell points
	self.mana = self.max_mana

	--Refresh charges
	for _, tid in pairs(self.talents_def) do
		self:setCharges(tid, self:getMaxCharges(tid))
	end

	--reset the ignore wound feat flag
	self.ignored_wound = false
end

--- Can we continue running?
-- We can run if no hostiles are in sight, and if we no interesting terrains are next to us
-- 'ignore_memory' is only used when checking for paths around traps.  This ensures we don't remember items "obj_seen" that we aren't supposed to
function _M:runCheck(ignore_memory)
  if spotHostiles(self) then return false, "hostile spotted" end

  -- Notice any noticeable terrain
  local noticed = false
  self:runScan(function(x, y, what)
    -- Only notice interesting terrains
    local grid = game.level.map(x, y, Map.TERRAIN)
    if grid and grid.notice then noticed = "interesting terrain" end

    -- Objects are always interesting, only on curent spot
    if what == "self" and not game.level.map.attrs(x, y, "obj_seen") then
      local obj = game.level.map:getObject(x, y, 1)
      if obj then
        if not ignore_memory then game.level.map.attrs(x, y, "obj_seen", true) end
        noticed = "object seen"
        return false, noticed
      end
    end

    local grid = game.level.map(x, y, Map.TERRAIN)
    if grid and grid.special and not grid.autoexplore_ignore and not game.level.map.attrs(x, y, "autoexplore_ignore") and self.running and self.running.path then
      game.level.map.attrs(x, y, "autoexplore_ignore", true)
      noticed = "something interesting"
      return false, noticed
    end
  end)
  if noticed then return false, noticed end

  self:playerFOV()

  return engine.interface.PlayerRun.runCheck(self)
end

--- Called after running a step
function _M:runMoved()
	self:playerFOV()
--[[	if self.running and self.running.explore then
		game.level.map:particleEmitter(self.x, self.y, 1, "dust_trail")
	end]]
end


--Castler's fix for still lit tiles
function _M:runStopped()
    game.level.map.clean_fov = true
    self:playerFOV()

	-- if you stop at an object (such as on a trap), then mark it as seen
	local obj = game.level.map:getObject(x, y, 1)
	if obj then game.level.map.attrs(x, y, "obj_seen", true) end
end

--- Activates a hotkey with a type "inventory" (taken from ToME 4)
function _M:hotkeyInventory(name)
	local find = function(name)
		local os = {}
		-- Sort invens, use worn first
		local invens = {}
		for inven_id, inven in pairs(self.inven) do
			invens[#invens+1] = {inven_id, inven}
		end
		table.sort(invens, function(a,b) return (a[2].worn and 1 or 0) > (b[2].worn and 1 or 0) end)
		for i = 1, #invens do
			local inven_id, inven = unpack(invens[i])
			local o, item = self:findInInventory(inven, name, {no_count=true, force_id=true, no_add_name=true})
			if o and item then os[#os+1] = {o, item, inven_id, inven} end
		end
		if #os == 0 then return end
		table.sort(os, function(a, b) return (a[4].use_speed or 1) < (b[4].use_speed or 1) end)
		return os[1][1], os[1][2], os[1][3]
	end

	local o, item, inven = find(name)
	if not o then
		Dialog:simplePopup("Item not found", "You do not have any "..name..".")
	else
		-- Wear it ??
		if o:wornInven() and not o.wielded and inven == self.INVEN_INVEN then
			if not o.use_no_wear then
				self:doWear(inven, item, o)
				return
			end
		end
		self:playerUseItem(o, item, inven)
	end
end

--- Move with the mouse
-- We just feed our spotHostile to the interface mouseMove
function _M:mouseMove(tmx, tmy)
  return engine.interface.PlayerMouse.mouseMove(self, tmx, tmy, spotHostiles)
end

--- Adds map lighting (see playerFov) to Actor.canReallySee
function _M:canReallySee(actor)
    return self:canSee(actor) and game.level.map.seens(actor.x, actor.y)
end

function _M:spottedMonsterXP()
   local act

    for i = 1, #self.fov.actors_dist do
      act = self.fov.actors_dist[i]
      if act and self:reactionToward(act) < 0 and self:canReallySee(act) and not act.seen
        then self.all_seen = self.all_seen or {}
        self.all_seen[act.name] = self.all_seen[act.name] or 0
        self.all_seen[act.name] = self.all_seen[act.name] + 1



        --Plugged in: a silent Knowledge check to determine whether you know the specials
        self:skillCheck("knowledge", 10+act.challenge, true)
        self.special_known[act.uid] = true
        act.seen = true

        --Formula found on the net because I suck at Maths
        local x = self.all_seen[act.name]
        local y = 100-(x*25)
        if y > 0 then self:gainExp(y) end
      end
    end

end


--Auto ID stuff

function _M:setCountID()
  if self.descriptor.class == "Rogue" then self.pseudo_id_counter = rng.range(5,10)
  elseif self.descriptor.class == "Fighter" or self.descriptor.class == "Barbarian" then self.pseudo_id_counter = rng.range(5,15)
  elseif self.descriptor.class == "Ranger" or self.descriptor.class == "Paladin" or self.descriptor.class == "Monk" or self.descriptor.class == "Warlock" or self.descriptor.class == "Cleric" then self.pseudo_id_counter = rng.range(10, 20)
  elseif self.descriptor.class == "Wizard" or self.descriptor.class == "Sorcerer" then self.pseudo_id_counter = rng.range(15, 25)
  end
end


function _M:decipherRunesItem(o)
    local can_rune = {}
--  o.runic == true if following words in flavor:
--"rune", "runic", "runed", "inscribed", "written", "symbol", "glyph", "engraved", "ancient", "script", "iconic",
    if o.runic and not o.pseudo_id then

      if self:skillCheck("decipherscript", 15) then
        o.pseudo_id = true

        game.logPlayer(self, ("By translating the runes, you discern that this is really %s!"):format(o.name))
      end
    end

end

function _M:pseudoID()
    local can_id = {}
    self:inventoryApplyAll(function(inven, item, o)
        if not o.pseudo_id then
            can_id[#can_id+1] = o
        end
    end)

    if #can_id == 0 then return end

    if self:skillCheck("intuition", 10, true) then
        local o = rng.table(can_id)
        o.pseudo_id = true
        if o.combat and o.combat.capacity and o.combat.capacity > 1 then
            game.logPlayer(self, ("You feel that your %s are %s."):format(o:getUnidentifiedName(), o:getPseudoIdFeeling()))
        else
            game.logPlayer(self, ("You feel that your %s is %s."):format(o:getUnidentifiedName(), o:getPseudoIdFeeling()))
        end
    end
end

function _M:schoolID()
    local can_id = {}
    self:inventoryApplyAll(function(inven, item, o)
        if o.pseudo_id and not o.identified then
            can_id[#can_id+1] = o
        end
    end)

    if #can_id == 0 then return end

    if self:skillCheck("intuition", 15, true) then
        local o = rng.table(can_id)
        o.school_id = true
    end
end

function _M:autoID()
    local can_id = {}
    self:inventoryApplyAll(function(inven, item, o)
        if o.pseudo_id and not o.identified then
            can_id[#can_id+1] = o
        end
    end)

    if #can_id == 0 then return end

    if self:skillCheck("intuition", 25, true) then
        local o = rng.table(can_id)
        o.identified = true
        game.logPlayer(self, "Identified: %s", o.name)
    end
end


--Get the fancy inventory title thing working
function _M:getEncumberTitleUpdater(title)
    return function()
        local enc, max = self:getEncumbrance(), self:getMaxEncumbrance()
        local color = "#00ff00#"
        if enc > max then color = "#ff0000#"
        --Color-code medium and heavy load
        elseif enc > max * 0.66 then color = "#ff8a00#"
        elseif enc > max * 0.33 then color = "#fcff00#"
        end
        return ("%s - %sEncumbrance %d/%d"):format(title, color, enc, max)
    end
end

function _M:showEquipInven(title, filter, action, on_select, inven)
    return engine.interface.ActorInventory.showEquipInven(self,
        self:getEncumberTitleUpdater(title)(), filter, action, on_select, inven)
end

function _M:showInventory(title, inven, filter, action)
    return engine.interface.ActorInventory.showInventory(self,
        self:getEncumberTitleUpdater(title)(), inven, filter, action)
end


  --Inventory
  function _M:playerPickup()
    -- If 2 or more objects, display a pickup dialog, otherwise just picks up
    if game.level.map:getObject(self.x, self.y, 2) then
		local titleupdator = self:getEncumberTitleUpdater("Pickup")
		local d d = self:showPickupFloor(titleupdator(), nil, function(o, item)
			local o = self:pickupFloor(item, true)
			if o and type(o) == "table" then o.__new_pickup = true end
			self.changed = true
			d:updateTitle(titleupdator())
			d:used()
		end)
    else
        if self:pickupFloor(1, true) then
            self:sortInven()
            self:useEnergy()
        end
    self.changed = true
    end
end

function _M:playerDrop()
	if self.no_inventory_access then return end
	local inven = self:getInven(self.INVEN_INVEN)
	local titleupdator = self:getEncumberTitleUpdater("Drop object")
	local d d = self:showInventory(titleupdator(), inven, nil, function(o, item)
		self:doDrop(inven, item, function() d:updateList() end)
		d:updateTitle(titleupdator())
		return true
	end)
end

--Taken from ToME
function _M:playerWear()
	if self.no_inventory_access then return end
	local inven = self:getInven(self.INVEN_INVEN)
	local titleupdator = self:getEncumberTitleUpdater("Wield/wear object")
	local d d = self:showInventory(titleupdator(), inven, function(o)
		return o:wornInven() and self:getInven(o:wornInven()) and true or false
	end, function(o, item)
		self:doWear(inven, item, o)
		d:updateTitle(titleupdator())
		return true
	end)
end

function _M:playerTakeoff()
	if self.no_inventory_access then return end
	local titleupdator = self:getEncumberTitleUpdater("Take off object")
	local d d = self:showEquipment(titleupdator(), nil, function(o, inven, item)
		self:doTakeoff(inven, item, o)
		d:updateTitle(titleupdator())
		return true
	end)
end

--Usable items
function _M:playerUseItem(object, item, inven)
    local use_fct = function(o, inven, item)
        if not o then return end
        local co = coroutine.create(function()
            self.changed = true

            local ret = o:use(self, nil, inven, item) or {}
            if not ret.used then return end
			if ret.id then
				o:identify(true)
			end
            if ret.destroy then
                if o.multicharge and o.multicharge > 1 then
                    o.multicharge = o.multicharge - 1
                else
                    local _, del = self:removeObject(self:getInven(inven), item)
                    if del then
                        game.log("You have no more %s.", o:getName{no_count=true, do_color=true})
                    else
                        game.log("You have %s.", o:getName{do_color=true})
                    end
                    self:sortInven(self:getInven(inven))
                end
            end
        end)
        local ok, ret = coroutine.resume(co)
        if not ok and ret then print(debug.traceback(co)) error(ret) end
        return true
    end

    if object and item then return use_fct(object, inven, item) end

    local titleupdator = self:getEncumberTitleUpdater("Use object")
    self:showEquipInven(titleupdator(),
        function(o)
            return o:canUseObject()
        end,
        use_fct
    )
end


function _M:doDrop(inven, item, on_done, nb)
    if self.no_inventory_access then return end

    local o = self:getInven(inven) and self:getInven(inven)[item]
  if o and o.plot then
    game.logPlayer(self, "You can not drop %s (plot item).", o:getName{do_colour=true})
    return
  end

  if o and o.__tagged then
    game.logPlayer(self, "You can not drop %s (tagged).", o:getName{do_colour=true})
    return
  end

  if game.zone.worldmap then
    Dialog:yesnoLongPopup("Warning", "You cannot drop items on the world map.\nIf you drop it, it will be lost forever.", 300, function(ret)
      -- The test is reversed because the buttons are reversed, to prevent mistakes
      if not ret then
        local o = self:getInven(inven) and self:getInven(inven)[item]
        if o and not o.plot then
          if o:check("on_drop", self) then return end
          local o = self:removeObject(inven, item, true)
          game.logPlayer(self, "You destroy %s.", o:getName{do_colour=true, do_count=true})
          self:checkEncumbrance()
          self:sortInven()
          self:useEnergy()
          if on_done then on_done() end
        elseif o then
          game.logPlayer(self, "You can not destroy %s.", o:getName{do_colour=true})
        end
      end
    end, "Cancel", "Destroy", true)
    return
  end

  --item sacrifice
  local t = game.level.map(self.x, self.y, Map.TERRAIN)
  local o = self:getInven(inven) and self:getInven(inven)[item]

    if t.is_altar then
      if o and not o.plot then
        self:itemSacrifice(o)
        game.logPlayer(self, "You destroy %s.", o:getName{do_colour=true, do_count=true})
        self:checkEncumbrance()
        self:sortInven()
        self:useEnergy()
        if on_done then on_done() end
      elseif o then
          game.logPlayer(self, "You can not destroy %s.", o:getName{do_colour=true})
      end
      return
    end

  if nb == nil or nb >= self:getInven(inven)[item]:getNumber() then
    self:dropFloor(inven, item, true, true)
  else
    for i = 1, nb do self:dropFloor(inven, item, true) end
  end
  self:checkEncumbrance()
  self:sortInven(inven)
  self:useEnergy()
  self.changed = true
--  game:playSound("actions/drop")
  if on_done then on_done() end
end

--[[function _M:doWear(inven, item, o)
    self:removeObject(inven, item, true)
    local ro = self:wearObject(o, true, true)
    if ro then
        if type(ro) == "table" then self:addObject(inven, ro) end
    elseif not ro then
        self:addObject(inven, o)
    end
    self:sortInven()
    self:useEnergy()
    self.changed = true
end]]

function _M:doTakeoff(inven, item, o)
    if self:addObject(self.INVEN_INVEN, o) then
    self:takeoffObject(inven, item)
  else
    game.logSeen(self, "Not enough room in inventory.")
  end
    self:sortInven()
    self:useEnergy()
    self.changed = true
end

--Container stuff, adapted from Gatecrashers
function _M:putIn(bag)
  local inven = self:getInven(self.INVEN_INVEN)
  local d d = self:showInventory("Put in", inven, nil, function(o, item)
    if not o.iscontainer then
      if bag:addObject(self.INVEN_INVEN, o) then
        self:removeObject(inven, item, true)
        self:sortInven(inven)
        bag:sortInven(inven)
        self:useEnergy()
        --print("PUT IN:"..tostring(item))
        --"Item" = # of inventory slot
        self.changed = true
      else
        game.logSeen(self, "No more room in container.")
        --return true
      end
    else
      game.logSeen(self, "You can't put a container in another container.")
      return true
      --you can switch these around to dump them out of the "insert objects in pot" screen.
    end
    --return true
  end)
end

function _M:takeOut(bag)
  local inven = bag:getInven(bag.INVEN_INVEN)
  local d d = bag:showInventory("Take out", inven, nil, function(o, item)
    if self:addObject(self.INVEN_INVEN, o) then
      bag:removeObject(inven, item, true)
      self:sortInven(inven)
      bag:sortInven(inven)
      self:useEnergy()
      self.changed = true
    end
    return true
  end)
end

--Taken from ToME
--- Call when an object is added
function _M:onAddObject(o)
	mod.class.Actor.onAddObject(self, o)
	if self.hotkey and o:attr("auto_hotkey") and config.settings.tome.auto_hotkey_object then
		local position
		local name = o:getName{no_count=true, force_id=true, no_add_name=true}

		if self.player then
			if self == game:getPlayer(true) then
				position = self:findQuickHotkey("Player: Specific", "inventory", name)
				if not position then
					local global_hotkeys = engine.interface.PlayerHotkeys.quickhotkeys["Player: Global"]
					if global_hotkeys and global_hotkeys["inventory"] then position = global_hotkeys["inventory"][name] end
				end
			else
				position = self:findQuickHotkey(self.name, "inventory", name)
			end
		end

		if position and not self.hotkey[position] then
			self.hotkey[position] = {"inventory", name}
		else
			for i = 1, 12 * (self.nb_hotkey_pages or 5) do
				if not self.hotkey[i] then
					self.hotkey[i] = {"inventory", name}
					break
				end
			end
		end
	end
end


--Level titles stuff
function _M:dominantClass()
  local Birther = require "engine.Birther"

    local list = {}
    local player = game.player

  for i, d in ipairs(Birther.birth_descriptor_def.class) do

    local level = player.classes[d.name] or 0
        if level > 0 then
        local name = ""
       name = "#WHITE#"..d.name.." #SANDY_BROWN#"..level.."#LAST#"

        table.insert(list, {name = name, desc = desc, level = level, real_name = d.name})
        end
    end

    self.list = list

    table.sort(self.list, function (a,b)
        if a.level == b.level then
            return a.name < b.name
        else
            return a.level > b.level
        end
    end)

    return list[1].real_name

end

function _M:dominantClassLevel()
  local player = game.player
  return player.classes[player:dominantClass()]
end

function _M:levelTitles()
  local player = game.player

  --Low tier titles
  if player:dominantClassLevel() <= 5 then
    if player:dominantClass() == "Barbarian" then return "Looter" end
    if player:dominantClass() == "Bard" then return "Singer" end
    if player:dominantClass() == "Cleric" then return "Novice" end
    if player:dominantClass() == "Druid" then return "Aspirant" end
    if player:dominantClass() == "Fighter" then return "Soldier" end
    if player:dominantClass() == "Monk" then return "Brother" end
    if player:dominantClass() == "Paladin" then return "Gallant" end
    if player:dominantClass() == "Ranger" then return "Runner" end
    if player:dominantClass() == "Rogue" then return "Footpad" end
    if player:dominantClass() == "Sorcerer" then return "Channeler" end
    if player:dominantClass() == "Wizard" then return "Channeler" end
    if player:dominantClass() == "Warlock" then return "Channeler" end
    if player:dominantClass() == "Shaman" then return "Channeler" end
  --Heroic tier titles / name level in OD&D
  elseif player:dominantClassLevel() <= 10 then
    if player:dominantClass() == "Barbarian" then return "Raider" end
    if player:dominantClass() == "Bard" then return "Bard" end
    if player:dominantClass() == "Cleric" then return "Priest" end
    if player:dominantClass() == "Druid" then return "Druid" end
    if player:dominantClass() == "Fighter" then return "Weaponmaster" end
    if player:dominantClass() == "Monk" then return "Disciple" end
    if player:dominantClass() == "Paladin" then return "Protector" end
    if player:dominantClass() == "Ranger" then return "Scout" end
    if player:dominantClass() == "Rogue" then return "Cutpurse" end
    if player:dominantClass() == "Sorcerer" then return "Sorcerer" end
    if player:dominantClass() == "Wizard" then return "Wizard" end
    if player:dominantClass() == "Warlock" then return "Warlock" end
    if player:dominantClass() == "Shaman" then return "Shaman" end
  --Conqueror tier titles
  elseif player:dominantClassLevel() <= 15 then
    if player:dominantClass() == "Barbarian" then return "Chieftain" end
    if player:dominantClass() == "Bard" then return "Trickster" end
    if player:dominantClass() == "Cleric" then return "High Priest" end
    if player:dominantClass() == "Druid" then return "High Druid" end
    if player:dominantClass() == "Fighter" then return "Captain" end
    if player:dominantClass() == "Monk" then return "Master" end
    if player:dominantClass() == "Paladin" then return "Justiciar" end
    if player:dominantClass() == "Ranger" then return "Tracker" end
    if player:dominantClass() == "Rogue" then return "Burglar" end
    if player:dominantClass() == "Sorcerer" then return "Summoner" end
    if player:dominantClass() == "Wizard" then return "Summoner" end
    if player:dominantClass() == "Warlock" then return "Summoner" end
    if player:dominantClass() == "Shaman" then return "High Shaman" end
  --Paragon tier titles
  elseif player:dominantClassLevel() <= 20 then
    if player:dominantClass() == "Barbarian" then return "Warmaster" end
    if player:dominantClass() == "Bard" then return "Master Trickster" end
    if player:dominantClass() == "Cleric" then return "Archpriest" end
    if player:dominantClass() == "Druid" then return "Archdruid" end
    if player:dominantClass() == "Fighter" then return "Warlord" end
    if player:dominantClass() == "Monk" then return "Master of Dragons" end
    if player:dominantClass() == "Paladin" then return "Champion" end
    if player:dominantClass() == "Ranger" then return "Ranger Knight" end
    if player:dominantClass() == "Rogue" then return "Sharper" end
    if player:dominantClass() == "Sorcerer" then return "Magister" end
    if player:dominantClass() == "Wizard" then return "Magister" end
    if player:dominantClass() == "Warlock" then return "Magister" end
    if player:dominantClass() == "Shaman" then return "Head Shaman" end
  --Epic tier titles
  --else
  end

end



--Player-specific perks stuff
--Pick a random egoed item to be given as perk
function _M:randomItem()
  local chance = rng.dice(1,15)
  if chance == 1 then self.perk_item = "battleaxe"
  elseif chance == 2 then self.perk_item = "rapier"
  elseif chance == 3 then self.perk_item = "long sword"
  elseif chance == 4 then self.perk_item = "dagger"
  elseif chance == 5 then self.perk_item = "morningstar"
  --Ranged weapons
  elseif chance == 6 then self.perk_item = "shortbow"
  elseif chance == 7 then self.perk_item = "longbow"
  elseif chance == 8 then self.perk_item = "sling"
  elseif chance == 9 then self.perk_item = "light crossbow"
  elseif chance == 10 then self.perk_item ="heavy crossbow"
  --Armor
  elseif chance == 11 then self.perk_item = "chain mail"
  elseif chance == 12 then self.perk_item = "chain shirt"
  elseif chance == 13 then self.perk_item = "studded leather"
  elseif chance == 14 then self.perk_item = "breastplate"
  else self.perk_item = "plate armor"   end
  self.perk = "magical "..self.perk_item
end

--Add a random ego-ed item
function _M:giveEgoAxe()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="battleaxe", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="battleaxe", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoRapier()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="rapier", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="rapier", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoSword()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="long sword", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="long sword", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoDagger()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="dagger", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="dagger", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoMorningstar()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="morningstar", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="morningstar", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoShortbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="shortbow", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="shortbow", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoLongbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="longbow", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="longbow", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoSling()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="sling", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="sling", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoLCrossbow()
    local inven = game.player:getInven("MAIN_HAND")
    local o = game.zone:makeEntity(game.level, "object", {name="light crossbow", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="light crossbow", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoHCrossbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="heavy crossbow", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="heavy crossbow", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoChainmail()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="chain mail", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="chain mail", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoChainShirt()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="chain shirt", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="chain shirt", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoLeather()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="studded leather", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="studded leather", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoBreastplate()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="breastplate", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="breastplate", ego_chance=1000}, nil, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoPlate()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="plate armor", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="plate armor", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

--Actually give the starting items
function _M:giveAxe()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="battleaxe", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveRapier()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="rapier", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveScimitar()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="scimitar", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveSword()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="long sword", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveDagger()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="dagger", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveMorningstar()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="morningstar", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveLMace()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="light mace", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveHMace()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="heavy mace", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveSickle()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="sickle", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveStaff()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="quarterstaff", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveHammer()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="warhammer", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveSpear()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="short spear", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveScythe()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="scythe", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveShortbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="shortbow", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveLongbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="longbow", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveSling()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="sling", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveLCrossbow()
    local inven = game.player:getInven("MAIN_HAND")
    local o = game.zone:makeEntity(game.level, "object", {name="light crossbow", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject("MAIN_HAND", o)
        o.pseudo_id = true
      end
end

function _M:giveHCrossbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="heavy crossbow", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject("MAIN_HAND", o)
        o.pseudo_id = true
      end
end

function _M:giveHandCrossbow()
  local o = game.zone:makeEntity(game.level, "object", {name="hand crossbow", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject("MAIN_HAND", o)
        o.pseudo_id = true
      end
end

function _M:giveChainmail()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="chain mail", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveChainShirt()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="chain shirt", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveLeather()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="studded leather", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:givePadded()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="padded armor", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveBreastplate()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="breastplate", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:givePlate()
  local inven = game.player:getInven("BODY")
  local o = game.zone:makeEntity(game.level, "object", {name="plate armor", ego_chance=-1000}, 1, true)
      if o then
        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveStartingEQ()
  local class = game.player.descriptor.class
  local race = game.player.descriptor.race
--  local item = self:randomItem()
    if class == "Barbarian" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
        then self:givePerkWeapon() end
      --Racial weapons
      if race == "Halfling" or race == "Gnome" or race == "Elf" or race == "Half-Elf" then self:giveSword()
      elseif race == "Drow" then self:giveScimitar()
      else self:giveAxe() end
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveChainmail() end

    elseif class == "Bard" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
        then self:givePerkWeapon() end
      --Racial weapons
      if race == "Halfling" or race == "Gnome" then self:giveDagger()
      elseif race == "Elf" then self:giveSword()
      elseif race == "Drow" then self:giveScimitar()
      elseif race == "Human" or race == "Half-Elf" then self:giveRapier()
      elseif race == "Dwarf" or race == "Duergar" then self:giveLMace() end
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveChainShirt() end

    elseif class == "Cleric" or class == "Shaman" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
        then self:givePerkWeapon() end
      if race == "Halfling" or race == "Gnome" then self:giveLMace()
      else self:giveHMace() end
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveChainmail() end

    elseif class == "Druid" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
        then self:givePerkWeapon() end
      --Racial weapons
      if race == "Halfling" or race == "Gnome" then self:giveSickle()
      elseif race == "Human" or race == "Half-Elf" then self:giveStaff()
      elseif race == "Dwarf" or race == "Duergar" then self:giveScythe()
      else self:giveScimitar() end
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:givePadded() end

    elseif class == "Fighter" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      if race == "Halfling" or race == "Gnome" then self:giveSword()
      elseif race == "Drow" then self:giveScimitar()
      elseif race == "Half-Orc" then self:giveAxe()
      else self:giveSword() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveChainmail() end

    elseif class == "Monk" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()  end

    elseif class == "Paladin" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      if race == "Halfling" or race == "Gnome" then self:giveSword()
      elseif race == "Dwarf" then self:giveHammer()
      --TO DO: give lance once mounts are in
      else self:giveSword() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveChainmail() end

    elseif class == "Ranger" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      --Racial weapons
      if race == "Halfling" or race == "Gnome" or race == "Half-Orc" then self:giveSpear()
      elseif race == "Drow" then self:giveScimitar()
      elseif race == "Dwarf" or race == "Duergar" then self:giveHammer()
      else self:giveSword() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveLeather() end

    elseif class == "Rogue" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      --Racial weapons
      if race == "Halfling" or race == "Gnome" then self:giveLCrossbow()
      elseif race == "Drow" then self:giveHandCrossbow()
      elseif race == "Elf" then self:giveLongbow()
      else self:giveShortbow() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()
      else self:giveLeather() end

    elseif class == "Sorcerer" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      self:giveDagger()
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor() end

    elseif class == "Wizard" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      --Racial items
      if race == "Halfling" or race == "Gnome" then self:giveDagger()
      else self:giveStaff() end
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor() end

    elseif class == "Warlock" then
      --Account for perk items
      if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      self:giveSword()
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor() end
      self:giveChainShirt()

    else end
end


function _M:givePerkWeapon()
    --Weapon
    if self.perk_item == "battleaxe" then self:giveEgoAxe()
    elseif self.perk_item == "rapier" then self:giveEgoRapier()
    elseif self.perk_item == "long sword" then self:giveEgoSword()
    elseif self.perk_item == "dagger" then self:giveEgoDagger()
    elseif self.perk_item == "morningstar" then self:giveEgoMorningstar()
    --Ranged weapons
    elseif self.perk_item == "shortbow" then self:giveEgoShortbow()
    elseif self.perk_item == "longbow" then self:giveEgoLongbow()
    elseif self.perk_item == "sling" then self:giveEgoSling()
    elseif self.perk_item == "light crossbow" then self:giveEgoLCrossbow()
    elseif self.perk_item == "heavy crossbow" then self:giveEgoHCrossbow()
    else end
end

function _M:givePerkArmor()
    --Armor
    if self.perk_item == "chain mail" then self:giveEgoChainmail()
    elseif self.perk_item == "chain shirt" then self:giveEgoChainShirt()
    elseif self.perk_item == "studded leather" then self:giveEgoLeather()
    elseif self.perk_item == "breastplate" then self:giveEgoBreastplate()
    elseif self.perk_item == "plate armor" then self:giveEgoPlate()
    else end
end

--Exercising attributes
function _M:exerciseStat(stat, d, reason, cap)
  local required
  local stat_increased

  --Prevent errors
  local stat_increased = self.stat_increased[stat]
  self.stat_increased[stat] = 0
--  self.number_increased[stat] = 0
  --assume every stat has a different reason
  self.number_increased[reason] = 0

  --Respect caps
  if (self.stat_increased[stat] or 0) > 5 then return end -- plus inherent potential

  if d > 0 then
    if (self.number_increased[reason] or 0) > cap then return end
  end

  --Do the increasing!
  self:attr("train_"..stat, d)
  self.number_increased[reason] = d

  --Skills reduce number of points required
  if stat == "str" then required = 100 end -- minus math.max(0, self.skill_athletics)
  if stat == "dex" then required = 100 end -- minus math.max(0, self.skill_athletics)
  if stat == "con" then required = 100 end -- minus math.max(0, self.skill_athletics)
  if stat == "int" then required = 100 - math.max(0, self.skill_knowledge) end
  if stat == "wis" then required = 100 - math.max(0, self.skill_concentration) end
  if stat == "cha" then required = 100 end -- minus math.max(0, self.skill_perform)
  if stat == "luc" then required = 100 end

  --Increase stat if exercising/training puts us above the cap
  if self:attr("train_"..stat) > required then
    --zero the points!!!
    self:attr("train_"..stat, 0, true)
    self:incStat(stat, 1)
    self.stat_increased[stat] = self.stat_increased[stat] + 1
  end


end



--Deity system code

function _M:isFollowing(deity)
  return self.descriptor.deity == deity
end


function _M:incFavorFor(deity, d)
  if self:isFollowing(deity) then
    self.favor = self.favor + d
    self.max_favor = self.favor
  end
end


function _M:getFavorLevel(max_favor)
  local ret = 0

  if max_favor == 0 then ret = 0 end
  if max_favor < 100 then ret = 0 end

  --Incursion's values, streamlined
  if max_favor >= 100 then ret = 1 end
  if max_favor >= 500 then ret = 2 end
  if max_favor >= 1250 then ret = 3 end
  if max_favor >= 4500 then ret = 4 end
  if max_favor >= 12000 then ret = 5 end
  if max_favor >= 24000 then ret = 6 end
  if max_favor >= 54000 then ret = 7 end
  if max_favor >= 96000 then ret = 8 end
  if max_favor >= 102000 then ret = 9 end
  if max_favor >= 205000 then ret = 10 end

    game.log("Favor level:"..ret)

  return ret
end

--Lifted whole from Incursion
--Some deity colors have been changed from Inc! (lots of them were duplicated)
--Asherath is tan not cyan; Immotian is gold not pink; Khasrach is olive not red; Essiah is pink not blue
--Hesani is uniformly yellow, Multitude uniformly slate
function _M:divineMessage(deity, message, desc)
  local string
  local color = ""

  if deity == "Aiswin" then
    color = "#BLUE#"
    if message == "anger" then string = "The air grows sharply cold, and all the hairs on the back of your neck stand up straight!" end
    if message == "pleased" then string = "A soft red glow surronds you, and you hear a whispered voice in the back of your mind:"..color.."|Ideal.|#LAST#" end
    if message == "prove worth" then string = "A silky, dangerous voice whispers into your mind:"..color.."|Prove your devotion.|#LAST#" end
    if message == "insufficient" then string = "A silky whisper mindspeaks: "..color.."|Insufficient.|#LAST#" end
    if message == "blessing one" then string = "A silky whisper speaks into your mind: "..color.."|I will make you one with shadows!|#LAST#" end
    if message == "blessing two" then string = "A silky whisper speaks into your mind: "..color.."|I grant you intimacy with the night!|#LAST#" end
    if message == "blessing three" then string = "A silky whisper speaks into your mind: "..color.."|I gift you with secret lore!|#LAST#" end
    if message == "blessing four" then string = "A silky whisper speaks into your mind: "..color.."|I will open your eyes to the weakness of your enemies!|#LAST#" end
    if message == "blessing five" then string = "A silky whisper speaks into your mind: "..color.."|I name you master over all shadows!|#LAST#" end
    if message == "blessing six" then string = "A silky whisper speaks into your mind: "..color.."|I gift you with words of silk and malice!|#LAST#" end
    if message == "blessing seven" then string = "A silky whisper speaks into your mind: "..color.."|I teach you now to glory in the lamentations of those who have wronged you!|#LAST#" end
    if message == "blessing eight" then string = "A silky whisper speaks into your mind: "..color.."|I teach you now to strike by surprise and inflict pain with a touch!|#LAST#" end
    if message == "blessing nine" then string = "A silky whisper speaks into your mind: "..color.." |To you I open the most secret shadow paths, and grant words to call forth a thousand knives!|#LAST#" end
    if message == "crowned" then string = "A silky whisper speaks into your mind: "..color.."|I crown you the Harbringer of Ruin!|#LAST#" end
    if message == "insufficient" then string = "A sinuous voice intones: "..color.."|Insufficient.|#LAST#" end
    if message == "bad sacrifice" then string = "A silky voice hisses angrily: "..color.."|Abomination!|#LAST#" end
    if message == "offer raise" then string = color.."|I offer to you a chance to avenge yourself from beyond death!|#LAST#" end
    if message == "salutation" then string = color.."|Blessed be those who walk the path of shadows!|#LAST#" end
    if message == "convert" then string = "" end
  end


  if deity == "Asherath" then
    color = "#TAN#"
    if message == "salutation" then string = color.."|Go forth; gain strength and knowledge to shape the world!|#LAST#" end
    if message == "anger" then string = "You feel that Asherath is gravely displeased with you." end
    if message == "bad prayer" then string = "The air grows sharply cold, and you realize you have made a serious mistake." end
    if message == "jealousy" then string = color.."|Do you really believe I could not have predicted your betrayal? Fool.|#LAST#" end
    if message == "convert" then string = "There is no response from Asherath, but you have a sense of acceptance." end
    if message == "timeout" then string = "You know that Asherath expects His clerics to succeed with little aid, and you feel gravely uneasy about your frequent requests." end
    if message == "prayer" then string = "Time seems to slow down around you briefly... or is it just the fog of war?" end
    if message == "no aid" then string = "As is often the case, Asherath apparently expects you to solve this matter yourself." end
    if message == "out of aid" then string = "Asherath will no longer aid you." end
    if message == "nearly out" then string = "You feel certain Asherath grows tired of your entreaties." end
    if message == "blessing one" then string = "Your training in the Ways of Asherath teaches you to strike true against your enemies." end
    if message == "blessing two" then string = "Your training in the Ways of Asherath helps you to preserve your mental and physical might." end
    if message == "blessing three" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection. You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "blessing four" then string = "Your training in the Ways of Asherath expands your horizons." end
    if message == "blessing five" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection." end
    if message == "blessing six" then string = "Your training in the Ways of Asherath allows you to push your body and mind beyond previously-understood limits. You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "blessing seven" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection." end
    if message == "blessing eight" then string = "Your training in the Ways of Asherath allows you to push your body and mind beyond previously-understood limits." end
    if message == "blessing nine" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection.  You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "crowned" then string = color.."|I crown you the Psyche of War!|#LAST#" end
  end

  if deity == "Ekliazeh" then
    color = "#SANDY_BROWN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|By the forge and the hammer, we stand united!|#LAST#" end
    if message == "anger" then string = "A deep voice thunders, "..color.."|Thou hast broken the ancient Law!|#LAST#" end
    if message == "pleased" then string = "A deep voice thunders, "..color.."|Great riches are these!|#LAST#" end
    if message == "prove worth" then string = "A deep voice intones, "..color.."|Any aspirant must first prove his mettle!|#LAST#" end
    if message == "not worthy" then string = "A deep voice scorns, "..color.."|Thou art no child of mine!|#LAST#" end
    if message == "bad prayer" then string = "A deep voice thunders, "..color.." |Unclean creature! Betrayer of the Law!|#LAST#" end
    if message == "jealousy" then string = "A deep voice thunders, "..color.." |Thou turns back on our covenant? Then suffer!|#LAST#" end
    if message == "convert" then string = color.."|Uphold my Law, and I will carry you through all of life's hardships. Honor the ways of my people, and you will discover tremendous strength!|#LAST#" end
    if message == "forsake" then string = "A deep voice thunders, "..color.." |Thou art a traitor to the Law, and art forever anathema to all my people!|#LAST#" end
    if message == "timeout" then string = "A deep voice intones, "..color.." |"..self.name..", you rely overmuch on my aid! You must survive on your own.|#LAST#" end
    if message == "prayer" then string = "The earth seems to rumble in time with your heartbeat!" end
    if message == "no aid" then string = "A deep voice speaks sorrowfully, "..color.."|I have no further aid to grant unto you, my child.|#LAST#" end
    if message == "out of aid" then string = "A deep voice speaks sorrowfully, "..color.."|I have given you all the aid even a champion may receive in one lifetime!|#LAST#" end
    if message == "nearly out" then string = "A deep voice speaks sorrowfully, "..color.." |Soon I will no longer be able to aid you, my child. Be ready!|#LAST#" end
    if message == "sacrifice" then string = "Your sacrifice dissolves in a rich golden light!" end
    if message == "insufficient" then string = "A deep voice thunders, "..color.."|This is the paltry portion you reserve for your god?!|#LAST#" end
    if message == "satisfied" then string = "A deep voice thunders, "..color.."|You honor the Law with your offering.|#LAST#" end
    if message == "impressed" then string = "A deep voice thunders, "..color.."|Great glory be upon you for the sacrifice you have wrought!|#LAST#" end
    if message == "lessened" then string = "You feel as though your sins have been lessened in Ekliazeh's eyes." end
    if message == "mollified" then string = "You feel as though your sins have been washed away in Ekliazeh's eyes." end
    if message == "bad sacrifice" then string = "A deep voice thunders, "..color.."|You dare to offer me the blood of goodly folk?!|#LAST#" end
    -- "A deep voice thunders, |You dare to offer me the blood of my chosen people?!|"
    if message == "offer raise" then string = "I offer you the chance to return to life, to me my champion and guide my people on the path to righteousness!" end
    if message == "blessing one" then string = color.."|I gift you with the fortitude to endure all of life's ordeals!|#LAST#" end
    if message == "blessing two" then string = color.."|I gift you with the endurance of a perfect worker-soldier!|#LAST#" end
    if message == "blessing three" then string = color.."|I gift you with the ability to shape metal, and to speak with the spirits of the earth!|#LAST#" end
    if message == "blessing four" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing five" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "blessing six" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing seven" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "blessing eight" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing nine" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "crowned" then string = color.."|I crown you the Warrior of the Law!|#LAST#" end
    --Drow/Goblin
    if message == "custom one" then string = color.."|You whose people have slain my children for millenia now appeal to me? Suffer!|#LAST#" end
    --Elf/Lizardfolk
    if message == "custom two" then string = color.."|Your people are too distant from the Earth to follow my ways.|#LAST#" end
    if message == "custom three" then string = color.."|I bless thy workings of the earth!|#LAST#" end
  end


  if deity == "Erich" then
    color = "#PURPLE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Let there be zeal in your heart, truth in your words, honor in your deeds and blood upon your sword!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "bad sacrifice" then string = "A proud voice booms, "..color.."|Thou stains my altar with the blood of that trash?! Suffer, churl!|#LAST#" end
    --Goblin in sight for smite
    if message == "custom one" then string = "A proud voice booms, "..color.." |I will cleanse this filth from your presence!|#LAST#" end
    --No target for smite
    if message == "custom two" then string = "A proud voice intones, "..color.."|I cannot aid you against worthy foes. You must fight your own battles, with my blessing.|#LAST#" end
    --Grant item
    if message == "custom three" then string = "A proud voice proclaims, "..color.."|Use this and find glory in my name!|#LAST#" end
    --Erich's Disfavor Effect (-4 penalty on all rolls in combat, persistent)
    if message == "custom four" then string = "A proud voice scorns, "..color.."|Vile cur, suffer for thy cowardice!|#LAST#" end
    --Goblinoid
    if message == "custom five" then string = "An angry voice declares, "..color.."|I deal not with filth and base creatures!|#LAST#" end
  end


  if deity == "Essiah" then
    color = "#PINK#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|The horizon awaits...|#LAST#" end
    if message == "convert" then string = "" end
    if message == "blessing one" then string = color.."|I teach thee now to honor the feelings of thy lovers, and the crafts of herbs to control thine own body.|#LAST#" end
    if message == "blessing two" then string = color.."|May all thy journeys be swift and clear, if not uninteresting.|#LAST#" end
    if message == "blessing three" then string = color.."|I grant to thee the beauty to lead an entertaining life, and further the wisdom to lead a good one.|#LAST#" end
    if message == "blessing four" then string = color.."|Let nothing impede thy freedom to move!|#LAST#" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end

  end


  if deity == "Hesani" then
    color = "#YELLOW#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Walk in harmony with the world, and your prosperity shall multiply a thousand-fold. Fight against its tides, and they will tear your life asunder.|#LAST#" end
    if message == "convert" then string = "" end
    --only barbarian levels
    if message == "custom one" then string = color.."|To embrace the path of harmony, one must first turn away from barbarism.|#LAST#" end

  end


  if deity == "Immotian" then
    color = "#GOLD#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|The flame of purity lights the path to righteousness!|#LAST#" end
    if message == "bad sacrifice" then string = color.."|Barbarian! Thou hast stained My altar with blood! This is an abomination of the highest order!|#LAST#" end
    if message == "convert" then string = "" end
    --any hostile in sight on smite (transforms into a pillar of salt DC 25)
    if message == "custom one" then string = color.."|Accursed be those who strike at believers!|#LAST#" end
    if message == "custom two" then string = "" end
    --god pulse (summon fire critters)
    if message == "custom three" then string = color.."|Blessed is thee who shares kinship with the spirits of flame!|#LAST#" end
    --god pulse event (empowered maximized enlarged Order's Wrath)
    if message == "custom four" then string = color.."|Let no unlawful villain lay hands upon my follower!|#LAST#" end
    --change water in equipment into blood
    if message == "custom five" then string = color.."|I curse thee, wayward follower: let thy sweetest water taste as bitter as a clotted blood of thine enemies!|#LAST#" end
    if message == "custom six" then string = color.."|I curse thee, wayward follower: a plague upon thy fields!|#LAST#" end
    --4d50 favor
    if message == "custom seven" then string = "You feel Immotian is pleased with the community you have built and will not strain it further by enlarging it." end
    if message == "blessing one" then string = color.."|Walk in the light of My truth, and no flames shall burn thee!|#LAST#" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Khasrach" then
    color = "#OLIVE_DRAB#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "" end
    if message == "convert" then string = "" end
    if message == "bad sacrifice" then string = color.."|Thou dares to offer me the blood of mine own people?! SUFFER!|#LAST#" end
    --|Thou dares to offer me the blood of our allies?!|
    --anger, changeLevel(10, math.max(game.level.level + ((self.anger -3)/5)))
    if message == "custom one" then string = color.."|Thou hast sinned against my way; now, prove thy loyalty in this trial by ordeal!|#LAST#" end
    --god pulse, summon a friendly orc(s)
    if message == "custom two" then string = color.."|Know always that our people have strength in numbers!|#LAST#" end
    --retribution, summon enemy orc(s)
    if message == "custom three" then string = color.."|Destroy the infidel, my children!|#LAST#" end
    --elf/dwarf/human/mage level
    if message == "custom four" then string = color.."|Thou art an enemy of my people! Suffer, infidel!|#LAST#" end
    if message == "blessing one" then string = color.."|So I bless thee: that thou shalt turn aside all charms and compulsions, and see clearly past the machinations of others to determine thy future!|#LAST#" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Kysul" then
    color = "#LIGHT_GREEN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Seek now thine antediluvian progenitors that in sunken cities for eons have lain.|#LAST#" end
    if message == "aid" then string = "Kysul guides you to safety through the cracks and flaws between dimensions." end
    if message == "convert" then string = "" end
    --god pulse, gift
    if message == "custom one" then string = "An inhuman emanation vaguely imitates language: "..color.."|This, my child: a relic of civilizations long since engulfed by the flow of eons!|#LAST#" end
    --anger, ???
    if message == "custom two" then string = "You feel profane." end
    --anger x2, closest enemy gets pseudonatural template
    if message == "custom three" then string = "You feel you are surely facing the ire of Kysul..." end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Mara" then
    color = "#ANTIQUE_WHITE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|May you find beauty in endings.|#LAST#" end
    if message == "bad sacrifice" then string = "A solemn voice thunders: "..color.."|You have stained my altar with conquest-blood! You shall suffer for this grievous misjudgement!|#LAST#" end
    if message == "convert" then string = "" end
    --anger, your body decomposes
    if message == "custom one" then string = "A solemn voice speaks crossly: "..color.."|Learn now why death is never to be lightly dispensed!|#LAST#" end
    --god pulse, revenant
    if message == "custom two" then string = "A solemn voice intones: "..color.."|This soul seeks to make atonement for past misdeeds, and will travel with you to aid you on your quest.|#LAST#" end
    --god pulse, self.level >= 5, revenant w/class levels
    if message == "custom three" then string = "A solemn voice intones: "..color.."|This soul seeks to find closure lacking in life, and will travel with you to aid you on your quest.|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Maeve" then
    color = "#DARK_GREEN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|And there shall be laughter and magic and blood, and we shall dance our dance until the end of time...|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse; o.type is either cloak/ring/amulet; must be magical
    if message == "custom one" then string = "A mellifluous voice titters, "..color.."|Oh, what a pretty" ..o.type.."! I simply must have it!|#LAST#" end
    --god pulse; summon single non-good non-lawful CR player.level+2 monster
    if message == "custom two" then string = "A mellifluous voice titters, "..color.."|Now, my precious acolyte, entertain me with your wonderous displays of warcraft!|#LAST#" end
    --god pulse; Maeve's Whimsy
    if message == "custom three" then string = "A mellifluous voice titters, "..color.."|Now, on this moonless eve, the Faerie Queen works her wiles: so what's fair is foul, and foul's fair!|#LAST#" end
    --god pulse x2; closest friendly non-player turns hostile;
    --random magic non-cursed item glows with a silvery light and gets a +1 bonus
    if message == "custom four" then string = "A mellifluous voice titters, "..color.."|Let discord and misrule reign eternal!|#LAST#" end

    if message == "custom five" then string = "A mellifluous voice intones, "..color.."|Now, my beautiful plaything, drink deeply of my well of ancient fey dweomers!|#LAST#" end
    --god pulse; 1 on 1d3, a druidic spell or an arcane spell (player.level+3)/2
    if message == "custom six" then string = "A mellifluous voice intones, "..color.."|To you, my loyal knight of the trees, I bequithe this ancient faerie magick!|#LAST#" end
    --beautiful/handsome; god pulse - magic non-cursed item
    if message == "custom seven" then string = "A mellifluous voice intones, "..color.."|A gift I bequeath to thee, for my most loyal and <hText> of champions!|#LAST#" end
    --anger/god pulse; enlarged Othello's irresistible dance
    if message == "custom eight" then string = "A mellifluous voice titters, "..color.." |Let there be dance and music and merryment!|#LAST#" end
    --retribution; summons hostile elf twilight huntsman
    if message == "custom nine" then string = "A mellifluous voice howls, "..color.."|Now, my loyal huntsman, destroy the traitor!|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Sabin" then
    color = "#LIGHT_BLUE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Life is a whirlwind. Cast free your tethers, dive forward and watch as you soar!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "custom one" then string = "A resonant voice speaks: "..color.."|Thou hast grown too static -- be changed!|#LAST#" end
    if message == "custom two" then string = "You are struck by a bolt of inspiration!" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = color.."|I grant thee the potential for excellence!|#LAST#" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Semirath" then
    color = "#ORCHID#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Now, my child, go forth and teach the legions of ignorance that there are many fates worse than death, and some even involve radishes!|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse; hostile non-good humanoid in LOS
    if message == "custom one" then string = "A boyish voice speaks: "..color.."|Leave my follower alone, you cretins!|#LAST#" end
    --anger; drop armor (clothes)
    if message == "custom two" then string = "A boyish voice speaks: "..color.."|Gratuitous nudity is *always* appropriate!|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Xavias" then
    color = "#DARK_SLATE_GRAY#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|And the path of the Golden Lion, the Philosopher's Treasure, the Glory of Transmutation shall soon be lain clear before thee!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "custom one" then string = "An elderly voice speaks sadly, "..color.."|Forgive me, my child: thou lacks the depth of vision to truly explore the Holy Mysteries.|#LAST#" end
    --grant spellbook
    if message == "custom two" then string = "An elderly voice speaks slowly: "..color.."|I gift you with Hermetic wisdom!|#LAST#" end
    --Int+Wis < 26
    if message == "custom three" then string = "An elderly voice speaks slowly: "..color.." |Thy mind is too feeble to be initiated into thine Holy Mysteries.|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Xel" then
    color = "#DARK_RED#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "You feel an aching, primordial hunger. "..color.."|Blood for the blood god!|#LAST#" end
    --doesn't really communicate
  end


  if deity == "Zurvash" then
    color = "#CRIMSON#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "May your hunt be fruitful, and your plunder rich and succulent!" end
    if message == "convert" then string = "" end
    --anger; summon several hostile non-good fiendish critters, total CR player.level +2
    if message == "custom one" then string = "A growling voice hisses: "..color.."|Destroy the infidel, my beautiful children!|#LAST#" end
    if message == "blessing one" then string = "A growling voice speaks: "..color.."|Only the strong will survive!|#LAST#" end
    if message == "blessing two" then string = "A growling voice speaks: "..color.."|Be you the hunter and not the hunted!|#LAST#" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end

  if deity == "Multitude" then
    color = "#SLATE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|killemflayemburnemhurtemmakeemscreammakeemBLEED...|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse, gain 4d50 favor
    if message == "custom one" then string = color.."|Goodhordegrownhordebloodyhordeghostspleased...|#LAST#" end
    --god pulse, summon several player.level+2 demons
    if message == "custom two" then string = color.."|aidhimservehimlovehimkillforhim...|#LAST#" end
    --anger; summon several player.level+2 demons but hostile
    if message == "custom three" then string = color.."|traitortraitortraitorDIEtraitortraitor...|#LAST#" end
    --don't really communicate
  end



    if desc then string = string.." about "..desc end
    game.logPlayer(self, string)
end

function _M:transgress(deity, anger, angered, desc)
  --Currently only increase for your patron
  if self:isFollowing(deity) then

  --reduce Wis temporarily by math.max(anger, 10)
  old_anger = self.anger

  self.anger = old_anger + anger
  end

  if angered then self:setGodAngerTimer() end

  if self.anger >= 50 then self.anathema = true end
  if self.anger >= 35 then self.forsaken = true end

  if self.anger >= 5 then self:divineMessage(deity, "very uneasy", desc)
  else self:divineMessage(deity, "uneasy", desc) end

end

function _M:isForsaken(deity)
  if self.forsaken == true then return true
  else return false end
end

function _M:isAnathema(deity)
  if self.anathema == true then return true
  else return false end
end

function _M:setGodPulse()
  local deity = self.descriptor.deity

  if deity == "Aiswin" or deity == "Hesani" or deity == "Immotian" or deity == "Sabin" or deity == "Semirath" or deity == "Xel" or deity == "Zurvash" then self.god_pulse_counter = 10
  elseif deity == "Ekliazeh" or deity == "Essiah" or deity == "Khasrach" or deity == "Kysul" or deity == "Mara" or deity == "Xavias" then self.god_pulse_counter = 20
  elseif deity == "Maeve" then self.god_pulse_counter = 25
  elseif deity == "Erich" then self.god_pulse_counter = 30
  elseif deity == "Multitude" then self.god_pulse_counter = 7
  end
end

function _M:setGodAngerTimer()
  local deity = self.descriptor.deity

  if deity == "Erich" or deity == "Hesani" or deity == "Kysul" or deity == "Mara" or deity == "Xel" or deity == "Zurvash" then self.god_anger_counter = 10
  elseif deity == "Immotian" then self.god_anger_counter = 15
  elseif deity == "Aiswin" or deity == "Essiah" or deity == "Semirath" or deity == "Xavias" then self.god_anger_counter = 20
  elseif deity == "Ekliazeh" then self.god_anger_counter = 25
  elseif deity == "Khasrach" or deity == "Sabin" then self.god_anger_counter = 30
  elseif deity == "Maeve" or deity == "Multitude" then self.god_anger_counter = 7
  end
end


function _M:godPulse()
  local deity = self.descriptor.deity
  if deity == "Aiswin" then
  --  game.logPlayer(self, "Aiswin whispers a secret to you!")
    --case one: identify a random item
    --case two: give Aiswin's Lore spell ("Mystical knowledge of Aiswin's Lore imprints itself on your mind!")
    --case three: mark random actor in range 30 as seen
  end
  if deity == "Ekliazeh" then
    --case one: mend random item in inventory
    --case two: "Your o.name glows with a brilliant silver light!"
  --  self:divineMessage("Ekliazeh", "custom three")
  end
  if deity == "Erich" then
    --grant a random arms/weapon
  --  self:divineMessage("Erich", "custom three")
  end
  if deity == "Essiah" then
    --ESSIAH_DREAM stuff
    --after rest, if angry, damage 3d10 CON, the wrath of Essiah
    --if self:getFavorLevel(max_favor) >= 1d12 then
    --"Essiah appears to you in your dreams in the form you find most appealing, and beckons seductively. /n Accept the embrace?"
    --Y:"You experience a feverish, erotic dream of great intensity. That was certainly a learning experience!"
    --self:gainExp(10*self.level*(self.getFavorLevel+4))
    --exercise CHA and CON
    --self:exercise("cha", rng.dice(5,12), "cha_Essiah", 70)
    --self:exercise("con", rng.dice(5,12), "con_Essiah", 70)
    --N: "The goddess shrugs, smiles warmly without condemnation at you, and vanishes."
  end
  if deity == "Hesani" then
    if game.level.level > 1 and self.level < 12 then
      if game.level.level > (self.level/2) then
        self:transgress("Hesani", 1, "lack of patience")
      end
    end
  --  game.logPlayer(self, "Natural flows replenish you.")
    --refresh random available spell
  end
  if deity == "Immotian" then
    --if threatened
  --  self:divineMessage("Immotian", "custom four")
    --Empowered+Maximized+Enlarged Order's Wrath centered on player
    --else if something then
    --self:incFavorFor("Immotian", 4d50) self:divineMessage("Immotian", "custom seven")
    --else summon fire critters self:divineMessage("Immotian", "custom three")
  end
  if deity == "Khasrach" then
    --summon orcs
    --if angry self:divineMessage("Khasrach", "custom three") all orcs e.faction = "enemies"
    --else self:divineMessage("Khasrach", "custom two") e.faction == "players"
  end

  if deity == "Kysul" then
    if self:getFavorLevel(self.max_favor) < 3 then
    else --gift random item
  --    self:divineMessage("Kysul", "custom one")
    end
  end

  if deity == "Mara" then
    if self.favor >= 1500 then
      --summon revenant
    --  self:divineMessage("Mara", "custom two")
    end
  end

  if deity == "Maeve" then
    --exercise LUC
    self:exerciseStat("luc", rng.dice(4,12), "luc_Maeve", 80)
    --if threatened and rng.dice(1,2) == 1 then
    --Othello's Irresistible Dance on player
  --  self:divineMessage("Maeve", "custom eight")
    --else self:randomMaeveStuff(false) end
  end

  if deity == "Sabin" then
    --if has allies then self:transgress("Sabin", 1, "relying on others")
    if self:getFavorLevel(self.max_favor) > 3 then
      self:divineMessage("Sabin", "custom two")
      local gain = 10*self.level*self:getFavorLevel(self.max_favor)
      self:gainExp(gain)
      --exercise INT
      self:exerciseStat("int", rng.dice(5,12), "int_Sabine", 70)
    end
  end
  if deity == "Semirath" then
    --fumble a non-good hostile humanoid in player's sight if there's one
  --  self:divineMessage("Semirath", "custom one")
    --game.logSeen("%s collapses in a fit of uncontrollable laughter!")
  end
  if deity == "Xavias" then
    game.logPlayer(self, "Your mind is filled with dreamlike images and cryptic symbolism -- you are enlightened!")
    --exercise INT & WIS
    self:exerciseStat("int", rng.dice(5,12), "int_Xavias", 70)
    self:exerciseStat("wis", rng.dice(5,12), "wis_Xavias", 70)

    local Intbonus = math.floor((game.player:getInt()-10)/2)
    local Wisbonus = math.floor((game.player:getWis()-10)/2)
    self:gainExp(math.max(1,((Intbonus+Wisbonus)*100)))
  end
  if deity == "Xel" then
    if self.life < self.max_life then
      game.logPlayer(self, "Stolen vitality heals your injuries!")
      self:resetToFull()
    end
  end
  if deity == "Zurvash" then
    --if has a non-animal ally, self:transgress("Zurvash", 1, "relying on others")
    game.logPlayer(self, "You go berserk! You feel flush with a supernatural endurance!")
    self:setEffect(self.EFF_RAGE, self:getFavorLevel(self.max_favor), {})
  end

  if deity == "Multitude" then
    --if something then
    --summon several player.level+2 demons for 30+Chamod turns
    --if angry, e.faction = "enemies", else e.faction = "players"
    --self:divineMessage("Multitude", "custom three")
    --else
    self:incFavorFor("Multitude", rng.dice(4,50))
    self:divineMessage("Multitude", "custom seven")
  end

end

function _M:godAnger()
    local deity = self.descriptor.deity

    if deity == "Aiswin" then
      --if not afraid then
    --  self:setEffect(self.EFF_FEAR, 200, {})
      game:logPlayer(self, "You catch vague glimses of nightmarish, obscene shapes menacing you from the shadows!")
    end

    if deity == "Ekliazeh" then
      --pick random good item, destroy it
    --  game:logPlayer(self, "Your %s dissolves into a pile of gravel!":format(o.name))
    end

    if deity == "Erich" then
      --if already has this effect, do nothing
      --self:setEffect(self.EFF_ERICH_DISFAVOR, 20, {})
      self:divineMessage("Erich", "custom four")
    end

    if deity == "Essiah" then
      --if has ESSIAH_DREAM flag, remove it
      game.logPlayer(self, "In your dreams, you relive all the suffering you have wrongfully brought to others!")
      --CON damage 3d10
    end

    if deity == "Hesani" then
      --forget random x spells prepared
      game.logPlayer(self, "Moving against the currents of the world, you feel depleted.")
    end

    if deity == "Immotian" then
      --if has potion in equipment, destroy it and give a potion of blood instead
      --self:divineMessage("Immotian", "custom five")
      --else cast insect plague on player
      self:divineMessage("Immotian", "custom three")
    end

    if deity == "Khasrach" then
      if game.level.level > math.min(9, self.level+2) then
        --retribution
      end
      self:divineMessage("Khasrach", "custom one")
      game.logPlayer(self, "You are cast down!")

      local change = (10 - game.level.level)

      if game.level.level >= 10 then game:changeLevel(1)
      else
--[[        if game.zone.max_level >= self.level.level + change then
        game:changeLevel(change) end]]
      end
    end

    if deity == "Kysul" then
      --get closest enemy, apply pseudonatural template to it
      self:divineMessage("Kysul", "custom three")
    end

    if deity == "Mara" then
      if self.type ~= "undead" then
        self:divineMessage("Mara", "custom one")
        game.logPlayer(self, "Your body decomposes!")
      end
    end

    if deity == "Maeve" then
      self:randomMaeveStuff(true)
    end

    if deity == "Sabin" then
      self:divineMessage("Sabin", "custom one")
      --swap attributes
    end

    if deity == "Semirath" then
      if self.anger >= 15 then
        self:divineMessage("Semirath", "custom two")
        --retribution
      end
      --take random item and place it in a random place on map
    end

    if deity == "Xavias" then
      game.logPlayer(self, "Your mind is filled with dreamlike images and cryptic symbolism -- you can't comprehend it!")
      --a harrowing vision from Xavias, confuse for 40 turns
    end

    if deity == "Xel" then
      game.logPlayer(self, "Xel drinks your life!")
    --  deal xd6 necro damage
    --if self.life == old life then
    --game.logPlayer("You feel Xel is angrier now")
    --self:transgress("Xel", 1, false, "frustrating Xel")
    end

    if deity == "Zurvash" then
      local result = rng.dice(1,3)
      local duration = rng.dice(3,8)
      if result == 1 then
        game.logPlayer(self, "You are stricken with fear!")
        --self:setEffect(self.EFF_FEAR, duration, {})
      end
      if result == 2 then
        game.logPlayer(self, "You are stricken with weakness")
        --reduce STR by ?
      end
      if result == 3 then
        game.logPlayer(self, "You are inexplicably struck blind!")
        --self:setEffect(self.EFF_BLIND, duration, {})
      end
    end

    if deity == "Multitude" then
      self:divineMessage("Multitude", "custom four")
      --summon multiple CR player.level+2 hostile demons
    end
end

function _M:randomMaeveStuff(anger)
  local result = rng.dice(1,8)

  if anger then result = rng.dice(1,4) end

  --BAD stuff
  if result == 1 then
    --remove random cloak/ring/amulet
  --  game.logPlayer(self, "Your %s vanishes!":format(o.name))
  end

  if result == 2 then
    --summon single non-good non-lawful hostile CR self.level +2
    self:divineMessage("Maeve", "custom two")
  end

  if result == 3 then
    self:divineMessage("Maeve", "custom three")
    --Maeve's Whimsy
  end

  if result == 4 then
    --find closest friendly and turn it hostile
    self:divineMessage("Maeve", "custom four")
  end

  --Good stuff
  if result == 5 then
    --random magic non-cursed item gets an additional +1
    self:divineMessage("Maeve", "custom four")
  --  game.logPlayer("Your %s glows with a silvery light!"):format(o.name))
  end

  if result == 6 then
    self:divineMessage("Maeve", "custom six")
    local result = rng.dice(1,3)
    if result == 1 then
      --random druidic spell level (CR+2)/3
      game.logPlayer(self, "Knowledge of the dweomer %s imprints itself on your mind!"):format(t.name)
    else
      --random arcane spell, level (CR+2)/3
      game.logPlayer(self, "Knowledge of the dweomer %s imprints itself on your mind!"):format(t.name)
    end
  end

  if result == 7 then
    self:divineMessage("Maeve", "custom seven")
    --give a random good item
  end

  if result == 8 then
    game.logPlayer(self, "You are surronded in a corona of rainbow light!")
    --for every non-construct hostile in LOS and 12 range
  --  game.logSeen("%s's heart is forever ensnared!":format(e.name))
  end

end

--Determines if the sacrifice is neutral, unworthy, angry or abomination
function _M:getActorSacrificeReaction(deity, actor)
  local ret

  if deity == "Aiswin" then
    if actor.type == "humanoid" then
      ret = "neutral"
    end
    --no flag for grave wounding
    if not actor.aiswin or not actor.aiswin == true then
      ret = "unworthy"
    end
    --if used to be friendly then return "abomination"
  end

  if deity == "Ekliazeh" then
    if actor.subtype == "dwarf" then
      ret = "abomination"
    end
    --if was friendly then return "unworthy"
  end

  if deity == "Erich" then
    if actor.subtype == "goblinoid" then
      ret = "abomination"
    end
  end

  if deity == "Essiah" then
    --if non-evil then ret = "angry"
    --if was friendly then ret = "angry"
    --or vampire or erinyes or gray nymph
    if actor.name == "satyr" or actor.name == "nymph" then
      ret = "neutral"
    end
  end

  if deity == "Khasrach" then
    if actor.subtype == "goblinoid" then
      ret = "angry"
    end
    if actor.subtype == "orc" then
      ret = "abomination"
    end
    if actor.challenge < self.level then
      ret = "unworthy"
    end
  end

  if deity == "Kysul" then
    if actor.type == "aberration" then
      ret = "neutral"
      --if not evil then ret = "abomination"
    end
  --  if actor.alignment == "lawful good" or actor.alignment == "neutral good" or actor.alignment == "chaotic good"
  --or was friendly then ret = "abomination"
  end

  if deity == "Mara" then
    --flag damaged by player
    if actor.mara == true then
      ret = "abomination"
    else
      ret = "neutral"
    end
  end

  if deity == "Maeve" then
    if actor.subtype == "elf" then
      ret = "abomination"
    end
  end

  if deity == "Multitude" then
    --if non-good and was friendly then ret = "unworthy"
  end

  if deity == "Zurvash" then
    if actor.challenge < self.level then
      ret = "unworthy"
    end
  end

  return ret
end

function _M:sacrificeMult(actor)
  local deity = game.player.descriptor.deity

  if not deity.sacrifice then return end

  if not deity.sacrifice[actor.type] or deity.sacrifice[actor.subtype] then return end

  if actor.type ~= "humanoid"  then
    return deity.sacrifice[actor.type]
  else
    if not deity.sacrifice[humanoid] then
    return deity.sacrifice[actor.subtype]
    else return deity.sacrifice[actor.type]
    end
  end
end



function _M:sacrificeValue(actor)
  local player = game.player
  local value = player.sacrifice_value
  local max_value = player.max_sacrifice_value
  local mult = 10

  mult = self:sacrificeMult(actor) or 10

--  value = (mult*actor.challenge*(10+player.knowledge_skill))/10
    --cba to add another skill now
    player.sacrifice_value = player.sacrifice_value or {}
    value[actor.type] = value[actor.type] or 0
    value[actor.type] = (mult*actor.challenge)/10

    player.max_sacrifice_value = player.max_sacrifice_value or {}
    max_value[actor.type] = max_value[actor.type] or 0

    if value[actor.type] > (max_value[actor.type] or 0) then
      max_value[actor.type] = value[actor.type]
      self.impressed_deity = true
    end

    return value[actor.type]

end


--NOTE: actor is the monster that got killed on the altar tile
function _M:liveSacrifice(actor)
  local player = game.player
  --sacrificing only to player's deity for now
  local deity = self.descriptor.deity

  local sac_val = self:sacrificeValue(actor)

  --No live sacrifices if Hesani worshipper
  if deity == "Hesani" then return end
  --..or Immotian
  if deity == "Immotian" then return end

  if self.forsaken == true then
    player:divineMessage(deity, "bad prayer")
    --retribution
  return end

  --if actor.summoned == true or actor.illusion == true then return end

  --check deity reaction first before doing anything else
  if self:getActorSacrificeReaction(deity, actor) == "abomination" then
    player:transgress(deity, 5, true, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end

  if self:getActorSacrificeReaction(deity, actor) == "angry" then
    player:transgress(deity, 1, false, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end
  if self:getActorSacrificeReaction(deity, actor) == "unworthy" then
    player:divineMessage(deity, "insufficient")
    return end


  player:divineMessage(deity, "sacrifice")

  self:sacrificeValue(actor)

  --reduce anger
  if self.anger > 0 then
    local check_anger = math.max(0, (self.anger-3))
    if check_anger > 0 then
      player:divineMessage(deity, "lessened")
    else
      player:divineMessage(deity, "mollified")
    end
  end

  --message
  if self.impressed_deity == true then
    player:divineMessage(deity, "impressed")
    --exercise WIS
  else
    player:divineMessage(deity, "satisfied")
  end

  --increase favor by sacrifice value
  player:incFavorFor(deity, sac_val)

end

function _M:sacrificeItemMult(actor)
  local deity = game.player.descriptor.deity

  if not deity.sacrifice then return end

  if not deity.sacrifice[item.type] or deity.sacrifice[item.subtype] then return end

end



function _M:sacrificeItemValue(item)
  local player = game.player
  local value = player.sacrifice_value
  local max_value = player.max_sacrifice_value
  local mult = 10

  mult = self:sacrificeItemMult(item) or 10

--  value = (mult*actor.challenge*(10+player.knowledge_skill))/10
    --cba to add another skill now
    player.sacrifice_value = player.sacrifice_value or {}
    value[item.type] = value[item.type] or 0
    value[item.type] = (mult*item.cost)/10

    player.max_sacrifice_value = player.max_sacrifice_value or {}
    max_value[item.type] = max_value[item.type] or 0


    --deity is impressed if item.cost > WealthByLevel[self.level / 2] / 20)
 --[[   if value[item.type] > (max_value[item.type] or 0) then
      max_value[item.type] = value[item.type]
      self.impressed_deity = true
    end]]

    return value[item.type]
end


function _M:itemSacrifice(item)
  local player = game.player
  --sacrificing only to player's deity for now
  local deity = self.descriptor.deity

  local sac_val

  --Hesani takes only golden items

  if self.forsaken == true then
    player:divineMessage(deity, "bad prayer")
    --retribution
  return end

  --check deity reaction first before doing anything else
  if self:getActorSacrificeReaction(deity, actor) == "abomination" then
    player:transgress(deity, 5, true, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end

  if self:getActorSacrificeReaction(deity, actor) == "angry" then
    player:transgress(deity, 1, false, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end
  if self:getActorSacrificeReaction(deity, actor) == "unworthy" then
    player:divineMessage(deity, "insufficient")
    return end


  player:divineMessage(deity, "sacrifice")


  if item.subtype == "corpse" and item.victim then
    sac_val = self:sacrificeValue(item.victim)
  else
    sac_val = self:sacrificeItemValue(item)
  end

  --reduce anger
  if self.anger > 0 then
    local check_anger = math.max(0, (self.anger-3))
    if check_anger > 0 then
      player:divineMessage(deity, "lessened")
    else
      player:divineMessage(deity, "mollified")
    end
  end

  --message
  if self.impressed_deity == true then
    player:divineMessage(deity, "impressed")
    --exercise WIS
  else
    player:divineMessage(deity, "satisfied")
  end

  --increase favor by sacrifice value
  player:incFavorFor(deity, sac_val)

end

--Do only one thing in order of importance
--Deduce aid costs as favor penalty %
---if existing favor penalty + aid cost > 100 then player:divineMessage(deity, "out of aid")
--if favor penalty > 70 & favor penalty + aid cost <= 70 then player:divineMessage(deity, "nearly out")
function _M:divineAid()
  local player = game.player
  local poisoned = player:isPoisoned()

  if self.life < self.max_life*0.7 then
    self:resetToFull()
    game.logPlayer(self, "Your wounds heal fully!")
    return end
  if poisoned then player:removeEffect(self[poisoned]) return end
  if self.nutrition < 1500 then
    self.nutrition = 3500
    game.logPlayer(self, "You no longer feel hungry.")
    return end
--if petrified then unpetrify "Your afflictions are purified!"
--if blind then remove the effect "Your afflictions are purified!"
--if paralysed/held then remove the effect "Divine clarity restores focus to your thoughts!"
--if afraid then remove the effect "Your afflictions are purified!"
--if enemy & enemy CR > player.level*2 then teleport "deity carries you to safety!"
--if diseased/sick then remove the effect "Your afflictions are purified!"
--if cursed then remove curse ""Your curses are lifted!"
  if self.nutrition < 2000 then
    self.nutrition = 3500
    game.logPlayer(self, "You no longer feel hungry.")
    return end
-- if enemy & enemy CR > player.level then smite

end


--For prayer talent
function _M:pray()
  game.logPlayer(self, ("You prayed to %s for divine aid"):format(self.descriptor.deity))

  --knowledge:theology check against PRAYER_DC
  --"You fail to recite the ritual prayers and invocations correctly." if failed

  --if not your deity, divine jealousy

  --if self.anger above tolerance, retribution

  --maybe implement timeout?

  self:divineAid()

end






--Moddable tiles code from ToME 4
--- Return attachement coords
function _M:attachementSpot(kind, particle)
  local as = self.attachement_spots or self.image
  if not as then return end
  if not game.tiles_attachements or not game.tiles_attachements[as] or not game.tiles_attachements[as][kind] then return end
  local x, y = 0, 0
  if particle then x, y = -0.5, -0.5 end
  return game.tiles_attachements[as][kind].x + x, game.tiles_attachements[as][kind].y + y
end

--- Update tile for races that can handle it
function _M:updateModdableTile()
  if not self.moddable_tile or Map.tiles.no_moddable_tiles then
    local add = self.add_mos or {}
--[[    if self.shader_auras and next(self.shader_auras) then
      local base, baseh, basey, base1 = nil
      if self.image == "invis.png" and add[1] and add[1].image then
        base = add[1].image
        base1 = true
        baseh, basey = add[1].display_h, add[1].display_y
      elseif not self.add_mos then
        base = self.image
        base1 = false
        baseh, basey = self.display_h, self.display_y
      end

      if base then
        self.add_mos = add
        for _, def in pairs(self.shader_auras) do
          table.insert(add, 1, {_isshaderaura=true, image_alter="sdm", sdm_double=not baseh or baseh < 2, image=base, shader=def.shader, shader_args=def.shader_args, textures=def.textures, display_h=2, display_y=-1})
        end
        if not base1 then add[#add+1] = {_isshaderaura=true, image=base, display_y=basey, display_h=baseh} end

        self:removeAllMOs()
        if self.x and game.level then game.level.map:updateMap(self.x, self.y) end
      end
    else]]if self.add_mos then
    --[[  for i = #add, 1, -1 do
        if add[i]._isshaderaura then table.remove(add, i) end
      end]]
      if not next(self.add_mos) then self.add_mos = nil end

      self:removeAllMOs()
      if self.x and game.level then game.level.map:updateMap(self.x, self.y) end
    end
    return
  end
  self:removeAllMOs()


    local base = "default/tiles/player/default/"
    --Use racial dolls
    local doll = "default/tiles/player/racial_dolls/"

	  self.image = doll..(self.moddable_tile_base or "human_m.png")
  	self.add_mos = {}
  	local add = self.add_mos
  	local i

--  self:triggerHook{"Actor:updateModdableTile:back", base=base, add=add}

  i = self.inven[self.INVEN_CLOAK]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile):format("behind")..".png", auto_tall=1} end

--[[  if self.shader_auras and next(self.shader_auras) then
    for _, def in pairs(self.shader_auras) do
      add[#add+1] = {image_alter="sdm", sdm_double=true, image=base..(self.moddable_tile_base or "base_01.png"), shader=def.shader, shader_args=def.shader_args, textures=def.textures, display_h=2, display_y=-1}
    end
  end]]

  if not self:attr("disarmed") then
    i = self.inven[self.INVEN_MAIN_HAND]; if i and i[1] and i[1].moddable_tile_back then
      add[#add+1] = {image = base..(i[1].moddable_tile_back):format("right")..".png", auto_tall=1}
    end
    i = self.inven[self.INVEN_OFF_HAND]; if i and i[1] and i[1].moddable_tile_back then
      add[#add+1] = {image = base..(i[1].moddable_tile_back):format("left")..".png", auto_tall=1}
    end
  end

  i = self.inven[self.INVEN_CLOAK]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile):format("shoulder")..".png", auto_tall=1} end
  i = self.inven[self.INVEN_BOOTS]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile)..".png", auto_tall=1} end
  i = self.inven[self.INVEN_BODY]; if i and i[1] and i[1].moddable_tile2 then add[#add+1] = {image = base..(i[1].moddable_tile2)..".png", auto_tall=1}
  elseif not self:attr("moddable_tile_nude") then add[#add+1] = {image = base.."lower_body_01.png"} end
  i = self.inven[self.INVEN_BODY]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile)..".png", auto_tall=1}
  elseif not self:attr("moddable_tile_nude") then add[#add+1] = {image = base.."upper_body_01.png"} end
  i = self.inven[self.INVEN_HELM]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile)..".png", auto_tall=1} end
  i = self.inven[self.INVEN_GLOVES]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile)..".png", auto_tall=1} end
  i = self.inven[self.INVEN_CLOAK]; if i and i[1] and i[1].moddable_tile_hood then add[#add+1] = {image = base..(i[1].moddable_tile):format("hood")..".png", auto_tall=1} end
  i = self.inven[self.INVEN_QUIVER]; if i and i[1] and i[1].moddable_tile then add[#add+1] = {image = base..(i[1].moddable_tile)..".png", auto_tall=1} end
 if not self:attr("disarmed") then
    i = self.inven[self.INVEN_MAIN_HAND]; if i and i[1] and i[1].moddable_tile then
      add[#add+1] = {image = base..(i[1].moddable_tile):format("right")..".png", auto_tall=1}
      if i[1].moddable_tile_particle then
        add[#add].particle = i[1].moddable_tile_particle[1]
        add[#add].particle_args = i[1].moddable_tile_particle[2]
      end
      if i[1].moddable_tile_ornament then add[#add+1] = {image = base..(i[1].moddable_tile_ornament):format("right")..".png", auto_tall=1} end
    end
    i = self.inven[self.INVEN_OFF_HAND]; if i and i[1] and i[1].moddable_tile then
      add[#add+1] = {image = base..(i[1].moddable_tile):format("left")..".png", auto_tall=1}
      if i[1].moddable_tile_ornament then add[#add+1] = {image = base..(i[1].moddable_tile_ornament):format("left")..".png", auto_tall=1} end
    end
  end

--  self:triggerHook{"Actor:updateModdableTile:front", base=base, add=add}

  if self.moddable_tile_ornament and self.moddable_tile_ornament[self.female and "female" or "male"] then add[#add+1] = {image = base..self.moddable_tile_ornament[self.female and "female" or "male"]..".png", auto_tall=1} end
  if self.moddable_tile_ornament2 and self.moddable_tile_ornament2[self.female and "female" or "male"] then add[#add+1] = {image = base..self.moddable_tile_ornament2[self.female and "female" or "male"]..".png", auto_tall=1} end

  if self.x and game.level then game.level.map:updateMap(self.x, self.y) end
end

--Actually plug in the above
function _M:onWear(o, inven_id)
    engine.interface.ActorInventory.onWear(self, o, inven_id)

    self:updateModdableTile()
end

function _M:onTakeoff(o, inven_id)
    engine.interface.ActorInventory.onTakeoff(self, o, inven_id)

    self:updateModdableTile()
end

-- Quick Switch Weapons
function _M:quickSwitchWeapons(free_swap, message, silent)
	if self.no_inventory_access then return end

	-- Check for Quick Draw
	local free_swap = free_swap or false
	if self:knowTalent(self.T_QUICK_DRAW) then free_swap = true end

	local weapon = self:getInven("MAIN_HAND")[1]
	local ranged = self:getInven("SHOULDER")[1]
	local mh = self:getInven("MAIN_HAND")
	local sh = self:getInven("SHOULDER")

	if ranged and ranged.ranged then
		self:doWear(mh, 1, ranged)
		self:doWear(sh, 1, weapon, self, sh, 1)
		game.logPlayer("You swap your weapons")
		return end

	if ranged and not ranged.ranged then
		self:doWear(mh, 1, weapon)
		self:doWear(sh, 1, ranged)
		game.logPlayer("You swap your weapons")
		return end

end
