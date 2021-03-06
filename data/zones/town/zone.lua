-- Veins of the Earth
-- Zireael 2014
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

return {
	name = "Town",
	level_range = {1, 1},
	max_level = 1,
--	decay = {300, 800},
	width = 70, height = 70,
--	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Town",
			building_chance = 70,
			max_building_w = 8, max_building_h = 8,
			edge_entrances = {6,4},
			floor = "FLOOR",
			external_floor = "FLOOR",
			wall = "WALL",
			up = {"UP", "SHAFT_UP"},
			down = { "DOWN", "SHAFT_DOWN" },
			door = "DOOR",

			nb_rooms = false,
			rooms = false,
		},
		actor = {
		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.Random",
			nb_npc = {10, 20},
		--[[	class = "mod.class.generator.actor.OnSpots",
				nb_spots = 2, on_spot_chance = 75,]]
		},
		object = {
            class = "mod.class.generator.object.Random",
            nb_object = {20, 30},
        },
	},
	levels =
	{
	--Place exit to worldmap on level 1
		[1] = {
		generator = { map = {
		up = "EXIT",
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

	end,
}
