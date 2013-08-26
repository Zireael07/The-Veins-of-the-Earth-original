-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

local Talents = require "engine.interface.ActorTalents"

--- Resolves equipment creation for an actor
function resolvers.equip(t)
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

-- Resolves material level based on actor level
-- @param base = base value at level = base_level (scales as sqrt)
-- @param spread = number of std deviations (1 usually) in material level
-- @param min, max = material level limits
function resolvers.matlevel(base, base_level, spread, mn, mx)
	return {__resolver="matlevel", base, base_level, spread, mn, mx}
end
function resolvers.calc.matlevel(t, e)
	local mean = math.min(e.level/10+1,t[1] * (e.level/t[2])^.5) -- I5 material level scales up with sqrt of actor level or level/10
	local spread = math.max(t[3],mean/5) -- spread out probabilities at high level
	local mn = t[4] or 1
	local mx = t[5] or 5
	
	local rand = math.floor(rng.normalFloat(mean,spread))
	return util.bound(rand,mn,mx)
end

-- Estimate actor final level for drop calculations (.__resolve_last does not work)
local function actor_final_level(e)
	local finlevel = math.max(math.max(e.level,e.start_level),1)
	if game.zone.actor_adjust_level and e.forceLevelup then
		return math.max(finlevel, game.zone:actor_adjust_level(game.level, e) + e:getRankLevelAdjust())
	else
		return math.max(finlevel, game.zone.base_level + e:getRankLevelAdjust())
	end
end

--- Resolves drops creation for an actor; drops a created on the fly randart
function resolvers.drop_randart(t)
	return {__resolver="drop_randart", __resolve_last=true, t}
end
--- Actually resolve the drops creation
function resolvers.calc.drop_randart(t, e)
	t = t[1]
	local filter = t.filter

 	local matresolver = resolvers.matlevel(5,50,1,2) -- Min material level 2
   
--	game.log("#LIGHT_BLUE#Calculating randart drop for %s (uid %d, est level %d)",e.name,e.uid,actor_final_level(e))
	if not filter then
		filter = {ignore_material_restriction=true, no_tome_drops=true, ego_filter={keep_egos=true, ego_chance=-1000}, special=function(eq)
			local matlevel = resolvers.calc.matlevel(matresolver,{level = actor_final_level(e)})
--			game.log("Checking equipment %s against material level %d for %s (final level %d)",eq.name,matlevel,e.name, actor_final_level(e))
			return (not eq.unique and eq.randart_able) and eq.material_level == matlevel and true or false
		end}
	end

--	print("Randart Drops resolver")
	local base = nil
	if filter then
		if not filter.defined then
			base = game.zone:makeEntity(game.level, "object", filter, nil, true)
		else
			base = game.zone:makeEntityByName(game.level, "object", filter.defined)
		end
	end

	local o = game.state:generateRandart{base=base, lev=resolvers.current_level}
	if o then
--		print("Zone made us a randart drop according to filter!", o:getName{force_id=true})
		e:addObject(e.INVEN_INVEN, o)
		game.zone:addEntity(game.level, o, "object")

		if t.id then o:identify(t.id) end
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

--- Random bonus based on level (sets the mbonus max level, we use 60 instead of 50 to get some forced randomness at high level)
resolvers.mbonus_max_level = 90

--- Random bonus based on level and material quality
resolvers.current_level = 1
function resolvers.mbonus_material(max, add, pricefct)
	return {__resolver="mbonus_material", max, add, pricefct}
end
function resolvers.calc.mbonus_material(t, e)
	local ml = e.material_level or 1
	local v = math.ceil(rng.mbonus(t[1], resolvers.current_level, resolvers.mbonus_max_level) * ml / 5) + (t[2] or 0)

	if e.cost and t[3] then
		local ap, nv = t[3](e, v)
		e.cost = e.cost + ap
		v = nv or v
	end

	if e.ego_bonus_mult then
		if v >= 1 then
			v = math.ceil(v * (1 + e.ego_bonus_mult))
		else
			v = v * (1 + e.ego_bonus_mult)
		end
	end

	return v
end

--- Random bonus based on level, more strict
resolvers.current_level = 1
function resolvers.mbonus_level(max, add, pricefct, step)
	return {__resolver="mbonus_level", max, add, step or 10, pricefct}
end
function resolvers.calc.mbonus_level(t, e)
	local max = resolvers.mbonus_max_level

	local ml = 1 + math.floor((resolvers.current_level - 1) / t[3])
	ml = util.bound(rng.float(ml, ml * 1.6), 1, 6)

	local maxl = 1 + math.floor((max - 1) / t[3])
	local power = 1 + math.log10(ml / maxl)

	local v = math.ceil(rng.mbonus(t[1], resolvers.current_level, max) * power) + (t[2] or 0)

	if e.cost and t[4] then
		local ap, nv = t[4](e, v)
		e.cost = e.cost + ap
		v = nv or v
	end

	return v
end

--- Random bonus based on level
resolvers.current_level = 1
function resolvers.mbonus(max, add, pricefct)
	return {__resolver="mbonus", max, add, pricefct}
end
function resolvers.calc.mbonus(t, e)
	local v = rng.mbonus(t[1], resolvers.current_level, resolvers.mbonus_max_level) + (t[2] or 0)

	if e.cost and t[3] then
		local ap, nv = t[3](e, v)
		e.cost = e.cost + ap
		v = nv or v
	end

	return v
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

--- Charms resolver
function resolvers.charm(desc, cd, fct, tcd)
	return {__resolver="charm", desc, cd, fct, tcd}
end
function resolvers.calc.charm(tt, e)
	local cd = tt[2]
	e.max_power = cd
	e.power = e.max_power
	e.use_power = {name=tt[1], power=cd, use=tt[3], __no_merge_add=true}
	if e.talent_cooldown == nil then e.talent_cooldown = tt[4] or "T_GLOBAL_CD" end
	return
end

--- Charms talent resolver
function resolvers.charmt(tid, tlvl, cd, tcd)
	return {__resolver="charmt", tid, tlvl, cd, tcd}
end
function resolvers.calc.charmt(tt, e)
	local cd = tt[3]
	e.max_power = cd
	e.power = e.max_power
	local lvl = util.getval(tt[2], e)
	e.use_talent = {id=tt[1], power=cd, level=lvl, __no_merge_add=true}
	if e.talent_cooldown == nil then e.talent_cooldown = tt[4] or "T_GLOBAL_CD" end
	return
end

--- Activates all sustains at birth
function resolvers.sustains_at_birth()
	return {__resolver="sustains_at_birth", __resolve_last=true}
end
function resolvers.calc.sustains_at_birth(_, e)
	e.on_added = function(self)
		for tid, _ in pairs(self.talents) do
			local t = self:getTalentFromId(tid)
			if t and t.mode == "sustained" then
				self.energy.value = game.energy_to_act
--				print("===== activating sustain", self.name, tid)
				self:useTalent(tid)
			end
		end
	end
end

--- Help creating randarts
function resolvers.randartmax(v, max)
	return {__resolver="randartmax", v=v, max=max}
end
function resolvers.calc.randartmax(t, e)
	return t.v
end

--- Inscription resolver
function resolvers.inscription(name, data)
	return {__resolver="inscription", name, data}
end
function resolvers.calc.inscription(t, e)
	e:setInscription(nil, t[1], t[2], false, false, nil, true, true)
	return nil
end

--- Random inscription resolver
local inscriptions_max = {
	heal = 1,
	protect = 1,
	attack = 4,
	movement = 1,
	utility = 6,
	teleport = 0, -- Annoying
}

function resolvers.inscriptions(nb, list, kind, ignore_limits)
	return {__resolver="inscriptions", nb, list, kind, ignore_limits}
end
function resolvers.calc.inscriptions(t, e)
	local kind = nil
	if not t[4] then
		if t[3] then
			kind = function(o)
				if 	o.inscription_kind == t[3] and
					(e.__npc_inscription_kinds[o.inscription_kind] or 0) < (inscriptions_max[o.inscription_kind] or 0)
					then return true
				end return false
			end
		else
			kind = function(o)
				if 	(e.__npc_inscription_kinds[o.inscription_kind] or 0) < (inscriptions_max[o.inscription_kind] or 0)
					then return true
				end return false
			end
		end
	end

	e.__npc_inscription_kinds = e.__npc_inscription_kinds or {}
	for i = 1, t[1] do
		local o
		if type(t[2]) == "table" then
			if #t[2] > 0 then
				local name = rng.tableRemove(t[2])
				if not name then return nil end
				o = game.zone:makeEntity(game.level, "object", {special=kind, name=name}, nil, true)
			else
				o = game.zone:makeEntity(game.level, "object", {special=kind, type="scroll"}, nil, true)
			end
		else
			o = game.zone:makeEntity(game.level, "object", {special=kind, type="scroll", subtype=t[2]}, nil, true)
		end
		if o and o.inscription_talent and o.inscription_data then
			o.inscription_data.use_any_stat = 0.5 -- Cheat a bit to scale inscriptions nicely
			o.inscription_data.cooldown = math.ceil(o.inscription_data.cooldown * 1.6)
			e:setInscription(nil, o.inscription_talent, o.inscription_data, false, false, nil, true, true)
			e.__npc_inscription_kinds[o.inscription_kind] = (e.__npc_inscription_kinds[o.inscription_kind] or 0) + 1
		end
	end
	return nil
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

function resolvers.emote_random(def)
	return {__resolver="emote_random", def}
end
function resolvers.calc.emote_random(t, e)
	local def = t[1]
	def.chance = def.chance or 0.1
	if def.allow_backup_guardian then
		def[#def+1] = function()
			local t = game.state:getBackupGuardianEmotes{}
			return #t > 0 and rng.table(t) or nil
		end
	end
	return def
end

function resolvers.nice_tile(def)
	return {__resolver="nice_tile", def}
end
function resolvers.calc.nice_tile(t, e)
	if engine.Map.tiles.nicer_tiles then
		if t[1].tall then t[1] = {image="invis.png", add_mos = {{image="=BASE=TILE=", display_h=2, display_y=-1}}} end
		if t[1].add_mos and t[1].add_mos[1] and t[1].add_mos[1].image == "=BASE=TILE=" then t[1].add_mos[1].image = e.image end
		table.merge(e, t[1])
	end
	return nil
end

function resolvers.shooter_capacity()
	return {__resolver="shooter_capacity", __resolve_last=true}
end
function resolvers.calc.shooter_capacity(t, e)
	e.combat.capacity = math.floor(e.combat.capacity)
	e.combat.shots_left = e.combat.capacity
	return nil
end

--- Give staves a flavor, appropriate damage type, spellpower, spellcrit, and the ability to teach the command staff talent
function resolvers.staff_wielder(name)
	return {__resolver="staff_wielder", name}
end
function resolvers.calc.staff_wielder(t, e)
	local staff_type = rng.table{2, 2, 2, 2, 3, 3, 3, 4, 4, 4}
	e.flavor_name = e["flavor_names"][staff_type]
	if staff_type == 2 then
		e.combat.damtype = rng.table{engine.DamageType.FIRE, engine.DamageType.COLD, engine.DamageType.LIGHTNING, engine.DamageType.ARCANE }
		e.modes = {"fire", "cold", "lightning", "arcane"}
		e.name = e.name:gsub(" staff", " magestaff")
	elseif staff_type == 3 then
		e.combat.damtype = rng.table{engine.DamageType.LIGHT, engine.DamageType.DARKNESS, engine.DamageType.TEMPORAL,  engine.DamageType.PHYSICAL }
		e.modes = {"light", "darkness", "temporal", "physical"}
		e.name = e.name:gsub(" staff", " starstaff")
	elseif staff_type == 4 then
		e.combat.damtype = rng.table{engine.DamageType.DARKNESS, engine.DamageType.BLIGHT, engine.DamageType.ACID, engine.DamageType.FIRE,}
		e.modes = {"darkness", "blight", "acid", "fire"}
		e.name = e.name:gsub(" staff", " vilestaff")
	end
	return 	{ inc_damage = {[e.combat.damtype] = e.combat.dam}, combat_spellpower = e.material_level * 3, combat_spellcrit = e.material_level, learn_talent = {[Talents.T_COMMAND_STAFF] = 1}, }
end
