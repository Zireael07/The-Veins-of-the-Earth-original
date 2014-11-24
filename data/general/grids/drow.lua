--Veins of the Earth
--Zireael 2014

--Drow city/outpost tiles

--Worldmap exit
newEntity{
    define_as = "EXIT",
    type = "floor", subtype = "floor",
    name = "exit to worldmap",
    image = "tiles/newtiles/worldmap_stairs_up.png",
    display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
    notice = true,
    always_remember = true,
    change_level = 1,
    change_zone = "worldmap",
}

newEntity{
    define_as = "FLOOR",
    type = "floor", subtype = "floor",
    name = "floor", image = "tiles/floor.png",
    display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
    define_as = "WALL",
    type = "wall", subtype = "wall",
    name = "wall", image = "tiles/newtiles/drow_wall.png",
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
    name = "faerie lantern",
    define_as = "FAERIE_TORCH",
    image = "tiles/newtiles/faerie_lantern.png",
    display = '#', color=colors.GREEN, back_color = {r=30, g=30, b=60},
}

--Doors
newEntity{
    define_as = "DOOR",
    type = "wall", subtype = "floor",
    name = "door", image = "tiles/newtiles/door_drow.png",
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

-- Special stuff

newEntity{
    define_as = "MOSS",
    type = "floor", subtype = "vegetation",
    name = "luminescent moss",
    image = "tiles/newtiles/moss.png",
    display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
}

--Building entrances
newEntity{
    base = "EXIT",
    define_as = "NOBLE_ENTRANCE",
    name = "building entrance",
    image = "tiles/stairs_up.png",
    change_level = 1,
    change_zone = "noble compound",
}

newEntity{
    base = "EXIT",
    define_as = "EXIT_TOWN",
    name = "exit to town",
    image = "tiles/stairs_up.png",
    change_level = 1,
    change_zone = "drow city",
}