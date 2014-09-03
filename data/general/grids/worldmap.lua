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

--Worldmap tiles

newEntity{
	define_as = "DOWN",
	type = "floor", subtype = "floor",
	name = "dungeon entrance",
	image = "tiles/newtiles/worldmap_stairs_down.png",
	display = '>', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
--	change_level=1,
}

newEntity{
	base = "DOWN",
	define_as = "DOWN_TUNNELS",
	spot = "tunnels",
	change_zone = "tunnels",
	change_level = 1,
}

newEntity{
	base = "DOWN",
	define_as = "DOWN_CAVERN",
	spot = "cavern",
	change_zone = "cavern",
	change_level = 1,
}

newEntity{
	base = "DOWN",
	define_as = "DOWN_COMPOUND",
	change_zone = "compound",
	spot = "compound",
	change_level = 1,
}

newEntity{
	base = "DOWN",
	define_as = "DOWN_LABIRYNTH",
	change_zone = "labirynth",
	spot = "labirynth",
	change_level = 1,
}

newEntity{
	base = "DOWN",
	define_as = "DOWN_ARENA",
	change_zone = "arena",
	spot = "arena",
	change_level = 1,
}


--Other grids
newEntity{
	define_as = "FLOOR",
	type = "floor", subtype = "floor",
	name = "floor", image = "tiles/floor.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "WALL",
	type = "wall", subtype = "wall",
	name = "wall", image = "tiles/wall.png",
	display = '#', color=colors.BLACK, back_color={r=30, g=30, b=60},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
}