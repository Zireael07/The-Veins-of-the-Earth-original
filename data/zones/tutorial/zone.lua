-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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
	name = "Tutorial",
	level_range = {1, 1},
	level_scheme = "player",
	max_level = 3,
	decay = {300, 800},
--	actor_adjust_level = function(zone, level, e) return zone.base_level + e:getRankLevelAdjust() end,
	width = 50, height = 50,
--	all_remembered = true,
	all_lited = true,
	persistent = "zone",
--	ambient_music = "Woods of Eremae.ogg",
	no_level_connectivity = true,
	no_worldport = true,
	generator =  {
		map = {
			class = "engine.generator.map.Static",
		},
		actor = {
			class = "mod.class.generator.actor.Random",
			nb_npc = {0, 0},
--			guardian = "LONE_WOLF",
		},
		object = {
			class = "engine.generator.object.Random",
			nb_object = {0, 0},
		},
		trap = {
			class = "engine.generator.trap.Random",
			nb_trap = {0, 0},
		},
	},
	levels =
	{
		[1] = {
			generator = { map = { map = "tutorial/tutorial1" }, },
		},
	},
}
