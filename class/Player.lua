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
require "mod.class.Actor"
require "engine.interface.PlayerRest"
require "engine.interface.PlayerRun"
require "engine.interface.PlayerMouse"
require "engine.interface.PlayerHotkeys"
local Map = require "engine.Map"
local Dialog = require "engine.Dialog"
local DeathDialog = require "mod.dialogs.DeathDialog"
local Astar = require"engine.Astar"
local DirectPath = require "engine.DirectPath"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(mod.class.Actor,
					  engine.interface.PlayerRest,
					  engine.interface.PlayerRun,
					  engine.interface.PlayerMouse,
					  engine.interface.PlayerHotkeys))

local exp_chart = {
  [1]	= 0,
  [2]	= 1000,
  [3]	= 2500,
  [4]	= 4500,
  [5]	= 7000,
  [6]	= 10000,
  [7]	= 14000,
  [8]	= 200000,
  [9]	= 280000,
  [10]	= 380000,
  [11]	= 500000,
  [12]	= 650000,
  [13]	= 850000,
  [14]	= 1100000,
  [15]	= 1400000,
  [16]	= 1800000,
  [17]	= 2300000,
  [18]	= 2900000,
  [19]	= 3600000,
  [20]	= 4400000,
  [21]	= 5400000,
  [22]	= 6800000,
  [23]	= 8400000,
  [24]	= 10200000,
  [25]	= 12500000,
  [26]	= 17500000,
  [27]	= 25000000,
  [28]	= 35000000,
  [29]	= 50000000,
  [30]	= 75000000,
  [31]	= 10000000,
  [32]	= 15000000,
  [33]	= 20000000,
  [34]	= 27500000,
  [35]	= 35000000,
  [36]	= 45000000,
  [37]	= 55000000,
  [38]	= 70000000,
  [39]	= 85000000,
  [40]	= 100000000,
  [41]	= 125000000,
  [42]	= 150000000,
  [43]	= 180000000,
  [44]	= 210000000,
  [45]	= 240000000,
  [46]	= 270000000,
  [47]	= 300000000,
  [48]	= 350000000,
  [49]	= 400000000,
  [50]	= 450000000,
}

function _M:init(t, no_default)
  t.display=t.display or '@'
  t.color_r=t.color_r or 230
  t.color_g=t.color_g or 230
  t.color_b=t.color_b or 230

  t.player = true
  t.type = t.type or "humanoid"
  t.subtype = t.subtype or "player"
  t.faction = t.faction or "players"

  t.lite = t.lite or 0

  mod.class.Actor.init(self, t, no_default)
  engine.interface.PlayerHotkeys.init(self, t)

  self.descriptor = {}
  self.max_level = 50
  self.max_exp = self.exp
  self.level_hiwater = self.level
  self.speed = 0
end

function _M:getExpChart(level)
  if not level or level < 1 then return 0 end
  return math.floor((exp_chart[level] * (self.xp_mult or 100))/100)
end

function _M:move(x, y, force)
  local moved = mod.class.Actor.move(self, x, y, force)
  if moved then
    game.level.map:moveViewSurround(self.x, self.y, 8, 8)

    self:describeFloor(self.x, self.y)
  end

  -- Remember not to describe this grid again.
  self.old_x, self.old_y = self.x, self.y

  return moved
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

  -- Clean log flasher
  game.flash:empty()

  -- Resting ? Running ? Otherwise pause
  if not self:restStep() and not self:runStep() and self.player then
    game.paused = true
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
  self:computeFOV(self.lite, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyLite(x, y) end, true, true, true)
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
  if spotHostiles(self) then return false, "hostile spotted" end

  if self.resting.rest_turns and self.repeat_action then
    -- Slight Hack(TM):  We re-use the resting infrastructure to repeat
    -- certain actions like attempting to open locked doors.
    return self:repeat_action()
  end

  -- Check resources, make sure they CAN go up, otherwise we will never stop
  --[[
  if self:getPower() < self:getMaxPower() and self.power_regen > 0 then return true end
  ]]

  -- Regen health at a rate of 1/50th of max_life after havign rested for 20 turns already 
  if self.resting.cnt > 20 then
    local regen = math.ceil(self.max_life / 50) or 1
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
  for _, tid in pairs(self.talents_def) do
    local c = self:getCharges(tid)
    local m = self:getMaxCharges(tid)
    if c < m then
      return true
    end
  end

  self.resting.wait_cooldowns = nil

  return false, "all resources and life at maximum"
end

function _M:onRestStop()
  -- Remove any repeating action.
  self.repeat_action = nil
end

--- Can we continue running?
-- We can run if no hostiles are in sight, and if we no interesting terrains are next to us
function _M:runCheck()
  if spotHostiles(self) then return false, "hostile spotted" end

  -- Notice any noticeable terrain
  local noticed = false
  self:runScan(function(x, y)
    -- Only notice interesting terrains
    local grid = game.level.map(x, y, Map.TERRAIN)
    if grid and grid.notice then noticed = "interesting terrain" end
  end)
  if noticed then return false, noticed end
  
  self:playerFOV()

  return engine.interface.PlayerRun.runCheck(self)
end

--- Move with the mouse
-- We just feed our spotHostile to the interface mouseMove
function _M:mouseMove(tmx, tmy)
  return engine.interface.PlayerMouse.mouseMove(self, tmx, tmy, spotHostiles)
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
        self:pickupFloor(1, true)
        self:sortInven()
        self:useEnergy()
    self.changed = true
    end
end

function _M:playerDrop()
    local inven = self:getInven(self.INVEN_INVEN)
    local d d = self:showInventory("Drop object", inven, nil, function(o, item)
        self:dropFloor(inven, item, true, true)
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
    if self:takeoffObject(inven, item) then
        self:addObject(self.INVEN_INVEN, o)
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
