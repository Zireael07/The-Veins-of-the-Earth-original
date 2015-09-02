-- Veins of the Earth
-- Copyright (C) 2015 Zireael
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
	name = "Flooded cavern",
	level_range = {1, 1},
	max_level = 200,
	decay = {300, 800},
	width = 50, height = 50,
--	persistent = "zone",
	generator =  {
		map = {
			class = "mod.class.generator.map.CavernAlternate",
			edge_entrances = {4,6},
			zoom = 10,
			hurst = 0.2,
			alt_chance = 80,
			min_floor = 200,
			floor = "FLOOR",
			wall = "WALL",
			up = "FLOOR",
			down = "DOWN",
			floor_alt = "WATER",
		},
		actor = {
			class = "mod.class.generator.actor.Random",
			nb_npc = {15, 25},
			--max cr filter is added to dlvl
			--NOTE: critters (especially humanoid) might have higher CR due to resolvers
			filters = {{max_cr=4}},
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
	},

	post_process = function(level)
		if level.level == 5 then world:gainAchievement("A dark start", game.player)
		elseif level.level == 10 then world:gainAchievement("Deeper and deeper", game.player)
		elseif level.level == 20 then world:gainAchievement("It's scary down there", game.player)
		end
	end
}
