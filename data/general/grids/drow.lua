--Veins of the Earth
--Zireael 2014-2015

--Drow city/outpost tiles

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

--Up/down for metropolis
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
    define_as = "FLOOR",
    type = "floor", subtype = "floor",
    name = "floor", image = "tiles/UT/floor_cobblestone.png",
    display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

--Graphical variant
newEntity{
	base = "FLOOR",
	define_as = "FLOOR_TILED",
	image = "tiles/terrain/floor_tiled.png",
}

--For buildings
newEntity{
    base = "FLOOR",
    define_as = "FLOOR_BUILDING",
    image = "tiles/terrain/floor_building.png",
}

newEntity{
    define_as = "WALL",
    type = "wall", subtype = "wall",
    name = "wall", image = "tiles/new/drow_wall.png",
    display = '#', color=colors.BLACK, back_color={r=30, g=30, b=60},
    always_remember = true,
    does_block_move = true,
    can_pass = {pass_wall=1},
    block_sight = true,
    air_level = -20,
    dig = "FLOOR",
}

newEntity{
    base = "WALL",
    define_as = "WALL_NOBLE",
    image = "tiles/terrain/wall_noble.png",
}

newEntity{
    base = "WALL",
    name = "faerie lantern",
    define_as = "FAERIE_TORCH",
    image = "tiles/new/faerie_lantern.png",
    display = '#', color=colors.GREEN, back_color = {r=30, g=30, b=60},
}

newEntity{
    base = "WALL",
    name = "fountain",
    define_as = "FOUNTAIN",
    image = "tiles/terrain/fountain.png",
    display = '⌠', color=colors.BLUE, back_color = {r=30, g=30, b=60},
}

newEntity{
    base = "WALL",
    define_as = "WALL_CITY",
    image = "tiles/UT/wall_stone.png",
    display = '#', color=colors.BLACK, back_color=colors.DARK_GREY,
}

--Doors
newEntity{
    define_as = "DOOR",
    type = "wall", subtype = "floor",
    name = "door", image = "tiles/new/door_drow.png",
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


--Gate
newEntity{ base = "DOOR",
    define_as = "GATE",
    name = "gate", image = "tiles/terrain/gate_closed.png",
    display = "+", color=colors.DARK_GREY, back_color={r=30, g=30, b=60},
}


-- Special stuff

newEntity{
    define_as = "MOSS",
    type = "floor", subtype = "vegetation",
    name = "luminescent moss",
    image = "tiles/new/moss.png",
    display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
}

--Building entrances
newEntity{
    base = "EXIT",
    define_as = "NOBLE_ENTRANCE",
    name = "building entrance",
    image = "tiles/terrain/stairs_up.png",
    change_level = 1,
    change_zone = "noble compound",
}

newEntity{
    base = "EXIT",
    define_as = "BROTHEL_ENTRANCE",
    name = "building entrance",
    image = "tiles/terrain/stairs_up.png",
    change_level = 1,
    change_zone = "brothel",
}

newEntity{
    base = "EXIT",
    define_as = "TAVERN_ENTRANCE",
    name = "building entrance",
    image = "tiles/terrain/stairs_up.png",
    change_level = 1,
    change_zone = "tavern",
}

newEntity{
    base = "EXIT",
    define_as = "INN_ENTRANCE",
    name = "building entrance",
    image = "tiles/terrain/stairs_up.png",
    change_level = 1,
    change_zone = "inn",
}

newEntity{
    base = "EXIT",
    define_as = "EXIT_TOWN",
    name = "exit to town",
    image = "tiles/terrain/stairs_up.png",
    change_level = 1,
    change_zone = "drow city",
}
