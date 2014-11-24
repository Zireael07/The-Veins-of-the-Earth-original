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
	name = "Drow City",
	level_range = {1, 1},
	max_level = 1,
--	decay = {300, 800},
	width = 70, height = 70,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Town",
			building_chance = 80,
			max_building_w = 8, max_building_h = 8,
			edge_entrances = {6,4},
			floor = "FLOOR",
			external_floor = "FLOOR",
			wall = "WALL",
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

		game:placeTerrainMulti("FAERIE_TORCH", 10)

		local spot = game.level:pickSpot{type="building", subtype="building"}
		local g = game.zone:makeEntityByName(game.level, "terrain", "NOBLE_ENTRANCE")
		game.zone:addEntity(game.level, g, "terrain", spot.x, spot.y)
		level.spots[#level.spots+1] = {x=spot.x, y=spot.y, type="zone-change", subtype="noble house"}

	end,

	--Exiting buildings should now work
	entry_point = function(_, _, from_zone)
		if not from_zone then
      		return nil
    	elseif from_zone.name == "Drow Noble House" then 
      		return game.level:pickSpot{ type="zone-change", subtype="noble house" }
      	else
      		return nil
      	end
	end,
}
