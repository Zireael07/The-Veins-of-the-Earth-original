-- Veins of the Earth
-- Copyright (C) 2013-2014 Zireael
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


local Talents = require "engine.interface.ActorTalents"
local DamageType = require "engine.DamageType"

--Taken from ToME
--- Resolves equipment creation for an actor
function resolvers.equip(t)
	return {__resolver="equip", __resolve_last=true, t}
end
function resolvers.equipnoncursed(t)
	for i, filter in ipairs(t) do
		filter.not_properties = filter.not_properties or {}
		filter.not_properties[#filter.not_properties+1] = "cursed"
	end
	return {__resolver="equip", __resolve_last=true, t}
end


--- Actually resolve the equipment creation
function resolvers.calc.equip(t, e)
--	print("Equipment resolver for", e.name)
	-- Iterate of object requests, try to create them and equip them
	for i, filter in ipairs(t[1]) do
--		print("Equipment resolver", e.name, filter.type, filter.subtype, filter.defined)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			local forced
			o, forced = game.zone:makeEntityByName(game.level, "object", filter.defined, filter.random_art_replace and true or false)
			-- If we forced the generation this means it was already found
			if forced then
--				print("Serving unique "..o.name.." but forcing replacement drop")
				filter.random_art_replace.chance = 100
			end
		end
		if o then
--			print("Zone made us an equipment according to filter!", o:getName())

			-- curse (done here to ensure object attributes get applied correctly)
			if e:knowTalent(e.T_DEFILING_TOUCH) then
				local t = e:getTalentFromId(e.T_DEFILING_TOUCH)
				t.curseItem(e, t, o)
			end

			-- Auto alloc some stats to be able to wear it
			if filter.autoreq and rawget(o, "require") and rawget(o, "require").stat then
--				print("Autorequire stats")
				for s, v in pairs(rawget(o, "require").stat) do
					if e:getStat(s) < v then
						e.unused_stats = e.unused_stats - (v - e:getStat(s))
						e:incStat(s, v - e:getStat(s))
					end
				end
			end

			if e:wearObject(o, true, false) == false then
				e:addObject(e.INVEN_INVEN, o)
			end

			-- Do not drop it unless it is an ego or better
			if not o.unique then o.no_drop = true --[[print(" * "..o.name.." => no drop")]] end
			if filter.force_drop then o.no_drop = nil end
			if filter.never_drop then o.no_drop = true end
			game.zone:addEntity(game.level, o, "object")

			if t[1].id then o:identify(t[1].id) end

			if filter.random_art_replace then
				o.__special_boss_drop = filter.random_art_replace
			end
		end
	end
	-- Delete the origin field
	return nil
end

--- Resolves inventory creation for an actor
function resolvers.inventory(t)
	return {__resolver="inventory", __resolve_last=true, t}
end
--- Actually resolve the inventory creation
function resolvers.calc.inventory(t, e)
	-- Iterate of object requests, try to create them and equip them
	for i, filter in ipairs(t[1]) do
		print("Inventory resolver", e.name, e.filter, filter.type, filter.subtype)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			if filter.base_list then
				local _, _, class, file = filter.base_list:find("(.*):(.*)")
				if class and file then
					local base_list = require(class):loadList(file)
					base_list.__real_type = "object"
					o = game.zone:makeEntityByName(game.level, base_list, filter.defined)
				end
			else
				o = game.zone:makeEntityByName(game.level, "object", filter.defined)
			end
		end
		if o then
--			print("Zone made us an inventory according to filter!", o:getName())
			e:addObject(t[1].inven and e:getInven(t[1].inven) or e.INVEN_INVEN, o)
			game.zone:addEntity(game.level, o, "object")

			if t[1].id then o:identify(t[1].id) end
		end
	end
	e:sortInven()
	-- Delete the origin field
	return nil
end

--- Resolves drops creation for an actor
function resolvers.drops(t)
	return {__resolver="drops", __resolve_last=true, t}
end
--- Actually resolve the drops creation
function resolvers.calc.drops(t, e)
	t = t[1]
	if not rng.percent(t.chance or 100) then return nil end
	if t.check and not t.check(e) then return nil end

	-- Iterate of object requests, try to create them and drops them
	for i = 1, (t.nb or 1) do
		local filter = t[rng.range(1, #t)]
		filter = table.clone(filter)

		-- Make sure if we request uniques we do not get lore, it would be kinda deceptive
		if filter.unique then
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "lore"
		end

--		print("Drops resolver", e.name, filter.type, filter.subtype, filter.defined)
		local o
		if not filter.defined then
			o = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			local forced
			o, forced = game.zone:makeEntityByName(game.level, "object", filter.defined, filter.random_art_replace and true or false)
			-- If we forced the generation this means it was already found
			if forced then
--				print("Serving unique "..o.name.." but forcing replacement drop")
				filter.random_art_replace.chance = 100
			end
		end
		if o then
--			print("Zone made us a drop according to filter!", o:getName())
			e:addObject(e.INVEN_INVEN, o)
			game.zone:addEntity(game.level, o, "object")

			if t.id then o:identify(t.id) end

			if filter.random_art_replace then
				o.__special_boss_drop = filter.random_art_replace
			end
		end
	end
	-- Delete the origin field
	return nil
end


--- Resolves drops creation for an actor
function resolvers.store(def, faction, door, sign)
	return {__resolver="store", def, faction, door, sign}
end
--- Actually resolve the drops creation
function resolvers.calc.store(t, e)
	if t[3] then
		e.image = t[3]
		if t[4] then e.add_mos = {{display_x=0.6, image=t[4]}} end
	end

	e.store_faction = t[2]
	t = t[1]

	e.block_move = function(self, x, y, who, act, couldpass)
		if who and who.player and act then
			if self.store_faction and who:reactionToward({faction=self.store_faction}) < 0 then return true end
			self.store:loadup(game.level, game.zone)
			self.store:interact(who, self.name)
		end
		return true
	end
	e.store = game:getStore(t)
	e.store.faction = e.store_faction
--	print("[STORE] created for entity", t, e, e.name)

	-- Delete the origin field
	return nil
end

function resolvers.ammo()
	return {__resolver="ammo", __resolve_last=true}
end
function resolvers.calc.ammo(t, e)
	e.capacity = math.floor(e.capacity)
	e.remaining = e.capacity
	return nil
end



--- Generic resolver, takes a function, executes at the end
function resolvers.genericlast(fct)
	return {__resolver="genericlast", __resolve_last=true, fct}
end
function resolvers.calc.genericlast(t, e)
	return t[1](e)
end

--- Charges resolver, gives a random use talent
function resolvers.random_use_talent(types, power)
	types = table.reverse(types)
	return {__resolver="random_use_talent", __resolve_last=true, types, power}
end
function resolvers.calc.random_use_talent(tt, e)
	local ml = e.material_level or 1
	local ts = {}
	for i, t in ipairs(engine.interface.ActorTalents.talents_def) do
		if t.random_ego and tt[1][t.random_ego] and t.type[2] < ml then ts[#ts+1]=t.id end
	end
	local tid = rng.table(ts) or engine.interface.ActorTalents.T_SENSE
	local t = engine.interface.ActorTalents.talents_def[tid]
	local level = util.bound(math.ceil(rng.mbonus(5, resolvers.current_level, resolvers.mbonus_max_level) * ml / 5), 1, 5)
	e.cost = e.cost + t.type[2] * 3 * level
	e.recharge_cost = t.type[2] * 3 * level
	return { id=tid, level=level, power=tt[2] }
end




--- Help creating randarts
function resolvers.randartmax(v, max)
	return {__resolver="randartmax", v=v, max=max}
end
function resolvers.calc.randartmax(t, e)
	return t.v
end




--- Tactical settings made easy
function resolvers.tactic(name)
	return {__resolver="tactic", name}
end
function resolvers.calc.tactic(t, e)
	if t[1] == "default" then return {type="default", }
	elseif t[1] == "standby" then return {type="standby", standby=1}
	elseif t[1] == "melee" then return {type="melee", attack=2, attackarea=2, disable=2, escape=0, closein=2, go_melee=1}
	elseif t[1] == "ranged" then return {type="ranged", disable=1.5, escape=3, closein=0, defend=2, heal=2, safe_range=4}
	elseif t[1] == "tank" then return {type="tank", disable=3, escape=0, closein=2, defend=2, protect=2, heal=3, go_melee=1}
	elseif t[1] == "survivor" then return {type="survivor", disable=2, escape=5, closein=0, defend=3, protect=0, heal=6, safe_range=8}
	end
	return {}
end

--Originals start here
function resolvers.classes()
	return {__resolver="classes", __resolve_last=true}
end

function resolvers.calc.classes(t, e)
	local Birther = require("engine.Birther")
	local class = {}

	local class_list = Birther.birth_descriptor_def.class

	for class, n in ipairs(t[1]) do
		e = e:giveLevels(class, n)
		return e
	end
end

function resolvers.class()
 	return {__resolver="class", __resolve_last=true}
end


function resolvers.calc.class(t, e)
	local Birther = require("engine.Birther")
	local class

	local n = rng.dice(1,8)

	if rng.chance(2) then class = "Fighter" --end
	elseif rng.chance(4) then class = "Cleric" --end
	elseif rng.chance(2) then class = "Barbarian"
	elseif rng.chance(3) then class = "Rogue"
	elseif rng.chance(3) then class = "Ranger"
	elseif rng.chance(5) then class = "Wizard"
 	elseif rng.chance(6) then class = "Sorcerer"
	elseif rng.chance(8) then class = "Druid" --end
	elseif rng.chance(10) then class = "Warlock" 
	else end

	if class then
	--safety check 
		if game.zone.max_cr then
			if e.challenge + n > game.level.level + game.zone.max_cr then return end
		end

	e:giveLevels(class, n)
	e.challenge = e.challenge + n

	e.life = e.max_life

	end
end

--Special stuff
function resolvers.specialnpc()
 	return {__resolver="specialnpc", __resolve_last=true}
end

function resolvers.calc.specialnpc(t, e)
	local choice
	local cr_boost

	--pick special template
	if rng.chance(2) then 
		choice = "bandit"
		cr_boost = 2
	elseif rng.chance(6) then
		choice = "outlaw"
		cr_boost = 1
	elseif rng.chance(10) then
		choice = "brigand"
		cr_boost = 1
	elseif rng.chance(8) then 
		choice = "chieftain"
		cr_boost = 2
	elseif rng.chance(6) then
		choice = "shaman"
		cr_boost = 2
	elseif rng.chance(4) then 
		choice = "skilled"
		cr_boost = 1
	elseif rng.chance(10) then
		choice = "experienced"
		cr_boost = 2
	elseif rng.chance(15) then
		choice = "veteran"
		cr_boost = 4
	elseif rng.chance(20) then
		choice = "elite"
		cr_boost = 5
	elseif rng.chance(25) then
		choice = "master"
		cr_boost = 7
	elseif rng.chance(30) then
		choice = "paragon"
		cr_boost = 9
	elseif rng.chance(40) then
		choice = "legendary"
		cr_boost = 12
	end

	--safety check
	if game.zone.max_cr then
		if e.challenge + cr_boost > game.zone.max_cr + game.level.level then
			choice = nil
		end
	end 

	--apply the templates now
	--BANDIT: +2 Str, -2 Cha; HD +1 armor proficiencies, martial weapon proficiency. Power Attack;
	if choice == "bandit" then	
--		e:learnTalent(e.POWER_ATTACK, true)
--		e:learnTalent(e.MARTIAL_WEAPON_PROFICIENCY, true)
		e.challenge = e.challenge +2
		e.hit_die = e.hit_die +1 
		e.special = "bandit"
	--OUTLAW: +2 Dex -2 Cha; HD +1, armor proficiencies; Dodge, Expertise, Deft Opportunist
	elseif choice == "outlaw" then
--	e:learnTalent(e.DODGE, true)
		e.challenge = e.challenge +1
		e.hit_die = e.hit_die +1
		e.special = "outlaw"
	--BRIGAND: +2 Dex -2 Cha +2 HD; armor proficiencies; Power Attack, Endurance
	elseif choice == "brigand" then
		e.challenge = e.challenge +1
		e.hit_die = e.hit_die +2
		e.special = "brigand"
	--CHIEFTAIN: +4 Str  +4 Con, +2 attack, Power Attack, Cleave, *2 HD
	--magic armor and weapons
	elseif choice == "chieftain" then
--		e:learnTalent(e.POWER_ATTACK, true)
--		e:learnTalent(e.CLEAVE, true)
		e.hit_die = e.hit_die*2
		e.combat_attack = e.combat_attack +2
		e.challenge = e.challenge +2 
		e.special = "chieftain"
	--SHAMAN: +4 Wis +2 HD +2 CR; Combat Casting	
	-- potions, wands
	elseif choice == "shaman" then
		--e:learnTalent(e.COMBAT_CASTING, true)
		e.hit_die = e.hit_die +2
		e.challenge = e.challenge +2
		e.special = "shaman"
	--SKILLED: +1 to all attributes, +1 HD, +1 attack, +1 CR
	elseif choice == "skilled" then
		e.hit_die = e.hit_die +1
		e.combat_attack = e.combat_attack +1
		e.challenge = e.challenge +1 
		e.special = "skilled"
	--EXPERIENCED: +2 to all attributes, +2 attack +2 HD
	elseif choice == "experienced" then
		e.combat_attack = e.combat_attack +2
		e.challenge = e.challenge +2
		e.hit_die = e.hit_die +2
		e.special = "experienced"
	--VETERAN: +2 Str +3 other attributes, +4 attack +4 HD
	elseif choice == "veteran" then
		e.challenge = e.challenge +4
		e.combat_attack = e.combat_attack +4
		e.hit_die = e.hit_die +4
		e.special = "veteran"
	--ELITE: +2 Str +4 other attributes; +6 attack +8 HD
	elseif choice == "elite" then
		e.challenge = e.challenge +5
		e.combat_attack = e.combat_attack +6
		e.hit_die = e.hit_die +8
		e.special = "elite"
	--MASTER: +2 Str +4 other attributes; +8 attack +12 HD
	elseif choice == "master" then
		e.challenge = e.challenge +7
		e.combat_attack = e.combat_attack +8
		e.hit_die = e.hit_die +12
		e.special = "master"
	--PARAGON: +2 Str +4 other attributes; +10 attack +15 HD
	elseif choice == "paragon" then
		e.challenge = e.challenge +9
		e.combat_attack = e.combat_attack +10
		e.hit_die = e.hit_die +15
		e.special = "paragon"
	--LEGENDARY: +2 Str +4 other attributes; +14 attack +20 HD
	elseif choice == "legendary" then
		e.challenge = e.challenge +12
		e.combat_attack = e.combat_attack +14
		e.hit_die = e.hit_die +20
		e.special = "legendary"
	end

end

--Since egos result in random freezes on level gen, make them here
function resolvers.templates()
	return {__resolver="templates", __resolve_last=true}
end

function resolvers.calc.templates(t, e)
	local choice
	local cr_boost

	if rng.chance(5) then
		choice = "zombie"
		cr_boost = 1
	elseif rng.chance(5) then
		choice = "skeleton"
		cr_boost = 1
	elseif rng.chance(10) then
		choice = "celestial"
		cr_boost = 2
	elseif rng.chance(10) then
		choice = "fiendish"
		cr_boost = 2
	elseif rng.chance(15) then
		choice = "half-celestial"
		cr_boost = 2
	elseif rng.chance(15) then
		choice = "half-fiend"
		cr_boost = 2
	elseif rng.chance(15) then
		choice = "half-dragon"
		cr_boost = 2
	elseif rng.chance(25) then
		choice = "half-fey"
		cr_boost = 2
	elseif rng.chance(20) then
		choice = "flame"
		cr_boost = 2
	elseif rng.chance(20) then
		choice = "earthen"
		cr_boost = 2
	elseif rng.chance(20) then
		choice = "gaseous"
		cr_boost = 2
	elseif rng.chance(20) then
		choice = "aqueous"
		cr_boost = 2
	elseif rng.chance(25) then
		choice = "three-eyed"
		cr_boost = 3
	elseif rng.chance(30) then
		choice = "pseudonatural"
		cr_boost = 4
	end

	--safety check
	if game.zone.max_cr then
		if e.challenge + cr_boost > game.zone.max_cr + game.level.level then
			choice = nil
		end
	end 

	--apply the template
	if choice == "zombie" then
		e.template = "zombie"
		e.display = "Z"
		e.color=colors.WHITE
		e.infravision = 3
		e.challenge = e.challenge +1
		e.combat = { dam= {1,6} }
	elseif choice == "skeleton" then
		e.template = "skeleton"
		e.display = "s" 
		e.color=colors.WHITE
		e.infravision = 3
		e.challenge = e.challenge +1
		e.combat = { dam= {1,6} }
	--DR 5/magic
	elseif choice == "celestial" then
		e.template = "celestial"
		e.infravision = 3
		e.spell_resistance = e.hit_die + 5
		e.challenge = e.challenge +2
		e.resist = { [DamageType.ACID] = 5,
	[DamageType.COLD] = 5,
	[DamageType.ELECTRIC] = 5,
	 }
	--DR 5/magic
	elseif choice == "fiendish" then
		e.template = "fiendish"
		e.infravision = 3
		e.spell_resistance = e.hit_die + 5
		e.challenge = e.challenge +2
		e.resist = { [DamageType.FIRE] = 5,
	[DamageType.COLD] = 5,
	 }
	--Stat increases, spell-likes, fly speed, 
	elseif choice == "half-celestial" then
		e.template = "half-celestial"
		e.infravision = 3
		e.spell_resistance = e.hit_die + 10
		e.combat_natural = e.combat_natural +1
		e.challenge = e.challenge +2
		e.resist = { [DamageType.ACID] = 5,
	[DamageType.COLD] = 5,
	[DamageType.ELECTRIC] = 5,
	 }

	--Stat increases, spell-likes, fly, bite/claw
	elseif choice == "half-fiend" then
		e.template = "half-fiend"
		e.infravision = 3
		e.spell_resistance = e.hit_die + 10
		e.combat_natural = e.combat_natural +1
		e.challenge = e.challenge +2
		e.resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	[DamageType.FIRE] = 10,
	 }

	--Stat increases, breath weapon; bite/claw
	elseif choice == "half-dragon" then
		e.template = "half-dragon"
		e.combat_natural = e.combat_natural +4
		e.infravision = 3
		e.challenge = e.challenge +2
		e.resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }

	 --Str -4, Dex +4, Wis +4, Cha +4; Alertness, Dodge, Mobility, Finesse; Nature Sense
	 --Spell-likes: faerie fire, sleep, dimension door
	 elseif choice == "half-fey" then
	 	e.template = "half-fey"
	 	e.infravision = 3
	 	e.type = "fey"
	 	e.challenge = e.challenge +2
	 --Fire immunity, 1d10 fire aura
	 elseif choice == "flame" then
	 	--change color to red
	 	e.type = "elemental"
	 	e.challenge = e.challenge +2
	 	e.template = "flame"
	 --Str +4, Dex -2; AC +6; earthmeld, tremorsense 6 tiles
	 elseif choice == "earthen" then
	 	--change color to brown
	 	e.type = "elemental"
	 	e.challenge = e.challenge +2
	 	e.template = "earthen"
	 --Dex +6, flight
	 elseif choice == "gaseous" then
	 	--change color to white
	 	e.type = "elemental"
	 	e.challenge = e.challenge +2
	 	e.template = "gaseous" 
	 --1d4 slam + engulf DC 20
	 elseif choice == "aqueous" then
	 	--change color to blue
	 	e.type = "elemental"
	 	e.challenge = e.challenge +2
	 	e.template = "aqueous"
	 elseif choice == "three-eyed" then
	 	e.template = "three-eyed"
	 	e.challenge = e.challenge +3
	 	--confusion DC 14 gaze
	 	e.infravision = 3
	 	e.skill_spot = (e.skill_spot or 0) +6
	 	e.skill_search = (e.skill_search or 0) +6
	 	
	 --Dex +4, Int +8, Wis +6, Cha +4; Tentacles 1d8, devour, evasion,
	 --spell-likes: "true strike", "distance distortion", "evard's black tentacles", "displacement", "confusion";
	 elseif choice == "pseudonatural" then
	 	--change color to pink
	 	e.template = "pseudonatural"
	 	e.challenge = e.challenge +4
	 	e.combat_attack = e.combat_attack +2
	 	e.hit_die = e.hit_die +3
	 	e.spell_resistance = 35
	 --TO DO: ethereal CR +3, incorporeal, only touch attacks

	end
end

function resolvers.animaltemplates()
	return {__resolver="animaltemplates", __resolve_last=true}
end

function resolvers.calc.animaltemplates(t, e)
	local choice
	local cr_boost

	--STR +4 DEX + 2 CON +2 AC +3 attack +4 HD +4; immmune to fear
	if rng.chance(5) then
		choice = "dire"
		cr_boost = 3
	--HD +1 attack +6 dmg +6
	--Pounce, Rake, Multiattack, Rend
	elseif rng.chance(15) then
		choice = "feral"
		cr_boost = 2
	end

	--safety check
	if game.zone.max_cr then
		if e.challenge + cr_boost > game.zone.max_cr + game.level.level then
			choice = nil
		end
	end 

	if choice == "dire" then
		e.challenge = e.challenge +3
		e.combat_attack = e.combat_attack +4
		e.hit_die = e.hit_die +4
		e.combat_natural = e.combat_natural +3
		e.template = "dire"
	elseif choice == "feral" then
		e.challenge = e.challenge +2
		e.hit_die = e.hit_die +1
		e.combat_attack = e.combat_attack +6
		e.template = "feral"
	end	


end



--[[	--CURATE: +4 CR; +2 Str +2 Con +4 Int +3 Wis +6; AC +2 attack +3 HD +4; armor proficiencies, Combat Casting, Power Attack, turn undead (Clr5)
	elseif rng.chance(15) then
		--feats go here
		e.challenge = e.challenge + 4
		e.hit_die = e.hit_die +4
		e.combat_attack = e.combat_attack + 3
		e.combat_untyped = e.combat_untyped +2
		e.special = "curate"]]


--Moddable tiles, based on ToME's
function resolvers.moddable_tile(image, values)
	return {__resolver="moddable_tile", image}
end
function resolvers.calc.moddable_tile(t, e)
	local slot = t[1]
	local r, r2
	if slot == "cloak" then r = {"cloak_green"}
	elseif slot == "heavy" then
		r = {"plate","half_plate","half_plate2","half_plate3"}
		r2 = {"leg_armor01","leg_armor02","leg_armor03","leg_armor04"}
	elseif slot == "light" then
		r = {"chainmail","chainmail3","leather_armour","leather_armour2","leather_armour3"}
	--	r2 = {"lower_body_03","lower_body_04","lower_body_05","lower_body_06","lower_body_06",}
	elseif slot == "robe" then r = {"monk_black","monk_blue","robe_green","robe_green_gold","robe_yellow"}
	elseif slot == "shield" then r = {"shield_kite2","shield_round1","shield_round2","shield_round3"}
	elseif slot == "staff" then r = {"staff_plain", "staff_mage"}
	elseif slot == "leather_boots" then r = {"middle_brown","middle_brown2","middle_brown3",}
	elseif slot == "heavy_boots" then r = {"middle_gold"}
	elseif slot == "gauntlets" then r = {"gauntlet_blue",}
	elseif slot == "gloves" then r = {"glove_red", "glove_brown"}
	elseif slot == "sword" then r = {"short_sword_%s", "long_sword_%s"}
	elseif slot == "greatsword" then r = {"great_sword"}
	elseif slot == "trident" then r = {"trident"}
	elseif slot == "whip" then r = {"whip_%s"}
	elseif slot == "mace" then r = {"mace_%s", "mace2_%s", "mace3_%s"}
	elseif slot == "handaxe" then r = {"hand_axe_%s"}
	elseif slot == "axe" then r = {"war_axe_%s"}
	elseif slot == "greataxe" then r = {"greataxe"}
	elseif slot == "bow" then r = {"bow"}
	elseif slot == "crossbow" then r = {"crossbow"}
	elseif slot == "sling" then r = {"sling"}
	elseif slot == "dagger" then r = {"dagger_%s"}
	elseif slot == "helm" then r = {"helm_plume"}
	elseif slot == "leather_cap" then r = {"cap_black1"}
	end
	
	r = rng.table(r)
--	r = r[util.bound(ml, 1, #r)]
	if r2 then
--		r2 = r2[util.bound(ml, 1, #r2)]
		r2 = rng.table(r2)
		e.moddable_tile2 = r2
	end
	if type(r) == "string" then return r else e.moddable_tile_big = true return r[1] end
end

function resolvers.value(list)
	return {__resolver="value", list }
end

--10 coppers to a silver, 20 silvers to a gold means 200 coppers to a gold
--10 gold to a platinum means 2000 coppers to a platinum
function resolvers.calc.value(t, e)
	for kind, amt in pairs(t[1]) do

	local value = 0

	if kind == "silver" then value = value + amt*10 end
	if kind == "gold" then value = value + amt*200 end
	if kind == "platinum" then value = value + amt*2000 end
	
	return value
	end
	
end

-- Assign a flavor to flavored objects that haven't had a flavor assigned
-- to them, and adjust a flavored object's color and tile image
function resolvers.flavored()
  return { __resolver='flavored' }
end
function resolvers.calc.flavored(t, e)
  local fl_def = e:isFlavored()
  if fl_def then
    local used = game.state.flavors_assigned[e.type][e.subtype]
    if not used[e.name] then
    	--see Object.lua lines 414
      used[e.name] = fl_def.pop_flavor(e.type, e.subtype)
    end
    local color = used[e.name][2]
    e.color = color
    e.image = used[e.name][3]
    
    local flavor_name = used[e.name][1]
    if e.unided_name then
    e.unided_name = flavor_name.." "..e.unided_name
	end
  end
end



--Starting equipment resolver
--- Resolves equipment creation for an actor
function resolvers.startingeq(t)
	return {__resolver="equip", __resolve_last=true, t}
end
--- Actually resolve the equipment creation
function resolvers.calc.startingeq(t, e)
	if e.perk ~= "" then
		local o = game.zone:makeEntity(game.level, "object", {name=e:randomItem(), ego_chance=1000}, nil, true)

		if o then

			while o.cursed == true do
				o = game.zone:makeEntity(game.level, "object", {name=e:randomItem(), ego_chance=1000}, nil, true)
			end

			if e:wearObject(o, true, false) == false then
				e:addObject(e.INVEN_INVEN, o)
			end

			game.zone:addEntity(game.level, o, "object")

			if t[1].id then o:identify(t[1].id) end
		end
	end

	for i, race in ipairs(t[1]) do
	
		if e.descriptor.race == race then
	--	print("Equipment resolver for", e.name)
		-- Iterate of object requests, try to create them and equip them
			for i, filter in ipairs(race.t[1]) do
--			print("Equipment resolver", e.name, filter.type, filter.subtype, filter.defined)
			local o
			if not filter.defined then
				o = game.zone:makeEntity(game.level, "object", filter, nil, true)
			else
				local forced
				o, forced = game.zone:makeEntityByName(game.level, "object", filter.defined, filter.random_art_replace and true or false)
				-- If we forced the generation this means it was already found
				if forced then
--					print("Serving unique "..o.name.." but forcing replacement drop")
					filter.random_art_replace.chance = 100
				end
			end
			if o then
	--			print("Zone made us an equipment according to filter!", o:getName())

				if e:wearObject(o, true, false) == false then
					e:addObject(e.INVEN_INVEN, o)
				end

				game.zone:addEntity(game.level, o, "object")

				if t[1].id then o:identify(t[1].id) end

			end
			end
		end
	end

	-- Delete the origin field
	return nil
end
