-- Veins of the Earth
-- Zireael 2014-2015
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

local houses = { "baenre", "armgo", "tlabbar", "mizzrym", "nasadra", "auvryndar", "aleanrahel" }
local pick = rng.tableRemove(houses)

return {
--	name = "Drow Noble House",

	name = "House "..pick:capitalize().." Compound",
	level_range = {1, 1},
	max_level = 1,
--	decay = {300, 800},
	width = 70, height = 70,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Building",
			max_block_w = 15, max_block_h = 15,
			max_building_w = 5, max_building_h = 5,

			floor = "FLOOR_BUILDING",
			external_floor = "FLOOR",
			wall = "WALL_NOBLE",
			up = "UP",
			down = "DOWN",
			door = "DOOR",

			nb_rooms = false,
			rooms = false,
		},
		actor = {
			class = "mod.class.generator.actor.OnSpots",
			nb_npc = {20, 30},
			nb_spots = 5, on_spot_chance = 75,
		},
		object = {
            class = "mod.class.generator.object.Random",
            nb_object = {10, 20},
        },
	},
	levels =
	{
	--Place exit to town on level 1
		[1] = {
		generator = { map = {
		up = "EXIT_TOWN",
		},},
	},
	--No shaft up on level 2
		[2] = {
		generator = { map = {
		up = "UP",
		},},
	},

	},

	post_process = function(level)
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

		game:placeTerrainMulti("FAERIE_TORCH", 10)

--		game:placeTerrain("FAERIE_TORCH")
		local pick = "baenre"
		local name = game.zone.name
		local split = name:split(' ')
		if split[2] then
			pick = split[2]:uncapitalize()
			game.log("Split zone name "..pick)
		end

		for uid, e in pairs(level.entities) do e.faction = pick end

	end,
}
