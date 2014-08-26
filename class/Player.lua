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
  self.ecl = 1

  
  self.descriptor = self.descriptor or {}
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

  self.weapon_type = {}
  self.favored_enemy = {}
  self.last_class = {}
  self.all_kills = self.all_kills or {}
  self.all_seen = self.all_seen or {}
  self.special_known = self.special_known or {}
end

function _M:onBirth()
  --Finish the character
  self:levelClass(self.descriptor.class)
  self:giveStartingEQ()

  self:giveStartingSpells()

--  self:setTile()
--  self:equipAllItems()

  savefile_pipe:push(game.player.name, "entity", game.player, "engine.CharacterVaultSave")

  -- HACK: This forces PlayerDisplay and HotkeysDisplay to update after birth descriptors are finished.
  game.player.changed = true
  self:resetToFull()
  self:setCountID()

--  game:registerDialog(require"mod.dialogs.Help".new(self.player))
end

function _M:onPremadeBirth()
--  self:setTile()
  --Add the basic talents
  self:learnTalent(self.T_SHOOT, true)
  self:learnTalent(self.T_POLEARM, true)
  self:learnTalent(self.T_STEALTH, true)

--  self:giveStartingSpells()

  -- HACK: This forces PlayerDisplay and HotkeysDisplay to update after birth descriptors are finished.
  game.player.changed = true
  self:resetToFull()
  self:setCountID()
--  game:registerDialog(require"mod.dialogs.Help".new(self.player))
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
  if self.descriptor.class == "Cleric" or self.descriptor.class == "Shaman" then
    self:setCharges(self.T_CURE_LIGHT_WOUNDS, 2)

  end

  if self.descriptor.class == "Wizard" or self.descriptor.class == "Sorcerer" then
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
  return ([[%s%s
#RED#HP: %d (%d%%)
#WHITE#STR %s DEX %s CON %s 
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

function _M:act()
  if not mod.class.Actor.act(self) then return end

  -- Funky shader things !
  self:updateMainShader()

  self.old_life = self.life

  self:spottedMonsterXP()

  self:checkEncumbrance()

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

 self.nutrition = self.nutrition - 1

 --Cap nutrition
 --NOTE: start 500, hungry 200, starving 50
 if self.nutrition == 1 then self.nutrition = 1 end

 --ID counters
 local inven = game.player:getInven("INVEN")
 self.id_counter = self.id_counter - 1
 self.pseudo_id_counter = self.pseudo_id_counter - 1

  if self.pseudo_id_counter == 0 then --and inven > 0 then
    self:pseudoID()
    self:setCountID()
  end

  if self.id_counter == 0 then
    self:autoID()
    self.id_counter = 50
  end

  -- Clean log flasher
--  game.flash:empty(true)

  -- Resting ? Running ? Otherwise pause
  if not self:restStep() and not self:runStep() and self.player then
    game.paused = true
  end
end

--- Funky shader stuff
function _M:updateMainShader()
  if game.fbo_shader then
  -- Set shader HP warning
    if self.life ~= self.old_life then
      if self.life < (self.max_life*0.5) then game.fbo_shader:setUniform("hp_warning", 1 - (self.life / self.max_life))
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

function _M:playerFOV()
  -- Clean FOV before computing it
  game.level.map:cleanFOV()
  -- Compute both the normal and the lite FOV, using cache
  self:computeFOV(self.sight or 20, "block_sight", function(x, y, dx, dy, sqdist)
    game.level.map:apply(x, y, fovdist[sqdist])
  end, true, false, true)

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
end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src)
  self:runStop("taken damage")
  self:restStop("taken damage")
  local ret = mod.class.Actor.onTakeHit(self, value, src)
  if self.life < self.max_life * 0.3 then
    local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
    game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, "LOW HEALTH!", {255,0,0}, true)
  end
  return ret
end

function _M:die(src)
  if self.game_ender then
    engine.interface.ActorLife.die(self, src)

    game.paused = true
    self.energy.value = game.energy_to_act
    game:registerDialog(DeathDialog.new(self))
    --Mark depth for bones
    World:boneLevel(game.level.level)
  else
    mod.class.Actor.die(self, src)
  end
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

--- Can we continue resting ?
-- We can rest if no hostiles are in sight, and if we need life/mana/stamina (and their regen rates allows them to fully regen)
function _M:restCheck()
  --Implemented Light Sleeper feat; EVIL!
  if self:knowTalent(self.T_LIGHT_SLEEPER) and spotHostiles(self) then return false, "hostile spotted" 
    elseif rng.percent(50) and spotHostiles(self) then return false, "hostile spotted" end


  -- Regen health at a rate of 1 hp per turn after having rested for 20 turns already 
  if self.resting.cnt > 20 then
    local regen = 1
    self.life = math.min(self.max_life, self.life + regen)
    
    --Refresh charges
    for _, tid in pairs(self.talents_def) do
      self:setCharges(tid, self:getMaxCharges(tid))
    end
  end

  if self.life < self.max_life then return true end


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

--Castler's fix for still lit tiles
function _M:runStopped()
    game.level.map.clean_fov = true
    self:playerFOV()
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

function _M:pseudoID()
local list = {}
        local inven = game.player:getInven("INVEN")
        i = rng.range(1, #inven)
        local o = inven[i]
          --add a check for empty inventory
          if o and o.pseudo_id == false then
            local check = self:skillCheck("intuition", 10, true)
                        if check then 
                          o.pseudo_id = true 
                        end        
          else end
end

function _M:autoID()
  local list = {}
        local inven = game.player:getInven("INVEN")
        i = rng.range(1, #inven)
        local o = inven[i]
          if o and o.identified == false and o.pseudo_id == true then
            local check = self:skillCheck("intuition", 25, true)
                        if check then 
                          o.identified = true 
                          game.logSeen(game.player, "Identified: %s", o.name)
                        end        
            else end
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
        local d d = self:showPickupFloor("Pickup", nil, function(o, item)
            self:pickupFloor(item, true)
            self.changed = true
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
    local inven = self:getInven(self.INVEN_INVEN)
    local d d = self:showInventory("Drop object", inven, nil, function(o, item)
        self:dropFloor(inven, item, true, true)
        self:checkEncumbrance()
        self:sortInven(inven)
        self:useEnergy()
        self.changed = true
        return true
    end)
end 

function _M:doDrop(inven, item, on_done, nb)
    if self.no_inventory_access then return end
    
    if nb == nil or nb >= self:getInven(inven)[item]:getNumber() then
        self:dropFloor(inven, item, true, true)
    else
        for i = 1, nb do self:dropFloor(inven, item, true) end
    end
    self:sortInven(inven)
    self:useEnergy()
    self.changed = true
    if on_done then on_done() end
end

function _M:doWear(inven, item, o)
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
end

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

--Usable items
function _M:playerUseItem(object, item, inven)
    local use_fct = function(o, inven, item)
        if not o then return end
        local co = coroutine.create(function()
            self.changed = true

            local ret = o:use(self, nil, inven, item) or {}
            if not ret.used then return end
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

    local titleupdator = self:getEncumberTitleUpdator("Use object")
    self:showEquipInven(titleupdator(),
        function(o)
            return o:canUseObject()
        end,
        use_fct
    )
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

--Player-specific perks stuff
--Pick a random egoed item to be given as perk
function _M:randomItem()
  local chance = rng.dice(1,15)
  if chance == 1 then self.perk_item = "iron battleaxe" 
  elseif chance == 2 then self.perk_item = "rapier" 
  elseif chance == 3 then self.perk_item = "long sword"  
  elseif chance == 4 then self.perk_item = "iron dagger" 
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
  local o = game.zone:makeEntity(game.level, "object", {name="iron battleaxe", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="iron battleaxe", ego_chance=1000}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="iron dagger", ego_chance=1000}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="iron dagger", ego_chance=1000}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="iron battleaxe", ego_chance=-1000}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="iron dagger", ego_chance=-1000}, 1, true)
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
        then self:givePerkArmor()  end

    elseif class == "Paladin" then
      --Account for perk items
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
        --Ranged weapons
       or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
          then self:givePerkWeapon() end
      self:giveDagger()
      --Account for perk items
      if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor" 
        then self:givePerkArmor() end

    elseif class == "Wizard" then
      --Account for perk items
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
      if self.perk_item == "iron battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "iron dagger" or self.perk_item == "morningstar"
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
    if self.perk_item == "iron battleaxe" then self:giveEgoAxe()      
    elseif self.perk_item == "rapier" then self:giveEgoRapier()
    elseif self.perk_item == "long sword" then self:giveEgoSword()
    elseif self.perk_item == "iron dagger" then self:giveEgoDagger()
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


--Display a cool player tile
function _M:setTile()
  self:removeAllMOs()
  if self.descriptor.race == "Human" then 
    if self.descriptor.class == "Barbarian" then end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_human_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_human_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_human_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_human_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_human_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_human_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_human_sorcerer.png" end
    
  elseif self.descriptor.race == "Half-Elf" or self.descriptor.race == "Half-Drow" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_halfelf_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_halfelf_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_halfelf_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_halfelf_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_halfelf_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_halfelf_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_halfelf_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_halfelf_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player_halfelf_sorcerer.png" end

  elseif self.descriptor.race == "Elf" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_elf_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_elf_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_elf_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_elf_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_elf_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_elf_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_elf_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_elf_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_elf_sorcerer.png" end

  elseif self.descriptor.race == "Drow" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_drow_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_drow_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_drow_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_drow_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_drow_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_drow_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_drow_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_drow_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_drow_sorcerer.png" end

  elseif self.descriptor.race == "Dwarf" or self.descriptor.race == "Duergar" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_dwarf_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_dwarf_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_dwarf_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_dwarf_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_dwarf_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_dwarf_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_dwarf_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_dwarf_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_dwarf_sorcerer.png" end

  elseif self.descriptor.race == "Halfling" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_halfling_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/player_halfling_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_halfling_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_halfling_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/player_halfling_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_halfling_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/newtiles/player/player_halfling_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_halfling_sorcerer.png" end

  elseif self.descriptor.race == "Gnome" or self.descriptor.race == "Kobold" then
    if self.descriptor.class == "Barbarian" then self.image = "tiles/newtiles/player/player_gnome_fighter.png" end
    if self.descriptor.class == "Bard" then self.image = "tiles/newtiles/player/player_gnome_rogue.png" end
    if self.descriptor.class == "Cleric" then self.image = "tiles/player.png" end
    if self.descriptor.class == "Druid" then self.image = "tiles/newtiles/player/player_gnome_priest.png" end
    if self.descriptor.class == "Fighter" then self.image = "tiles/newtiles/player/player_gnome_fighter.png" end
    if self.descriptor.class == "Ranger" then self.image = "tiles/newtiles/player/player_gnome_ranger.png" end
    if self.descriptor.class == "Rogue" then self.image = "tiles/newtiles/player/player_gnome_rogue.png" end
    if self.descriptor.class == "Sorcerer" then self.image = "tiles/newtiles/player/player_gnome_sorcerer.png" end
    if self.descriptor.class == "Wizard" then self.image = "tiles/player_gnome_mage.png" end
    if self.descriptor.class == "Warlock" then self.image = "tiles/newtiles/player/player_gnome_sorcerer.png" end  
  else end

  Map:resetTiles()
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


--    local base = "tiles/player/"..self.moddable_tile.."/"

    local base = "default/tiles/player/default/"

	self.image = base..(self.moddable_tile_base or "human_m.png")
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
