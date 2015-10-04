--Veins of the Earth
--Zireael 2015

load("/data/general/grids/town.lua")

newEntity{
    base = "WALL",
    name = "elven wall",
    define_as = "WALL_ELVEN",
    image = "tiles/new/wall_elven.png",
    display = '#', color=colors.GREEN, back_color = {r=30, g=30, b=60},
}

newEntity{
	base = "FLOOR",
	define_as = "FLOOR_ELVEN",
	image = "tiles/terrain/floor_elven.png",
    display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.LIGHT_GREEN,
}

newEntity{
	base = "FLOOR",
	define_as = "FLOOR_WHITE",
	image = "tiles/terrain/white_cobbles.png",
    display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.WHITE,
}
