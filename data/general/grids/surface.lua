-- Veins of the Earth
-- Zireael 2016
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

--Surface map tiles

newEntity{
	define_as = "DOWN",
	type = "floor", subtype = "floor",
	name = "dungeon entrance",
	image = "tiles/terrain/entrance.png",
	display = '>', color=colors.DARK_GREY, back_color=colors.DARK_GREEN,
	notice = true,
	always_remember = true,
--	change_level=1,
}

--Other grids
newEntity{
	define_as = "FLOOR",
	type = "floor", subtype = "floor",
	name = "grass", image = "tiles/terrain/grass.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "WALL",
	type = "wall", subtype = "wall",
	name = "mountain", image = "tiles/terrain/mountain.png",
	display = '#', color=colors.WHITE, back_color=colors.DARK_GREEN,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
}
