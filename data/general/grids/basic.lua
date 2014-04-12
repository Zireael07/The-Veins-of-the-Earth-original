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

newEntity{
	define_as = "UP",
	name = "previous level",
	image = "tiles/stairs_up.png",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
}

newEntity{
	define_as = "DOWN",
	name = "next level",
	image = "tiles/stairs_down.png",
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "SHAFT_UP",
	name = "previous level",
	image = "tiles/shaft_up.png",
	display = '<', color_r=210, color_g=105, color_b=30, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -2,
}

newEntity{
	define_as = "SHAFT_DOWN",
	name = "next level",
	image = "tiles/shaft_down.png",
	display = '>', color_r=210, color_g=105, color_b=30, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 2,
}


newEntity{
	define_as = "FLOOR",
	name = "floor", image = "tiles/floor.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

--Taken from Incursion
newEntity{
	base = "FLOOR",
	define_as = "FLOOR_BLOOD",
	name = "pool of blood",
	display = ' ', color=colors.RED, back_color=colors.DARK_GREY,
}

newEntity{
	base = "FLOOR",
	define_as = "FLOOR_SLIME",
	name = "pool of slime",
	display = ' ', color=colors.YELLOW_GREEN, back_color=colors.DARK_GREY,
}


newEntity{
	define_as = "WALL",
	name = "wall", image = "tiles/wall.png",
	display = '#', color=colors.BLACK, back_color={r=30, g=30, b=60},
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

--Taken from Incursion
newEntity{
	base = "WALL",
	define_as = "WALL_ICE",
	display = '#', color=colors.LIGHT_BLUE, back_color=colors.STEEL_BLUE,
}

newEntity{
	base = "WALL",
	define_as = "WALL_LIMESTONE",
	display = '#', color=colors.LIGHT_GREEN, back_color=colors.DARK_GREY,
	image = "tiles/limestone.png",
}

newEntity{
	base = "WALL",
	define_as = "WALL_MARBLE",
	display = '#', color=colors.DARK_GREEN, back_color=colors.DARK_BLUE,
	image = "tiles/marble.png",
}

newEntity{
	base = "WALL",
	define_as = "WALL_WARDED",
	display = '#', color=colors.VIOLET, back_color={r=30, g=30, b=60},
}

newEntity{
	base = "WALL",
	define_as = "WALL_ADAMANT",
	display = '#', color=colors.LIGHT_SLATE, back_color={r=30, g=30, b=60},
}

--Digging grids taken from Incursion
newEntity{
	base = "WALL",
	define_as = "GOLD_VEIN",
	display = '#', color=colors.YELLOW, back_color={r=30, g=30, b=60},
	image = "tiles/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "DIAMOND_VEIN",
	display = '#', color=colors.WHITE, back_color={r=30, g=30, b=60},
	image = "tiles/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "MITHRIL_VEIN",
	display = '#', color=colors.STEEL_BLUE, back_color={r=30, g=30, b=60},
	image = "tiles/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "ADAMANT_VEIN",
	display = '#', color=colors.DARK_SLATE, back_color={r=30, g=30, b=60},
	image = "tiles/veins.png",
}

--Inspired by Angband
newEntity{
	base = "WALL",
	define_as = "TREASURE_VEIN",
	display = '#', color=colors.ORANGE, back_color={r=30, g=30, b=60},
	image = "tiles/veins.png",
}

newEntity{
	define_as = "DOOR",
	name = "oak door", image = "tiles/door.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.LIGHT_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}


newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "tiles/door_opened.png",
	display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
	always_remember = true,
	door_closed = "DOOR",
}

--Taken from Incursion
newEntity{ base = "DOOR",
	define_as = "DOOR_IRON",
	name = "iron door", image = "tiles/newtiles/door_iron.png",
	display = '+', color=colors.DARK_GREY, back_color=colors.SLATE,
	door_opened = "DOOR_OPEN",
}

newEntity{ base = "DOOR",
	define_as = "DOOR_DARKWOOD",
	name = "darkwood door", image = "tiles/newtiles/door_darkwood.png",
	display = '+', color=colors.DARK_GREY, back_color=colors.DARK_BROWN,
	door_opened = "DOOR_OPEN",
}

newEntity{ base = "DOOR",
	define_as = "DOOR_WARDED",
	name = "warded oak door", image = "tiles/newtiles/door_warded.png",
	display = '+', color=colors.VIOLET, back_color=colors.DARK_BROWN,
	door_opened = "DOOR_OPEN",
}


-- Special stuff

newEntity{
	define_as = "MOSS",
	type = "floor", subtype = "vegetation",
	name = "luminescent moss",
	image = "tiles/newtiles/moss.png",
	display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
}

newEntity{
	define_as = "WATER",
	type = "floor", subtype = "water",
	name = "water", image = "tiles/water.png",
	display = '~', color=colors.BLUE, back_color=colors.LIGHT_BLUE,
	always_remember = true,
	mindam = 1,
	maxdam = 4,
	on_stand = function(self, x, y, who)
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
	image = "tiles/deep_water.png",
	display = '~', color=colors.BLUE, back_color=colors.DARK_BLUE,
	always_remember = true,
	mindam = 2,
	maxdam = 6,
	on_stand = function(self, x, y, who)
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
	image = "tiles/lava.png",
	display = '~', color=colors.RED, back_color=DARK_GREY,
	always_remember = true,
	mindam = 2,
	maxdam = 6,
	on_stand = function(self, x, y, who)
		local DT = engine.DamageType
		local dam = DT:get(DT.LAVA).projector(self, x, y, DT.LAVA, rng.dice(self.mindam, self.maxdam))
		if dam > 0 then game.logPlayer(who, "The lava burns you!") end
	end
}

newEntity{
	define_as = "CHASM",
	type = "floor", subtype = "chasm",
	name = "chasm", 
	image = "tiles/chasm.png",
	display = '~', color_r=43, color_g=43, color_b=43, back_color=DARK_GREY,
	on_stand = function(self, x, y, who)
		if who == game.player then
			local save1 = who:skillCheck("jump", 30)
			local save2 = who:skillCheck("balance", 15)
			if not save1 or save2 then game:changeLevel(game.level.level + rng.dice(1,6)) end
		end
	end
}

newEntity{
	define_as = "WEB",
	type = "floor", subtype = "web",
	name = "webbing", 
	display = '#', color=colors.DARK_GREY, back_color=colors.GREY,
	always_remember = true,
}

newEntity{
	define_as = "ICE",
	type = "floor", subtype = "ice",
	name = "ice floor", 
	image = "tiles/newtiles/ice_floor.png",
	display = ' ', color=colors.STEEL_BLUE, back_color=colors.STEEL_BLUE,
	always_remember = true,
	on_stand = function(self, x, y, who)
		local save = who:skillCheck("balance", 10)
		if not save then who:setEffect(who.EFF_FELL, 1, {}) end 
	end
}

newEntity{
	define_as = "FUNGI",
	type = "floor", subtype = "fungi",
	name = "underground fungi", 
	display = '#', color=colors.CHOCOLATE, back_color=colors.DARK_GREY,
	always_remember = true,
}

newEntity{
	define_as = "SAND",
	type = "floor", subtype = "sand",
	name = "sand", 
	display = ' ', color=colors.YELLOW, back_color=colors.GREY,
	always_remember = true,
}

newEntity{
	define_as = "SWAMP",
	type = "floor", subtype = "swamp",
	name = "sand", 
	display = ' ', color=colors.UMBER, back_color=colors.DARK_GREEN,
	always_remember = true,
}

newEntity{
	define_as = "ALTAR",
	type = "floor", subtype = "furniture",
	name = "altar", 
	display = '&', color=colors.WHITE, back_color=colors.DARK_GREY,
	always_remember = true,
}

--Taken from Gatecrashers
newEntity{
	define_as = "CHEST",
	type = "chest", subtype = "floor",
	name = "chest",
	add_mos = {{image="tiles/chest.png", display_h=1, display_w=1, display_y=0, display_x=0}},
	always_remember = true,
	force_clone = true,
	block_move = function(self, x, y, who, act, couldpass)
		-- Open chest
		if not self.opened then
			--block if not player
			if not who or not who.player or not act then return true end
			if not rng.percent(20) then
				game.log("You open the chest!")
			--[[	self.add_mos = {{image="tiles/chest_open.png", display_h=1, display_w=1, display_y=0, display_x=0}}
				self:removeAllMOs()]]
				self.opened = true
				o = game.zone:makeEntity(game.level, "object", nil, nil, true)
				game.zone:addEntity(game.level, o, "object", x, y)
			else
				game.log("The chest was a mimic!")
				local m = game.zone:makeEntity(game.level, "actor", {name="mimic"}, nil, true)
				if m then 
					m:resolve()
					game.zone:addEntity(game.level, m, "actor", x, y)
				end
				local g = game.zone:makeEntityByName(game.level, "terrain", "FLOOR")
				if g then
					--TURN CHEST INTO FLOOR
					game.zone:addEntity(game.level, g, "terrain", x, y)
				end
			end
			return true
		end
		
		return false
	end,
}