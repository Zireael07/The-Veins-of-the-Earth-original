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
	self.combat_dr = 0
--	self.combat_base_ac = 10
	self.combat_bab = 0
	self.hit_die = 4

	--Define AC types
	self.combat_armor_ac = 0
	self.combat_shield = 0
	self.combat_natural = 0
	self.combat_magic = 0
	self.combat_dodge = 0
	self.combat_untyped = 0

	--Some more combat stuff
	self.more_attacks = 0

	--Challenge Rating & ECL set to 0 & 1
	self.challenge = 0
	self.ecl = 1

	--Skill ranks
	self.max_skill_ranks = 4
	self.cross_class_ranks = math.floor(self.max_skill_ranks/2)

	-- Default melee barehanded damage
	self.combat = { dam = {1,4} }

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
	self.skill_handleanimal = 0
	self.skill_heal = 0
	self.skill_hide = 0
	self.skill_intimidate = 0
	self.skill_intuition = 0
	self.skill_jump = 0
	self.skill_knowledge = 0
	self.skill_listen = 0
	self.skill_movesilently = 0
	self.skill_openlock = 0
	self.skill_search = 0
	self.skill_sensemotive = 0
	self.skill_swim = 0
	self.skill_pickpocket = 0 --what is called sleight of hand in 3.5
	self.skill_spellcraft = 0
	self.skill_survival = 0
	self.skill_tumble = 0
	self.skill_usemagic = 0

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
	self.allocated_charges = {}

	--Light-related
	self.lite = 0 --Temporary test
	self.infravision = 0

	self.life = t.max_life or self.life

	-- Use weapon damage actually
	if not self:getInven("MAIN_HAND") or not self:getInven("OFF_HAND") then return end
	if weapon then dam = weapon.combat.dam
	end
end

-- Called when our stats change
function _M:onStatChange(stat, v)
	if stat == "str" then self:checkEncumbrance() end
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

	-- check passive stuff. This should be in actbase I think but I cant get it to work
	if self:knowTalent(self.T_BLOOD_VENGANCE) then
		if self.life / self.max_life < 0.5 then
			self:setEffect(self.EFF_BLOOD_VENGANCE, 1, {})
		end
	end

	if self:attr("sleep") then self.energy.value = 0 end

	-- Check terrain special effects
	game.level.map:checkEntity(self.x, self.y, Map.TERRAIN, "on_stand", self)


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

	-- TODO This is where we do auto-search for traps.
	return moved
end

function _M:tooltip()
	return ([[%s%s
		#RED#HP: %d (%d%%)
		#WHITE#STR %s DEX %s CON %s 
		WIS %s INT %s CHA %s
		#GOLD#CR %s
		%s]]):format(
		self:getDisplayString(),
		self.name,
		self.life, self.life * 100 / self.max_life,
		self:getStat('str'),
		self:getStat('dex'),
		self:getStat('con'),
		self:getStat('int'),
		self:getStat('wis'),
		self:getStat('cha'),
		self:attr('challenge'),
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

	local tt_def = self:getTalentTypeFrom(ab.type[1])

	--remove charge
	if tt_def.all_limited then self:incCharges(ab, -1) end

	--Spell failure!
	if self.classes and self.classes["Wizard"] and (self.spell_fail or 0) > 0 and rng.percent(self.spell_fail) then game.logPlayer(self, "You armor hinders your spellcasting! Your spell fails!") return false end

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
	if self.challenge < (game.player.level - 4) then return 0
	else return (self.exp_worth) end
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

--Skill checks, Zireael
function _M:getSkill(skill)
	local stat_for_skill = { balance = "dex", bluff = "cha", climb = "str", concentration = "con", diplomacy = "cha", disabledevice = "int", escapeartist = "dex", handleanimal = "wis", heal = "wis", hide = "dex", intimidate = "cha", intuition = "int", jump = "str", knowledge = "wis", listen = "wis", movesilently = "dex", openlock = "dex", pickpocket = "dex", search = "int", sensemotive = "wis", swim = "str", spellcraft = "int", survival = "wis", tumble = "dex", usemagic = "int" }
	if (not skill) then return 0 end
	local penalty_for_skill = { balance = "yes", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "no", jump = "yes", knowledge = "no", listen = "no", movesilently = "yes", openlock = "no", pickpocket = "yes", search = "no", sensemotive = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "no" }
	if penalty_for_skill[skill] == "yes" then return (self:attr("skill_"..skill) or 0) + math.floor((self:getStat(stat_for_skill[skill])-10)/2) - (self:attr("armor_penalty") or 0) end
	return (self:attr("skill_"..skill) or 0) + math.floor((self:getStat(stat_for_skill[skill])-10)/2) end 

function _M:skillCheck(skill, dc, silent)
	local success = false

	local d = rng.dice(1,20)
	if d == 20 then return true
	elseif d == 1 then return false
	end

	local result = d + (getSkill(skill) or 0) 

	if result > dc then success = true end

	if not silent then
		local who = self:getName()
		local s = ("%s check for %s: %d vs %d dc -> %s"):format(
			skill:capitalize(), who, d, dc, success and "success" or "failure")
		game.log(s)
	end

	return success
end

function _M:opposedCheck(skill1, target, skill2)
	local my_skill = self:getSkill(skill1)
	local enemy_skill = target:getSkill(skill2)

	if d + (my_skill or 0) > d + (enemy_skill or 0) then return true end
	return false
end

--AC, Sebsebeleb & Zireael
function _M:getAC()
	local dex_bonus = (self:getDex()-10)/2
	--Splitting it up to avoid stuff like stacking rings of protection or bracers of armor + armor
--	local base = self.combat_base_ac or 10
	local armor = self.combat_armor or 0
	local shield = self.combat_shield or 0
	local natural = self.combat_natural or 0
	local magic = self.combat_magic or 0
	local dodge = self.combat_dodge or 0
	local untyped = self.combat_untyped or 0

	if self.max_dex_bonus then dex_bonus = math.min(dex_bonus, self.max_dex_bonus) end 

	if self.combat_magic then magic = math.max(magic, 5) end
	
	return (10 + armor + shield + natural + magic + dodge) + (dex_bonus or 0)
end

--Saving throws, Sebsebeleb & Zireael
function _M:reflexSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("reflex_save") or 0) + math.max((self:getStat("dex")-10)/2, (self:getStat("int")-10)/2)
	if not roll == 1 and roll == 20 or roll + save > dc then
		return true
	else
		return false
	end
end

function _M:fortitudeSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("fortitude_save") or 0) + math.max((self:getStat("con")-10)/2, (self:getStat("str")-10)/2)
	if not roll == 1 and roll == 20 or roll + save > dc then
		return true
	else
		return false
	end
end

function _M:willSave(dc)
	local roll = rng.dice(1,20)
	local save = math.floor(self.level / 4) + (self:attr("will_save") or 0) + math.max((self:getStat("wis")-10)/2, (self:getStat("cha")-10)/2)
	if not roll == 1 and roll == 20 or roll + save > dc then
		return true
	else
		return false
	end
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
function _M:getMaxMaxCharges(talent_type)
	local t = {}
	local l = self.level + 5
	while l > 5 do
		t[#t+1] = math.min(8, l)
		l = l - 3
	end
	return t
end

function _M:getMaxCharges(tid)
	if type(tid) == "table" then tid = tid.id end
	return self.max_charges[tid] or 0
end

function _M:getCharges(tid)
	if type(tid) == "table" then tid = tid.id end
	return self.charges[tid] or 0
end

function _M:incMaxCharges(tid, v)
	-- TODO: Clean this nastiness up
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


	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(tt, tid.level)
	if a + v > self:getMaxMaxCharges()[1] then return end
	self.max_charges[tid] = (self.max_charges[tid] or 0) + v
	self:incAllocatedCharges(tt, t.level, v)
end

function _M:setMaxCharges(tid, v)
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

	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(tt, tid.level)
	if a + v > self:getMaxMaxCharges()[1] then return end
	self.max_charges[tid] = v
	self:setAllocatedCharges(tt, t.level, v)
end

function _M:setCharges(tid, v)
	local t
	local id
	if type(tid) == "table" then 
		t = tid
		id = t.id
	else
		t = self:getTalentFromId(tid)
		id = tid
	end
	if t then t.charges = v end
	self.charges[id] = v
end

function _M:incCharges(tid, v)
	if type(tid) == "table" then tid = tid.id end
	local new = (self:getCharges(tid) or 0) + v
	self:setCharges(tid, new)  
end

function _M:getAllocatedCharges(type, level)
	local tid = self:getTalentFromId(type)
	local c = self.allocated_charges[type]
	c = c and c[value]
	return c or 0
end

function _M:setAllocatedCharges(type, level, value)
	if not self.allocated_charges[type] then self.allocated_charges[type] = {} end
	if not self.allocated_charges[type][level] then self.allocated_charges[type][level] = {} end
	self.allocated_charges[type][level] = value
end

function _M:incAllocatedCharges(type, level, value)
	local c = self:getAllocatedCharges(type, level)
	local val = c and (c + value) or value
	self:setAllocatedCharges(type, level, val)
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

	--- Levelup class stuff
	-- Goes through every talent and checks if it should be leveled passively by levels
	--self:levelPassives()

	--Gain hp and skill points (generic)
	self.max_life = self.max_life + self.hd_size
	self.skill_point = self.skill_point + self.skill_point
	self.max_skill_ranks = self.max_skill_ranks + 1
	
	--May level up class
	self.class_points = self.class_points + 1

	if self.level % 3 == 0 then --feat points given every 3 levels. Classes may give additional feat points.
		self.feat_point = self.feat_point + 1
	end
	--Additional (iterative) attacks
	if self.level % 5 == 0 then 
		self.more_attacks = (self.more_attacks or 0) + 1 
	end



	-- Heal up on new level
	--  self:resetToFull()

	-- Auto levelup ?
	if self.autolevel then
		engine.Autolevel:autoLevel(self)
	end

	--if self == game.player then game:onTickEnd(function() game:playSound("actions/levelup") end, "levelupsound") end

	if game then game:registerDialog(require("mod.dialogs.LevelupDialog").new(self.player)) end

end

function _M:levelClass(name)
	local birther = require "engine.Birther"
	local d = birther:getBirthDescriptor("class", name)

	local level = (self.classes[name] or 0) + 1
	self.classes[name] = level
	if self.class_points then
		self.class_points = self.class_points - 1
	end

	if level == 1 then --Apply the descriptor... or not?

	end

	d.on_level(self, level)
end

--Encumbrance & auto-ID stuff, Zireael
function _M:onAddObject(o)
	self:checkEncumbrance()
	if self == game.player and o.identified == false then
		local check = self:skillCheck("intuition", 10)
		if check then
			o.identified = true
		end	
	end	
end

function _M:onRemoveObject(o)
	self:checkEncumbrance()
end	


function _M:getMaxEncumbrance()
	local add = 0
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
	
	--Limit logging to the player
	if self == game.player then game.log(("#00FF00#Total encumbrance: %d"):format(enc)) end
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
