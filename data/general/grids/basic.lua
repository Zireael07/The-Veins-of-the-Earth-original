-- Veins of the Earth
-- Zireael
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

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
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "FLOOR",
	name = "floor", image = "terrain/marble_floor.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "WALL",
	name = "wall", image = "terrain/granite_wall1.png",
	display = '#', color_r=255, color_g=255, color_b=255, back_color={r=30, g=30, b=60},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "DOOR",
	name = "door", image = "terrain/granite_door1.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "terrain/granite_door1_open.png",
	display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
	always_remember = true,
	door_closed = "DOOR",
}

-- Special stuff

newEntity{
	define_as = "MOSS",
	type = "floor", subtype = "vegetation",
	name = "luminicent moss", image = "terrain/marble_floor.png",
	display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
	
}

newEntity{
	define_as = "WATER",
	type = "floor", subtype = "water",
	name = "water", image = "terrain/marble_floor.png",
	display = '~', color=colors.BLUE, back_color=colors.DARK_GREY,
	always_remember = true,
--	on_stand = function(self, x, y, who)
--	who:skillCheck(swim, 10)
--		if true then end
--		else
--		local DT = engine.DamageType
--		local dam = DT:get(DT.WATER).projector(self, x, y, DT.WATER, rng.range(10, 30))
--	 	if dam > 0 then game.logPlayer(who, "You start drowning!") end end
--	end
}


newEntity{
	define_as = "LAVA",
	type = "floor", subtype = "lava",
	name = "lava", image = "terrain/marble_floor.png",
	display = '~', color=colors.RED, back_color=DARK_GREY,
	always_remember = true,
	mindam = 2,
	maxdam = 6,
--	on_stand = function(self, x, y, who)
--	local DT = engine.DamageType
--	local dam = DT:get(DT.FIRE).projector(self, x, y, DT.FIRE, rng.dice(self.mindam, self.maxdam))
--	if dam > 0 then game.logPlayer(who, "The lava burns you!") end,
}

newEntity{
	define_as = "CHASM",
	type = "floor", subtype = "chasm",
	name = "floor", image = "terrain/marble_floor.png",
	display = '~', color_r=43, color_g=43, color_b=43, back_color=DARK_GREY,
--	on_stand = function(self, x, y, who)
	change_level = 2,

}