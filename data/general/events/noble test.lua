-- Veins of the Earth
-- Copyright (C) 2016 Zireael
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
-- Based on ToME 4

-- Find a random spot
local x, y = game.state:findEventGrid(level)
if not x then return false end

local id = "noble-house-special" --..game.turn

local changer = function(id)
    local houses = { "baenre", "armgo", "tlabbar", "mizzrym", "nasadra", "auvryndar", "aleanrahel" }
    local pick = rng.tableRemove(houses)
    local short_name = pick.."-noble-compound"

    local name = pick:capitalize().." House Compound"
    game.log("Zone name is: "..name)

    local npcs = mod.class.NPC:loadList{"/data/general/npcs/townies_drow.lua"}
    local objects = mod.class.Object:loadList("/data/zones/noble-compound/objects.lua")
    local terrains = mod.class.Grid:loadList("/data/general/grids/drow.lua")
    local zone = mod.class.Zone.new(id, {
        --name = "House Compound",
        name = name,
        level_range = {1,1}, 
        level_scheme = "player",
        max_level = 1,
        width = 20, height = 20,
        reload_lists = false,
        persistent = "zone",
        generator =  {
            map = {
            class = "engine.generator.map.Building",
            max_block_w = 15, max_block_h = 15,
            max_building_w = 5, max_building_h = 5,

            floor = "FLOOR_BUILDING",
            external_floor = "FLOOR",
            wall = "WALL_NOBLE",
            up = "EXIT_TOWN",
            down = "DOWN",
            door = "DOOR",

            nb_rooms = false,
            rooms = false,
        },
            actor = {
                class = "mod.class.generator.actor.Random",
                nb_npc = {14, 14},
            },
            object = {
                class = "engine.generator.object.Random",
                filters = {{type="gem"}},
                nb_object = {6, 9},
            },
            --[[trap = {
                class = "engine.generator.trap.Random",
                nb_trap = {6, 9},
            },]]
        },
        npc_list = npcs,
        grid_list = terrains,
        object_list = objects,
        trap_list = mod.class.Trap:loadList("/data/zones/noble-compound/traps.lua"),
    })
    return zone
end

local g = game.level.map(x, y, engine.Map.TERRAIN):cloneFull()
g.name = "noble compound"
g.display='>' g.color_r=0 g.color_g=0 g.color_b=255 g.notice = true
g.image = "tiles/terrain/stairs_up.png"
g.change_level=1 
g.change_zone = id
g:removeAllMOs()
g.real_change = changer
g.change_level_check = function(self)
    game:changeLevel(1, self.real_change(self.change_zone))
    self.change_level_check = nil
    self.real_change = nil
    return true
end
game.zone:addEntity(game.level, g, "terrain", x, y)

return true
