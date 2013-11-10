-- Veins of the Earth
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
local NameGenerator = require "engine.NameGenerator"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(mod.class.Actor,
					  engine.interface.PlayerRest,
					  engine.interface.PlayerRun,
					  engine.interface.PlayerMouse,
					  engine.interface.PlayerHotkeys))

local exp_chart = function(level)
if level==1 then return 1000 
else return 500*level*(level+1)/2 end
end

function _M:init(t, no_default)
  image = "tiles/player.png"
  t.display=t.display or '@'
  t.color_r=t.color_r or 230
  t.color_g=t.color_g or 230
  t.color_b=t.color_b or 230

  t.player = true
  t.type = t.type or "humanoid"
  t.subtype = t.subtype or "player"
  t.faction = t.faction or "players"

  mod.class.Actor.init(self, t, no_default)
  engine.interface.PlayerHotkeys.init(self, t)

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
  self.nutrition = 100
  self.lite_counter = 5000
  self.id_counter = 2000

  self.weapon_type = {}
  self.favored_enemy = {}
  self.all_kills = self.all_kills or {}
end

function _M:onBirth()
  self:randomName()
  self:levelClass(self.descriptor.class)
  self:resetToFull()
  game:registerDialog(require"mod.dialogs.Help".new(self.player))
end

function _M:randomPerk()
local d = rng.dice(1,2)
  if d == 1 then self:randomFeat()
  elseif d == 2 then self:randomSpell() end
--  else self:randomItem() end 
end

function _M:randomName()
local random_name = {
  human_male = {
  syllablesStart ="Aeron, Courynn, Daelric, Dorn, Helm, Lynneth, Rowan, Sealmyd, Borivik, Fyodor, Vladislak, Khalid, Rasheed, Zasheir, Zasheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
  rules = "$s $e",
  },
  human_female = {
  syllablesStart ="Ariadne, Courynna, Daelra, Lynneth, Sealmyd, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Mara, Natali, Zofia, Jaheira, Zasheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
  rules = "$s $e",
  },
  halfelf_male = {
  syllablesStart ="Aeron, Courynn, Daelric, Dorn, Evendur, Helm, Lynneth, Rowan, Sealmyd, Khalid, Zasheir",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  halfelf_female = {
  syllablesStart ="Ariadne, Courynna, Lynneth, Rowan, Sealmyd, Shandri, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Mara, Natali, Zofia, Jaheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  elf_male = {
  syllablesStart ="Aravilar, Faelar, Saevel, Rhistel",
  syllablesMiddle = "Moon, Evening",
  syllablesEnd ="flower, blade, star, fall",
  rules = "$s $m$e",
  },

  elf_female = {
  syllablesStart ="Hacathra, Imizael, Talindra, Vestele",
  syllablesMiddle = "Moon, Evening",
  syllablesEnd ="flower, blade, star, fall",
  rules = "$s $m$e",
  },

  halforc_male = {
  syllablesStart ="Durth, Fang, Gothog, Harl, Orrusk, Orik, Thog",
  syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  halforc_female = {
  syllablesStart ="Orvaega, Duvaega, Varra",
  syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  dwarf_male = {
  syllablesStart ="Dorn, Khondar, Thorik",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold",
  syllablesEnd ="bite, shield, dark",
  rules = "$s $m$e",
  },

  dwarf_female = {
  syllablesStart ="Belmara, Dorna",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold",
  syllablesEnd ="bite, shield, dark",
  rules = "$s $m$e",
  },

  drow_male = { 
  syllablesStart ="Alak, Drizzt, Ilmryn, Khalazza, Merinid, Mourn, Nym, Pharaun, Rizzen, Solaufein, Tebryn, Zaknafein",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Baenre, Coloara, Glannath, Hune, Illistyn, Khalazza, Pharn, Seerear, Vrinn, Xiltyn",
  rules = "$s $m$e",
  },

  drow_female = { 
  syllablesStart ="Akordia, Chalithra, Chalinthra, Eclavdra, Nedylene, Qilue, SiNafay",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Baenre, Coloara, Glannath, Hune, Illistyn, Khalazza, Pharn, Seerear, Vrinn, Xiltyn",
  rules = "$s $m$e",
  },

  duergar_male = {
  syllablesStart = "Thorik, Dorn",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark",
  syllablesEnd = "bite, shield, dark",
  rules = "$s $m$e",
  },

  duergar_female = {
  syllablesStart = "Belmara, Dorna",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark",
  syllablesEnd = "bite, shield, dark",
  rules = "$s $m$e",
  },

  gnome_male = {
  syllablesStart = "Colmarr, Falrinn, Halbrinn",
  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "orm, rock, stone, horn",
  rules = "$s $m$e",
  },
  gnome_female = {
  syllablesStart = "Eliss, Lissa, Meree, Nathee",
  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "orm, rock, stone, horn",
  rules = "$s $m$e",
  }
} 

    if self.descriptor.race == "Human" then
      if self.descriptor.sex == "Female" then 
      local ng = NameGenerator.new(random_name.human_female) 
      self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else local ng = NameGenerator.new(random_name.human_male)
        self:setName(ng:generate()) 
        print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Half-Elf" or self.descriptor.race == "Half-Drow" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halfelf_female)
        self:setName(ng:generate()) 
        print("GENERATING A RANDOM NAME")
      else
      local ng = NameGenerator.new(random_name.halfelf_male) 
      self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Elf" then
      if self.descriptor.sex == "Female" then
      local ng = NameGenerator.new(random_name.elf_female)
      self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else 
      local ng = NameGenerator.new(random_name.elf_male)
      self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Half-Orc" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halforc_female)
        self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else
      local ng = NameGenerator.new(random_name.halforc_male)
      self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Dwarf" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.dwarf_female)
        self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else 
      local ng = NameGenerator.new(random_name.dwarf_male) 
      self:setName(ng:generate())
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Drow" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.drow_female)
        self:setName(ng:generate()) 
        print("GENERATING A RANDOM NAME")
      else
      local ng = NameGenerator.new(random_name.drow_male)
      self:setName(ng:generate())
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Duergar" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.duergar_female)
        self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else
      local ng = NameGenerator.new(random_name.duergar_male) 
      self:setName(ng:generate())
      print("GENERATING A RANDOM NAME") end
    elseif self.descriptor.race == "Deep gnome" or self.descriptor.race == "Gnome" or self.descriptor.race == "Halfling" then 
      if self.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.gnome_female)
        self:setName(ng:generate()) 
      print("GENERATING A RANDOM NAME")
      else
      local ng = NameGenerator.new(random_name.gnome_male) 
      self:setName(ng:generate())
      print("GENERATING A RANDOM NAME") end
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