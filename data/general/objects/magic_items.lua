--Veins of the Earth
-- Zireael 2013-2015

local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_POTION",
    slot = "INVEN",
    type = "potion", subtype = "potion",
    image = "tiles/object/potion.png",
    display = "!", color=colors.RED,
    name = "potion", instant_resolve = true,
    unided_name = "potion",
    identified = false,
    cost = 0,
    level_range = {1,10},
    encumber = 0,
    rarity = 5,
    desc = [[A potion.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/potions.lua", egos_chance = {suffix=100},
}

--Mushrooms (should give nutrition in addition to potion effects)
newEntity{
    define_as = "BASE_MUSHROOM",
    slot = "INVEN",
    type = "potion", subtype = "mushroom",
    image = "tiles/object/mushroom_yellow.png",
    display = ",", color=colors.YELLOW,
    name = "mushroom", --instant_resolve = true,
    unided_name = "mushroom",
    identified = false,
    cost = 0,
    level_range = {1,10},
    encumber = 0,
    rarity = 10,
    desc = [[An edible mushroom.]],
    egos = "/data/general/objects/properties/potions.lua", egos_chance = {suffix=100},
}

--Tattoos
newEntity{
    define_as = "BASE_TATTOO",
    slot = "INVEN",
    name = "tattoo",
    unided_name = "tattoo",
    identified = false,
    cost = 0,
    level_range = {1,10},
    rarity = 10,
    type = "scroll", subtype = "tattoo",
    display = "?", color=colors.RED,
    encumber = 0,
    desc = [[A tattoo.]],
}

--Rods
newEntity{
    define_as = "BASE_ROD",
    slot = "INVEN",
    name = "rod",
    unided_name = "rod",
    identified = false,
    cost = 0,
    level_range = {1,10},
    rarity = 10,
    slot = "INVEN",
    type = "wand", subtype = "rod",
    image = "tiles/object/wand.png",
    display = "-", color=colors.GREEN,
    encumber = 0,
    desc = [[A rod.]],
}



--Charged items
newEntity{
    define_as = "BASE_WAND",
    name = "wand",
    unided_name = "wand",
    identified = false,
    level_range = {1,10},
    cost = 10,
    rarity = 2,
    slot = "INVEN",
    type = "wand", subtype = "wand",
    image = "tiles/object/wand.png",
    display = "-", color=colors.RED,
    encumber = 0,
    multicharge = 50,
    desc = [[A wand.]],
    egos = "/data/general/objects/properties/charged.lua", egos_chance = {suffix=100},
}

newEntity{
    define_as = "BASE_SCROLL",
    name = "scroll", instant_resolve = true,
    unided_name = "scroll",
    identified = false,
    level_range = {1, 10},
    rarity = 2,
    cost = 50,
    slot = "INVEN",
    type = "scroll", subtype = "scroll",
    image = "tiles/object/scroll.png",
    display = "?", color=colors.WHITE,
    encumber = 0,
    multicharge = 50,
    resolvers.flavored(),
    desc = [[A scroll.]],
    egos = "/data/general/objects/properties/charged.lua", egos_chance = {suffix=100},
}

--For the Self-Resurrect feat
newEntity{
    define_as = "RESURRECTION_DIAMOND",
    name = "resurrection diamond",
    unided_name = "diamond",
    cost = 0,
    slot = "INVEN",
    type = "gem", subtype = "gem",
    display = "*", color=colors.ANTIQUE_WHITE,
    image = "tiles/object/diamond.lua",
    encumber = 0,
    desc = [[A perfect white diamond.]],
}
