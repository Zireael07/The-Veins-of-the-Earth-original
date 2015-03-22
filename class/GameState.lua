-- Veins of the Earth
-- Copyright (C) 2013 - 2014 Zireael
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
require "engine.Entity"
local Particles = require "engine.Particles"
local Shader = require "engine.Shader"
local Map = require "engine.Map"
local NameGenerator = require "engine.NameGenerator"
local NameGenerator2 = require "engine.NameGenerator2"

local Object = require 'mod.class.Object'

module(..., package.seeall, class.inherit(engine.Entity))

function _M:init(t, no_default)
	engine.Entity.init(self, t, no_default)

	self.unique_death = {}
	self.used_events = {}
	self.boss_killed = 0
	self.stores_restock = 1
	self.birth = {}

	--Flavor stuff from ToME2 by Zizzo
	 self.flavors_known = {}
 	 self.flavors_assigned = {}
  	self.flavors_unused = {}

  	 -- Prepopulate the various flavor-related state tables.
  	for type, subtypes in pairs(Object.flavors_def) do
    	self.flavors_known[type] = self.flavors_known[type] or {}
    	self.flavors_assigned[type] = self.flavors_assigned[type] or {}
    	self.flavors_unused[type] = self.flavors_unused[type] or {}
    	for subtype, def in pairs(subtypes) do
      		self.flavors_known[type][subtype] = self.flavors_known[type][subtype] or {}
      		self.flavors_assigned[type][subtype] = self.flavors_assigned[type][subtype] or {}
      		if def.values then
			local l = {}
				for i = 1, #def.values do l[i] = i end
				table.shuffle(l)
				self.flavors_unused[type][subtype] = self.flavors_unused[type][subtype] or l
      		end
      		if def.assigned then
				table.merge(self.flavors_assigned[type][subtype], def.assigned)
    	  	end
    	end
  	end
end

--Day/night code from ToME
local function doTint(from, to, amount)
	local tint = {r = 0, g = 0, b = 0}
	tint.r = (from.r * (1 - amount) + to.r * amount)
	tint.g = (from.g * (1 - amount) + to.g * amount)
	tint.b = (from.b * (1 - amount) + to.b * amount)
	return tint
end

--- Compute a day/night cycle
-- Works by changing the tint of the map gradually
function _M:dayNightCycle()
	local map = game.level.map
	local shown = map.color_shown
	local obscure = map.color_obscure

--[[	if not config.settings.tome.daynight then
		-- Restore defaults
		map._map:setShown(unpack(shown))
		map._map:setObscure(unpack(obscure))
		return
	end]]

	local hour, minute = game.calendar:getTimeOfDay(game.turn)
	hour = hour + (minute / 60)
	local tint = {r = 0.5, g = 0.1, b = 0.1}
	local startTint = {r = 0.5, g = 0.1, b = 0.1}
	local endTint = {r = 0.5, g = 0.1, b = 0.1}
	if hour <= 4 then
		tint = {r = 0.8, g = 0.75, b = 0.75}
	--yellow
	elseif hour > 4 and hour <= 7 then
		startTint = { r = 0.5, g = 0.5, b = 0.1 }
		endTint = { r = 0.5, g = 0.8, b = 0.1 }
		tint = doTint(startTint, endTint, (hour - 4) / 3)
	elseif hour > 7 and hour <= 12 then
		startTint = { r = 0.5, g = 0.8, b = 0.1 }
		endTint = { r = 0.1, g = 0.3, b = 0.1 }
		tint = doTint(startTint, endTint, (hour - 7) / 5)
		--green
	elseif hour > 12 and hour <= 18 then
		startTint = { r = 0.1, g = 0.3, b = 0.1 }
		endTint = { r = 0.9, g = 0.75, b = 0.75 }
		tint = doTint(startTint, endTint, (hour - 12) / 6)
	-- pink
	elseif hour > 18 and hour < 24 then
		startTint = { r = 0.9, g = 0.75, b = 0.75 }
		endTint = { r = 0.8, g = 0.75, b = 0.75 }
		tint = doTint(startTint, endTint, (hour - 18) / 6)
	end
	map._map:setShown(shown[1] * (tint.r+0.4), shown[2] * (tint.g+0.4), shown[3] * (tint.b+0.4), shown[4])
	map._map:setObscure(obscure[1] * (tint.r+0.2), obscure[2] * (tint.g+0.2), obscure[3] * (tint.b+0.2), obscure[4])
end

--Taken from ToME, to be adjusted
--------------------------------------------------------------
-- Loot filters
--------------------------------------------------------------

--PF/SRD values in gp (multiply by 10 to get silver)
local wealth_by_level = {
	monster = {
		[1] = 300,
		[2] = 600,
		[3] = 900,
		[4] = 1200,
		[5] = 1600,
		[6] = 2000,
		[7] = 2600,
		[8] = 3400,
		[9] = 4500,
		[10] = 5800,
		[11] = 7500,
		[12] = 9800,
		[13] = 13000,
		[14] = 17000,
		[15] = 22000,
		[16] = 28000,
		[17] = 36000,
		[18] = 47000,
		[19] = 61000,
		[20] = 80000,
	},
	npc = {
		[1] = 290,
		[2] = 780,
		[3] = 1650,
		[4] = 2400,
		[5] = 3450,
		[6] = 4650,
		[7] = 6000,
		[8] = 7800,
		[9] = 10050,
		[10] = 12750,
		[11] = 16350,
		[12] = 21000,
		[13] = 27000,
		[14] = 34800,
		[15] = 45000,
		[16] = 58500,
		[17] = 75000,
		[18] = 96000,
		[19] = 123000,
		[20] = 159000,
	},
	--character wealth by level
	boss = {
		--no CR 1 bosses exist!!!
		[1] = 115, --1st level starting gear average is 115 gp (1150 silver)
		[2] = 1000,
		[3] = 3000,
		[4] = 6000,
		[5] = 10500,
		[6] = 16000,
		[7] = 23500,
		[8] = 33000,
		[9] = 46000,
		[10] = 62000,
		[11] = 82000,
		[12] = 108000,
		[13] = 140000,
		[14] = 185000,
		[15] = 240000,
		[16] = 315000,
		[17] = 410000,
		[18] = 530000,
		[19] = 685000,
		[20] = 880000,
	},
}


local drop_tables = {
	normal = {
		[1] = {
			uniques = 0.5,
			double_greater = 0,
			greater_normal = 0,
			greater = 0,
			double_ego = 20,
			ego = 45,
			basic = 38,
			money = 7,
			lore = 2,
		},
		[2] = {
			uniques = 0.7,
			double_greater = 0,
			greater_normal = 0,
			greater = 10,
			double_ego = 35,
			ego = 30,
			basic = 41,
			money = 8,
			lore = 2.5,
		},
		[3] = {
			uniques = 1,
			double_greater = 10,
			greater_normal = 15,
			greater = 25,
			double_ego = 25,
			ego = 25,
			basic = 10,
			money = 8.5,
			lore = 2.5,
		},
		[4] = {
			uniques = 1.1,
			double_greater = 15,
			greater_normal = 35,
			greater = 25,
			double_ego = 20,
			ego = 5,
			basic = 5,
			money = 8,
			lore = 3,
		},
		[5] = {
			uniques = 1.2,
			double_greater = 35,
			greater_normal = 30,
			greater = 20,
			double_ego = 10,
			ego = 5,
			basic = 5,
			money = 8,
			lore = 3,
		},
	},
	store = {
		[1] = {
			uniques = 0.5,
			double_greater = 10,
			greater_normal = 15,
			greater = 25,
			double_ego = 45,
			ego = 10,
			basic = 0,
			money = 0,
			lore = 0,
		},
		[2] = {
			uniques = 0.5,
			double_greater = 20,
			greater_normal = 18,
			greater = 25,
			double_ego = 35,
			ego = 8,
			basic = 0,
			money = 0,
			lore = 0,
		},
		[3] = {
			uniques = 0.5,
			double_greater = 30,
			greater_normal = 22,
			greater = 25,
			double_ego = 25,
			ego = 6,
			basic = 0,
			money = 0,
			lore = 0,
		},
		[4] = {
			uniques = 0.5,
			double_greater = 40,
			greater_normal = 30,
			greater = 25,
			double_ego = 20,
			ego = 4,
			basic = 0,
			money = 0,
			lore = 0,
		},
		[5] = {
			uniques = 0.5,
			double_greater = 50,
			greater_normal = 30,
			greater = 25,
			double_ego = 10,
			ego = 0,
			basic = 0,
			money = 0,
			lore = 0,
		},
	},
	boss = {
		[1] = {
			uniques = 3,
			double_greater = 0,
			greater_normal = 0,
			greater = 5,
			double_ego = 45,
			ego = 45,
			basic = 0,
			money = 4,
			lore = 0,
		},
		[2] = {
			uniques = 4,
			double_greater = 0,
			greater_normal = 8,
			greater = 15,
			double_ego = 40,
			ego = 35,
			basic = 0,
			money = 4,
			lore = 0,
		},
		[3] = {
			uniques = 5,
			double_greater = 10,
			greater_normal = 22,
			greater = 25,
			double_ego = 25,
			ego = 20,
			basic = 0,
			money = 4,
			lore = 0,
		},
		[4] = {
			uniques = 6,
			double_greater = 40,
			greater_normal = 30,
			greater = 25,
			double_ego = 20,
			ego = 0,
			basic = 0,
			money = 4,
			lore = 0,
		},
		[5] = {
			uniques = 7,
			double_greater = 50,
			greater_normal = 30,
			greater = 25,
			double_ego = 10,
			ego = 0,
			basic = 0,
			money = 4,
			lore = 0,
		},
	},
}

local loot_mod = {
	uvault = { -- Uber vault
		uniques = 40,
		double_greater = 8,
		greater_normal = 5,
		greater = 3,
		double_ego = 0,
		ego = 0,
		basic = 0,
		money = 0,
		lore = 0,
	},
	gvault = { -- Greater vault
		uniques = 10,
		double_greater = 2,
		greater_normal = 2,
		greater = 2,
		double_ego = 1,
		ego = 0,
		basic = 0,
		money = 0,
		lore = 0,
	},
	vault = { -- Default vault
		uniques = 5,
		double_greater = 2,
		greater_normal = 3,
		greater = 3,
		double_ego = 2,
		ego = 0,
		basic = 0,
		money = 0,
		lore = 0,
	},
}

--[[local default_drops = function(zone, level, what)
	if zone.default_drops then return zone.default_drops end
	local lev = util.bound(math.ceil(zone:level_adjust_level(level, "object") / 10), 1, 5)
--	print("[TOME ENTITY FILTER] making default loot table for", what, lev)
	return table.clone(drop_tables[what][lev])
end]]
local wealth = function(zone, level, what)
	if zone.default_drops then return zone.default_drops end
	local lev = game.level.level
--	if what == "monster" then lev = e.challenge end
--	if what == "npc" then lev = e.challenge end
--	if what == "boss" then lev = level end
	print("[VEINS ENTITY FILTER] making wealth table for", what, lev)
--	return table.clone(wealth_by_level[what][lev])
	return wealth_by_level[what][lev]
end

function _M:defaultEntityFilter(zone, level, type)
	if type ~= "object" then return end

	-- By default we dont apply special filters, but we always provide one so that entityFilter is called
	return {
		veins = wealth(zone, level, "boss"),
	}
end

--- Alter any entity filters to process our specific loot tables
-- Here be magic! We tweak and convert and turn and create filters! It's magic but it works :)
function _M:entityFilterAlter(zone, level, type, filter)
	if type ~= "object" then return filter end

	if filter.force_veins_drops or (not filter.veins and not filter.defined and not filter.special and not filter.unique and not filter.ego_chance and not filter.ego_filter and not filter.no_tome_drops) then
		filter = table.clone(filter)
		filter.veins = wealth(zone, filter.veins_level or level, filter.veins_drops or "boss")
	end

	if filter.veins then
--		local t = (filter.veins == true) and default_drops(zone, level, "boss") or filter.veins
		local cost = (filter.veins == true) and wealth(zone, level, "boss") or filter.veins
		filter.veins = nil

		if filter.veins_mod then
			t = table.clone(t)
			if _G.type(filter.veins_mod) == "string" then filter.veins_mod = loot_mod[filter.veins_mod] end
			for k, v in pairs(filter.veins_mod) do
--				print(" ***** LOOT MOD", k, v)
				t[k] = (t[k] or 0) * v
			end
		end

		if cost then
			if cost < 20000 then
				--no unique items
				print("[VEINS ENTITY FILTER] rejecting unique because of cost")
				filter.not_properties = filter.not_properties or {}
				filter.not_properties[#filter.not_properties+1] = "unique"
			end

			--no single item on a level/in a NPC inventory should cost more than 1/2 total WBL
	--		filter.cost = cost/2
		end

--[[		-- If we request a specific type/subtype, we don't want categories that could make that not happen
		if filter.type or filter.subtype or filter.name then t.money = 0 t.lore = 0	end

		local u = t.uniques or 0
		local dg = u + (t.double_greater or 0)
		local ge = dg + (t.greater_normal or 0)
		local g = ge + (t.greater or 0)
		local de = g + (t.double_ego or 0)
		local e = de + (t.ego or 0)
		local m = e + (t.money or 0)
		local l = m + (t.lore or 0)
		local total = l + (t.basic or 0)

		local r = rng.float(0, total)
		if r < u then
			print("[TOME ENTITY FILTER] selected Uniques", r, u)
			filter.unique = true
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "lore"

		elseif r < dg then
			print("[TOME ENTITY FILTER] selected Double Greater", r, dg)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance={tries = { {ego_chance=100, properties={"greater_ego"}, }, {ego_chance=100, properties={"greater_ego"} } } }

		elseif r < ge then
			print("[TOME ENTITY FILTER] selected Greater + Ego", r, ge)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance={tries = { {ego_chance=100, properties={"greater_ego"}, }, {ego_chance=100, not_properties={"greater_ego"}, } }}

		elseif r < g then
			print("[TOME ENTITY FILTER] selected Greater", r, g)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance={tries = { {ego_chance=100, properties={"greater_ego"}, } } }

		elseif r < de then
			print("[TOME ENTITY FILTER] selected Double Ego", r, de)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance={tries = { {ego_chance=100, not_properties={"greater_ego"}, }, {ego_chance=100, not_properties={"greater_ego"}, } }}

		elseif r < e then
			print("[TOME ENTITY FILTER] selected Ego", r, e)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance={tries = { {ego_chance=100, not_properties={"greater_ego"}, } } }

		elseif r < m then
			print("[TOME ENTITY FILTER] selected Money", r, m)
			filter.special = function(e) return e.type == "money" or e.type == "gem" end

		elseif r < l then
			print("[TOME ENTITY FILTER] selected Lore", r, l)
			filter.special = function(e) return e.lore and true or false end

		else
			print("[TOME ENTITY FILTER] selected basic", r, total)
			filter.not_properties = filter.not_properties or {}
			filter.not_properties[#filter.not_properties+1] = "unique"
			filter.ego_chance = -1000
		end]]
	end

	if filter.random_object then
		print("[TOME ENTITY FILTER] random object requested, removing ego chances")
		filter.ego_chance = -1000
	end

	-- By default we dont apply special filters, but we always provide one so that entityFilter is called
	return filter
end

function _M:entityFilter(zone, e, filter, type)
	if type == "object" then
		if filter.cost then
			if e.cost > filter.cost then return false end
		end

	return true
	else
		return true
	end
end


function _M:locationRevealAround(x, y)
	game.level.map.lites(x, y, true)
	game.level.map.remembers(x, y, true)
	for _, c in pairs(util.adjacentCoords(x, y)) do
		game.level.map.lites(x+c[1], y+c[2], true)
		game.level.map.remembers(x+c[1], y+c[2], true)
	end
end

--Events stuff taken from ToME
function _M:doneEvent(id)
	return self.used_events[id]
end

function _M:canEventGrid(level, x, y)
	return game.player:canMove(x, y) and not level.map.attrs(x, y, "no_teleport") and not level.map:checkAllEntities(x, y, "change_level") and not level.map:checkAllEntities(x, y, "special")
end

function _M:canEventGridRadius(level, x, y, radius, min)
	local list = {}
	for i = -radius, radius do for j = -radius, radius do
		if game.state:canEventGrid(level, x+i, y+j) then list[#list+1] = {x=x+i, y=y+j} end
	end end

	if #list < min then return false
	else return list end
end

function _M:findEventGrid(level, checker)
	local x, y = rng.range(1, level.map.w - 2), rng.range(1, level.map.h - 2)
	local tries = 0
	local can = checker or self.canEventGrid
	while not can(self, level, x, y) and tries < 100 do
		x, y = rng.range(1, level.map.w - 2), rng.range(1, level.map.h - 2)
		tries = tries + 1
	end
	if tries >= 100 then return false end
	return x, y
end

function _M:findEventGridRadius(level, radius, min)
	local x, y = rng.range(3, level.map.w - 4), rng.range(3, level.map.h - 4)
	local tries = 0
	while not self:canEventGridRadius(level, x, y, radius, min) and tries < 100 do
		x, y = rng.range(3, level.map.w - 4), rng.range(3, level.map.h - 4)
		tries = tries + 1
	end
	if tries >= 100 then return false end
	return self:canEventGridRadius(level, x, y, radius, min)
end

function _M:eventBaseName(sub, name)
	local base = "/data"
	local _, _, addon, rname = name:find("^([^+]+)%+(.+)$")
	if addon and rname then
		base = "/data-"..addon
		name = rname
	end
	return base.."/general/events/"..sub..name..".lua"
end

function _M:startEvents()
	if not game.zone.events then print("No zone events loaded") return end

	if not game.zone.assigned_events then
		local levels = {}
		if game.zone.events_by_level then
			levels[game.level.level] = {}
		else
			for i = 1, game.zone.max_level do levels[i] = {} end
		end

		-- Generate the events list for this zone, eventually loading from group files
		local evts, mevts = {}, {}
		for i, e in ipairs(game.zone.events) do
			if e.name then if e.minor then mevts[#mevts+1] = e else evts[#evts+1] = e end
			elseif e.group then
				local f, err = loadfile(self:eventBaseName("groups/", e.group))
				if not f then error(err) end
				setfenv(f, setmetatable({level=game.level, zone=game.zone}, {__index=_G}))
				local list = f()
				for j, ee in ipairs(list) do
					if e.percent_factor and ee.percent then ee.percent = math.floor(ee.percent * e.percent_factor) end
					if e.forbid then ee.forbid = table.append(ee.forbid or {}, e.forbid) end
					if ee.name then if ee.minor then mevts[#mevts+1] = ee else evts[#evts+1] = ee end end
				end
			end
		end

		-- Randomize the order they are checked as
		table.shuffle(evts)
		table.print(evts)
		table.shuffle(mevts)
		table.print(mevts)
		for i, e in ipairs(evts) do
			-- If we allow it, try to find a level to host it
			if (e.always or rng.percent(e.percent) or (e.special and e.special() == true)) and (not e.unique or not self:doneEvent(e.name)) then
				local lev = nil
				local forbid = e.forbid or {}
				forbid = table.reverse(forbid)
				if game.zone.events_by_level then
					lev = game.level.level
				else
					if game.zone.events.one_per_level then
						local list = {}
						for i = 1, #levels do if #levels[i] == 0 and not forbid[i] then list[#list+1] = i end end
						if #list > 0 then
							lev = rng.table(list)
						end
					else
						if forbid then
							local t = table.genrange(1, game.zone.max_level, true)
							t = table.minus_keys(t, forbid)
							lev = rng.table(table.keys(t))
						else
							lev = rng.range(1, game.zone.max_level)
						end
					end
				end

				if lev then
					lev = levels[lev]
					lev[#lev+1] = e.name
				end
			end
		end
		for i, e in ipairs(mevts) do
			local forbid = e.forbid or {}
			forbid = table.reverse(forbid)

			local start, stop = 1, game.zone.max_level
			if game.zone.events_by_level then start, stop = game.level.level, game.level.level end
			for lev = start, stop do
				if rng.percent(e.percent) and not forbid[lev] then
					local lev = levels[lev]
					lev[#lev+1] = e.name

					if e.max_repeat then
						local nb = 1
						local p = e.percent
						while nb <= e.max_repeat do
							if rng.percent(p) then
								lev[#lev+1] = e.name
								nb = nb + 1
							else
								break
							end
							p = p / 2
						end
					end
				end
			end
		end

		game.zone.assigned_events = levels
	end

	return function()
		print("Assigned events list")
		table.print(game.zone.assigned_events)

		for i, e in ipairs(game.zone.assigned_events[game.level.level] or {}) do
			local f, err = loadfile(self:eventBaseName("", e))
			if not f then error(err) end
			setfenv(f, setmetatable({level=game.level, zone=game.zone, event_id=e.name, Map=Map}, {__index=_G}))
			f()
		end
		game.zone.assigned_events[game.level.level] = {}
		if game.zone.events_by_level then game.zone.assigned_events = nil end
	end
end
