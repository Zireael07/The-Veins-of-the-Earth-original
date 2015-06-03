-- Veins of the Earth
-- Zireael 2015
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
	name = "Bank",
	level_range = {1, 1},
	max_level = 1,
	width = 20, height = 20,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	load_tips = {
{ text = [[Want your kids to have something? Leave the money in a bank.]] },
{ text = [[Leave the money in a bank if you don't want it to get stolen.]] },
{ text = [[The bankers take a cut for storing your monies.]]},
{ text = [[The bank is heavily warded, to ensure your funds are safe.]]},
},
	generator =  {
		map = {
			class = "engine.generator.map.Static",
			map = "zones/bank",
		--	zoom = 5,
		},
		actor = { },
		--object = { },
		--trap = { },

	},

	post_process = function(level)
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

	end,
}
