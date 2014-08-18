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
	name = "Xorn Lair",
	level_range = {1, 1},
	max_level = 10,
--	decay = {300, 800},
	width = 80, height = 80,
	persistent = "zone",
	no_level_connectivity = true,
	no_autoexplore = true,
	generator =  {
		map = {
			class = "mod.class.generator.map.Roomer",
		--	class = "engine.generator.map.Roomer",
			no_tunnels = true,
			nb_rooms = 10,
			lite_room_chance = 0,
		--	rooms = {"simple"},
			rooms = {"forest_clearing"},
			['.'] = "FLOOR",
			['#'] = "WALL",
			up = "UP",
			down = "DOWN",
			door = "DOOR",
			nb_rooms = 10,
		},
		actor = {
		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.XornTunnelers",
			nb_npc = {10, 20},
			-- Number of tunnelers + 2 (one per stair)
			nb_tunnelers = 7,
		},
		object = {
            class = "engine.generator.object.Random",
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
