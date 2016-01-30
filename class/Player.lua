-- Veins of the Earth
-- Zireael 2013-2015
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
local DamageType = require "engine.DamageType"
local Astar = require"engine.Astar"
local DirectPath = require "engine.DirectPath"
local World = require "mod.class.World"
local PlayerLore = require "mod.class.interface.PlayerLore"
local PlayerReligion = require "mod.class.interface.PlayerReligion"
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
			mod.class.interface.PlayerReligion,
            mod.class.interface.PartyDeath,
            PlayerLore))

local exp_chart = function(level)
if level==1 then return 1000
else return 500*level*(level+1)/2 end
end

--Stuff for class descriptions which for some reason can't go in Birther or definitions themselves
_M.bab_to_number = {
	full = 1,
	good = 0.75,
	bad = 0.5,
}

_M.save_to_number = {
	first = {
		good = 2,
		bad = 0,
	},
	other = {
		good = 0.66,
		bad = 0.33,
	}
}

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
  self.bank_money = 0
  self.background_points = 2 --to account for lvl 1

  --Timers :D
  self.nutrition = 5000
  self.lite_counter = 5000
  self.pseudo_id_counter = 10
  self.id_counter = 50
  self.god_pulse_counter = 35
  self.god_anger_counter = 35

  self.weapon_type = {}
  self.favored_enemy = {}
  self.last_class = {}
  self.all_kills = self.all_kills or {}
  self.languages = {}

  --Knowledge tracking
  self.all_seen = self.all_seen or {}
  self.special_known = self.special_known or {}
  self.hp_known = self.hp_known or {}
  self.type_known = self.type_known or {}

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

  --kids
  self.kids = {}

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

  self:checkNutrition()

  -- Resting ? Running ? Otherwise pause
  if not self:restStep() and not self:runStep() and self.player then
    game.paused = true
  end
end

function _M:playerCounters()
	self:decreaseNutrition(1)

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

	--dependent on XP tick
	--ID counters
	 local inven = game.player:getInven("INVEN")

	 --Don't count down ID when resting
	 if not self.resting and self:xpTick() then
	 self.id_counter = self.id_counter - 1
	 self.pseudo_id_counter = self.pseudo_id_counter - 1
	  end

  --Deity counters
  if self.descriptor.deity ~= "None" and not self.resting then
	if self:xpTick() then
		self.god_pulse_counter = self.god_pulse_counter - 1

	    if self.anger > 0 then
	    self.god_anger_counter = self.god_anger_counter - 1
	    end
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

	--Stuff every xp tick
	if self:xpTick() then

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
end

--Birth stuff
function _M:onBirth()
  --Finish the character
  self:levelClass(self.descriptor.subclass)
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
  if self.descriptor.subclass == "Cleric" then --or self.descriptor.subclass == "Shaman" then
    self:setCharges(self.T_CURE_LIGHT_WOUNDS, 2)

  end

  if self.descriptor.subclass == "Wizard" or self.descriptor.subclass == "Magus" then --or self.descriptor.subclass == "Sorcerer" then
    self:setCharges(self.T_MAGIC_MISSILE, 2)
    self:setCharges(self.T_MAGE_ARMOR, 1)
  end

  if self.descriptor.subclass == "Bard" then
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

	--Worldmap passage of time
	if game.zone.worldmap and not force then
		-- Cheat with time
		local change = 1000
		game.turn = game.turn + change
		self:decreaseNutrition(change/10)

		if moved then
			--Forage
			local check = self:skillCheck("survival", 10)
			if check then
				self:incNutrition(1000)
			end

			--Hunt
		--[[	local check = self:skillCheck("survival", 15)
			if check then
				self:incNutrition(2000)
			end]]
		end
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
--[[  ts:add(("Casting speed: %s"):format(self:spellCastingSpeed()))
  ts:add(("Game turn: %s"):format(game.turn/10), true)

  ts:add(("Global speed: %d"):format(self.global_speed or 1), true)

  ts:add(("Energy remaining: %d"):format(self.energy_value or 1), true)

  ts:add(("Movement speed: %d"):format(self.movement_speed or 1), true)

  ts:add(("Movement speed bonus: %0.1f"):format(self.movement_speed_bonus or 0), true)]]

  return ts
end

function _M:describeFloor(x, y)
  if self.old_x == self.x and self.old_y == self.y then return end

  -- Auto-pickup stuff from floor.
  if self:getInven(self.INVEN_INVEN) and not self:attr("sleep") then
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
  end


  -- i is now one higher than the number of objects on the floor.
  -- TODO Prompt to pickup, probably controlled by a setting.
  if i and i == 2 then
    game.log('On floor:  %s', game.level.map:getObject(x, y, 1):getName())
 elseif i and i > 2 then
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
  fovdist[i] = math.max((20 - math.sqrt(i)) / 17, 0.6)
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

	--used by tracking
	if self:attr("heightened_senses") then
		local radius = (self.heightened_senses or 0)
		local lite = math.max(self.lite, (self.infravision or 0))
		local bonus = math.max(1, radius + lite)
		self:computeFOV(bonus, "block_sight", function(x, y, dx, dy, sqdist)
			if game.level.map(x, y, game.level.map.ACTOR) then
				game.level.map.seens(x, y)
			end
		end, true, true, true)
	end

-- Apply lite from NPCs
  local uid, e = next(game.level.entities)
  while uid do
    if e ~= self and e.lite and e.lite > 0 and e.computeFOV then
      e:computeFOV(e.lite, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyExtraLite(x, y, fovdist[sqdist]) end, true, true)
    end
    uid, e = next(game.level.entities, uid)
  end

  -- Calculate our own FOV
	local lite = self.lite + (self.low_light_vision or 0)
  	self:computeFOV(lite, "block_sight", function(x, y, dx, dy, sqdist)
      game.level.map:applyLite(x, y)
	  --color it appropriately
	  if self:attr("lite") and self.lite >= 1 then
		  local map = game.level.map
	  	  local shown = map.color_shown
		  local tint = { r= 0.82, g = 0.75, b = 0.1}
		  map._map:setShown(shown[1] * (tint.r+0.4), shown[2] * (tint.g+0.4), shown[3] * (tint.b+0.4), shown[4])
  	  end
      game.level.map.remembers(x, y, true) -- Remember the tile
  end, true, false, true)

  --If our darkvision is better than our lite, check it.
  if (self:attr("infravision") or 0) > self.lite then
    self:computeFOV(self:attr("infravision"), "block_sight", function(x, y, dx, dy, sqdist)
      if not game.level.map.seens(x, y) then
        game.level.map.seens(x, y, 0.75) -- If we only see due to darkvision, it looks dark
      end
      game.level.map.remembers(x, y, true)
  end, true, false, true)
  end

  --else (so that npcs may still target us while blind)
--[[  -- Compute both the normal and the lite FOV, using cache
  self:computeFOV(self.sight or 10, "block_sight", function(x, y, dx, dy, sqdist)
    game.level.map:apply(x, y, fovdist[sqdist])
  end, true, false, true)]]

end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src, death_note)
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
        game.player.name:capitalize(), game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.subclass:lower(),
        death_mean or "battered",
        srcname,
        src.name == top_killer and " (yet again)" or "",
        killermsg,
        game.level.level, game.zone.name
      )
    else
      msg = "%s the level %d %s %s %s on level %s of %s."
      msg = msg:format(
        game.player.name, game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.subclass:lower(),
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

function _M:decreaseNutrition(turns)
	--paranoia
	if not turns then turns = 1 end

	--Count down nutrition
	local nutrition = self.nutrition

	if not self.resting then
	  if self:knowTalent(self.T_FASTING) then
		self:incNutrition(-0.33*turns)
	  elseif self.slow_digest then
		  self:incNutrition(-0.5*turns)
	  else
	  	self:incNutrition(-1*turns)
	  end
	end

	if self.resting then
	  --1/5th normal rate for elves
	  if self:hasDescriptor{race="Drow"} or self:hasDescriptor{race="Elf"} then
		if self:knowTalent(self.T_FASTING) then
		  self:incNutrition(-0.06*turns)
		else
		  self:incNutrition(-0.2*turns)
		end
	  else
		if self:knowTalent(self.T_FASTING) then
		self:incNutrition(-0.16*turns)
		  elseif self.slow_digest then
		  self:incNutrition(-0.25*turns)
		else
		--Halve hunger rate when sleeping
		self:incNutrition(-0.5*turns)
		end
	  end
	end

   --Cap nutrition
   if self.nutrition == 1 then self.nutrition = 1 end
end

--Apply effects from hunger
--see PlayerDisplay line 140 for values
function _M:checkNutrition()
	if self.nutrition > 3000 then
		if self:hasEffect(self.EFF_HUNGRY) then self:removeEffect(self.EFF_HUNGRY, true) end
	end
	if self.nutrition < 3000 then self:setEffect(self.EFF_HUNGRY, 1000, {}) end
	if self.nutrition < 2000 then
		self:setEffect(self.EFF_STARVING, 1000, {})
		if self:hasEffect(self.EFF_HUNGRY) then self:removeEffect(self.EFF_HUNGRY, true) end
	end
	if self.nutrition < 1500 then
		self:setEffect(self.EFF_WEAK, 1000, {})
		if self:hasEffect(self.EFF_STARVING) then self:removeEffect(self.EFF_STARVING, true) end
	end
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

	game.level.map.clean_fov = true
  	self:playerFOV()

  return engine.interface.PlayerRun.runCheck(self)
end

--- Called after running a step
function _M:runMoved()
	game.level.map.clean_fov = true
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

--- Uses an hotkeyed talent
-- This requires the ActorTalents interface to use talents and a method player:playerUseItem(o, item, inven) to use inventory objects
function _M:activateHotkey(id)
	-- Visual feedback to show which key was pressed
	if game.uiset.hotkeys_display and game.uiset.hotkeys_display.clics and game.uiset.hotkeys_display.clics[id] and self.hotkey[id] then
		local zone = game.uiset.hotkeys_display.clics[id]
		game.uiset:addParticle(
			game.uiset.hotkeys_display.display_x + zone[1] + zone[3] / 2, game.uiset.hotkeys_display.display_y + zone[2] + zone[4] / 2,
			"hotkey_feedback", {w=zone[3], h=zone[4]}
		)
	end

	return engine.interface.PlayerHotkeys.activateHotkey(self, id)
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

        act.seen = true

        --Formula found on the net because I suck at Maths
        local x = self.all_seen[act.name]
        local y = 100-(x*25)
        if y > 0 then self:gainExp(y) end

		--Plugged in: a silent Knowledge check to determine whether you know the specials
        self:skillCheck("knowledge", 10+act.challenge, true)
        self.special_known[act.uid] = true

		--determine if we know opponent hp
		self:skillCheck("heal", 10, true)
		self.hp_known[act.uid] = true

		--do we know enemy type?
		self:skillCheck("knowledge", 10)
		self.type_known[act.uid] = true

      end
    end

end


--Auto ID stuff
function _M:xpTick()
	if self.exp ~= self.old_exp then return true end
	return false
end

function _M:setCountID()
  if self.descriptor.subclass == "Rogue" then self.pseudo_id_counter = rng.range(5,10)
  elseif self.descriptor.subclass == "Fighter" or self.descriptor.subclass == "Barbarian" then self.pseudo_id_counter = rng.range(5,15)
  elseif self.descriptor.subclass == "Ranger" or self.descriptor.subclass == "Paladin" or self.descriptor.subclass == "Monk" or self.descriptor.subclass == "Warlock" or self.descriptor.subclass == "Cleric" then self.pseudo_id_counter = rng.range(10, 20)
  elseif self.descriptor.subclass == "Wizard" or self.descriptor.subclass == "Sorcerer" then self.pseudo_id_counter = rng.range(15, 25)
  end
end


function _M:decipherRunesItem(o)
	if not o.pseudo_id then

      if self:skillCheck("decipher_script", 15) then
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

  --Inventory
  function _M:playerPickup()
    -- If 2 or more objects, display a pickup dialog, otherwise just picks up
    if game.level.map:getObject(self.x, self.y, 2) then
		local titleupdator = self:getEncumberTitleUpdater("Pickup")
		local d d = self:showPickupFloor(titleupdator(), nil, function(o, item)
		        if self:attr("sleep") then
				game.logPlayer(self, "You cannot pick up items from the floor while asleep!")
				return
			end
			local o = self:pickupFloor(item, true)
			if o and type(o) == "table" then o.__new_pickup = true end
			self.changed = true
			d:updateTitle(titleupdator())
			d:used()
		end)
    else
		if self:attr("sleep") then
			return
		end
		local o = self:pickupFloor(1, true)
		if o and type(o) == "table" then
			self:useEnergy()
			o.__new_pickup = true
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
        if self.no_inventory_access then return end
	if not game.zone or game.zone.worldmap then game.logPlayer(self, "You cannot use items on the world map.") return end

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

--- Called upon dropping an object
function _M:onDropObject(o)
	if self.player then game.level.map.attrs(self.x, self.y, "obj_seen", true)
	elseif game.level.map.attrs(self.x, self.y, "obj_seen") then game.level.map.attrs(self.x, self.y, "obj_seen", false) end
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
        PlayerReligion:itemSacrifice(o)
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
function _M:putIn(bag, filter)
  local inven = self:getInven(self.INVEN_INVEN)
  local d d = self:showInventory("Put in", inven, nil, function(o, item)
    if not o.iscontainer then
      if bag:addObject(self.INVEN_INVEN, o) then
		if (filter and o.type == filter or o.subtype == filter) or not filter then
        	self:removeObject(inven, item, true)
        	self:sortInven(inven)
        	bag:sortInven(inven)
        	self:useEnergy()
        	self.changed = true
		else
			game.logSeen(self, "You can't put %s in this container", o:getName({no_count=true}))
		end
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

--new
function _M:doButcher(inven, item)
	local o = self:getInven(inven) and self:getInven(inven)[item]

	if o then

		self:removeObject(inven, item, true)
		game.logPlayer(self, "You butcher %s.", o:getName{do_colour=true, do_count=true})
		self:checkEncumbrance()
		self:sortInven(inven)

		local chunk = game.zone:makeEntity(game.level, "object", {name="chunk of meat", ego_chance=-1000}, 1, true)
		local chunk_stale = game.zone:makeEntity(game.level, "object", {name="chunk of stale meat", ego_chance=-1000}, 1, true)

		if o.name:find("stale") then
			local n = rng.dice(1,6)
			while n > 0 do
				game.zone:addEntity(game.level, chunk_stale, "object")
				self:addObject(game.player:getInven("INVEN"), chunk_stale)
				chunk_stale.pseudo_id = true
				n = n-1
				self:checkEncumbrance()
				self:sortInven(inven)
			end
		else
			local n = rng.dice(1,6)
			while n > 0 do
				game.zone:addEntity(game.level, chunk, "object")
				self:addObject(game.player:getInven("INVEN"), chunk)
				chunk_stale.pseudo_id = true
				n = n-1
				self:checkEncumbrance()
				self:sortInven(inven)
			end
		end

		self:useEnergy()
	end

	self:checkEncumbrance()
	self:sortInven(inven)
	self.changed = true

end

--Cleaner code
function _M:incNutrition(v)
	if not v then return end

	self.nutrition = self.nutrition + v
end

function _M:doEatFood(inven, item)
	local o = self:getInven(inven) and self:getInven(inven)[item]

	if o then
		if not o.base_nutrition then return end
		local base = o.base_nutrition
		local nut_mod = o.nutrition or 0
		local nut = (base*nut_mod) or 0
		self:removeObject(inven, item)
		self:incNutrition(nut)

		if o.subtype ~= "water" then
			game.logPlayer(self, "You eat %s.", o:getName{do_colour=true, no_count=true})
		else
			game.logPlayer(self, "You drink %s.", o:getName{do_colour=true, no_count=true})
		end

		self:checkEncumbrance()
		self:sortInven(inven)
	end
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

--Player only bank stuff
function _M:incBank(v)
	self.bank_money = self.bank_money + v
	if self.bank_money < 0 then self.bank_money = 0 end
end

--5% cut for storing
function _M:bankCharge(v)
	local charge = 0.05*v

	return v-charge
end

--Level titles stuff
function _M:dominantClass()
  local Birther = require "engine.Birther"

    local list = {}
    local player = game.player

  for i, d in ipairs(Birther.birth_descriptor_def.subclass) do

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
  local o = game.zone:makeEntity(game.level, "object", {name="battleaxe", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="rapier", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="long sword", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="dagger", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="morningstar", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="shortbow", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="shortbow", ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("MAIN_HAND"), o)
        o.pseudo_id = true
      end
end

function _M:giveEgoLongbow()
  local inven = game.player:getInven("MAIN_HAND")
  local o = game.zone:makeEntity(game.level, "object", {name="longbow", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="sling", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
    local o = game.zone:makeEntity(game.level, "object", {name="light crossbow", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="heavy crossbow", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="chain mail", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="chain shirt", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="studded leather", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="breastplate", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
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
  local o = game.zone:makeEntity(game.level, "object", {name="plate armor", force_addon = {" +1"}, add_levels=10, ego_chance=1000, ego_filter = {add_levels=10, not_properties={"cursed"},},}, 1, true)
      if o then
        while o.cursed == true do
        o = game.zone:makeEntity(game.level, "object", {name="plate armor", ego_chance=1000}, 1, true)
        end

        game.zone:addEntity(game.level, o, "object")
        game.player:addObject(game.player:getInven("BODY"), o)
        o.pseudo_id = true
      end
end

function _M:giveStartingEQ()
	--Account for perk items
	if self.perk_item == "battleaxe" or self.perk_item == "rapier" or self.perk_item == "long sword" or self.perk_item == "dagger" or self.perk_item == "morningstar"
	  --Ranged weapons
	 or self.perk_item == "shortbow" or self.perk_item == "longbow" or self.perk_item == "sling" or self.perk_item == "light crossbow" or self.perk_item == "heavy crossbow"
		then self:givePerkWeapon() end
	if self.perk_item == "chain mail" or self.perk_item == "chain shirt" or self.perk_item == "studded leather" or self.perk_item == "breastplate" or self.perk_item == "plate armor"
	  then self:givePerkArmor()  end
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

	self.image = base.."shadow.png"

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

	local basebody = doll..(self.moddable_tile_base or "human_m.png")
	add[#add+1] = {image = basebody, auto_tall=1}

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
  elseif not self:attr("moddable_tile_nude") then add[#add+1] = {image = base.."pants_l_white.png"} end
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

	-- Learn Talent
	if o.wielder and o.wielder.learn_talent then
		for tid, level in pairs(o.wielder.learn_talent) do
			self:learnTalent(tid, level)
		end
	end

    self:updateModdableTile()
end

function _M:onTakeoff(o, inven_id)
    engine.interface.ActorInventory.onTakeoff(self, o, inven_id)

	if o.wielder and o.wielder.learn_talent then
		for tid, level in pairs(o.wielder.learn_talent) do
		--	self:unlearnItemTalent(o, tid, level)
			self:unlearnTalent(tid)
		end
	end

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

--Offspring stuff
function _M:generateKid(npc)
	--nothing happens if those races aren't cross-fertile
	if self.descriptor.race == "Dwarf" and not npc.subtype == "dwarf" then return end
	if self.descriptor.race == "Halfling" and not npc.subtype == "halfling" then return end
	if self.descriptor.race == "Lizardfolk" and not npc.subtype == "lizardfolk" then return end
	if self.descriptor.race == "Kobold" and not npc.subtype == "kobold" then return end

	--make the kid
	local NPC = require "mod.class.NPC"
	kid = NPC.new{
		name = "kid",
		type = "humanoid",
		sex = resolvers.kid_sex(),
		subtype = resolvers.kid_race(self.descriptor.race, npc.subtype:capitalize()),
		stats = { str=rng.dice(3,6), dex=rng.dice(3,6), con=rng.dice(3,6), int=rng.dice(3,6), wis=rng.dice(3,6), cha=rng.dice(3,6), luc=rng.dice(3,6)},
		display = "h", color=colors.GOLD,
		image = "tiles/new/drow_child.png",
		max_life = resolvers.rngavg(5,10),
		challenge = 1,
		hit_die = 1,
		alignment = resolvers.kid_alignment(self, npc),
--		resolvers.talents{ [Talents.T_SHOOT]=1, },
		body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	    ai = "humanoid_level", ai_state = { talent_in=3, ai_move="move_astar", },
		resolvers.inventory {
		full_id=true,
		{ name = "torch", },
		{ name = "food rations"},
		{ name = "flask of water"},
		},
		combat = { dam= {1,6} },
	    faction = "neutral",
	    open_door = true,
		resolvers.kid_name(),
		resolvers.wounds()
	}

	kid:resolve() kid:resolve(nil, true)

	return kid
end

function _M:addKid(actor)
	self.kids[#self.kids+1] = actor
--	game.log("Added the kid to list")
end

function _M:getKids()
	return self.kids
end

function _M:hasKids()
	for i, e in pairs(self.kids) do
		return true
	end

	return false
end

function _M:generateRandomClassTable()
	local Birther = require "engine.Birther"
	local list = {}

	for i, d in ipairs(Birther.birth_descriptor_def.subclass) do
		if not d.prestige then
			list[#list+1] = {name=d.name, desc=d.desc, d = d}
		end
	end

	self.list_random_class = list
end

function _M:kidApplyRace(actor)
	--apply race effects
	local Birther = require "engine.Birther"
	for i, d in ipairs(Birther.birth_descriptor_def.race) do
		if d.name == actor.descriptor.race then
			if d.copy then
				local copy = table.clone(d.copy, true)
	            -- Append array part
	            while #copy > 0 do
	                local f = table.remove(copy)
	                table.insert(actor, f)
	            end
	            -- Copy normal data
	            table.merge(actor, copy, true)
	        end
	        if d.copy_add then
	            local copy = table.clone(d.copy_add, true)
	            -- Append array part
	            while #copy > 0 do
	                local f = table.remove(copy)
	                table.insert(actor, f)
	            end
	            -- Copy normal data
	            table.mergeAdd(actor, copy, true)
	        end
			if d.talents then
	            for tid, lev in pairs(d.talents) do
	                for i = 1, lev do
	                    actor:learnTalent(tid, true)
	                end
	            end
	        end
		end
	end
end

function _M:kidTakeover(actor)

	-- Convert the class to always be a player
	if actor.__CLASSNAME ~= "mod.class.Player" then
		actor.__PREVIOUS_CLASSNAME = actor.__CLASSNAME
		local uid = actor.uid
		actor.replacedWith = false
		actor:replaceWith(mod.class.Player.new(actor))
		actor.replacedWith = nil
		actor.uid = uid
		__uids[uid] = actor
		actor.changed = true
	end

	--give it player body
	actor.body = { MAIN_HAND=1, OFF_HAND=1, SHOULDER=1, BODY=1, CLOAK=1, BELT=1, QUIVER=1, GLOVES=1, BOOTS=1, HELM=1, RING=2, AMULET=1, LITE=1, TOOL=1, INVEN=30 }
	actor:initBody()


	self:generateRandomClassTable()

	--set descriptors
	actor.descriptor.sex = actor.sex
	actor.descriptor.race = actor.subtype:capitalize()
	self:kidApplyRace(actor)
	actor.descriptor.alignment = actor.alignment

	local class = rng.table(self.list_random_class)
	actor.descriptor.subclass = class
	actor:levelClass(class.name)




	--re-add inventory since initBody deletes it
	actor.resolvers.inventory {
	full_id=true,
	{ name = "torch", },
	{ name = "food rations"},
	{ name = "flask of water"},
	}

	actor:resolve() actor:resolve(nil, true)


	--adjust some stuff
	actor.money = 500
	actor.faction = "players"

	--give player skills
	actor:learnTalent(actor.T_SHOOT, true)
    actor:learnTalent(actor.T_PRAYER, true)
    actor:learnTalent(actor.T_POLEARM, true)
    actor:learnTalent(actor.T_STEALTH, true)
	actor:learnTalent(actor.T_JUMP, true)
	actor:learnTalent(actor.T_INTIMIDATE, true)
    actor:learnTalent(actor.T_DIPLOMACY, true)
    actor:learnTalent(actor.T_ANIMAL_EMPATHY, true)
    actor:learnTalent(actor.T_MOUNT, true)

	-- Setup as the current player
	actor.player = true
	game.paused = actor:enoughEnergy()
	game.player = actor
	game.uiset.hotkeys_display.actor = actor
	Map:setViewerActor(actor)
	if game.target then game.target.source_actor = actor end
	if game.level and actor.x and actor.y then game.level.map:moveViewSurround(actor.x, actor.y, 8, 8) end
	actor._move_others = actor.move_others
	actor.move_others = true

	if not actor.hotkeys_sorted then actor:sortHotkeys() end

end
