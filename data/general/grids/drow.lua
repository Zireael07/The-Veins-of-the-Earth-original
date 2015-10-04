--Veins of the Earth
--Zireael 2015

load("/data/general/grids/town.lua")

newEntity{
    base = "WALL",
    name = "faerie lantern",
    define_as = "FAERIE_TORCH",
    image = "tiles/new/faerie_lantern.png",
    display = '#', color=colors.GREEN, back_color = {r=30, g=30, b=60},
}

-- Special stuff
newEntity{
    define_as = "MOSS",
    type = "floor", subtype = "vegetation",
    name = "luminescent moss",
    image = "tiles/new/moss.png",
    display = '¤', color_r=52, color_g=222, color_b=137, back_color=colors.GREY,
}
