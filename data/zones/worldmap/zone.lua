-- Veins of the Earth
-- Zireael 2014-2015
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
	worldmap_see_radius = 4,
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
		local l1 = game.zone:makeEntityByName(level, "terrain", "DOWN_START")

		if l1 then
			local x, y = game.level.default_up.x, game.level.default_up.y
			game.zone:addEntity(level, l1, "terrain", x, y)
			level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-change", subtype="small_tunnels"}
			print("Placed dungeon entrance", l1.change_zone, x, y)
		else
		print("Starting area entrance not found")
		end

		--put other dungeon entrances
		local to_place = {
			--debug
			"DOWN_ARENA",
			--various generators
			"DOWN_TUNNELS", "DOWN_CAVERN", "DOWN_COMPOUND", "DOWN_LABIRYNTH",
			--tree/fungi
			"DOWN_GROVE", "DOWN_FOREST", "DOWN_MAZE",
			--city
			"DOWN_DROWCITY", "DOWN_DROWOUTPOST", "DOWN_DROWMETROPOLIS", "DOWN_RUINS",
			--special
			"DOWN_TOWER",
			--endgame
			"DOWN_ELVEN"
	 	}

		game:placeWorldmapEntrances(to_place)

	end,

	--For the worldmap to work properly
	entry_point = function(_, _, from_zone)
    if not from_zone then
      return nil
  	elseif from_zone.name == "Small tunnels" then
      return game.level:pickSpot{ type="zone-change", subtype="small_tunnels" }
  elseif from_zone.name == "Tunnels" then
	  return game.level:pickSpot{ type="zone-change", subtype="tunnels" }
  	elseif from_zone.name == "Drow City" then
		return game.level:pickSpot{ type="zone-change", subtype="drow_city" }
	elseif from_zone.name == "Drow Outpost" then
		return game.level:pickSpot{ type="zone-change", subtype="drow_outpost" }
	elseif from_zone.name == "Drow Metropolis" then
		return game.level:pickSpot{ type="zone-change", subtype="drow_metropolis" }
	elseif from_zone.name == "Town" then
		return game.level:pickSpot{ type="zone-change", subtype="town" }
	elseif from_zone.name == "Cave Grove" then
		return game.level:pickSpot{ type="zone-change", subtype="grove" }
	elseif from_zone.name == "Fungi Maze" then
		return game.level:pickSpot{ type="zone-change", subtype="fungi_maze" }
	elseif from_zone.name == "Fungi Forest" then
		return game.level:pickSpot{ type="zone-change", subtype="forest" }
    elseif from_zone.name == "Cavern" then
      return game.level:pickSpot{ type="zone-change", subtype="cavern" }
    elseif from_zone.name == "Arena" then
      return game.level:pickSpot{ type="zone-change", subtype="arena" }
    elseif from_zone.name == "Compound" then
      return game.level:pickSpot{ type="zone-change", subtype="compound" }
    elseif from_zone.name == "Labirynth" then
      return game.level:pickSpot{ type="zone-change", subtype="labirynth" }
    elseif from_zone.name == "Wizard Tower" then
	  return game.level:pickSpot{ type="zone-change", subtype="tower" }
    elseif from_zone.name == "Elven Outpost" then
	  return game.level:pickSpot{ type="zone-change", subtype="elven" }
    else
      return nil
    end
  end,
}
