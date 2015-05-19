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

newEntity{
	define_as = "EXIT",
	type = "floor", subtype = "portal",
	name = "portal",
--	image = "tiles/new/worldmap_stairs_up.png",
	display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	change_zone = "tunnels", --temp
}


newEntity{
	define_as = "FLOOR",
	type = "floor", subtype = "floor",
	name = "floor", image = "tiles/terrain/floor.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "WALL",
	type = "wall", subtype = "wall",
	name = "wall", image = "tiles/terrain/wall.png",
	display = '#', color=colors.BLACK, back_color={r=30, g=30, b=60},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
--	air_level = -20,
--	dig = "FLOOR",
}

--Planar tiles
newEntity{
    base = "FLOOR",
    define_as = "FIRE_FLOOR",
    name = "fire", image = "tiles/UT/fire_floor.png",
    color_r=255, color_g=115, color_b=0, back_color=colors.FIREBRICK,
}

newEntity{
	base = "FLOOR",
	define_as = "WATER_FLOOR",
	name = "water", image = "tiles/UT/water_floor.png",
	display = "~", color=colors.AQUAMARINE, back_color=colors.ROYAL_BLUE,
	change_level = 1,
}

newEntity{
	base = "FLOOR",
	define_as = "AIR_FLOOR",
	name = "air", image = "tiles/UT/air_floor.png",
	color=colors.WHITE, back_color=colors.WHITE,
	change_level = 1,
}

newEntity{
	base = "FLOOR",
	define_as = "EARTH_FLOOR",
	name = "earth", image = "tiles/UT/earth.png",
	color=colors.SLATE, back_color=colors.UMBER,
}

newEntity{
	base = "WALL",
	define_as = "FIRE_WALL",
	name = "fire wall", image = "tiles/new/fire_wall.png",
	color_r=255, color_g=115, color_b=0, back_color=colors.DARK_RED,
}

newEntity{
	base = "WALL",
	define_as = "WATER_WALL",
	name = "water wall", image = "tiles/new/water_wall.png",
	display = "~", color=colors.DARK_BLUE, back_color=colors.ROYAL_BLUE,
}

newEntity{
	base = "WALL",
	define_as = "AIR_WALL",
	name = "cloud", image = "tiles/UT/air_wall.png",
	display = ' ', color=colors.SLATE, back_color=colors.SLATE,
	block_sight = false,
}

newEntity{
	base = "WALL",
	define_as = "EARTH_WALL",
	name = "earth wall", image = "tiles/UT/earth_wall.png",
	color=colors.CHOCOLATE, back_color=colors.UMBER,
}
