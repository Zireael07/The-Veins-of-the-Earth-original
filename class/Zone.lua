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

require "engine.class"
local Zone = require "engine.Zone"
local Map = require "engine.Map"

local Astar = require "engine.Astar"
local forceprint = print
local print = function() end

module(..., package.seeall, class.inherit(Zone))

--- Called when the zone file is loaded
function _M:onLoadZoneFile(basedir)
	-- Load events if they exist
	if fs.exists(basedir.."events.lua") then
		local f = loadfile(basedir.."events.lua")
		setfenv(f, setmetatable({self=self}, {__index=_G}))
		self.events = f()
	end
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
--          print("computing rarity of", e.name)

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
    --    return e[rarity_field] and e.challenge <= level.level + 5 and (not filter or filter(e))

    elseif type == 'object' then
        return e[rarity_field] and e.level_range and (not filter or filter(e))
    else
    -- From the original Zone:computeRarities()
    return e[rarity_field] and e.level_range and (not filter or filter(e))
  end

end

--- Checks an entity against a filter
function _M:checkFilter(e, filter, type)
    if e.unique and game.uniques[e.__CLASSNAME.."/"..e.unique] then print("refused unique", e.name, e.__CLASSNAME.."/"..e.unique) return false end

    if not filter then return true end
    if filter.ignore and self:checkFilter(e, filter.ignore, type) then return false end

    print("Checking filter", filter.type, filter.subtype, "::", e.type,e.subtype,e.name)
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
        if filter.max_cr and e.challenge >= (base_level or 0) + game.level.level + filter.max_cr then print("Refused max_cr", e.name, e.challenge) return false end
    end

    return true
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
