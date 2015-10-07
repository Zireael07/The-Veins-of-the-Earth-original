-- Veins of the Earth
-- Zireael 2015

load("/data/general/grids/basic.lua")

newEntity{ base = "EXIT",
    define_as = "PORTAL_FIRE",
    name = "fire portal",
    image = "tiles/new/portal_fire.png",
    display = '<', color=colors.RED, back_color=colors.DARK_GREY,
    change_zone = "plane of fire",
    spot = "fire",
}

newEntity{ base = "EXIT",
    define_as = "PORTAL_WATER",
    name = "water portal",
    image = "tiles/new/portal_water.png",
    display = '<', color=colors.BLUE, back_color=colors.DARK_GREY,
    change_zone = "plane of water",
    spot = "water",
}

newEntity{ base = "EXIT",
    define_as = "PORTAL_EARTH",
    name = "earth portal",
    image = "tiles/new/portal_earth.png",
    display = '<', color=colors.LIGHT_UMBER, back_color=colors.DARK_GREY,
    change_zone = "plane of earth",
    spot = "earth",
}

newEntity{ base = "EXIT",
    define_as = "PORTAL_AIR",
    name = "air portal",
    image = "tiles/new/portal_air.png",
    display = '<', color=colors.WHITE, back_color=colors.DARK_GREY,
    change_zone = "plane of air",
    spot = "air",
}
