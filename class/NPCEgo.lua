--Veins of the Earth
--Zireael 2016

--based on Zizzo's ToME 2 port

require 'engine.class'
local Entity = require 'engine.Entity'
local Tiles = require 'engine.Tiles'
local Zone = require 'mod.class.Zone'

module(..., package.seeall, class.inherit(Entity))

_M.egos_def = {}

--We're duplicating some of the T-Engine Zone code to achieve same results
function _M:okToGenerate(e)
    return e[rarity_field] and e.level_range
--    return e[rarity_field] and e.level_range and e.level_range[1] <= game.level.level
end

function _M:checkRarity(list, filter)
    local lev = game.level.level
    rarity_field = rarity_field or "rarity"
    local r = { total=0 }

    for i, e in ipairs(list) do
        if e[rarity_field] and e.level_range and (not filter or filter(e)) then
            if self:okToGenerate(e) then
                local max = 10000
                local genprob = math.floor(max / e[rarity_field])
                print(("Entity(%30s) got %3d (=%3d / %3d) chance to generate. Level range(%2d-%2s), current %2d"):format(e.name, math.floor(genprob), math.floor(max), e[rarity_field], e.level_range[1], e.level_range[2] or "--", lev))

                if genprob > 0 then
                    r.total = r.total + genprob
                    r[#r+1] = { e=e, genprob=r.total, level_diff = lev - game.level.level }
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

function _M:pickEgo(m, list, egos_list, picked_etype, etype)
    picked_etype[etype] = true
    if _G.type(etype) == "number" then etype = "" end

    --here we do our own filtering
--    list = self:okEgo(m, list)

    egos = self:checkRarity(list, etype ~= "" and function(e) return e[etype] end or nil)

    egos_list[#egos_list+1] = Zone:pickEntity(egos)

    if egos_list[#egos_list] then print("Picked ego :=>", egos_list[#egos_list].name) else print("Picked ego :=>", #egos_list) end
end

function _M:tryAddEgo(m)
    -- No ego uniques, thanks...
    if m.unique then return end
    --Don't burp if we don't have npc_egos listed
    if not m.npc_egos then return end

    self.egos_def = self:loadList(m.npc_egos, true)

    --ToME 4 code
    local egos_list = {}
    local ego_chance = 0
    if _G.type(m.egos_chance) == "number" then m.egos_chance = {m.egos_chance} end
    -- Pick an ego, then an other and so until we get no more
    local chance_decay = 1
    local picked_etype = {}
    local etype = rng.tableIndex(m.egos_chance, picked_etype)
    local echance = etype and m.egos_chance[etype]
    while etype and rng.percent(util.bound(echance / chance_decay + (ego_chance or 0), 0, 100)) do
        local ego = self.egos_def
        self:pickEgo(m, ego, egos_list, picked_etype, etype)

        etype = rng.tableIndex(m.egos_chance, picked_etype)
        echance = m.egos_chance[etype]
        if m.egos_chance_decay then chance_decay = chance_decay * m.egos_chance_decay end
    end

    --apply (ToME 4 code)
    if #egos_list > 0 then
        for ie, ego in ipairs(egos_list) do
            Zone:applyEgo(m, ego)
        end
        -- Re-resolve with the (possibly) new resolvers
        m:resolve()
    end
    m.npc_egos = nil m.egos_chance = nil
end
