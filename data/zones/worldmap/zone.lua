-- Veins of the Earth
-- Zireael 2014
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
local Map = require "engine.Map"


return {
	name = "Veins of the Earth",
	level_range = {1, 1},
	max_level = 1,
	width = 50, height = 50,
	all_lited = true,
	persistent = "zone",
	worldmap = true,
	generator =  {
		map = {
			class = "mod.class.generator.map.RandomWorldmap",
			down = "DOWN",
			wall = "WALL",
			floor = "FLOOR",
		},
	},

	post_process = function(level)
		-- put starting dungeon entrance
		local l1 = game.zone:makeEntityByName(level, "terrain", "DOWN_TUNNELS")

		if l1 then
			local x, y = game.level.default_up.x, game.level.default_up.y
			game.zone:addEntity(level, l1, "terrain", x, y)
			level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-change", subtype="tunnels"}
			print("Placed dungeon entrance", l1.change_zone, x, y)
		else
		print("Tunnels entrance not found")	
		end

		--put other dungeon entrances
		game:placeDungeonEntrance("DOWN_CAVERN")

		game:placeDungeonEntrance("DOWN_ARENA")

		game:placeDungeonEntrance("DOWN_COMPOUND")

		game:placeDungeonEntrance("DOWN_LABIRYNTH")


	--[[	local l2 = game.zone:makeEntityByName(level, "terrain", "DOWN_CAVERN")

		if l2 then
			local x, y = rng.range(2, (game.level.map.w/2)-1), rng.range(2, (game.level.map.h/2)-1)

			local tries = 0
			while (game.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or game.level.map(x, y, Map.OBJECT) or game.level.map.room_map[x][y].special) and tries < 100 do
				x, y = rng.range(2, (game.level.map.w/2)-1), rng.range(2, (game.level.map.h/2)-1)
				tries = tries + 1
			end
			if tries < 100 then
				game.zone:addEntity(level, l2, "terrain", x, y)
				level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-change", subtype="cavern"}
				print("Placed dungeon entrance", l2.change_zone, x, y)
			else
				level.force_recreate = true
			end
		else
			print("Cavern entrance not found")
		end]]


	end,

	--For the worldmap to work properly
	entry_point = function(_, _, from_zone)
    if not from_zone then
      return nil
    elseif from_zone.name == "Tunnels" then 
      return game.level:pickSpot{ type="zone-change", subtype="tunnels" }
    elseif from_zone.name == "Cavern" then
      return game.level:pickSpot{ type="zone-change", subtype="cavern" }
    elseif from_zone.name == "Arena" then
      return game.level:pickSpot{ type="zone-change", subtype="arena" }
    elseif from_zone.name == "Compound" then
      return game.level:pickSpot{ type="zone-change", subtype="compound" }
    elseif from_zone.name == "Labirynth" then
      return game.level:pickSpot{ type="zone-change", subtype="labirynth" }
    else
      return nil
    end
  end,
}
