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
		--paranoia alert
	--	if game.level.turn_counter < 0 then game.level.turn_counter == 0 end

		game.level.turn_counter = game.level.turn_counter + 1

		--Every 5 player turns
		if game.level.turn_counter % 50 == 0 then
			
		--generate an opponent
		local m = game.zone:makeEntity(game.level, "actor", f, nil, true)
		if m then
		local x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
		local tries = 0
		--	while (not m:canMove(x, y) or (game.level.map.room_map[x][y] and game.level.map.room_map[x][y].special)) and tries < 100 do
			while not m:canMove(x,y) and tries < 100 do
				x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
				tries = tries + 1
			end
			if tries < 100 then
			game.zone:addEntity(game.level, m, "actor", x, y)
		--	if self.post_generation then self.post_generation(m) end
			end
		end


		end

	end,
}
