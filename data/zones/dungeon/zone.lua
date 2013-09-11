-- Veins of the Earth
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it wil_l be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

return {
	name = "Upperdark",
	level_range = {1, 1},
	max_level = 1000,
	decay = {300, 800},
	width = 50, height = 50,
--	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Roomer",
			nb_rooms = 10,
			rooms = { {"simple", 5}, {"circle", 5}, {"circle2", 5}, {"circle3", 5}, {"pilar", 10}, {"pilar2", 10}, {"pilar3", 10}, {"pilar4", 10}, {"rhomboid", 3}, {"rhomboid2", 3}, {"chasm1", 2}, {"chasm2", 2}, {"chasm3", 2}, {"big_moss1", 20}, {"big_moss2", 20}, {"moss_patch1", 30}, {"moss_patch2", 30}, {"moss_pilar1", 40}, {"moss_pilar2", 40}, {"moss_pilar3", 40}, {"lavafilled_pilar", 2}, {"waterfilled_pilar", 7}, {"waterfilled", 1}, {"waterfilled2", 1}, {"waterfilled3", 1}, {"waterfilled4", 1}, {"waterfilled_half", 5}, {"waterfilled_half2", 5} },
			lite_room_chance = 0,
			door_chance = 1,
			tunnel_change = 80,
			tunnel_random = 70,
			['.'] = "FLOOR",
	--		['.'] = { "FLOOR", "MOSS", "CHASM", "WATER", }
			['#'] = "WALL",
			up = "UP",
			down = "DOWN",
			door = "DOOR",
			['m'] = "MOSS",
			['x'] = "CHASM",
			['~'] = { "WATER", "WATER_DEEP" },
			['l'] = "LAVA",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {5, 10},
		},
		object = {
            class = "engine.generator.object.Random",
            nb_object = {20, 30},
        },
	},
	levels =
	{
		[1] = { 
		generator = { map = { 
		up = "FLOOR",
		},},
	},
	},
}
