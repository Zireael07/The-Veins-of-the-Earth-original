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
        for i = 1, #filter.not_properties do if e[filter.not_properties[i]] then return false end end
    end
    if e.checkFilter and not e:checkFilter(filter) then return false end
    if filter.special and not filter.special(e) then return false end
    if self.check_filter and not self:check_filter(e, filter, type) then return false end
    if filter.max_ood and resolvers.current_level and e.level_range and resolvers.current_level + filter.max_ood < e.level_range[1] then print("Refused max_ood", e.name, e.level_range[1]) return false end

    if e.unique then print("accepted unique", e.name, e.__CLASSNAME.."/"..e.unique) end

    --New filters
    if type == "actor" then
    --    if filter.challenge and (filter.challenge >= e.challenge or filter.challenge <= e.challenge) then return false end
        if filter.max_cr and e.challenge >= (base_level or 0) + game.level.level + filter.max_cr then return false end
    end

    return true
end