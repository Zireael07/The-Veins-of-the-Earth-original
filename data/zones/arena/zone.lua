-- Veins of the Earth
-- Zireael 2013-2014
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

local ActorRandom = require 'engine.generator.actor.Random'

return {
	name = "Arena",
	level_range = {1, 1},
	max_level = 1,
	width = 20, height = 20,
	all_remembered = true,
	all_lited = true,
--	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Static",
			map = "zones/arena",
		--	zoom = 5,
		},
		actor = { },
		--object = { },
		--trap = { },

	},

	post_process = function(level)
		level.turn_counter = 0
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

	end,

	on_turn = function(self)
		if not game.level.turn_counter then return end
		game.level.turn_counter = game.level.turn_counter + 1

		ActorRandom:generateOne()

	--[[	--paranoia alert
		if not game.level.level.turn_counter or game.level.turn_counter < 0 then game.level.turn_counter = 0 end
		--count turns
		game.level.turn_counter = game.level.turn_counter + 1
		if game.level.turn_counter % 10 = 0 then
		--	ActorRandom:generateOne()
		end]]
	end,

}
