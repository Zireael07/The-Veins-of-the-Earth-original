-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael
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


--Worldmap exit
newEntity{
	define_as = "EXIT",
	type = "floor", subtype = "floor",
	name = "exit to worldmap",
	image = "tiles/new/worldmap_stairs_up.png",
	display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	change_zone = "worldmap",
}

newEntity{
	define_as = "UP",
	name = "previous level",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
}

newEntity{
	define_as = "DOWN",
	name = "next level",
	display = '>', color_r=255, color_g=255, color_b=0, back_color={r=64, g=110, b=115},
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "FLOOR",
	name = "floor", image = "tiles/new/floor_cave.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color={r=71, g=122, b=136},
}

newEntity{
	define_as = "WALL",
	name = "wall", image = "tiles/UT/wall_cave.png",
	display = '#', color_r=0, color_g=0, color_b=0, back_color={r=30, g=30, b=60},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "DOOR",
	name = "door", image = "tiles/terrain/door.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "tiles/terrain/door_opened.png",
	display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
	always_remember = true,
	door_closed = "DOOR",
}

-- Special stuff

newEntity{
	define_as = "MOSS",
	type = "floor", subtype = "vegetation",
	name = "luminicent moss", image = "tiles/new/moss.png",
	display = '¤', color_r=52, color_g=222, color_b=137, back_color={r=71, g=122, b=136},

}

newEntity{
	define_as = "SHALLOW_WATER",
	type = "floor", subtype = "water",
	name = "water", image = "tiles/UT/shallow_water.png",
	display = '~', color=colors.LIGHT_BLUE, back_color=colors.CYAN,
	always_remember = true,
}

newEntity{
	define_as = "WATER",
	type = "floor", subtype = "water",
	name = "water", image = "tiles/terrain/water.png",
	display = '~', color=colors.BLUE, back_color=colors.LIGHT_BLUE,
	always_remember = true,
	mindam = 1,
	maxdam = 4,
	on_stand = function(self, x, y, who)
		if who.fly then return end
		local save = who:skillCheck("swim", 10)
		if not save then
			local DT = engine.DamageType
			local dam = DT:get(DT.WATER).projector(self, x, y, DT.WATER, rng.dice(self.mindam, self.maxdam))
		 	if who == game.player and dam > 0 then game.logPlayer(who, "You start drowning!") end
		end
	end,
}

newEntity{
	define_as = "DEEP_WATER",
	type = "floor", subtype = "water",
	name = "deep water",
	image = "tiles/terrain/deep_water.png",
	display = '~', color=colors.BLUE, back_color=colors.DARK_BLUE,
	always_remember = true,
	mindam = 2,
	maxdam = 6,
	on_stand = function(self, x, y, who)
		if who.fly then return end
		local save = who:skillCheck("swim", 15)
		if not save then
			local DT = engine.DamageType
			local dam = DT:get(DT.WATER).projector(self, x, y, DT.WATER, rng.dice(self.mindam, self.maxdam))
		 	if who == game.player and dam > 0 then game.logPlayer(who, "You start drowning!") end end
	end
}


newEntity{
	define_as = "LAVA",
	type = "floor", subtype = "lava",
	name = "lava",
	image = "tiles/terrain/lava.png",
	display = '~', color=colors.RED, back_color=DARK_GREY,
	always_remember = true,
	mindam = 2,
	maxdam = 6,
	on_stand = function(self, x, y, who)
		if who.fly then return end
		local DT = engine.DamageType
		local dam = DT:get(DT.LAVA).projector(self, x, y, DT.LAVA, rng.dice(self.mindam, self.maxdam))
		if who == game.player and dam > 0 then game.logPlayer(who, "The lava burns you!") end
	end
}
