-- Veins of the Earth
-- Copyright (C) 2013-2016 Zireael
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

			if e:wearObject(o, true, false, filter.force_inven or nil, filter.force_item or nil) == false then
				if filter.force_inven and e:getInven(filter.force_inven) then  -- we just really want it
					e:addObject(filter.force_inven, o, true, filter.force_item)
				else
					e:addObject(e.INVEN_INVEN, o)
				end
			end
		--[[	if e:wearObject(o, true, false) == false then
				e:addObject(e.INVEN_INVEN, o)
			end]]

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

--New store resolver
function resolvers.store(def)
	return {__resolver="store", def}
end

function resolvers.calc.store(t, e)
	t = t[1]

	e.store = game:getStore(t)
--	e.store.store.filters.veins_level = 5 + e.challenge
	print("[STORE] created for entity", t, e, e.name)

	-- Delete the origin field
	return nil
end

--- Resolves drops creation for an actor
function resolvers.static_store(def, faction, door, sign)
	return {__resolver="static_store", def, faction, door, sign}
end
--- Actually resolve the drops creation
function resolvers.calc.static_store(t, e)
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

--Moddable tiles, based on ToME's
function resolvers.moddable_tile(image, values)
	return {__resolver="moddable_tile", image}
end
function resolvers.calc.moddable_tile(t, e)
	local slot = t[1]
	local r, r2
	if slot == "cloak" then r = {"cloak_green"}
	elseif slot == "helm" then r = {"helm_plume"}
	elseif slot == "leather_cap" then r = {"cap_black1"}
	elseif slot == "heavy" then
		r = {"plate","half_plate","half_plate2","half_plate3"}
		r2 = {"leg_armor01","leg_armor02","leg_armor03","leg_armor04"}
	elseif slot == "leather" then
		r = {"leather_armour","leather_armour2","leather_armour3"}
	--	r2 = {"lower_body_03","lower_body_04","lower_body_05","lower_body_06","lower_body_06",}
	elseif slot == "mail" then
		r = {"chainmail","chainmail3",}
	--robes
	elseif slot == "archmage" then r = {"robe_green","robe_green_gold","robe_yellow", "robe_red_gold", "robe_brown"}
	elseif slot == "monk" then r = {"monk_black","monk_blue"}
	elseif slot == "rags" then r = {"robes"}

	elseif slot == "shield" then r = {"shield_kite2","shield_round1","shield_round2","shield_round3"}
	elseif slot == "staff" then r = {"staff_plain", "staff_mage"}
	elseif slot == "leather_boots" then r = {"middle_brown","middle_brown2","middle_brown3",}
	elseif slot == "heavy_boots" then r = {"middle_gold"}
	elseif slot == "gauntlets" then r = {"gauntlet_blue",}
	elseif slot == "gloves" then r = {"glove_red", "glove_brown"}
	--weapons start here
	elseif slot == "sword" then r = {"short_sword_%s", "long_sword_%s"}
	elseif slot == "dagger" then r = {"dagger_%s"}
	elseif slot == "kukri" then r = {"kukri_%s"}
	elseif slot == "sickle" then r = {"sickle"}
	elseif slot == "dagger" then r = {"dagger_%s"}
	--2h weapons
	elseif slot == "greatsword" then r = {"great_sword"}
	elseif slot == "greatclub" then r = {"greatclub"}
	elseif slot == "spear" then r = {"spear1"}
	elseif slot == "scythe" then r = {"scythe"}
	elseif slot == "halberd" then r = {"halberd"}
	elseif slot == "rapier" then r = {"rapier_%s"}
	elseif slot == "scimitar" then r = {"scimitar_%s"}
	elseif slot == "trident" then r = {"trident"}
	--blunt 1h weapons
	elseif slot == "whip" then r = {"whip_%s"}
	elseif slot == "mace" then r = {"mace_%s", "mace2_%s", "mace3_%s"}
	elseif slot == "morningstar" then r = {"morningstar_%s"}
	elseif slot == "hammer" then r = {"hammer_%s"}
	elseif slot == "club" then r = {"club_%s"}
	elseif slot == "flail" then r = {"flail_ball", "flail_ball2"}
	--axes
	elseif slot == "handaxe" then r = {"hand_axe_%s"}
	elseif slot == "axe" then r = {"war_axe_%s"}
	elseif slot == "greataxe" then r = {"greataxe"}
	--ranged weapons
	elseif slot == "shortbow" then r = {"bow"}
	elseif slot == "longbow" then r = {"bow_long"}
	elseif slot == "composite_bow" then r = {"bow_composite"}
	elseif slot == "crossbow" then r = {"crossbow"}
	elseif slot == "sling" then r = {"sling"}
	--exotics
	elseif slot == "hand_crossbow" then r = {"crossbow_hand"}
	elseif slot == "double_axe" then r = {"axe_double"}
	elseif slot == "spiked_chain" then r = {"flail_spike"}
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

--Reworked T-Engine to round down
--- Average random
function resolvers.rngavground(x, y)
	return {__resolver="rngavground", x, y}
end
function resolvers.calc.rngavground(t)
	return math.round(rng.avg(t[1], t[2]))
end



--Originals start here
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

--Wound system
function resolvers.wounds()
	return {__resolver="wounds", list,  __resolve_last=true }
end

function resolvers.calc.wounds(t, e)
	e.max_wounds = e:getCon()*2
	e.wounds = e.max_wounds
end


dofile("mod/resolvers_npc.lua")

--From ToME 2 port
-- Assign a flavor to flavored objects that haven't had a flavor assigned
-- to them, and adjust a flavored object's color and tile image
function resolvers.flavored()
  return { __resolver='flavored', __resolve_last=true, }
end
function resolvers.calc.flavored(t, e)
	if e.egoed then print("Flavoring egoed item") end
  local fl_def = e:isFlavored()
  if fl_def then
    local used = game.state.flavors_assigned[e.type][e.subtype]
    if not used[e.name] then
    	--see Object.lua lines 414
      used[e.name] = fl_def.pop_flavor(e.type, e.subtype)
    end
    local color = used[e.name][2]
    e.color = color

    --TODO: if specified but no file exists, use parent object image
	if not used[e.name][3] then
		e.image = e.image
	else
    e.image = used[e.name][3]
	end

    local flavor_name = used[e.name][1]
    if e.unided_name then
    e.unided_name = flavor_name.." "..e.unided_name
	end
  end
end



--Starting equipment resolver
--- Resolves equipment creation for a player
function resolvers.startingeq(t)
	return {__resolver="startingeq", __resolve_last=true, t}
end
--- Actually resolve the equipment creation
function resolvers.calc.startingeq(t, e)
	local class = e.descriptor.subclass
	local race = e.descriptor.race

	local racetable = {} --= t[class]["general"]

--	print("[STARTING EQ] subclass is "..class)
--	print("[STARTING EQ] race is ".. race)

	t = t[1]

	if t[class] then
	 	if t[class][race] then
			racetable = t[class][race]
		else
			racetable = t[class]["general"]
		end
	end

	for i, filter in ipairs(racetable) do
			--[[	filter.not_properties = filter.not_properties or {}
				filter.not_properties[#filter.not_properties+1] = "cursed"
				return {__resolver="equip", __resolve_last=true, racetable}]]

			--code dup out the wazoo since we don't have recursive resolvers yet
			local def = racetable
				print("Starting inventory resolver", e.name, e.filter, filter.type, filter.subtype)
				local o
				if not filter.defined then
					o = game.zone:makeEntity(game.level, "object", filter, nil, true)
				else
					o = game.zone:makeEntityByName(game.level, "object", filter.defined)

				end
				if o then
		--			print("Zone made us an inventory according to filter!", o:getName())
					e:addObject(def.inven and e:getInven(def.inven) or e.INVEN_INVEN, o)
					game.zone:addEntity(game.level, o, "object")

					if def.id then o:identify(def.id) end
				end
			end
			e:sortInven()
			-- Delete the origin field
			return nil
end

function resolvers.perks()
	return {__resolver="perks", __resolve_last=true, }
end

function resolvers.calc.perks(t, e)
	if e.perk ~= "" then
		t = { defined=e:randomItem(), ego_chance=1000, not_properties="cursed"}
	end
	return {__resolver="equip", __resolve_last=true, t}
end

--For elemental burst egos
function resolvers.burstdamage()
	return {__resolver="burstdamage", __resolve_last=true, }
end
function resolvers.calc.burstdamage(t, e)
	local burst = {1, 10}
	if e.combat.critical == 3 then burst = {2, 10} end
	if e.combat.critical == 4 then burst = {3,10} end
end

--Limiting egos to +1 bonus arms/armor
function resolvers.ego_chance()
	return {__resolver="ego_chance",} --__resolve_last=true, }
end
function resolvers.calc.ego_chance(t, e)
	if not e.egoed then print("Not egoed, return false") return false
	else print("Egoed, returning normal values") return { prefix=30, suffix=70} end
end

function resolvers.armor_durability()
	return {__resolver="armor_durability",} --__resolve_last=true, }
end
function resolvers.calc.armor_durability(t, e)
	if e and e.wielder then
		return ((e.wielder.combat_armor or 0)*5)/10 --dunno why I have to divide by 10
	else
		return 5
	end
end

--Special ego resolvers
function resolvers.mithril_lighten()
	return {__resolver="mithril_lighten", }--__resolve_last=true, }
end
function resolvers.calc.mithril_lighten(t, e)
	--let's make it lighter
	e.encumber = e.encumber/2
	--change category
	local type = "light"
	if e.subtype == "heavy" then type = "medium" end

	e.subtype = type
	--other
	e.wielder.spell_fail = e.wielder.spell_fail - 10
	e.wielder.max_dex_bonus = e.wielder.max_dex_bonus + 2
	e.wielder.armor_penalty = math.max(0, e.wielder.armor_penalty - 3)
end

function resolvers.graceful_armor()
	return {__resolver="graceful_armor", }-- __resolve_last=true, }
end
function resolvers.calc.graceful_armor(t,e)
	--Half acp
	e.wielder.armor_penalty = math.floor(e.wielder.armor_penalty/2)
end

function resolvers.featherlight()
	return {__resolver="featherlight", }-- __resolve_last=true, }
end
function resolvers.calc.featherlight(t, e)
	e.encumber = e.encumber/4
end

--Creating drops
local function actor_final_level(e)
	return e.challenge
end

function resolvers.npc_drops_level()
	return {__resolver="npc_drops_level", __resolve_last=true}
	--return {__resolver="npc_drops_level", t}
end

function resolvers.calc.npc_drops_level(t, e)
	 local level
--	 print("Checking level - %s for %s (final level %d)", e.challenge, e.name, actor_final_level(e))
		if e and _G.type(actor_final_level(e)) == "number" then
			level = actor_final_level(e)
		else
			level = e.challenge
		end

	return level
end



--Item creation
function resolvers.creation_cost()
	return {__resolver="creation_cost", }
end

function resolvers.calc.creation_cost(t, e)
--	if not e.name ==
	if not e.egoed then return 0 end
	--Force resolve cost first
	if type(e.cost) == "table" and e.cost.__resolver then e.cost = resolvers.calc[e.cost.__resolver](e.cost, e) end

	e.creation = {}
	--NOTE: Count in gold not in coppers
	local cost
	if e.cost and e.cost > 0 then cost = e.cost/200 end
	e.creation.gold_cost = cost/2
	e.creation.xp_cost = cost * 0.04

	print("[CREATION COST] Ego: "..e.name.." Gold:"..e.creation.gold_cost.." XP:"..e.creation.xp_cost)
end
