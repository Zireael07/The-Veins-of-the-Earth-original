-- Veins of the Earth
-- Zireael 2016
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
	name = "Vatic Wastes", --Theyra frontier area
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
		-- put exit to Veins
	--[[	local l1 = game.zone:makeEntityByName(level, "terrain", "DOWN_START")

		if l1 then
			local x, y = game.level.default_up.x, game.level.default_up.y
			game.zone:addEntity(level, l1, "terrain", x, y)
			level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-change", subtype="small_tunnels"}
			print("Placed dungeon entrance", l1.change_zone, x, y)
		else
		print("Starting area entrance not found")
		end
]]
	end,

	--For the worldmap to work properly
--[[ 	entry_point = function(_, _, from_zone)
   if not from_zone then
      return nil
  	elseif from_zone.name == "Tunnels" then
	  return game.level:pickSpot{ type="zone-change", subtype="tunnels" }

    else
      return nil
    end
  end,]]
  	on_enter = function()
  		--finish main quest
  		game.player:setQuestStatus("main_quest", engine.Quest.COMPLETED)
  		--show victory dialog
		game:registerDialog(require("mod.dialogs.VictoryDialog").new())
	end
}
