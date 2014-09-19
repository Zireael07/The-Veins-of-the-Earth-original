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
require "engine.Actor"
require "engine.Autolevel"
require "engine.interface.ActorTemporaryEffects"
require "mod.class.interface.ActorLife"
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
local Faction = require "engine.Faction"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.inherit(engine.Actor,
	engine.interface.ActorTemporaryEffects,
	mod.class.interface.ActorLife,
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
	self.combat_dr = 0
	self.combat_bab = 0
	self.combat_attack = 0
	self.hit_die = 4

	--Define AC types
	self.combat_armor_ac = 0
	self.combat_magic_armor = 0
	self.combat_shield = 0
	self.combat_magic_shield = 0
	self.combat_natural = 0
	
	self.combat_protection = 0
	self.combat_dodge = 0
	self.combat_untyped = 0

	--Some more combat stuff
	self.more_attacks = 0
	self.poison = self.poison or nil
	self.horse = self.horse or nil

	--Perks
	self.perk = self.perk or ""
	self.perk_item = self.perk_item or ""
	

	--Challenge Rating & ECL set to 0 & 1
	self.challenge = 0
	self.ecl = 1

	--Skill ranks
	self.max_skill_ranks = 4
	self.cross_class_ranks = math.floor(self.max_skill_ranks/2)

	-- Default melee barehanded damage
	self.combat = { dam = {1,4} }

	--Can now get classes
	self.classes = self.classes or {}

	--Templates (NPC only)
	self.template = self.template or nil
	self.special = self.special or nil

	--Saves
	self.will_save = self.will_save or 0
	self.reflex_save = self.reflex_save or 0
	self.fortitude_save = self.fortitude_save or 0

	--Skillz!
	self.skill_balance = 0
	self.skill_bluff = 0
	self.skill_climb = 0
	self.skill_concentration = 0
	self.skill_diplomacy = 0
	self.skill_disabledevice = 0
	self.skill_escapeartist = 0
	self.skill_handleanimal = 0 --what is called Animal Empathy in Incursion
	self.skill_heal = 0
	self.skill_hide = 0
	self.skill_intimidate = 0
	self.skill_intuition = 0
	self.skill_jump = 0
	self.skill_knowledge = 0
	self.skill_listen = 0
	self.skill_movesilently = 0
	self.skill_openlock = 0
	self.skill_ride = 0
	self.skill_search = 0
	self.skill_sensemotive = 0
	self.skill_swim = 0
	self.skill_pickpocket = 0 --what is called sleight of hand in 3.5
	self.skill_spellcraft = 0
	self.skill_survival = 0
	self.skill_tumble = 0
	self.skill_usemagic = 0

	--Skill bonuses (feat, kit etc.) to be applied on top of ranks
	self.skill_bonus_balance = 0
	self.skill_bonus_bluff = 0
	self.skill_bonus_climb = 0
	self.skill_bonus_concentration = 0
	self.skill_bonus_diplomacy = 0
	self.skill_bonus_disabledevice = 0
	self.skill_bonus_escapeartist = 0
	self.skill_bonus_handleanimal = 0 --what is called Animal Empathy in Incursion
	self.skill_bonus_heal = 0
	self.skill_bonus_hide = 0
	self.skill_bonus_intimidate = 0
	self.skill_bonus_intuition = 0
	self.skill_bonus_jump = 0
	self.skill_bonus_knowledge = 0
	self.skill_bonus_listen = 0
	self.skill_bonus_movesilently = 0
	self.skill_bonus_openlock = 0
	self.skill_bonus_ride = 0
	self.skill_bonus_search = 0
	self.skill_bonus_sensemotive = 0
	self.skill_bonus_swim = 0
	self.skill_bonus_pickpocket = 0 --what is called sleight of hand in 3.5
	self.skill_bonus_spellcraft = 0
	self.skill_bonus_survival = 0
	self.skill_bonus_tumble = 0
	self.skill_bonus_usemagic = 0

	--Make resists and projectiles work
	t.resists = t.resists or {}
	t.melee_project = t.melee_project or {}
	t.ranged_project = t.ranged_project or {}
	t.can_pass = t.can_pass or {}
	t.on_melee_hit = t.on_melee_hit or {}

	--Actually initiate some basic engine stuff
	engine.Actor.init(self, t, no_default)
	engine.interface.ActorTemporaryEffects.init(self, t)
	mod.class.interface.ActorLife.init(self, t)
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
	self.allocated_charges = {}

	-- Caster levels
	self.caster_levels = {}

	--Scoring
	self.kills = 0
	self.seen = false

	--Light-related
	self.lite = 0 --Temporary test
	self.infravision = 0

	self.life = t.max_life or self.life

	self.last_attacker = nil

	-- Use weapon damage actually
	if not self:getInven("MAIN_HAND") or not self:getInven("OFF_HAND") then return end
	if weapon then dam = weapon.combat.dam
	end
end

--Taken from Qi Daozei
function _M:onEntityMerge(a)
    -- Remove stats to make new stats work.  This is necessary for stats on a
    -- derived NPC (like kobold in the example module) to override the base
    -- define_as NPC.
    for i, s in ipairs(_M.stats_def) do
        if a.stats[i] then
            a.stats[s.short_name], a.stats[i] = a.stats[i], nil
        end
    end
end

-- Called when our stats change
function _M:onStatChange(stat, v)
	if stat == "str" then self:checkEncumbrance() end
	if stat == self.STAT_CON then self.max_life = self.max_life + v*2 end
end 

function _M:zeroStats()
	if self:getStat('str') == 0 and not self.dead then self:die() end --should be helpless
	if self:getStat('dex') == 0 and not self.dead then self:die() end --should be paralyzed
	if self:getStat('con') == 0 and not self.dead then self:die() end
	if self:getStat('int') == 0 and not self.dead then self:die() end -- should be unconscious
	if self:getStat('wis') == 0 and not self.dead then self:die() end --should be unconscious
	if self:getStat('cha') == 0 and not self.dead then self:die() end --should be unconscious
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

	--Check if stats aren't 0
	self:zeroStats()

	--Poison timer
	if self.poison_timer then self.poison_timer = self.poison_timer - 1 end


	--Death & dying related stuff
	self:deathStuff()

	-- check passive stuff. This should be in actbase I think but I cant get it to work
	if self:knowTalent(self.T_BLOOD_VENGANCE) then
		--Bloodied!
		if self.life / self.max_life < 0.5 then
			self:setEffect(self.EFF_BLOOD_VENGANCE, 1, {})
		end
	end

	if self:attr("sleep") then self.energy.value = 0 end

	-- Check terrain special effects
	game.level.map:checkEntity(self.x, self.y, Map.TERRAIN, "on_stand", self)

	--From Startide
	-- Shrug off effects
	for eff_id, params in pairs(self.tmp) do
		local DC = params.DC_ongoing or 10
		local eff = self.tempeffect_def[eff_id]
		if eff.decrease == 0 then 
			if self:saveRoll(DC, eff.type) then
				params.dur = 0 
			end
		end
	end

	-- Still not dead ?
	if self.dead then return false end

	-- Ok reset the seen cache
	self:resetCanSeeCache()

	if self.on_act then self:on_act() end

	if self.never_act then return false end

	-- Still enough energy to act ?
	if self.energy.value < game.energy_to_act then return false end

	return true
end

--Are we able to move at all? Currently checks if we are able to move anywhere, aka not if we cant move certain directions
function _M:canMove()
	if self:attr("never_move") then return false end
	return true
end

function _M:move(x, y, force)
	local moved = false
	if not self:canMove() then return moved end

	local ox, oy = self.x, self.y

	 -- Never move, but allow attacking (from Qi Daozei)
        if not force and self:attr("never_move_but_attack") then
            -- Copied from ToME - this asks the collision code to check for attacking
            if not game.level.map:checkAllEntities(x, y, "block_move", self, true) then
                game.logPlayer(self, "You are unable to move!")
            end
            return false
        end

	if force or self:enoughEnergy() then
		-- Check for confusion or random movement flag.
		local rand_prob = self.ai_state and self.ai_state.random_move or 0
		local rand_move = self:hasEffect(self.EFF_CONFUSED) or rng.range(1,100) <= rand_prob
		if rand_move and self.x and self.y then
			x, y = self.x + rng.range(-1,1), self.y + rng.range(-1,1)
		end

		moved = engine.Actor.move(self, x, y, force)

		if not force and moved and (self.x ~= ox or self.y ~= oy) and not self.did_energy then
			local speed = 1.0 - (1.0 * (self.movement_speed_bonus or 0))
			self:useEnergy(game.energy_to_act * speed)
		end
	end
	self.did_energy = nil

	-- This is where we do auto-search for traps.
	local grids = core.fov.circle_grids(self.x, self.y, 1, true)
		for x, yy in pairs(grids) do for y, _ in pairs(yy) do
			local trap = game.level.map(x, y, Map.TRAP)
			--Don't search for pseudo-traps
			if trap and not trap.type == "tutorial"
				--Do stuff
				and not trap:knownBy(self) and self:canSee(trap) and self:skillCheck("search", 15) then
				trap:setKnown(self, true)
				game.level.map:updateMap(x, y)
				game.logPlayer(self, "You have found a trap (%s)!", trap:getName())
			end
		end end

	return moved
end


--Descriptive stuff
--From Qi Daozei
function _M:getLogName()
    if self == game.player or (game.level.map.seens(self.x, self.y) and game.player:canSee(self)) then
        return self.name, true
    else
        return "something", false
    end
end

--Helper function to color high & low stats in birther
function _M:birthColorStats(stat)
	if self:getStat(stat) <= 6 then return "#RED#"..self:getStat(stat).."#LAST"
	elseif self:getStat(stat) > 15 then return "#GREEN#"..self:getStat(stat).."#LAST#"
	else return "#WHITE#"..self:getStat(stat).."#LAST#" end
end


--Helper function to color high stats (15+) when loading
function _M:colorHighStats(stat)
	if self:getStat(stat) > 15 then return "#GREEN#"..self:getStat(stat).."#LAST#"
	else return "#WHITE#"..self:getStat(stat).."#LAST#" end
end

--Helpers to color skills
--Incursion style
function _M:colorSkill(skill)

	if self:getSkill(skill) == 0 then return end


	if self:getSkill(skill) > 20 then return "#GOLD#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 15 then return "#LIGHT_RED#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 12 then return "#DARK_RED#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 9 then return "#LIGHT_GREEN#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 6 then return "#ORCHID#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 3 then return "#LIGHT_BLUE#"..self:getSkill(skill).."#LAST#"
	elseif self:getSkill(skill) > 1 then return "#DARK_BLUE#"..self:getSkill(skill).."#LAST#"
	else return "#WHITE#"..self:getSkill(skill).."#LAST#"
	end
end


--Tooltip stuffs
function _M:templateName()
	if self == game.player then end
	if not self.special and not self.template then return "" end
	
	
	if self.special ~= nil then
		if game.player.special_known[self.uid] then return self.special
		else return "" end

		--return self.special		
	else return "" end
	if self.template ~= nil then
		if game.player.special_known[self.uid] then return self.template
		else return "" end

--		return self.template
	else return "" end
end

function _M:className()
	if self == game.player then end
	if self.classes and self.classes["Fighter"] then return "#LIGHT_BLUE#fighter#LAST#"
	elseif self.classes and self.classes["Cleric"] then return "#LIGHT_BLUE#cleric#LAST#" 
	elseif self.classes and self.classes["Barbarian"] then return "#LIGHT_BLUE#barbarian#LAST#"
	elseif self.classes and self.classes["Rogue"] then return "#LIGHT_BLUE#rogue#LAST#"
	elseif self.classes and self.classes["Ranger"] then return "#LIGHT_BLUE#ranger#LAST#"
	elseif self.classes and self.classes["Wizard"] then return "#LIGHT_BLUE#wizard#LAST#"
	elseif self.classes and self.classes["Sorcerer"] then return "#LIGHT_BLUE#sorcerer#LAST#"
	elseif self.classes and self.classes["Druid"] then return "#LIGHT_BLUE#druid#LAST#"
	elseif self.classes and self.classes["Warlock"] then return "#LIGHT_BLUE#warlock#LAST#"
	else return "#LAST#" end
end

function _M:colorStats(stat)
	local player = game.player
	

	if (self:getStat(stat)-10)/2 > (player:getStat(stat)-10)/2 then return "#RED#"..self:getStat(stat).."#LAST#"
	elseif (self:getStat(stat)-10)/2 < (player:getStat(stat)-10)/2 then return "#GREEN#"..self:getStat(stat).."#LAST#"
	else return "#WHITE#"..self:getStat(stat).."#LAST#" end
end

function _M:formatCR()
    local cr = self:attr('challenge')
    local whole = math.floor(cr)
    local fraction = cr - whole

    if fraction == 0 then fraction = ''
    else fraction = ("1/%i"):format(math.round(1/fraction)) end

    if whole == 0 and fraction == '' then return "0"
    elseif whole == 0 then return fraction
    else return tostring(whole) .. ' ' .. fraction end
end

function _M:colorCR()
	local player = game.player

    if not self:attr("challenge") then
        return "#WHITE#-#LAST#"
    end

	if self.challenge > player.level then return "#FIREBRICK#"..self:formatCR().."#LAST#"
	elseif self.challenge < (player.level - 4) then return "#LIGHT_GREEN#"..self:formatCR().."#LAST#"
	elseif self.challenge < player.level then return "#DARK_GREEN#"..self:formatCR().."#LAST#"
	else return "#GOLD#"..self:formatCR().."#LAST#" end
end	

function _M:colorFaction()
	local player = game.player
	local factlevel = Faction:factionReaction(self.faction, game.player.faction)
	if self.faction and Faction.factions[self.faction] then 
		if factlevel == 0 then return "#WHITE#neutral#LAST#"
		elseif factlevel < 0 then return "#LIGHT_RED#hostile#LAST#"
		elseif factlevel > 0 then return "#LIGHT_GREEN#friendly#LAST#"
		end
	else end
end

function _M:tooltip()
	local ts = tstring{}

	ts:add({"color", "WHITE"}, ("%s"):format(self:getDisplayString()), true)

	ts:add({"color", "GOLD"}, ("%s "):format(self:templateName()), {"color", "WHITE"}) ts:add(self.name, {"color", "WHITE"}) ts:add((" %s"):format(self:className()), true)

	if self.type == "humanoid" then ts:add(self.type.." ("..self.subtype..")", true)
	else ts:add(self.type, true)
	end

	if self.life < 0 then ts:add({"color", 255, 0, 0}, "HP: unknown", {"color", "WHITE"}, true)
	else ts:add({"color", 255, 0, 0}, ("HP: %d (%d%%)"):format(self.life, self.life * 100 / self.max_life), {"color", "WHITE"}, true)
	end

	ts:add({"color", "WHITE"}, ("STR %s "):format(self:colorStats('str'))) ts:add({"color", "WHITE"}, ("DEX %s "):format(self:colorStats('dex'))) ts:add({"color", "WHITE"}, ("CON %s"):format(self:colorStats('con')), true)

	ts:add({"color", "WHITE"}, ("INT %s "):format(self:colorStats('int'))) ts:add({"color", "WHITE"}, ("WIS %s "):format(self:colorStats('wis'))) ts:add({"color", "WHITE"}, ("CHA %s"):format(self:colorStats('cha')), true)

	ts:add({"color", "GOLD"}, ("CR: %s"):format(self:colorCR()), {"color", "WHITE"}, true)

	ts:add({"color", "GOLD"}, ("XP: %d"):format(self:worthExp(game.player)), {"color", "WHITE"}, true)

	ts:add({"color", "WHITE"}, self.desc, {"color", "WHITE"}, true)

	ts:add(("%s"):format(self:colorFaction()), true)

	--Debugging speed stuff
--[[	ts:add(("Game turn: %s"):format(game.turn/10), true)

	ts:add(("Global speed: %d"):format(self.global_speed or 1), true)

	ts:add(("Energy remaining: %d"):format(self.energy_value or 1), true)

	ts:add(("Movement speed: %d"):format(self.movement_speed or 1), true)

	ts:add(("Movement speed bonus: %0.1f"):format(self.movement_speed_bonus or 0), true)]]

	return ts
end

--life regeneration (items or feats)
function _M:regenLife()
	if self.life_regen and not self:attr("no_life_regen") then
		local regen = self.life_regen

		self.life = util.bound(self.life + regen, self.die_at, self.max_life)
	end
end

--End of desc stuff
--Death & dying related stuff
function _M:deathStuff()
	if self.life > 0 then self:removeEffect(self.EFF_DISABLED) end

	if self.life == 0 then 
		--Undead and constructs now die at 0
		if self.type ~= "undead" and self.type ~= "construct" then
		self:setEffect(self.EFF_DISABLED, 1, {})
		self:removeEffect(self.EFF_DYING)
		else 
			if self:hasEffect(self.EFF_DYING) then self:removeEffect(self.EFF_DYING) end
		self:die() 
		end
	end	


	if self.life < 0 then 
		self:removeEffect(self.EFF_DISABLED)
		self:setEffect(self.EFF_DYING, 1, {})
		--Monsters bleed out quicker than players and have a smaller chance to stabilize
		if self == game.player then
			--Raging characters are considered stable as long as they are raging
			if self:hasEffect(self.EFF_RAGE) then self.life = 0 end
			if rng.percent(10) then self.life = 0
			else self.life = self.life - 1 end	
		else
			if rng.percent(2) then self.life = 0
			else self.life = self.life - 3 end
		end		
	end	

	--Ensure they can actually die due to bleeding out
	if not self == game.player and self.life <= -10 and not self.dead then 
		self:removeEffect(self.EFF_DYING, true, true) 

		--Remove any particles we have
		local ps = self:getParticlesList()
		for i, p in ipairs(ps) do self:removeParticles(p) end

		self:die(game.player) 
	end
	if self.life <= -10 and not self.dead then 
		self:removeEffect(self.EFF_DYING, true, true) 

		--Remove any particles we have
		local ps = self:getParticlesList()
		for i, p in ipairs(ps) do self:removeParticles(p) end

		self:die() end
end



function _M:onTakeHit(value, src)

	--if a sleeping target is hit, it will wake up
	if self:hasEffect(self.EFF_SLEEP) then
		self:removeEffect(self.EFF_SLEEP)
		game.logSeen(self, "%s wakes up from being hit!", self.name)
	end

	-- Split ?
	if self.clone_on_hit and rng.percent(self.clone_on_hit.chance) then
		-- Find space
		local x, y = util.findFreeGrid(self.x, self.y, 1, true, {[Map.ACTOR]=true})
		if x then
			-- Find a place around to clone
			local a
			if self.clone_base then a = self.clone_base:clone() else a = self:clone() end
			a.life = math.max(1, self.life - value / 2)
			a.clone_on_hit.chance = math.ceil(self.clone_on_hit.chance / 2)
			a.energy.val = 0
			a.exp_worth = 0.1
			a.inven = {}
			a:removeAllMOs()
			a.x, a.y = nil, nil
			game.zone:addEntity(game.level, a, "actor", x, y)
			game.logSeen(self, "%s splits in two!", self.name:capitalize())
			value = value / 2
		end
	end

	if self.on_takehit then value = self:check("on_takehit", value, src) end

	--Death & dying related stuff
	if (self.life - value) > 0 then self:removeEffect(self.EFF_DISABLED) end

	if (self.life - value) == 0 then 
		--Undead and constructs now die at 0
		if self.type ~= "undead" and self.type ~= "construct" then
		self:setEffect(self.EFF_DISABLED, 1, {})
		self:removeEffect(self.EFF_DYING)
		else 
			if self:hasEffect(self.EFF_DYING) then self:removeEffect(self.EFF_DYING, true, true) end
		self:die(src) 
		end
	end	


	if (self.life - value) < 0 then 
		if self == game.player and self:knowTalent(self.T_IGNORE_WOUND) and not self.ignored_wound then
			--ignore the wound
			self.life = self.life + value
			--set the flag
			self.ignored_wound = true
			game.logPlayer(self, "You ignore the wound!")

			return value
		end

		self:removeEffect(self.EFF_DISABLED)
		self:setEffect(self.EFF_DYING, 1, {})
		--Monsters bleed out quicker than players and have a smaller chance to stabilize
		if self == game.player then
			--Raging characters are considered stable as long as they are raging
			if self:hasEffect(self.EFF_RAGE) then self.life = 0 end
			if rng.percent(10) then self.life = 0
			else self.life = self.life - 1 end	
		else
			if rng.percent(2) then self.life = 0
			else self.life = self.life - 3 end
		end		
	end	

	--Ensure they can actually die due to bleeding out
	if not self == game.player and (self.life - value) <= -10 and not self.dead then 
		self:removeEffect(self.EFF_DYING, true, true) 
		
		--Remove any particles we have
		local ps = self:getParticlesList()
		for i, p in ipairs(ps) do self:removeParticles(p) end
		
		self:die(game.player) 

	end
	if (self.life - value) <= -10 and not self.dead then 
		self:removeEffect(self.EFF_DYING, true, true) 

		--Remove any particles we have
		local ps = self:getParticlesList()
		for i, p in ipairs(ps) do self:removeParticles(p) end

		self:die(src) 
	end
	
	return value
end

function _M:die(src)
	engine.interface.ActorLife.die(self, src)

	--Remove any particles we have
	local ps = self:getParticlesList()
	for i, p in ipairs(ps) do self:removeParticles(p) end

	-- Trigger on_die effects if any
	for eff_id, p in pairs(self.tmp) do
		local e = self.tempeffect_def[eff_id]
		if e.on_die then e.on_die(self, p) end
	end

	-- Gives the killer some exp for the kill
	local killer
	killer = src or self.last_attacker

	if killer and killer.gainExp then
		killer:gainExp(self:worthExp(killer))
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

	--drop corpses
	if not (self.name == "stirge" or name == "will'o'wisp" 
		or self.type == "outsider" or self.type == "demon" or self.type == "elemental" or self.type == "ooze" or self.type == "construct") then
		
		local corpse = game.zone:makeEntity(game.level, "object", {name="fresh corpse", ego_chance=-1000}, 1, true)
	--	local corpse = game.zone:makeEntityByName(game.level, "object", "FRESH_CORPSE")
		if corpse then
			corpse.name = self.name.." corpse"
			corpse.unided_name = self.name.." corpse"
			corpse.victim = self
			game.zone:addEntity(game.level, corpse, "object", dropx, dropy)
		--	game.log("Placed corpse "..self.name..dropx..dropy)
		end
	end



	if self ~= game.player and dropx == game.player.x and dropy == game.player.y then
		game.log('You feel something roll beneath your feet.')
	end

	-- Register kills for hiscores
	if killer and killer == game.player then
		if self.challenge < (game.player.level - 4) then 
			killer.kills = killer.kills
		else 
		killer.kills = killer.kills + 1 end
	else end

	self.dead = true -- mark as dead, for scores?

	-- Record kills for kill count
	local player = game.player
	
	if killer and killer == player then 
		player.all_kills = player.all_kills or {}
		player.all_kills[self.name] = player.all_kills[self.name] or 0
		player.all_kills[self.name] = player.all_kills[self.name] + 1
	end	

	--Divine reactions
	if killer and killer == player then

		self:deathDivineReaction()

		--live sacrifice on altar
		local t = game.level.map(self.x, self.y, Map.TERRAIN)

		if t.is_altar then
			player:liveSacrifice(self)
		end
	end

	return true
end

--self refers to the monster which was killed, see above
function _M:deathDivineReaction()	
	local player = game.player

	if player:isFollowing("None") then end

	if player:isFollowing("Asherath") 
		and self.challenge > player.level then
		player:incFavorFor("Asherath", 30*self.challenge)
	end

	if player:isFollowing("Ekliazeh") then
		if self.subtype == "drow" or self.subtype == "goblinoid" or self.type == "giant" then
			player:incFavorFor("Ekliazeh", 25*self.challenge)
		end
		if self.subtype == "dwarf" then --non undead; OR sapient construct
			player:transgress("Ekliazeh", 5, false, "killing a dwarf")
		end	
	end

	if player:isFollowing("Hesani")
		and self.type == "undead" then
	--	and self.alignment == "lawful evil" or self.alignment == "neutral evil" or self.alignment == "chaotic evil"
			player:incFavorFor("Hesani", 25*(math.max(1, self.challenge)))
			--TO DO: remove favor for killing living
	end

	if player:isFollowing("Immotian") then
		if self.type == "undead" or self.type == "aberration" or self.type == "demon" then --or self.type == "devil"
			player:incFavorFor("Immotian", 10*(math.max(1, self.challenge)))
		end
		if self.type == "dragon" or self.subtype == "fire" then --and self.alignment == "lawful good" or self.alignment == "neutral good" or self.alignment == "chaotic good"
			--5 if it used to be friendly
			player:transgress("Immotian", 2, false, "harming a sacred fire creature")
		end
	end

	if player:isFollowing("Khasrach") then
		if self.subtype == "human" or self.subtype == "elf" or self.subtype == "dwarf" then
	--	and has arcane spellcasting
			player:incFavorFor("Khasrach", 10*(math.max(1, self.challenge)))
		end
		if self.subtype == "orc" and self.challenge >= 2 then
			player:transgress("Khasrach", 1, false, "killing a skillful orc")
		end
	end

	if player:isFollowing("Kysul") then
		if self.type == "aberration" then
	--	if	self.alignment == "lawful evil" or self.alignment == "neutral evil" or self.alignment == "chaotic evil"
			player:incFavorFor("Kysul", 10*self.challenge)
		--else remove favor for killing non evil aberrations
		end
		if self.type == "outsider" then
			player:incFavorFor("Kysul", 5*self.challenge)
		end
	end

	if player:isFollowing("Mara")
		and self.type == "undead" then --and incorporeal
			player:incFavorFor("Mara", 50*self.challenge)
	end

	if player:isFollowing("Maeve")
		and self.subtype == "drow" then
			player:incFavorFor("Maeve", 50*self.challenge)
	end

	if player:isFollowing("Semirath") then
	--	TO DO: deduce points for killing normally evil race and self.alignment == "lawful good" or self.alignment == "neutral good" or self.alignment == "chaotic good"
	-- TO DO: deduce points for killing non-evil non-outsider non-elemental humanoid
	end

end

	

function _M:resolveSource()
	if self.summoner_gain_exp and self.summoner then
		return self.summoner:resolveSource()
	else
		return self
	end
end

function _M:resetToFull()
	if self.dead then return end
	self.life = self.max_life
end

function _M:levelupMsg()
  -- Subclasses handle the actual mechanics of leveling up; here we just
  -- print the message and add the flyer.
	local stale = false
	if self.level_hiwater then
		stale = self.level_hiwater >= self.level
		self.level_hiwater = math.max(self.level_hiwater, self.level)
	end

	--Add flash for player
	if self == game.player then flash = game.flash.GOOD
	else flash = game.flash.NEUTRAL end

	game.logSeen(self, flash, "#00FFFF#%s %s level %d.#LAST#", self.name, stale and 'regains' or 'gains', self.level)
	if self.x and self.y and game.level.map.seens(self.x, self.y) then
		local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(sx, sy, 80, 0.5, -2, 'LEVEL UP!', stale and {255, 0, 255} or {0, 255, 255})
	end

	-- Return true if this is the first time we've hit this level.
	return not stale
end

function _M:attack(target)
	self:bumpInto(target)
end

function _M:incMoney(v)
	if self.summoner then self = self.summoner end
	self.money = self.money + v
	if self.money < 0 then self.money = 0 end
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

--Provided a looong time ago by someone I can't recall (Zonk?).
 function _M:isFlanking(target)
    local x = target.x*2 - self.x
    local y = target.y*2 - self.y
    local z = game.level.map (x, y, MAP.ACTOR)
    if (z and self:reactionToward(z) < 0) then --- should also check if z is 'threatening'
        return true    
    else
        return false
    end
end
	

--- Called before a talent is used
-- Check the actor can cast it
-- @param ab the talent (not the id, the table)
-- @return true to continue, false to stop
function _M:preUseTalent(ab, silent)
	local tt_def = self:getTalentTypeFrom(ab.type[1])
	if tt_def.all_limited then --all_limited talenttypes all have talents that are daily limited 
		
		--No casting spells if your key stat is <= 9
		if self.classes and self.classes["Wizard"] and self:getInt() <= 9 then
			if not silent then game.logPlayer(self, "Your Intelligence is too low!") end
		return false
		end
		if self.classes and self.classes["Ranger"] and self:getWis() <= 9 then 
			if not silent then game.logPlayer(self, "Your Wisdom is too low!") end
		return false
		end
		if self.classes and self.classes["Cleric"] and self:getWis() <= 9 then 
			if not silent then game.logPlayer(self, "Your Wisdom is too low!") end
		return false
		end
		
		if self.classes and self.classes["Bard"] and self:getCha() <= 9 then 
			if not silent then game.logPlayer(self, "Your Charisma is too low!") end
		return false
		end	

		if  self:getCharges(ab) <= 0 then
			if not silent then game.logPlayer(self, "You have to prepare this spell") end
			return false 
		end
	end

	-- Check for special prequisites
	if ab.on_pre_use and not ab.on_pre_use(self, ab, silent) then 
		return nil
	end
	

	if not self:enoughEnergy() then return false end

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
				game.logSeen(self, "%s activates %s.", self:getLogName():capitalize(), ab.name)
			elseif ab.mode == "sustained" and self:isTalentActive(ab.id) then
				game.logSeen(self, "%s deactivates %s.", self:getLogName():capitalize(), ab.name)
			else
			--	game.logSeen(self, "%s uses %s.", self:getLogName():capitalize(), ab.name)
				game.logSeen(self, "%s uses %s.", self:getLogName():capitalize(), self:getTalentName(ab))
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

	local tt_def = self:getTalentTypeFrom(ab.type[1])

	--remove charge
	if tt_def.all_limited then self:incCharges(ab, -1) end

	--Spell failure!
	if tt_def.all_limited then

		if self.classes and self.classes["Wizard"] and (self.spell_fail or 0) > 0 and rng.percent(self.spell_fail) then game.logPlayer(self, "You armor hinders your spellcasting! Your spell fails!") return false end
		if self.classes and self.classes["Sorcerer"] and (self.spell_fail or 0) > 0 and rng.percent(self.spell_fail) then game.logPlayer(self, "You armor hinders your spellcasting! Your spell fails!") return false end
		if self.classes and self.classes["Bard"] and (self.spell_fail or 0) > 0 and rng.percent(self.spell_fail) then game.logPlayer(self, "You armor hinders your spellcasting! Your spell fails!") return false end
	end
	
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

function _M:isSpell(t)
	local tt_def = self:getTalentTypeFrom(t.type[1])
	local tt = self:getTalentTypeFrom(t)

	if tt_def.all_limited then return true end
	if t.type[1] == "innate/innate" or t.type[1] == "shaman/shaman" or t.type == "sorcerer/sorcerer" then return true end

	return false 

end

function _M:getTalentName(t)
	if not self:isSpell(t) then return t.name end
	if self:isSpell(t) then 
		if self == game.player then return t.name end
		--If player can see the source but he isn't the source
		if self ~= game.player and (game.level.map.seens(self.x, self.y) and game.player:canSee(self)) then 
			local check = game.player:skillCheck("spellcraft", t.level+15)
			if check then return t.name --end
			else return "something" end
		else return "something" end
	end
end	


--- How much experience is this actor worth
-- @param target to whom is the exp rewarded
-- @return the experience rewarded
function _M:worthExp(target)
	-- TODO Don't get experience from killing friendlies.
	if self.challenge < (game.player.level - 4) then return 0
	else return (self.exp_worth) end
end




--- Can the actor see the target actor
-- This does not check LOS or such, only the actual ability to see it.<br/>
-- Check for telepathy, invisibility, stealth, ...
function _M:canSeeNoCache(actor, def, def_pct)
	if not actor then return false, 0 end

	-- Newsflash: blind people can't see!
	if self:hasEffect(self.EFF_BLIND) then return false,100 end --Like this, the actor actually knows where its target is. Its just bad at hitting


	if actor ~= self and actor.attr and actor:attr("stealth") then
		local check = self:opposedCheck("spot", actor, "hide")
		if not check then 
			local check2 = self:opposedCheck("listen", actor, "movesilently")
			if check2 then return false, 100 end --we know where target is thanks to hearing
			return false, 0 
		end
	end

	return true, 100
end

--Taken from ToME
function _M:canSee(actor, def, def_pct)
	if not actor then return false, 0 end

	self.can_see_cache = self.can_see_cache or {}
	local s = tostring(def).."/"..tostring(def_pct)

	if self.can_see_cache[actor] and self.can_see_cache[actor][s] then return self.can_see_cache[actor][s][1], self.can_see_cache[actor][s][2] end
	self.can_see_cache[actor] = self.can_see_cache[actor] or {}
	self.can_see_cache[actor][s] = self.can_see_cache[actor][s] or {}

	local res, chance = self:canSeeNoCache(actor, def, def_pct)
	self.can_see_cache[actor][s] = {res,chance}

	-- Make sure the display updates
	if self.player and type(def) == "nil" and actor._mo then actor._mo:onSeen(res) end

	return res, chance
end

--- Reset our own seeing cache
function _M:resetCanSeeCache()
	self.can_see_cache = {}
	setmetatable(self.can_see_cache, {__mode="k"})
end

--- Reset the cache of everything else that had see us on the level
function _M:resetCanSeeCacheOf()
	if not game.level then return end
	for uid, e in pairs(game.level.entities) do
		if e.can_see_cache and e.can_see_cache[self] then e.can_see_cache[self] = nil end
	end
	game.level.map:updateMap(self.x, self.y)
end

--Taken from Qi Daozei
--- Checks if the actor can see the target actor, *including* checking for
--- LOS, lighting, etc.
function _M:canReallySee(actor)
    -- Non-players currently have no light limitations, so just use FOV.
    if not self.fov then self:doFOV() end
    return self:canSee(actor) and self.fov.actors[actor]
end

--- Is the target concealed for us?
-- Returns false if it isn't, or a number (50%/20% concealment) if it is
function _M:isConcealed(actor)
	if self:hasEffect(self.EFF_BLIND) then return 50 end
	if self:hasEffect(self.EFF_DARKNESS) then return 20 end
	if self:hasEffect(self.EFF_FAERIE) then return false end
	--All other effects go here since they're cancelled by faerie fire
	return false
end

--- Can the target be applied some effects
-- @param what a string describing what is being tried
function _M:canBe(what)
	if what == "poison" and self:knowTalent(self.T_POISON_IMMUNITY) then return false end
	if what == "disease" and self:knowTalent(self.T_DISEASE_IMMUNITY) then return false end
	if what == "sleep" and self:knowTalent(self.T_SLEEP_IMMUNITY) then return false end
	if what == "paralysis" and self:knowTalent(self.T_PARALYSIS_IMMUNITY) then return false end
	if what == "confusion" and self:knowTalent(self.T_CONFUSION_IMMUNITY) then return false end


	if what == "crit" and self.type == "construct" or self.type == "elemental" or self.type == "ooze" or self.type == "plant" or self.type == "undead" then return false end
	if what == "poison" and self.type == "construct" or self.type == "elemental" or self.type == "ooze" or self.type == "plant" or self.type == "undead" then return false end
	if what == "sleep" and self.type == "construct" or self.type == "dragon" or self.type == "elemental" or self.type == "ooze" or self.type == "plant" or self.type == "undead" then return false end
	if what == "paralysis" and self.type == "construct" or self.type == "dragon" or self.type == "elemental" or self.type == "ooze" or self.type == "plant" or self.type == "undead" then return false end
	if what == "stun" and self.type == "construct" or self.type == "elemental" or self.type == "ooze" or self.type == "plant" or self.type == "undead" then return false end
	if what == "disease" and self.type == "construct" or self.type == "undead" then return false end
	if what == "death" and self.type == "construct" or self.type == "undead" then return false end
	if what == "petrification" and self.subtype == "angel" or self.subtype == "archon" then return false end
	if what == "polymorph" and self.type == "ooze" or self.type == "plant" then return false end
	if what == "mind-affecting" and self.type == "construct" and self.type == "ooze" and self.type == "plant" and self.type == "undead" and self.type == "vermin" then return false end
	if what == "blind" and self.type == "ooze" then return false end
	if what == "fatigue" and self.type == "construct" or self.type == "undead" then return false end
--IMPORTANT! This one covers both ability drain, ability damage and energy drain, since those immunities always go together
	if what == "drain" and self.type == "construct" or self.type == "undead" then return false end

	if what == "acid" and self.subtype == "angel" then return false end
	if what == "cold" and self.subtype == "angel" then return false end
	if what == "electricity" and self.subtype == "archon" then return false end
	
	return true
end

function _M:addedToLevel(level, x, y)
--Warning: got a loop once
--Safeguards against overly high CR monsters
if game.level.level == 1 then 
	if self.challenge > (game.level.level + 3) then

		--Create new actor
		local m = game.zone:makeEntity(game.level, "actor", f, nil, true)

		-- Find space
        local x, y = util.findFreeGrid(self.x, self.y, 10, true, {[Map.ACTOR]=true})
        if not x then end

		if m and m:canMove(x, y) then
			game.zone:addEntity(game.level, m, "actor", x,y)
		end
		--Despawn the offender
		game.level:removeEntity(self, true)
	end
else
	if self.challenge > (game.level.level + 5) then		
		--Create new actor
		local m = game.zone:makeEntity(game.level, "actor", f, nil, true)
		
		-- Find space
        local x, y = util.findFreeGrid(self.x, self.y, 10, true, {[Map.ACTOR]=true})
        if not x then end

		if m and m:canMove(x, y) then
			game.zone:addEntity(game.level, m, "actor", x,y)
		end
		--Despawn the offender
		game.level:removeEntity(self, true)
	end
end


if self.encounter_escort then
                for _, filter in ipairs(self.encounter_escort) do
                        for i = 1, filter.number do
                               
                                if not filter.chance or rng.percent(filter.chance) then
                                        -- Find space
                                        local x, y = util.findFreeGrid(self.x, self.y, 10, true, {[Map.ACTOR]=true})
                                        if not x then break end
 
                                        -- Find an actor with that filter
                                        local m = game.zone:makeEntity(game.level, "actor", filter, nil, true)
 
                                        if m and m:canMove(x, y) then
 
                                                if filter.no_subescort then m.encounter_escort = nil end
                                                if self._empty_drops_escort then m:emptyDrops() end
 
                                                --Hack?
                                                if filter.challenge then
                                                		--Thanks Seb!
                                                        while m.challenge ~= filter.challenge do
                                                            m = game.zone:makeEntity(game.level, "actor", filter, nil, true)
                                                        end                                                        
                                                end
                                                game.zone:addEntity(game.level, m, "actor", x,y)
                                        end
 
                                --      game.zone:addEntity(game.level, m, "actor", x, y)
                                        if filter.post then filter.post(self, m) end
                                elseif m then m:removed() end
                        end
                end
        end
        self.encounter_escort = nil

self:check("on_added_to_level", level, x, y)


--Auto-remove dummy encounter npcs
if self.type == "encounter" then self:die() end
end


--Skill checks, Zireael
function _M:getSkill(skill)
	local stat_for_skill = { balance = "dex", bluff = "cha", climb = "str", concentration = "int", diplomacy = "cha", disabledevice = "int", escapeartist = "dex", handleanimal = "wis", heal = "wis", hide = "dex", intimidate = "cha", intuition = "int", jump = "str", knowledge = "wis", listen = "wis", movesilently = "dex", openlock = "dex", pickpocket = "dex", ride = "dex", search = "int", sensemotive = "wis", swim = "str", spellcraft = "int", spot = "wis", survival = "wis", tumble = "dex", usemagic = "int" }
	if (not skill) then return 0 end
	local penalty_for_skill = { balance = "yes", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "no", jump = "yes", knowledge = "no", listen = "no", movesilently = "yes", openlock = "no", pickpocket = "yes", ride = "no", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "no" }

	local check = (self:attr("skill_"..skill) or 0) + (self:attr("skill_bonus_"..skill) or 0) + math.floor((self:getStat(stat_for_skill[skill])-10)/2) 
	
	if penalty_for_skill[skill] == "no" then return check end

	if penalty_for_skill[skill] == "yes" then 
		if self:knowTalent(self.T_ARMOR_OPTIMISATION) and self:attr("armor_penalty") then
			return check - (self:attr("armor_penalty")/3 or 0) - (self:attr("load_penalty") or 0) --end
		else
		return check - (self:attr("armor_penalty") or 0) - (self:attr("load_penalty") or 0) end
	end

end

function _M:skillCheck(skill, dc, silent)
	local success = false

	local d = rng.dice(1,20)
	if d == 20 then return true
	elseif d == 1 then return false
	end

	local result = d + (self:getSkill(skill) or 0)

	if result > dc then success = true end

	--Limit logging to the player
	if not silent and self == game.player then
		local who = self:getName()
		local s = ("%s check for %s: dice roll %d + bonus %d = %d vs DC %d -> %s"):format(
			skill:capitalize(), who, d, self:getSkill(skill) or 0, result, dc, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end

	return success
end

function _M:opposedCheck(skill1, target, skill2)
	local success = false

	local my_skill = self:getSkill(skill1)
	local enemy_skill = target:getSkill(skill2)
	local d = rng.dice(1,20)
	local d2 = rng.dice(1,20)
	local enemy_total = d2 + (enemy_skill or 0)
	local my_total = d + (my_skill or 0)

	if d + (my_skill or 0) > enemy_total then success = true end

	if self == game.player then
		local s = ("Opposed check: dice roll %d + bonus %d versus DC %d -> %s"):format(
			d, my_skill or 0, enemy_total, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end 
	if target == game.player then
		local player_success = true
		if success then player_success = false end
		local s = ("Opposed check for the monster: %d versus DC %d -> player %s"):format(
			my_total, enemy_total, player_success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end 

	return success
end

--Cross-class skills, Zireael
function _M:crossClass(skill)
	--List class skills for every class 
	local c_barbarian = { balance = "no", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "yes", movesilently = "no", openlock = "no", pickpocket = "no", ride = "yes", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", usemagic = "no" }
	local c_bard = { balance = "yes", bluff = "yes", climb = "yes", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "no", pickpocket = "yes", ride = "no", search = "no", sensemotive = "yes", spot = "no", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "yes", usemagic = "yes" }
	local c_cleric = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "no", search = "no", sensemotive = "no", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_druid = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "yes", movesilently = "no", openlock = "no", pickpocket = "no", ride = "yes", search = "no", sensemotive = "no", spot = "yes", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "no", usemagic = "no" }
	local c_fighter = { balance = "no", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "yes", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "no", usemagic = "no" }
	local c_monk = { balance = "yes", bluff = "no", climb = "yes", concentration = "no", diplomacy = "yes", disabledevice = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "no", pickpocket = "no", ride = "no", search = "no", sensemotive = "yes", spot = "yes", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "no" }
	local c_paladin = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "yes", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "no", survival = "no", tumble = "no", usemagic = "no" }
	local c_ranger = { balance = "no", bluff = "no", climb = "yes", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "yes", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "no", pickpocket = "no", ride = "yes", search = "yes", sensemotive = "no", spot = "yes", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", usemagic = "no" }
	local c_rogue = { balance = "yes", bluff = "yes", climb = "yes", concentration = "no", diplomacy = "yes", disabledevice = "yes", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "yes", pickpocket = "yes", ride = "no", search = "yes", sensemotive = "yes", spot = "yes", swim = "no", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "yes" }
	local c_sorcerer = { balance = "no", bluff = "yes", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_wizard = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_warlock = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", ride = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	
	if (not skill) then return false end

	if self.last_class and self.last_class == "Barbarian" and c_barbarian[skill] == "no" then return true end
	if self.last_class and self.last_class == "Bard" and c_bard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Cleric" and c_cleric[skill] == "no" then return true end
	if self.last_class and self.last_class == "Druid" and c_druid[skill] == "no" then return true end
	if self.last_class and self.last_class == "Fighter" and c_fighter[skill] == "no" then return true end
	if self.last_class and self.last_class == "Monk" and c_monk[skill] == "no" then return true end
	if self.last_class and self.last_class == "Paladin" and c_paladin[skill] == "no" then return true end
	if self.last_class and self.last_class == "Ranger" and c_ranger[skill] == "no" then return true end
	if self.last_class and self.last_class == "Rogue" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Sorcerer" and c_sorcerer[skill] == "no" then return true end
	if self.last_class and self.last_class == "Wizard" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Warlock" and c_warlock[skill] == "no" then return true end
	if self.last_class and self.last_class == "Shaman" and c_cleric[skill] == "no" then return true end
	if self.last_class and self.last_class == "Shadowdancer" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Assasin" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Loremaster" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Archmage" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Blackguard" and c_paladin[skill] == "no" then return true end
	if self.last_class and self.last_class == "Arcane archer" and c_ranger[skill] == "no" then return true end


	return false
end

function _M:classFeat(tid)
	local Talents = require "engine.interface.ActorTalents"

	--A hardcoded list of class feats per class
	local f_barbarian = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_SHIELD_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes", T_MARTIAL_WEAPON_PROFICIENCY = "yes" }
	local f_bard = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes" }
	local f_cleric = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_HEAVY_ARMOR_PROFICIENCY = "yes", T_SHIELD_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes"  }
	local f_druid = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes" }
	local f_fighter = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_HEAVY_ARMOR_PROFICIENCY = "yes", T_SHIELD_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes", T_MARTIAL_WEAPON_PROFICIENCY = "yes" }
	local f_monk = { T_SIMPLE_WEAPON_PROFICIENCY = "yes" }
	local f_paladin = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_HEAVY_ARMOR_PROFICIENCY = "yes", T_SHIELD_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes", T_MARTIAL_WEAPON_PROFICIENCY = "yes" }
	local f_ranger = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes", T_MARTIAL_WEAPON_PROFICIENCY = "yes" }
	local f_rogue = { T_LIGHT_ARMOR_PROFICIENCY = "yes", T_MEDIUM_ARMOR_PROFICIENCY = "yes", T_SIMPLE_WEAPON_PROFICIENCY = "yes" }


	if self.classes and self.classes["Barbarian"] and f_barbarian[tid] == "yes" then return true end
	if self.classes and self.classes["Bard"] and f_bard[tid] == "yes" then return true end
	if self.classes and self.classes["Cleric"] and f_cleric[tid] == "yes" then return true end
	if self.classes and self.classes["Druid"] and f_druid[tid] == "yes" then return true end
	if self.classes and self.classes["Fighter"] and f_fighter[tid] == "yes" then return true end
	if self.classes and self.classes["Monk"] and f_monk[tid] == "yes" then return true end
	if self.classes and self.classes["Paladin"] and f_paladin[tid] == "yes" then return true end
	if self.classes and self.classes["Ranger"] and f_ranger[tid] == "yes" then return true end
	if self.classes and self.classes["Rogue"] and f_rogue[tid] == "yes" then return true end

	return false
end

--AC, Sebsebeleb & Zireael
function _M:getAC()
	local dex_bonus = self:getDexMod()
	--Splitting it up to avoid stuff like stacking rings of protection or bracers of armor + armor
--	local base = self.combat_base_ac or 10
	local armor = self.combat_armor_ac or 0
	local shield = self.combat_shield or 0
	local natural = self.combat_natural or 0
	local magic_armor = self.combat_magic_armor or 0
	local magic_shield = self.combat_magic_shield or 0
	local dodge = self.combat_dodge or 0
	local protection = self.combat_protection or 0
	local untyped = self.combat_untyped or 0

	if self.max_dex_bonus then dex_bonus = math.min(dex_bonus, self.max_dex_bonus) end 

	if self.combat_protection then protection = math.min(protection, 5) end

	--Shield Focus feat
	if self.combat_shield and self:knowTalent(self.T_SHIELD_FOCUS) then shield = shield + 2 end
	
	return math.floor((10 + armor + magic_armor + shield + magic_shield + natural + protection + dodge) + (dex_bonus or 0))
end

--Saving throws, Sebsebeleb & Zireael
function _M:reflexSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("reflex_save") or 0) + math.max(self:getDexMod(), self:getIntMod())

	if self == game.player then
		local s = ("Reflex save: %d roll + bonus = %d versus DC %d"):format(
			roll, save, dc)--, success and "success" or "failure")
		game.log(s)
	end

	return roll ~= 1 and (roll == 20 or roll + save > dc)
end

function _M:fortitudeSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("fortitude_save") or 0) + math.max(self:getConMod(), self:getStrMod())

	if self == game.player then
		local s = ("Fortitude save: %d roll + bonus = %d versus DC %d"):format(
			roll, save, dc)--, success and "success" or "failure")
		game.log(s)
	end

	return roll ~= 1 and (roll == 20 or roll + save > dc)
end

function _M:willSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("will_save") or 0) + math.max(self:getWisMod(), self:getChaMod())

	if self == game.player then
		local s = ("Will save: %d roll + bonus = %d versus DC %d"):format(
			roll, save, dc)--, success and "success" or "failure")
		game.log(s)
	end

	return roll ~= 1 and (roll == 20 or roll + save > dc)
end

function _M:saveRoll(DC, type)
	if type == "physical" then self:fortitudeSave(DC) end
	if type == "mental" then self:willSave(DC) end
end


--Metamagic & spellbook stuff, Sebsebeleb
function useMetamagic(self, t)
	local metaMod = {}
	for tid, _ in pairs(self.talents) do
		local t = self:getTalentFromId(tid)
		local tt = self:getTalentTypeFrom(t)
		if tt == "arcane/metamagic" and self:isTalentActive(t.id) then
			for i,v in ipairs(t.getMod(self, t)) do
				metaMod[i] = (metaMod[i] and metaMod[i] + v) or v
			end
		end
	end
	return metaMod
end 


--- The max charge worth you can have in a given spell level
function _M:getMaxMaxCharges(spell_list)
	local t = {}
	local l = self.level + 5
	while l > 5 do
		t[#t+1] = math.min(8, l)
		--We gain a new spell level every 3 character levels.
		l = l - 2
	end
	return t
end

function _M:getMaxCharges(tid)
	local t = self:getTalentFromId(tid)
	tid = t.id

	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		return self:getMaxMaxCharges()[t.level] or 0
	end
	return self.max_charges[tid] or 0
end

function _M:getCharges(tid)
	local t = self:getTalentFromId(tid)
	tid = t.id

	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		return self.charges[innatekind..t.level] or 0
	end
	return self.charges[tid] or 0
end

function _M:incMaxCharges(tid, v, spell_list)
	local tt
	local t
	if type(tid) == "table" then
		t = tid
		tt = tid.type[1]
		tid = tid.id 
	else
		t = self:getTalentFromId(tid)
		tt = self:getTalentFromId(tid).type[1]
	end

	--Does the player have the spell slots for this level?
	if not self:getMaxMaxCharges()[t.level] then return end

    -- Disallow going below 0.
    v = math.max(-(self.max_charges[tid] or 0), v)

	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(spell_list, t.level)
	if a + v > self:getMaxMaxCharges()[t.level] then return end
	self.max_charges[tid] = (self.max_charges[tid] or 0) + v
	self:incAllocatedCharges(spell_list, t.level, v)
end


--- Set the number of prepared instances of a certain spell
function _M:setMaxCharges(tid, spell_list, v)

	local t
	if type(tid) == "table" then
		t = tid
		tid = tid.id 
	else
		t = self:getTalentFromId(tid)
	end

	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(spell_list, tid.level)
	if a + v > self:getMaxMaxCharges()[tid.level] then return end
	self.max_charges[tid] = v
	self:setAllocatedCharges(spell_list, t.level, v)
end

--- Set the number of available instances of a certain spell
function _M:setCharges(tid, v)
	local t = self:getTalentFromId(tid)
	tid = t.id

	--Account for innate casting
	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		self.charges[innatekind..t.level] = v
	else
		self.charges[tid] = v
	end
end

--- Increase the number of available instances of a certain spell
function _M:incCharges(tid, v)
	if type(tid) == "table" then tid = tid.id end
	local new = (self:getCharges(tid) or 0) + v
	self:setCharges(tid, new)
end

function _M:getAllocatedCharges(spell_list, level)
	local c = self.allocated_charges[spell_list]
	c = c and c[level]
	return c or 0
end

function _M:setAllocatedCharges(spell_list, level, value)
	if not self.allocated_charges[spell_list] then self.allocated_charges[spell_list] = {} end
	if not self.allocated_charges[spell_list][level] then self.allocated_charges[spell_list][level] = {} end
	self.allocated_charges[spell_list][level] = value
end

function _M:incAllocatedCharges(spell_list, level, value)
	local c = self:getAllocatedCharges(spell_list, level)
	local val = c and (c + value) or value
	self:setAllocatedCharges(spell_list, level, val)
end

function _M:allocatedChargesReset()
	for k, v in pairs(self.max_charges) do
		self.max_charges[k] = 0
	end
	for k, v in pairs(self.charges) do
		self.charges[k] = 0
	end
	for k,v in pairs(self.allocated_charges) do
		for level, value in pairs(self.allocated_charges[k]) do
			self.allocated_charges[k][level] = 0
		end
	end
end

--DarkGod's useful functions
function _M:hasDescriptor(t)
	if not self.descriptor then return false end
	for k, v in pairs(t) do
		if self.descriptor[k] ~= v then return false end
	end
	return true
end

function _M:highestSpellDescriptor(what)
	local list = {}
	for tid, _ in pairs(self.talents) do
		local t = self:getTalentFromId(tid)
		if t.is_spell and t.descriptors and t.descriptors[what] and self:getCharges(t) > 0 then list[#list+1] = t end
	end
	if #list == 0 then return nil end
	table.sort(list, "level")
	return list[#list]
end

function _M:incCasterLevel(kind, v)
	self.caster_levels[kind] = self.caster_levels[kind] or 0
	self.caster_levels[kind] = self.caster_levels[kind] + v
end

function _M:casterLevel(kind)
	if type(kind) == "string" then
		if not self.caster_levels[kind] then return 0, "none" end
		return self.caster_levels[kind], kind
	else
		local t = self:getTalentFromId(kind)
		if not t.spell_kind then return 0, "none" end
		local max, kind = 0, "none"
		for k, _ in pairs(t.spell_kind) do
			max = math.max(max, (self:casterLevel(k)))
			kind = k
		end
		return max, kind
	end
end

function _M:spellIsKind(t, kind)
	if not t then return false end
	if not t.is_spell then return false end
	if not t.spell_kind[kind] then return false end
	return true
end

function _M:levelPassives()
	for tid, _ in pairs(self.talents_def) do
		local t = self:getTalentFromId(tid)
		local tt = self:getTalentTypeFrom(t.type[1])
		if self:knowTalentType(t.type[1]) then
			if tt.passive then
				if self:canLearnTalent(t) then
					self:learnTalent(tid)
					game.log("You learned "..t.name)
				end
			end
		end
	end
end

--Leveling up
function _M:levelup()
	engine.interface.ActorLevel.levelup(self)
	engine.interface.ActorTalents.resolveLevelTalents(self)

	--Player only stuff
	if self == game.player or game.party:hasMember(self) then
		--gain skill ranks
		self.max_skill_ranks = self.max_skill_ranks + 1
		--may level up class (player only)
		self.class_points = self.class_points + 1

		--feat points given every 3 levels. Classes may give additional feat points.
		if self.level % 3 == 0 then self.feat_point = (self.feat_point or 0) + 1 end
		
		--stat point gained every 4 levels
		if self.level % 4 == 0 then self.stat_point = (self.stat_point or 0) + 1 end

	end


	-- Auto levelup ?
	if self.autolevel then
		engine.Autolevel:autoLevel(self)
	end

	-- Heal up NPC on new level
	if self ~= game.player then self:resetToFull() end

	--NPC only stuff
	if self ~= game.player then

	end	



	--Notify player on epic level
	if self.level == 40 and self == game.player then
		Dialog:simpleLongPopup("Level 40!", "You have achieved #GOLD#level 40#WHITE#, congratulations!\n\nThis means you are now an #GOLD#EPIC#LAST# hero!", 400)
	end
	
	--Notify on party levelups
	if self.x and self.y and game.party:hasMember(self) and not self.silent_levelup then
		local x, y = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(x, y, 80, 0.5, -2, "LEVEL UP!", {0,255,255})
		game.log("#00ffff#Welcome to level %d [%s].", self.level, self.name:capitalize())
		if game.player ~= self then game.log = "Select "..self.name.. " in the party list and press G to use them." end
	end

	--Level up achievements
	if self == game.player then
--[[		if self.level == 10 then world:gainAchievement("LEVEL_10", self) end
		if self.level == 20 then world:gainAchievement("LEVEL_20", self) end
		if self.level == 30 then world:gainAchievement("LEVEL_30", self) end
		if self.level == 40 then world:gainAchievement("LEVEL_40", self) end
		if self.level == 50 then world:gainAchievement("LEVEL_50", self) end
]]
	end

	if self == game.player and game then game:registerDialog(require("mod.dialogs.LevelupDialog").new(self.player)) end

end

function _M:levelClass(name)
	local birther = require "engine.Birther"
	local d = birther:getBirthDescriptor("class", name)

	if not name then end

	local level = (self.classes[name] or 0) + 1
	self.classes[name] = level
	if self.class_points then
		self.class_points = self.class_points - 1
	end

	if level == 1 then --Apply the descriptor... or not?

	end

	self.last_class = name

	d.on_level(self, level, d)
end

function _M:giveLevels(name, n)
	if not name or not n then end
	
	while n > 0 do
	self:levelClass(name)
	n = n-1
	end
end

--Swap weapons functions
function _M:hasRangedWeapon()
	local inven = self.inven[self.INVEN_INVEN]
		for k, o in ipairs(inven) do
			if  o.ranged == true then
				return true
			end
		end
		return false
end

function _M:hasRangedAmmo()
	local inven = self.inven[self.INVEN_INVEN]
		for k, o in ipairs(inven) do
			if  o.ammo == true then
				return true
			end
		end
		return false
end

function _M:getRangedAmmo()
	local inven = self.inven[self.INVEN_INVEN]
		for k, o in ipairs(inven) do
			if  o.ammo == true then
				return o
			end
		end
		return nil
end

function _M:getRangedWeapon()
	local inven = self.inven[self.INVEN_INVEN]
		for k, o in ipairs(inven) do
			if  o.ranged == true then
				return o
			end
		end
		return nil
end


function _M:wieldRanged()
	local weapon = self:getInven("MAIN_HAND")[1]
    local ammo = self:getInven("QUIVER")[1]

    local mh = self.inven[self.INVEN_MAIN_HAND]
    local am = self.inven[self.INVEN_QUIVER]

    --Do we have ammo in inventory?
    if self:hasRangedAmmo() then
    	--check if types match
    	if weapon.ranged then 
    		if not weapon.ammo_type == self:getRangedAmmo().archery_ammo then return end
    	else 
    		if not self:getRangedWeapon().ammo_type == self:getRangedAmmo().archery_ammo then return end
    	end
    end
    
    if self:hasRangedWeapon() then

    	self:removeObject(inven, weapon, true)
    	
    	self:addObject(mh, self:getRangedWeapon())
    end

    if self:hasRangedAmmo() then
    	self:removeObject(inven, ammo, true)

    	self:addObject(am, self:getRangedAmmo())
    end
end

function _M:wieldMelee()
	local shield = self:getInven("OFF_HAND")[1]


end


--Encumbrance & auto-ID stuff, Zireael
function _M:on_pickup_object(o)
--	self:checkEncumbrance()
	
end

--[[function _M:onAddObject(o)
	
end]]

function _M:onRemoveObject(o)
	self:checkEncumbrance()
end	

function _M:getMaxEncumbrance()
	local add = 0
	--Streamlined d20's encumbrance
	if self:getStr() <= 10 then return math.floor(10*self:getStr())
	else return math.ceil((10*self:getStr()) + (5*(self:getStr()-10))) end
end

function _M:getEncumbrance()
	local enc = 0

	local fct = function(so) enc = enc + so.encumber end

	-- Compute encumbrance
	for inven_id, inven in pairs(self.inven) do
		for item, o in ipairs(inven) do
				o:forAllStack(fct)
		end
	end
	
	return math.floor(enc)
end

function _M:checkEncumbrance()
	-- Compute encumbrance
	local enc, max = self:getEncumbrance(), self:getMaxEncumbrance()	

	--Light load
	if enc < max * 0.33 then
		--remove any load effects one might have
		if self:hasEffect(self.EFF_MEDIUM_LOAD) then self:removeEffect(self.EFF_MEDIUM_LOAD, true) end
		if self:hasEffect(self.EFF_HEAVY_LOAD) then self:removeEffect(self.EFF_HEAVY_LOAD, true) end
	end


	--Heavy load
	if enc > max * 0.66 then
		--Loadbearer
		if self:knowTalent(self.T_LOADBEARER) and not self:hasEffect(self.EFF_MEDIUM_LOAD) then
			self:setEffect(self.EFF_MEDIUM_LOAD, 2, {}, true)
		end
		--Not loadbearer
		if self:knowTalent(self.T_LOADBEARER) and not self:hasEffect(self.EFF_HEAVY_LOAD) then
			--remove medium load if any
			if self:hasEffect(self.EFF_MEDIUM_LOAD) then self:removeEffect(self.EFF_MEDIUM_LOAD, true) end
			self:setEffect(self.EFF_HEAVY_LOAD, 2, {}, true)
		end
	end

	
	--Medium load
	if enc > max * 0.33 and not self:knowTalent(self.T_LOADBEARER) and not self:hasEffect(self.EFF_MEDIUM_LOAD) then
		--remove heavy load first
		if self:hasEffect(self.EFF_HEAVY_LOAD) then self:removeEffect(self.EFF_HEAVY_LOAD, true) end
		self:setEffect(self.EFF_MEDIUM_LOAD, 2, {}, true)
	
	end
	
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

function _M:reactionToward(target)
    local v = engine.Actor.reactionToward(self, target)

    if self:hasEffect(self.EFF_CHARM) then v = math.max(v, 100) end

    return v
end

--is there a quicker way to do it?
--From most dangerous to weakest
function _M:isPoisoned()
	if self:hasEffect(self.EFF_POISON_EXTRASTRONG_CON) then return EFF_POISON_EXTRASTRONG_CON end
	if self:hasEffect(self.EFF_POISON_DRAGON_BILE) then return EFF_POISON_DRAGON_BILE end
	if self:hasEffect(self.EFF_POISON_STRONG_CON) then return EFF_POISON_STRONG_CON end
	if self:hasEffect(self.EFF_POISON_STRONG_STR) then return EFF_POISON_STRONG_STR end
	if self:hasEffect(self.EFF_POISON_ARSENIC_SEC) then return EFF_POISON_ARSENIC_SEC end
	if self:hasEffect(self.EFF_POISON_MEDIUM_STR) then return EFF_POISON_MEDIUM_STR end
	if self:hasEffect(self.EFF_POISON_MALYSS_PRI) then return EFF_POISON_MALYSS_PRI end
	if self:hasEffect(self.EFF_POISON_MEDIUM_DEX) then return EFF_POISON_MEDIUM_DEX end
	if self:hasEffect(self.EFF_POISON_TERINAV_SEC) then return EFF_POISON_TERINAV_SEC end
	
	if self:hasEffect(self.EFF_POISON_MALYSS_SEC) then return EFF_POISON_MALYSS_SEC end
	if self:hasEffect(self.EFF_POISON_MOSS_SEC) then return EFF_POISON_MOSS_SEC end
	if self:hasEffect(self.EFF_POISON_DARK_REAVER_SEC) then return EFF_POISON_DARK_REAVER_SEC end
	if self:hasEffect(self.EFF_POISON_INSANITY_MIST_SEC) then return EFF_POISON_INSANITY_MIST_SEC end
	
	if self:hasEffect(self.EFF_POISON_MEDIUM_CON) then return EFF_POISON_MEDIUM_CON end
	if self:hasEffect(self.EFF_POISON_BLOODROOT_SEC) then return EFF_POISON_BLOODROOT_SEC end
	if self:hasEffect(self.EFF_POISON_WEAK_CON) then return EFF_POISON_WEAK_CON end
	if self:hasEffect(self.EFF_POISON_GREENBLOOD_SEC) then return EFF_POISON_GREENBLOOD_SEC end
	if self:hasEffect(self.EFF_POISON_UNGOL_DUST_SEC) then return EFF_POISON_UNGOL_DUST_SEC end
	if self:hasEffect(self.EFF_POISON_INSANITY_MIST_PRI) then return EFF_POISON_INSANITY_MIST_PRI end
	if self:hasEffect(self.EFF_POISON_MIDDLING_INT) then return EFF_POISON_MIDDLING_INT end
	if self:hasEffect(self.EFF_POISON_MIDDLING_STR) then return EFF_POISON_MIDDLING_STR end
	if self:hasEffect(self.EFF_POISON_UNGOL_DUST_PRI) then return EFF_POISON_UNGOL_DUST_PRI end
	if self:hasEffect(self.EFF_POISON_SHADOW_ESSENCE_PRI) then return EFF_POISON_SHADOW_ESSENCE_PRI end
	if self:hasEffect(self.EFF_POISON_SMALL_CENTIPEDE) then return EFF_POISON_SMALL_CENTIPEDE end
	if self:hasEffect(self.EFF_POISON_TOADSTOOL_SEC) then return EFF_POISON_TOADSTOOL_SEC end
	if self:hasEffect(self.EFF_POISON_TOADSTOOL_PRI) then return EFF_POISON_TOADSTOOL_PRI end

	return nil
end	


--Random feats & immunities code
function _M:randomFeat()
	local chance = rng.dice(1,29)
	
	if chance == 1 then self:learnTalent(self.T_DODGE, true)
	elseif chance == 2 then self:learnTalent(self.T_FINESSE, true) 
	elseif chance == 3 then self:learnTalent(self.T_TOUGHNESS, true)
	elseif chance == 4 then self:learnTalent(self.T_ACROBATIC, true)
	elseif chance == 5 then self:learnTalent(self.T_AGILE, true)
	elseif chance == 6 then self:learnTalent(self.T_ALERTNESS, true) 
	elseif chance == 7 then self:learnTalent(self.T_ANIMAL_AFFINITY, true)
	elseif chance == 8 then self:learnTalent(self.T_ARTIST, true) 
	elseif chance == 9 then self:learnTalent(self.T_ATHLETIC, true)
	elseif chance == 10 then self:learnTalent(self.T_COMBAT_CASTING, true)
	elseif chance == 11 then self:learnTalent(self.T_DEFT_HANDS, true) 
	elseif chance == 12 then self:learnTalent(self.T_INVESTIGATOR, true)
	elseif chance == 13 then self:learnTalent(self.T_MAGICAL_APTITUDE, true)
	elseif chance == 14 then self:learnTalent(self.T_MAGICAL_TALENT, true)
	elseif chance == 15 then self:learnTalent(self.T_NEGOTIATOR, true)
	elseif chance == 16 then self:learnTalent(self.T_NIMBLE_FINGERS, true)
	elseif chance == 17 then self:learnTalent(self.T_PERSUASIVE, true)
	elseif chance == 18 then self:learnTalent(self.T_SILVER_PALM, true)
	elseif chance == 19 then self:learnTalent(self.T_STEALTHY, true) 
	elseif chance == 20 then self:learnTalent(self.T_THUG, true) 
	elseif chance == 21 then self:learnTalent(self.T_TWO_WEAPON_FIGHTING, true)
	elseif chance == 22 then self:randomFocus()
	elseif chance == 23 then self:randomFocus()
	elseif chance == 24 then self:randomFavEnemy()
	elseif chance == 25 then self:randomFavEnemy()
	elseif chance == 26 then self:randomImmunity()
	elseif chance == 27 then self:randomImmunity()
	elseif chance == 28 then self:randomImmunity()
		--[[Commented out due to the problems with on_pre_use
		if chance == 1 then self:learnTalent(self.T_POWER_ATTACK, true)]]
	
	else self:learnTalent(self.T_IRON_WILL, true) 
	--	self.perk = "Iron Will" 
	end

end

function _M:randomFocus()
	local chance = rng.dice(1,24)

	if chance == 1 then self:learnTalent(self.T_WEAPON_FOCUS_AXE, true)
	elseif chance == 2 then self:learnTalent(self.T_WEAPON_FOCUS_BATTLEAXE, true)
	elseif chance == 3 then self:learnTalent(self.T_WEAPON_FOCUS_BOW, true)
	elseif chance == 4 then self:learnTalent(self.T_WEAPON_FOCUS_CLUB, true)
	elseif chance == 5 then self:learnTalent(self.T_WEAPON_FOCUS_CROSSBOW, true)
	elseif chance == 6 then self:learnTalent(self.T_WEAPON_FOCUS_DAGGER, true)
	elseif chance == 7 then self:learnTalent(self.T_WEAPON_FOCUS_FALCHION, true)
	elseif chance == 8 then self:learnTalent(self.T_WEAPON_FOCUS_FLAIL, true)
	elseif chance == 9 then self:learnTalent(self.T_WEAPON_FOCUS_HALBERD, true)
	elseif chance == 10 then self:learnTalent(self.T_WEAPON_FOCUS_HAMMER, true) 
	elseif chance == 11 then self:learnTalent(self.T_WEAPON_FOCUS_HANDAXE, true) 
	elseif chance == 12 then self:learnTalent(self.T_WEAPON_FOCUS_JAVELIN, true)
	elseif chance == 13 then self:learnTalent(self.T_WEAPON_FOCUS_KUKRI, true) 
	elseif chance == 14 then self:learnTalent(self.T_WEAPON_FOCUS_MACE, true)
	elseif chance == 15 then self:learnTalent(self.T_WEAPON_FOCUS_MORNINGSTAR, true)
	elseif chance == 16 then self:learnTalent(self.T_WEAPON_FOCUS_RAPIER, true)
	elseif chance == 17 then self:learnTalent(self.T_WEAPON_FOCUS_SCIMITAR, true)
	elseif chance == 18 then self:learnTalent(self.T_WEAPON_FOCUS_SCYTHE, true) 
	elseif chance == 19 then self:learnTalent(self.T_WEAPON_FOCUS_SHORTSWORD, true)
	elseif chance == 20 then self:learnTalent(self.T_WEAPON_FOCUS_SPEAR, true)
	elseif chance == 21 then self:learnTalent(self.T_WEAPON_FOCUS_SLING, true)
	elseif chance == 22 then self:learnTalent(self.T_WEAPON_FOCUS_STAFF, true)
	elseif chance == 23 then self:learnTalent(self.T_WEAPON_FOCUS_SWORD, true)

	else self:learnTalent(self.T_WEAPON_FOCUS_TRIDENT, true)	end

end

function _M:randomFavEnemy()
	local chance = rng.dice(1,30)

	if chance == 1 then self:learnTalent(self.T_FAVORED_ENEMY_ABERRATION, true)
	elseif chance == 2 then self:learnTalent(self.T_FAVORED_ENEMY_ANIMAL, true)
	elseif chance == 3 then self:learnTalent(self.T_FAVORED_ENEMY_CONSTRUCT, true)
	elseif chance == 4 then self:learnTalent(self.T_FAVORED_ENEMY_DRAGON, true)
	elseif chance == 5 then self:learnTalent(self.T_FAVORED_ENEMY_ELEMENTAL, true)
	elseif chance == 6 then self:learnTalent(self.T_FAVORED_ENEMY_FEY, true)
	elseif chance == 7 then self:learnTalent(self.T_FAVORED_ENEMY_GIANT, true)
	elseif chance == 8 then self:learnTalent(self.T_FAVORED_ENEMY_MAGBEAST, true)
	elseif chance == 9 then self:learnTalent(self.T_FAVORED_ENEMY_MONSTROUS_HUMANOID, true)
	elseif chance == 10 then self:learnTalent(self.T_FAVORED_ENEMY_OOZE, true)
	elseif chance == 11 then self:learnTalent(self.T_FAVORED_ENEMY_PLANT, true)
	elseif chance == 12 then self:learnTalent(self.T_FAVORED_ENEMY_UNDEAD, true)
	elseif chance == 13 then self:learnTalent(self.T_FAVORED_ENEMY_VERMIN, true)
	elseif chance == 14 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_DWARF, true)
	elseif chance == 15 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_GNOME, true)
	elseif chance == 16 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_DROW, true)
	elseif chance == 17 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_ELF, true)
	elseif chance == 18 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_HUMAN, true)
	elseif chance == 19 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_HALFLING, true)
	elseif chance == 20 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_PLANETOUCHED, true)
	elseif chance == 21 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_AQUATIC, true)
	elseif chance == 22 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_GOBLINOID, true)
	elseif chance == 23 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_REPTILIAN, true) 
	elseif chance == 24 then self:learnTalent(self.T_FAVORED_ENEMY_HUMANOID_ORC, true)
	elseif chance == 25 then self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_AIR, true)
	elseif chance == 26 then self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_EARTH, true)
	elseif chance == 27 then self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_EVIL, true)
	elseif chance == 28 then self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_FIRE, true)
	elseif chance == 29 then self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_GOOD, true)

	else self:learnTalent(self.T_FAVORED_ENEMY_OUTSIDER_WATER, true) 	end

end

function _M:randomImmunity()
	local chance = rng.dice(1,10)
	if chance == 1 then self:learnTalent(self.T_POISON_IMMUNITY, true)
	elseif chance == 2 then self:learnTalent(self.T_DISEASE_IMMUNITY, true)
	elseif chance == 3 then self:learnTalent(self.T_SLEEP_IMMUNITY, true) 
	elseif chance == 4 then self:learnTalent(self.T_PARALYSIS_IMMUNITY, true)
	elseif chance == 5 then self:learnTalent(self.T_FIRE_RESISTANCE, true)
	elseif chance == 6 then	self:learnTalent(self.T_ACID_RESISTANCE, true)
	elseif chance == 7 then self:learnTalent(self.T_COLD_RESISTANCE, true)
	elseif chance == 8 then self:learnTalent(self.T_ELECTRICITY_RESISTANCE, true)
	elseif chance == 9 then self:learnTalent(self.T_SONIC_RESISTANCE, true) 	
	else self:learnTalent(self.T_CONFUSION_IMMUNITY, true)
	end
end	

function _M:randomSpell()
	local chance = rng.dice(1,4)
	if chance == 1 then self:learnTalent(self.T_ACID_SPLASH_INNATE, true)
	elseif chance == 2 then self:learnTalent(self.T_GREASE_INNATE, true)
	elseif chance == 3 then self:learnTalent(self.T_HLW_INNATE, true)
	else self:learnTalent(self.T_CLW_INNATE, true)  
	end
end	




--Add healthbars
function _M:defineDisplayCallback()
	if not self._mo then return end

	local backps = self:getParticlesList(true)
	local ps = self:getParticlesList()

	local function tactical(x, y, w, h, zoom, on_map, tlx, tly)
		-- Healthbars code (taken from Hulk)
		if game.level and game.always_target then
			-- Tactical life info
			if on_map then
				local dh = h * 0.1
				local lp = math.max(0, self.life) / self.max_life + 0.0001
				if lp > .75 then -- green
					core.display.drawQuad(x + 3, y + h - dh, w - 6, dh, 129, 180, 57, 128)
					core.display.drawQuad(x + 3, y + h - dh, (w - 6) * lp, dh, 50, 220, 77, 255)
				elseif lp > .5 then -- yellow
					core.display.drawQuad(x + 3, y + h - dh, w - 6, dh, 175, 175, 10, 128)
					core.display.drawQuad(x + 3, y + h - dh, (w - 6) * lp, dh, 240, 252, 35, 255)
				elseif lp > .25 then -- orange
					core.display.drawQuad(x + 3, y + h - dh, w - 6, dh, 185, 88, 0, 128)
					core.display.drawQuad(x + 3, y + h - dh, (w - 6) * lp, dh, 255, 156, 21, 255)
				else -- red
					core.display.drawQuad(x + 3, y + h - dh, w - 6, dh, 167, 55, 39, 128)
					core.display.drawQuad(x + 3, y + h - dh, (w - 6) * lp, dh, 235, 0, 0, 255)
				end
			end
		end

		-- Tactical info (taken from T-Engine)
		if game.level and game.level.map.view_faction then
			local map = game.level.map
			if on_map then
				if not f_self then
					f_self = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_self)
					f_powerful = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_powerful)
					f_danger2 = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_danger2)
					f_danger1 = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_danger1)
					f_friend = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_friend)
					f_enemy = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_enemy)
					f_neutral = game.level.map.tilesTactic:get(nil, 0,0,0, 0,0,0, map.faction_neutral)
				end

				if self.faction then
					local friend
					if not map.actor_player then friend = Faction:factionReaction(map.view_faction, self.faction)
					else friend = map.actor_player:reactionToward(self) end

					if self == map.actor_player then
						f_self:toScreen(x, y, w, h)
					elseif map:faction_danger_check(self) then
						if friend >= 0 then f_powerful:toScreen(x, y, w, h)
						else
							if map:faction_danger_check(self, true) then
								f_danger2:toScreen(x, y, w, h)
							else
								f_danger1:toScreen(x, y, w, h)
							end
						end
					elseif friend > 0 then
						f_friend:toScreen(x, y, w, h)
					elseif friend < 0 then
						f_enemy:toScreen(x, y, w, h)
					else
						f_neutral:toScreen(x, y, w, h)
					end
				end
			end
		end
	end

	local function particles(x, y, w, h, zoom, on_map)
		local e
		local dy = 0
		if h > w then dy = (h - w) / 2 end
		for i = 1, #ps do
			e = ps[i]
			e:checkDisplay()
			if e.ps:isAlive() then e.ps:toScreen(x + w / 2, y + dy + h / 2, true, w / (game.level and game.level.map.tile_w or w))
			else self:removeParticles(e)
			end
		end
	end

	local function backparticles(x, y, w, h, zoom, on_map)
		local e
		local dy = 0
		if h > w then dy = (h - w) / 2 end
		for i = 1, #backps do
			e = backps[i]
			e:checkDisplay()
			if e.ps:isAlive() then e.ps:toScreen(x + w / 2, y + dy + h / 2, true, w / (game.level and game.level.map.tile_w or w))
			else self:removeParticles(e)
			end
		end
	end

	if self._mo == self._last_mo or not self._last_mo then
		self._mo:displayCallback(function(x, y, w, h, zoom, on_map, tlx, tly)
			tactical(tlx or x, tly or y, w, h, zoom, on_map)
			backparticles(x, y, w, h, zoom, on_map)
			particles(x, y, w, h, zoom, on_map)
			return true
		end)
	else
		self._mo:displayCallback(function(x, y, w, h, zoom, on_map, tlx, tly)
			tactical(tlx or x, tly or y, w, h, zoom, on_map)
			backparticles(x, y, w, h, zoom, on_map)
			return true
		end)
		self._last_mo:displayCallback(function(x, y, w, h, zoom, on_map)
			particles(x, y, w, h, zoom, on_map)
			return true
		end)
	end
end

require 'mod.class.patch.ActorTalentDialog'

