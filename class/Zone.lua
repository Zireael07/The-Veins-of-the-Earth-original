-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael
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
local Zone = require "engine.Zone"
local Map = require "engine.Map"
--local Dialog = require "engine.ui.Dialog"
local Dialog = require "mod.class.patch.Dialog"
local Astar = require "engine.Astar"
local forceprint = print
--local print = function() end

module(..., package.seeall, class.inherit(Zone))

--Don't merge creation cost tables
_M:addEgoRule("object", function(dvalue, svalue, key, dst, src, rules, state)
--[[	if key == "creation" then return end
	if key == "gold_cost" then return end
	if key == "xp_cost" then return end
	return true]]
	-- Only work on the use_simple keys.
	if key ~= 'use_simple' then return end
	-- If the special isn't a table, make it an empty one.
	if type(dvalue) ~= 'table' then dvalue = {} end
	if type(svalue) ~= 'table' then svalue = {} end
	-- If the special is a single special, wrap it to allow multiple.
	if dvalue.fct then dvalue = {dvalue} end
	if svalue.fct then svalue = {svalue} end
	-- Update
	dst[key] = dvalue
	-- Recurse with always append
	rules = table.clone(rules)
	table.insert(rules, 1, table.rules.append)
	return table.rules.recurse(dvalue, svalue, key, dst, src, rules, state)
end)

--- Called when the zone file is loaded
function _M:onLoadZoneFile(basedir)
	-- Load events if they exist
	if fs.exists(basedir.."events.lua") then
		local f = loadfile(basedir.."events.lua")
		setfenv(f, setmetatable({self=self}, {__index=_G}))
		self.events = f()

		self:triggerHook{"Zone:loadEvents", zone=self.short_name, events=self.events}
	else
		local evts = {}
		self:triggerHook{"Zone:loadEvents", zone=self.short_name, events=evts}
		if next(evts) then self.events = evts end
	end
end

function _M:getLoadTips()
	if self.load_tips then
		local l = rng.table(self.load_tips)
		return "#SANDY_BROWN#"..l.text.."#WHITE#"
	else
		return nil
	end
end

--- Asks the zone to generate a level of level "lev"
-- @param game which `Game`?
-- @param lev the level (from 1 to zone.max_level)
-- @param old_lev where are we leaving
-- @param no_close pass to `leaveLevel`
-- @return a `Level` object
function _M:getLevel(game, lev, old_lev, no_close)
	self:leaveLevel(no_close, lev, old_lev)

	local level_data = self:getLevelData(lev)

	local levelid = self.short_name.."-"..lev
	local level
	local new_level = false


	-- Load persistent level?
	if type(level_data.persistent) == "string" and level_data.persistent == "zone_temporary" then
		forceprint("Loading zone temporary level", self.short_name, lev)
		local popup = Dialog:simpleWaiterTip("Loading level", "Please wait while loading the level... ", self:getLoadTips(), nil, 10000)
		core.display.forceRedraw()

		self.temp_memory_levels = self.temp_memory_levels or {}
		level = self.temp_memory_levels[lev]

		if level then
			-- Setup the level in the game
			game:setLevel(level)
			-- Recreate the map because it could have been saved with a different tileset or whatever
			-- This is not needed in case of a direct to file persistance becuase the map IS recreated each time anyway
			level.map:recreate()
		end
		popup:done()
	elseif type(level_data.persistent) == "string" and level_data.persistent == "zone" and not self.save_per_level then
		forceprint("Loading zone persistance level", self.short_name, lev)
		local popup = Dialog:simpleWaiterTip("Loading level", "Please wait while loading the level... ", self:getLoadTips(), nil, 10000)
		core.display.forceRedraw()

		self.memory_levels = self.memory_levels or {}
		level = self.memory_levels[lev]

		if level then
			-- Setup the level in the game
			game:setLevel(level)
			-- Recreate the map because it could have been saved with a different tileset or whatever
			-- This is not needed in case of a direct to file persistance becuase the map IS recreated each time anyway
			level.map:recreate()
		end
		popup:done()
	elseif type(level_data.persistent) == "string" and level_data.persistent == "memory" then
		forceprint("Loading memory persistance level", self.short_name, lev)
		local popup = Dialog:simpleWaiterTip("Loading level", "Please wait while loading the level... ", self:getLoadTips(), nil, 10000)
		core.display.forceRedraw()

		game.memory_levels = game.memory_levels or {}
		level = game.memory_levels[levelid]

		if level then
			-- Setup the level in the game
			game:setLevel(level)
			-- Recreate the map because it could have been saved with a different tileset or whatever
			-- This is not needed in case of a direct to file persistance becuase the map IS recreated each time anyway
			level.map:recreate()
		end
		popup:done()
	elseif level_data.persistent then
		forceprint("Loading level persistance level", self.short_name, lev)
		local popup = Dialog:simpleWaiterTip("Loading level", "Please wait while loading the level... ", self:getLoadTips(), nil, 10000)
		core.display.forceRedraw()

		-- Try to load from a savefile
		level = savefile_pipe:doLoad(game.save_name, "level", nil, self.short_name, lev)

		if level then
			-- Setup the level in the game
			game:setLevel(level)
		end
		popup:done()
	end

	-- In any case, make one if none was found
	if not level then
		forceprint("Creating level", self.short_name, lev)
		local popup = Dialog:simpleWaiterTip("Generating level", "Please wait while generating the level... ", self:getLoadTips(), nil, 10000)
		core.display.forceRedraw()

		level = self:newLevel(level_data, lev, old_lev, game)
		new_level = true

		popup:done()
	end

	-- Clean up things
	collectgarbage("collect")

	-- Re-open the level if needed (the method does the check itself)
	level.map:reopen()

	return level, new_level
end


--- Parses the npc/objects list and compute rarities for random generation
-- ONLY entities with a rarity properties will be considered.<br/>
-- This means that to get a never-random entity you simply do not put a rarity property on it.

function _M:computeRarities(type, list, level, filter, add_level, rarity_field)
    rarity_field = rarity_field or "rarity"
    local r = { total=0 }
    print("******************", level.level, type)

    local lev = self:level_adjust_level(level, self, type) + (add_level or 0)
    lev = self:adjustComputeRaritiesLevel(level, type, lev)

    for i, e in ipairs(list) do
        if e[rarity_field] and e.level_range and (not filter or filter(e)) then
        --  print("computing rarity of", e.name)

            --Safety catch by Zizzo
           if self:okToGenerate(e, type, level, base_lev, lev, filter, rarity_field) then

            local max = 10000
            local genprob = math.floor(max / e[rarity_field])
            print(("Entity(%30s) got %3d (=%3d / %3d) chance to generate. Level range(%2d-%2s), current %2d"):format(e.name, math.floor(genprob), math.floor(max), e[rarity_field], e.level_range[1], e.level_range[2] or "--", lev))

            -- Generate and store egos list if needed
            if e.egos and e.egos_chance then
                if _G.type(e.egos_chance) == "number" then e.egos_chance = {e.egos_chance} end
                for ie, edata in pairs(e.egos_chance) do
                    local etype = ie
                    if _G.type(ie) == "number" then etype = "" end
                    if not level:getEntitiesList(type.."/"..e.egos..":"..etype) then
                        self:generateEgoEntities(level, type, etype, e.egos, e.__CLASSNAME)
                    end
                end
            end

            -- Generate and store addons list if needed
            if e.addons then
                if not level:getEntitiesList(type.."/"..e.addons..":addon") then
                    self:generateEgoEntities(level, type, "addon", e.addons, e.__CLASSNAME)
                end
            end

            if genprob > 0 then
--              genprob = math.ceil(genprob / 10 * math.sqrt(genprob))
                r.total = r.total + genprob
                r[#r+1] = { e=e, genprob=r.total, level_diff = lev - level.level }
            end

			else
			print(("Entity(%30s) not ok to generate. Level range(%2d-%2s), current %2d"):format(e.name, e.level_range[1], e.level_range[2] or "--", lev))

            end
        end
    end
    table.sort(r, function(a, b) return a.genprob < b.genprob end)

    local prev = 0
    local tperc = 0
    for i, ee in ipairs(r) do
        local perc = 100 * (ee.genprob - prev) / r.total
        tperc = tperc + perc
        print(("entity chance %2d : chance(%4d : %4.5f%%): %s"):format(i, ee.genprob, perc, ee.e.name))
        prev = ee.genprob
    end
    print("*DONE", r.total, tperc.."%")

    return r

end

function _M:okToGenerate(e, type, level, base_lev, max_ood_lev, filter, rarity_field)
    if type == 'actor' then
        return e[rarity_field] and e.level_range and (not filter or filter(e))

    elseif type == 'object' then
	return e[rarity_field] and e.level_range and e.level_range[1] <= max_ood_lev and (not filter or filter(e))
	else
    -- From the original Zone:computeRarities()
    return e[rarity_field] and e.level_range and e.level_range[1] <= max_ood_lev and (not filter or filter(e))
  end

end

--- Checks an entity against a filter
function _M:checkFilter(e, filter, type)
    if e.unique and game.uniques[e.__CLASSNAME.."/"..e.unique] then print("refused unique", e.name, e.__CLASSNAME.."/"..e.unique) return false end

    if not filter then return true end
    if filter.ignore and self:checkFilter(e, filter.ignore, type) then return false end

--    print("Checking filter", filter.type, filter.subtype, "::", e.type,e.subtype,e.name)
    if filter.type and filter.type ~= e.type then return false end
    if filter.subtype and filter.subtype ~= e.subtype then return false end
    if filter.name and filter.name ~= e.name then return false end
    if filter.define_as and filter.define_as ~= e.define_as then return false end
    if filter.unique and not e.unique then return false end
    if filter.properties then
        for i = 1, #filter.properties do if not e[filter.properties[i]] then return false end end
    end
    if filter.not_properties then
        for i = 1, #filter.not_properties do if e[filter.not_properties[i]] then print("Refused not properties",i) return false end end
    end
    if e.checkFilter and not e:checkFilter(filter) then return false end
    if filter.special and not filter.special(e) then return false end
    if self.check_filter and not self:check_filter(e, filter, type) then return false end
    if filter.max_ood and resolvers.current_level and e.level_range and resolvers.current_level + filter.max_ood < e.level_range[1] then print("Refused max_ood", e.name, e.level_range[1]) return false end

    if e.unique then print("accepted unique", e.name, e.__CLASSNAME.."/"..e.unique) end

    --New filters
    if type == "actor" then
    --    if filter.challenge and (filter.challenge >= e.challenge or filter.challenge <= e.challenge) then return false end
        if filter.max_cr and e.challenge >= (base_level or 0) + game:getDunDepth() + filter.max_cr then print("Refused max_cr", e.name, e.challenge) return false end
    end

    return true
end

--Backported from ToME git
--Necessary to avoid Lua'ing
local pick_ego = function(self, level, e, eegos, egos_list, type, picked_etype, etype, ego_filter, add_levels)
    picked_etype[etype] = true
    if _G.type(etype) == "number" then etype = "" end

    local egos = e.egos and level:getEntitiesList(type.."/"..e.egos..":"..etype)

    if not egos then
		if add_levels == nil then
		egos = self:generateEgoEntities(level, type, etype, eegos, e.__CLASSNAME)
		else
			egos = self:generateEgoEntities(level, type, etype, eegos, e.__CLASSNAME, add_levels)
		end
	end

    if self.ego_filter then ego_filter = self.ego_filter(self, level, type, etype, e, ego_filter, egos_list, picked_etype) end

    -- Filter the egos if needed
    if ego_filter then
        local list = {}
        for z = 1, #egos do list[#list+1] = egos[z].e end
        egos = self:computeRarities(type, list, level, function(e) return self:checkFilter(e, ego_filter) end, ego_filter.add_levels, ego_filter.special_rarity)
    end
    egos_list[#egos_list+1] = self:pickEntity(egos)

    if egos_list[#egos_list] then print("Picked ego", type.."/"..eegos..":"..etype, ":=>", egos_list[#egos_list].name) else print("Picked ego", type.."/"..eegos..":"..etype, ":=>", #egos_list) end
end

--dup out the wazoo!
local pick_force_ego = function(self, level, e, eegos, egos_list, type, picked_etype, etype, add_levels, name)
	local egos = e.egos and level:getEntitiesList(type.."/"..e.egos..":"..etype)

    if not egos then
		if add_levels == nil then
		egos = self:generateEgoEntities(level, type, etype, eegos, e.__CLASSNAME)
		else
			egos = self:generateEgoEntities(level, type, etype, eegos, e.__CLASSNAME, add_levels)
		end
	end

	--Pick the one whose name matches
	egos_list[#egos_list+1] = self:pickNamedEntity(egos, name)

	if egos_list[#egos_list] then print("Picked ego", type.."/"..eegos..":"..etype, ":=>", egos_list[#egos_list].name) else print("Picked ego", type.."/"..eegos..":"..etype, ":=>", #egos_list) end

end

function _M:pickNamedEntity(list, name)
	if #list == 0 then return nil end
	local r = rng.range(1, list.total)
	for i = 1, #list do
--		print("test", r, ":=:", list[i].genprob)
		if list[i].e.name == name then
--			print(" * select", list[i].e.name)
			return list[i].e
		end
	end
	return nil
end

--- Compute posible egos for this list
function _M:generateEgoEntities(level, type, etype, e_egos, e___CLASSNAME, add_level)
	print("Generating specific ego list", type.."/"..e_egos..":"..etype)
--[[	if add_level == nil then
	print("Generating ego list, nil add_level")
	else
	print("Generating ego list, non-nil add_level")
	end]]
	local egos = self:getEgosList(level, type, e_egos, e___CLASSNAME)
	if egos then
		local egos_prob = self:computeRarities(type, egos, level, etype ~= "" and function(e) return e[etype] end or nil, add_level)
		level:setEntitiesList(type.."/"..e_egos..":"..etype, egos_prob)
		level:setEntitiesList(type.."/base/"..e_egos..":"..etype, egos)
		return egos_prob
	end
end

-- Applies a single ego to a (pre-resolved) entity
-- May be in need to resolve afterwards
function _M:applyEgo(e, ego, type, no_name_change)
    if not e.__original then e.__original = e:clone() end
    print("ego", ego.__CLASSNAME, ego.name, getmetatable(ego))
    local orig_ego = ego
    ego = ego:clone()
    local newname = e.name
    if not no_name_change then
        local display = ego.display_string or ego.name
        if ego.prefix or ego.display_prefix then newname = display .. e.name
        else newname = e.name .. display end
    end
    print("applying ego", ego.name, "to ", e.name, "::", newname, "///", e.unided_name, ego.unided_name)
    ego.unided_name = nil
    ego.__CLASSNAME = nil
    ego.__ATOMIC = nil
    -- The ego requested instant resolving before merge ?
    if ego.instant_resolve then ego:resolve(nil, nil, e) end
    if ego.instant_resolve == "last" then ego:resolve(nil, true, e) end
    ego.instant_resolve = nil
    -- Void the uid, we dont want to erase the base entity's one
    ego.uid = nil
    ego.rarity = nil
    ego.level_range = nil
    -- Merge according to Object's ego rules.
    table.ruleMergeAppendAdd(e, ego, self.ego_rules[type] or {})

    e.name = newname
    if not ego.fake_ego then
        e.egoed = true
    end
    e.ego_list = e.ego_list or {}
    e.ego_list[#e.ego_list + 1] = {orig_ego, type, no_name_change}
end

-- WARNING the thing may be in need of re-identifying after this
local function reapplyEgos(self, e)
    if not e.__original then return e end
    local brandNew = e.__original -- it will be cloned upon first ego application
    if e.ego_list and #e.ego_list > 0 then
        for _, ego_args in ipairs(e.ego_list) do
            self:applyEgo(brandNew, unpack(ego_args))
        end
    end
    e:replaceWith(brandNew)
end

-- Remove an ego
function _M:removeEgo(e, ego)
    local idx = nil
    for i, v in ipairs(e.ego_list or {}) do
        if v[1] == ego then
            idx = i
        end
    end
    if not idx then return end
    table.remove(e.ego_list, idx)
    reapplyEgos(self, e)
    return ego
end

function _M:getEgoByName(e, ego_name)
    for i, v in ipairs(e.ego_list or {}) do
        if v[1].name == ego_name then return v[1] end
    end
end

function _M:removeEgoByName(e, ego_name)
    for i, v in ipairs(e.ego_list or {}) do
        if v[1].name == ego_name then return self:removeEgo(e, v[1]) end
    end
end

function _M:setEntityEgoList(e, list)
    e.ego_list = table.clone(list)
    reapplyEgos(self, e)
    return e
end

--- Picks and resolve an entity
-- @param level a Level object to generate for
-- @param type one of "object" "terrain" "actor" "trap"
-- @param filter a filter table
-- @param force_level if not nil forces the current level for resolvers to this one
-- @param prob_filter if true a new probability list based on this filter will be generated, ensuring to find objects better but at a slightly slower cost (maybe)
-- @return[1] nil if a filter was given an nothing found
-- @return[2] the fully resolved entity, ready to be used on a level
function _M:makeEntity(level, type, filter, force_level, prob_filter)
	resolvers.current_level = self.base_level + level.level - 1
	if force_level then resolvers.current_level = force_level end

	if prob_filter == nil then prob_filter = util.getval(self.default_prob_filter, self, type) end
	if filter == nil then filter = util.getval(self.default_filter, self, level, type) end
	if filter and self.alter_filter then filter = util.getval(self.alter_filter, self, level, type, filter) end

	local e
	-- No probability list, use the default one and apply filter
	if not prob_filter then
		local list = self:getEntities(level, type)
		local tries = filter and filter.nb_tries or 500
		-- CRUDE ! Brute force ! Make me smarter !
		while tries > 0 do
			e = self:pickEntity(list)
			if e and self:checkFilter(e, filter, type) then break end
			tries = tries - 1
		end
		if tries == 0 then return nil end
	-- Generate a specific probability list, slower to generate but no need to "try and be lucky"
	elseif filter then
		local base_list = nil
		if filter.base_list then
			if _G.type(filter.base_list) == "table" then base_list = filter.base_list
			else
				local _, _, class, file = filter.base_list:find("(.*):(.*)")
				if class and file then
					base_list = require(class):loadList(file)
				end
			end
		elseif type == "actor" then base_list = self.npc_list
		elseif type == "object" then base_list = self.object_list
		elseif type == "trap" then base_list = self.trap_list
		else base_list = self:getEntities(level, type) if not base_list then return nil end end
		local list = self:computeRarities(type, base_list, level, function(e) return self:checkFilter(e, filter, type) end, filter.add_levels, filter.special_rarity)
		e = self:pickEntity(list)
		print("[MAKE ENTITY] prob list generation", e and e.name, "from list size", #list)
		if not e then return nil end
	-- No filter
	else
		local list = self:getEntities(level, type)
		local tries = filter and filter.nb_tries or 50 -- A little crude here too but we only check 50 times, this is simply to prevent duplicate uniques
		while tries > 0 do
			e = self:pickEntity(list)
			if e and self:checkFilter(e, nil, type) then break end
			tries = tries - 1
		end
		if tries == 0 then return nil end
	end

	if filter then e.force_ego = filter.force_ego end
	if filter then e.force_addon = filter.force_addon end

	if filter and self.post_filter then e = util.getval(self.post_filter, self, level, type, e, filter) or e end

	e = self:finishEntity(level, type, e, (filter and filter.ego_filter) or (filter and filter.ego_chance), (filter and filter.add_levels))
	e.__forced_level = filter and filter.add_levels

	return e
end




--new FinishEntity backported from ToME git
--- Finishes generating an entity
function _M:finishEntity(level, type, e, ego_filter, add_levels)
    e = e:clone()
    e:resolve()

	-- Add "addon" properties, always
	if not e.unique and e.addons then
	    local egos_list = {}

	    if not e.force_addon then
	        pick_ego(self, level, e, e.addons, egos_list, type, {}, "addon", nil, add_levels)

	    else
	        --------------------------------------
	        -- Forced ego
	        --------------------------------------

	        local name = e.force_addon
	        if _G.type(name) == "table" then name = rng.table(name) end
	        print("Forcing addon", name)

	        pick_force_ego(self, level, e, e.addons, egos_list, type, {}, "addon", add_levels, name)
	    --    local egos = level:getEntitiesList(type.."/"..e.addons..":addon")
	    --    local egos = level:getEntitiesList(type.."/base/"..e.addons..":")
	    --    egos_list = {egos[name]}
	        e.force_addon = nil
	    end

	    if #egos_list > 0 then
	    --    print("Egos list bigger than 0")
	        for ie, ego in ipairs(egos_list) do
	            self:applyEgo(e, ego, type)
	        end
	        -- Re-resolve with the (possibly) new resolvers
	        e:resolve()
	    end
	    e.addons = nil
	end

    -- Add "ego" properties, sometimes
    if not e.unique and e.egos and (e.force_ego or e.egos_chance) then
        local egos_list = {}

        local ego_chance = 0
        if _G.type(ego_filter) == "number" then ego_chance = ego_filter; ego_filter = nil
        elseif _G.type(ego_filter) == "table" then ego_chance = ego_filter.ego_chance or 0
        else ego_filter = nil
        end

        if not e.force_ego then
            if _G.type(e.egos_chance) == "number" then e.egos_chance = {e.egos_chance} end

            if not ego_filter or not ego_filter.tries then
                --------------------------------------
                -- Natural ego
                --------------------------------------

                -- Pick an ego, then an other and so until we get no more
                local chance_decay = 1
                local picked_etype = {}
                local etype = e.ego_first_type and e.ego_first_type or rng.tableIndex(e.egos_chance, picked_etype)
                local echance = etype and e.egos_chance[etype]
                while etype and rng.percent(util.bound(echance / chance_decay + (ego_chance or 0), 0, 100)) do
                    pick_ego(self, level, e, e.egos, egos_list, type, picked_etype, etype, ego_filter)

                    etype = rng.tableIndex(e.egos_chance, picked_etype)
                    echance = e.egos_chance[etype]
                    if e.egos_chance_decay then chance_decay = chance_decay * e.egos_chance_decay end
                end

            else
                --------------------------------------
                -- Semi Natural ego
                --------------------------------------

                -- Pick an ego, then an other and so until we get no more
                local picked_etype = {}
                for i = 1, #ego_filter.tries do
                    local try = ego_filter.tries[i]

                    local etype = (i == 1 and e.ego_first_type and e.ego_first_type) or rng.tableIndex(e.egos_chance, picked_etype)
--                  forceprint("EGO TRY", i, ":", etype, echance, try)
                    if not etype then break end
                    local echance = etype and try[etype]

                    pick_ego(self, level, e, e.egos, egos_list, type, picked_etype, etype, try)
                end
            end
        else
            --------------------------------------
            -- Forced ego
            --------------------------------------

            local name = e.force_ego
            if _G.type(name) == "table" then name = rng.table(name) end
            print("Forcing ego", name)

			pick_force_ego(self, level, e, e.egos, egos_list, type, {}, "", add_levels, name)

			--    local egos = level:getEntitiesList(type.."/base/"..e.egos..":")
			--    egos_list = {egos[name]}

            e.force_ego = nil
        end

        if #egos_list > 0 then
            for ie, ego in ipairs(egos_list) do
                self:applyEgo(e, ego, type)
            end
            -- Re-resolve with the (possibly) new resolvers
            e:resolve()
        end
        if not ego_filter or not ego_filter.keep_egos then
            e.egos = nil e.egos_chance = nil e.force_ego = nil
        end
    end

    -- Generate a stack ?
    if e.generate_stack then
        local s = {}
        while e.generate_stack > 0 do
            s[#s+1] = e:clone()
            e.generate_stack = e.generate_stack - 1
        end
        for i = 1, #s do e:stack(s[i], true) end
    end

    e:resolve(nil, true)
    e:check("finish", e, self, level)
    return e
end


--move the connectivity check earlier compared to T-Engine 1.2.3 to save on log clutter & load times
function _M:newLevel(level_data, lev, old_lev, game)
    local map = self.map_class.new(level_data.width, level_data.height)
    map.updateMap = function() end
    if level_data.all_lited then map:liteAll(0, 0, map.w, map.h) end
    if level_data.all_remembered then map:rememberAll(0, 0, map.w, map.h) end

    -- Setup the entities list
    local level = self.level_class.new(lev, map)
    level:setEntitiesList("actor", self:computeRarities("actor", self.npc_list, level, nil))
    level:setEntitiesList("object", self:computeRarities("object", self.object_list, level, nil))
    level:setEntitiesList("trap", self:computeRarities("trap", self.trap_list, level, nil))

    -- Save level data
    level.data = level_data or {}
    level.id = self.short_name.."-"..lev

    -- Setup the level in the game
    game:setLevel(level)

    -- Generate the map
    local generator = self:getGenerator("map", level, level_data.generator.map)
    local ux, uy, dx, dy, spots = generator:generate(lev, old_lev)
    spots = spots or {}

    for i = 1, #spots do print("[NEW LEVEL] spot", spots[i].x, spots[i].y, spots[i].type, spots[i].subtype) end

    level.default_up = {x=ux, y=uy}
    level.default_down = {x=dx, y=dy}
    level.spots = spots

    -- Call a map finisher
    if level_data.post_process_map then
        level_data.post_process_map(level, self)
        if level.force_recreate then
            level:removed()
            return self:newLevel(level_data, lev, old_lev, game)
        end
    end


     -- Check for connectivity from entrance to exit
    local a = Astar.new(map, game:getPlayer())
    if not level_data.no_level_connectivity then
        print("[LEVEL GENERATION] checking entrance to exit A*", ux, uy, "to", dx, dy)
        if ux and uy and dx and dy and (ux ~= dx or uy ~= dy)  and not a:calc(ux, uy, dx, dy) then
            forceprint("Level unconnected, no way from entrance to exit", ux, uy, "to", dx, dy)
            level:removed()
            return self:newLevel(level_data, lev, old_lev, game)
        end
    end
    for i = 1, #spots do
        local spot = spots[i]
        if spot.check_connectivity then
            local cx, cy
            if type(spot.check_connectivity) == "string" and spot.check_connectivity == "entrance" then cx, cy = ux, uy
            elseif type(spot.check_connectivity) == "string" and spot.check_connectivity == "exit" then cx, cy = dx, dy
            else cx, cy = spot.check_connectivity.x, spot.check_connectivity.y
            end

            print("[LEVEL GENERATION] checking A*", spot.x, spot.y, "to", cx, cy)
            if spot.x and spot.y and cx and cy and (spot.x ~= cx or spot.y ~= cy) and not a:calc(spot.x, spot.y, cx, cy) then
                forceprint("Level unconnected, no way from", spot.x, spot.y, "to", cx, cy)
                level:removed()
                return self:newLevel(level_data, lev, old_lev, game)
            end
        end
    end

    -- Add the entities we are told to
    for i = 0, map.w - 1 do for j = 0, map.h - 1 do
        if map.room_map[i] and map.room_map[i][j] and map.room_map[i][j].add_entities then
            for z = 1, #map.room_map[i][j].add_entities do
                local ae = map.room_map[i][j].add_entities[z]
                self:addEntity(level, ae[2], ae[1], i, j, true)
            end
        end
    end end

    -- Now update it all in one go (faster than letter the generators do it since they usualy overlay multiple terrains)
    map.updateMap = nil
    map:redisplay()

    -- Generate actors
    if level_data.generator.actor and level_data.generator.actor.class then
        local generator = self:getGenerator("actor", level, spots)
        generator:generate()
    end

    -- Generate objects
    if level_data.generator.object and level_data.generator.object.class then
        local generator = self:getGenerator("object", level, spots)
        generator:generate()
    end

    -- Generate traps
    if level_data.generator.trap and level_data.generator.trap.class then
        local generator = self:getGenerator("trap", level, spots)
        generator:generate()
    end

    -- Adjust shown & obscure colors
    if level_data.color_shown then map:setShown(unpack(level_data.color_shown)) end
    if level_data.color_obscure then map:setObscure(unpack(level_data.color_obscure)) end

    -- Call a finisher
    if level_data.post_process then
        level_data.post_process(level, self)
        if level.force_recreate then
            level:removed()
            return self:newLevel(level_data, lev, old_lev, game)
        end
    end

    -- Delete the room_map, now useless
    map.room_map = nil

    --Check for spots connectivity again for spots added in post_process
    for i = 1, #spots do
        local spot = spots[i]
        if spot.check_connectivity then
            local cx, cy
            if type(spot.check_connectivity) == "string" and spot.check_connectivity == "entrance" then cx, cy = ux, uy
            elseif type(spot.check_connectivity) == "string" and spot.check_connectivity == "exit" then cx, cy = dx, dy
            else cx, cy = spot.check_connectivity.x, spot.check_connectivity.y
            end

            print("[LEVEL GENERATION] checking A*", spot.x, spot.y, "to", cx, cy)
            if spot.x and spot.y and cx and cy and (spot.x ~= cx or spot.y ~= cy) and not a:calc(spot.x, spot.y, cx, cy) then
                forceprint("Level unconnected, no way from", spot.x, spot.y, "to", cx, cy)
                level:removed()
                return self:newLevel(level_data, lev, old_lev, game)
            end
        end
    end


    return level
end
