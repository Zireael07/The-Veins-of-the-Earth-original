-- Veins of the Earth
-- Zireael 2013-2016

--Split to a separate files because these are not loaded if body parts option is on

--Bracers
newEntity{
    define_as = "BASE_BRACERS",
    slot = "ARMS",
    type = "bracers", subtype = "bracers",
    image = "tiles/new/bracers.png",
    display = "Ξ", color=colors.RED,
    encumber = 1,
    rarity = 18,
    level_range = {4,nil},
    identified = false,
    name = "bracers", short_name = "bracer",
    unided_name = "bracers",
    desc = [[A set of bracers.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/bracers.lua", egos_chance = { prefix=0, suffix=100},
}

--Greaves
newEntity{
    define_as = "BASE_GREAVES",
    slot = "LEGS",
    type = "legs", subtype = "legs",
    image = "tiles/new/greaves.png",
    display = "Д", color=colors.RED,
    encumber = 1,
    rarity = 15,
    identified = false,
    level_range = {4,nil},
    name = "greaves", short_name = "greaves",
    unided_name = "greaves",
    desc = [[Thick metal greaves.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

--Helmets
newEntity{ base = "BASE_MAGITEM",
    define_as = "BASE_HELM",
    slot = "HELM",
    type = "helm", subtype = "helm",
    image = "tiles/object/helmet_metal.png",
    display = "₵", color=colors.RED,
    moddable_tile = resolvers.moddable_tile("helm"),
    encumber = 1,
    rarity = 15,
    name = "helm", short_name = "helm",
    unided_name = "helm",
    desc = [[A helmet.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

newEntity{ base = "BASE_HELM",
    subtype = "ioun",
    image = "tiles/new/ioun_stone.png",
    display = "*", color=colors.RED,
    rarity = 35,
    name = "ioun stone", short_name = "ioun",
    unided_name = "stone",
    desc = [[A small oblong stone.]],
}

newEntity{ base = "BASE_HELM",
    image = "tiles/object/circlet.png",
    display = "₵", color=colors.SLATE,
    rarity = 25,
    name = "circlet", short_name = "circlet",
    unided_name = "circlet",
    desc = [[A simple circlet.]],
}

newEntity{ base = "BASE_HELM",
    image = "tiles/object/crown_golden.png",
    display = "₵", color=colors.YELLOW,
    rarity = 25,
    name = "crown", short_name = "crown",
    unided_name = "circlet",
    desc = [[A beautiful jewelled crown.]],
}
