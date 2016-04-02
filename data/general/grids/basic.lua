-- Veins of the Earth
-- Zireael 2013-2015
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

--Dungeon tiles
newEntity{
	define_as = "UP",
	type = "floor", subtype = "floor",
	name = "previous level",
	image = "tiles/terrain/stairs_up.png",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
}

newEntity{
	define_as = "DOWN",
	type = "floor", subtype = "floor",
	name = "next level",
	image = "tiles/terrain/stairs_down.png",
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "SHAFT_UP",
	type = "floor", subtype = "floor",
	name = "previous level",
	image = "tiles/terrain/shaft_up.png",
	display = '<', color_r=210, color_g=105, color_b=30, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -2,
}

newEntity{
	define_as = "SHAFT_DOWN",
	type = "floor", subtype = "floor",
	name = "next level",
	image = "tiles/terrain/shaft_down.png",
	display = '>', color_r=210, color_g=105, color_b=30, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 2,
}


newEntity{
	define_as = "FLOOR",
	type = "floor", subtype = "floor",
	name = "floor", image = "tiles/terrain/floor.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

--Graphical variant
newEntity{
	base = "FLOOR",
	define_as = "FLOOR_TILED",
	image = "tiles/terrain/floor_tiled.png",
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
	type = "wall", subtype = "wall",
	name = "wall", image = "tiles/terrain/wall.png",
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
	image = "tiles/terrain/limestone.png",
}

newEntity{
	base = "WALL",
	define_as = "WALL_MARBLE",
	display = '#', color=colors.DARK_GREEN, back_color=colors.DARK_BLUE,
	image = "tiles/terrain/marble.png",
}

newEntity{
	base = "WALL",
	define_as = "WALL_WARDED",
	name = "warded wall",
	display = '#', color=colors.VIOLET, back_color={r=30, g=30, b=60},
	image = "tiles/new/wall_warded.png",
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
	name = "gold vein",
	display = '#', color=colors.YELLOW, back_color={r=30, g=30, b=60},
	image = "tiles/terrain/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "DIAMOND_VEIN",
	name = "diamond vein",
	display = '#', color=colors.WHITE, back_color={r=30, g=30, b=60},
	image = "tiles/terrain/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "MITHRIL_VEIN",
	name = "mithril vein",
	display = '#', color=colors.STEEL_BLUE, back_color={r=30, g=30, b=60},
	image = "tiles/terrain/veins.png",
}

newEntity{
	base = "WALL",
	define_as = "ADAMANT_VEIN",
	name = "adamant vein",
	display = '#', color=colors.DARK_SLATE, back_color={r=30, g=30, b=60},
	image = "tiles/terrain/veins.png",
}

--Inspired by Angband
newEntity{
	base = "WALL",
	name = "treasure vein",
	define_as = "TREASURE_VEIN",
	display = '#', color=colors.ORANGE, back_color={r=30, g=30, b=60},
	image = "tiles/terrain/veins.png",
	dig = "FLOOR",
}

--Torches
newEntity{
	base = "WALL",
	name = "wall torch",
	define_as = "WALL_TORCH",
	display = '#', color=colors.YELLOW, back_color = {r=30, g=30, b=60},
}

newEntity{
	base = "WALL",
	name = "faerie lantern",
	define_as = "FAERIE_TORCH",
	image = "tiles/new/faerie_lantern.png",
	display = '#', color=colors.GREEN, back_color = {r=30, g=30, b=60},
}

--Blocking stuff (essentially walls)
newEntity{
	define_as = "FUNGI",
	base = "WALL",
	type = "wall", subtype = "fungi",
	name = "underground fungi",
	image = "tiles/new/fungi.png",
	display = '#', color=colors.CHOCOLATE, back_color=colors.DARK_GREY,
	always_remember = true,
}

newEntity{
	define_as = "TREE_UNDERGROUND",
	base = "WALL",
	type = "wall", subtype = "tree",
	name = "underground tree",
	image = "tiles/new/dungeon tree.png",
	display = '#', color=colors.LIGHT_GREEN, back_color=colors.DARK_GREY,
	always_remember = true,
}

--Doors
newEntity{
	define_as = "DOOR",
	type = "wall", subtype = "floor",
	name = "oak door", image = "tiles/terrain/door.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.LIGHT_UMBER,
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

--Locked doors
newEntity{ base = "DOOR",
	define_as = "LOCKED_DOOR",
	name = "locked door",
	image = "tiles/terrain/door.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.LIGHT_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	block_move = function(self, x, y, who, act, couldpass)
		-- Open door
		if not self.opened then
			--block if not player
			if not who or not who.player or not act then return true end
			local check = game.player:skillCheck("open_lock", 15)
			if check then
				game.log("You open the door!")
			--[[	self.add_mos = {{image="tiles/terrain/chest_open.png", display_h=1, display_w=1, display_y=0, display_x=0}}
				self:removeAllMOs()]]
				self.opened = true
				local g = game.zone:makeEntityByName(game.level, "terrain", "DOOR_OPEN")
				if g then
					--turn into open door
					game.zone:addEntity(game.level, g, "terrain", x, y)
				end
			else game.log("You fail to open the door.")
			end
			return true
		end

		return false
	end,
}

--Taken from Incursion
newEntity{ base = "DOOR",
	define_as = "DOOR_IRON",
	name = "iron door", image = "tiles/UT/door_iron.png",
	display = '+', color=colors.DARK_GREY, back_color=colors.SLATE,
	door_opened = "DOOR_OPEN",
}

newEntity{ base = "DOOR",
	define_as = "DOOR_DARKWOOD",
	name = "darkwood door", image = "tiles/new/door_darkwood.png",
	display = '+', color=colors.DARK_GREY, back_color=colors.DARK_BROWN,
	door_opened = "DOOR_OPEN",
}

newEntity{ base = "DOOR",
	define_as = "DOOR_WARDED",
	name = "warded oak door", image = "tiles/new/door_warded.png",
	display = '+', color=colors.VIOLET, back_color=colors.DARK_BROWN,
	door_opened = "DOOR_OPEN",
}


-- Special stuff

newEntity{
	define_as = "MOSS",
	type = "floor", subtype = "vegetation",
	name = "luminescent moss",
	image = "tiles/new/moss.png",
	display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
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

newEntity{
	define_as = "CHASM",
	type = "floor", subtype = "chasm",
	name = "chasm",
	image = "tiles/new/chasm.png",
	display = '~', color_r=43, color_g=43, color_b=43, back_color=DARK_GREY,
	on_stand = function(self, x, y, who)
		if who == game.player then
			local save1 = who:skillCheck("balance", 15)
			local save2 = who:skillCheck("jump", 30)

			if not save1 then game:changeLevel(game:getDunDepth() + rng.dice(1,6))
			elseif not save2 then game:changeLevel(game:getDunDepth() + rng.dice(1,6))
			else end
		else
			if not who.fly then who:disappear() end
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
	image = "tiles/UT/ice.png",
	display = ' ', color=colors.STEEL_BLUE, back_color=colors.STEEL_BLUE,
	always_remember = true,
	on_stand = function(self, x, y, who)
        if who.fly or who:hasEffect(who.EFF_FELL) then return end
		local save = who:skillCheck("balance", 10)
		if not save then who:setEffect(who.EFF_FELL, 1, {}) end
	end
}

newEntity{
	define_as = "SAND",
	type = "floor", subtype = "sand",
	name = "sand",
	image = "tiles/UT/sand.png",
	display = ' ', color=colors.YELLOW, back_color=colors.YELLOW,
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
	define_as = "MUD",
	type = "floor", subtype = "mud",
	image = "tiles/UT/mud.png",
	name = "mud",
	display = ' ', color=colors.DARK_UMBER, back_color=colors.UMBER,
	always_remember = true,
}

newEntity{
	define_as = "PILLAR",
	type = "floor", subtype = "furniture",
	name = "pillar",
	display = '¤', color=colors.GREY, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "ROCK_PILLAR",
	type = "floor", subtype = "furniture",
	name = "rock pillar",
	display = '¤', color=colors.SANDY_BROWN, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "ALTAR",
	type = "floor", subtype = "furniture",
	name = "altar",
	image = "tiles/terrain/altar.png",
	display = '&', color=colors.WHITE, back_color=colors.DARK_GREY,
	always_remember = true,
	is_altar = true,
}

--An altar for every deity (can't be resolve'd due to the way T-Engine sees grids)
--Colors match deity message colors
newEntity{	base = "ALTAR",
	define_as = "ALTAR_AISWIN",
	name = "altar to Aiswin",
	color=colors.BLUE,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_ASHERATH",
	name = "altar to Asherath",
	color=colors.TAN,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_EKLIAZEH",
	name = "altar to Ekliazeh",
	color=colors.SANDY_BROWN,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_ERICH",
	name = "altar to Erich",
	color=colors.PURPLE,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_ESSIAH",
	name = "altar to Essiah",
	color=colors.PINK,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_HESANI",
	name = "altar to Hesani",
	color=colors.YELLOW,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_IMMOTIAN",
	name = "altar to Immotian",
	color=colors.GOLD,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_KHASRACH",
	name = "altar to Khasrach",
	color=colors.OLIVE_DRAB,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_KYSUL",
	name = "altar to Kysul",
	color=colors.LIGHT_GREEN,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_MARA",
	name = "altar to Mara",
	color=colors.ANTIQUE_WHITE,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_MAEVE",
	name = "altar to Maeve",
	color=colors.DARK_GREEN,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_SABIN",
	name = "altar to Sabin",
	color=colors.LIGHT_BLUE,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_SEMIRATH",
	name = "altar to Semirath",
	color=colors.ORCHID,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_XAVIAS",
	name = "altar to Xavias",
	color=colors.DARK_SLATE_GRAY,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_XEL",
	name = "altar to Xel",
	color=colors.DARK_RED,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_ZURVASH",
	name = "altar to Zurvash",
	color=colors.CRIMSON,
}

newEntity{	base = "ALTAR",
	define_as = "ALTAR_MULTITUDE",
	name = "altar to Multitude",
	color=colors.SLATE,
}


--Taken from Gatecrashers
newEntity{
	define_as = "CHEST",
	type = "chest", subtype = "floor",
	name = "chest",
	add_mos = {{image="tiles/terrain/chest.png", display_h=1, display_w=1, display_y=0, display_x=0}},
	always_remember = true,
	force_clone = true,
	block_move = function(self, x, y, who, act, couldpass)
		-- Open chest
		if not self.opened then
			--block if not player
			if not who or not who.player or not act then return true end
			if not rng.percent(20) then
				game.log("You open the chest!")
			--[[	self.add_mos = {{image="tiles/terrain/chest_open.png", display_h=1, display_w=1, display_y=0, display_x=0}}
				self:removeAllMOs()]]
				self.opened = true
				o = game.zone:makeEntity(game.level, "object", {ego_chance=1000}, nil, true)
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

newEntity{ base = "CHEST",
	define_as = "CHEST_LOCKED",
	block_move = function(self, x, y, who, act, couldpass)
		-- Open chest
		if not self.opened then
			--block if not player
			if not who or not who.player or not act then return true end
			if who:skillCheck("open_lock", 15) then
				game.log("You open the chest!")
				self.opened = true
				o = game.zone:makeEntity(game.level, "object", {ego_chance=1000}, nil, true)
				game.zone:addEntity(game.level, o, "object", x, y)
			else
				game.log("The chest is still locked!")
			end
			return true
		end

		return false
	end,
}
