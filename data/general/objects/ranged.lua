--Veins of the Earth
--Zireael 2013-2015

local Talents = require "engine.interface.ActorTalents"

--Ranged weapons
newEntity{
    define_as = "BASE_RANGED",
    type = "weapon",
    ranged = true,
    ammo_type = "arrow",
    slot = "MAIN_HAND",
    offslot = "SHOULDER",
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_HXBOW",
    slot = "MAIN_HAND",
--    offslot = "SHOULDER",
    slot_forbid = "OFF_HAND",
    image = "tiles/crossbow.png",
    type = "weapon", subtype="crossbow",
    image = "tiles/crossbow_heavy.png",
    display = "}", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("crossbow"),
    encumber = 8,
    rarity = 6,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "heavy crossbow",
    image = "tiles/crossbow_heavy.png",
    desc = "A normal trusty heavy crossbow.\n\n",
    level_range = {1, 10},
--    cost = 50,
    cost = resolvers.value{silver=350},
    combat = {
        dam = {1,10},
        threat = 1,
        range = 12,
    },
}

--Range 80 ft.
newEntity{ base = "BASE_RANGED",
    define_as = "BASE_LXBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="crossbow",
    image = "tiles/crossbow_light.png",
    display = "}", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("crossbow"),
    encumber = 8,
    rarity = 6,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },

    desc = "A normal trusty light crossbow.\n\n",
    name = "light crossbow",
    level_range = {1, 10},
--    cost = 50,
    cost = resolvers.value{silver=150},
    combat = {
        dam = {1,8},
        threat = 1,
        range = 8,
    },
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_SLING",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sling",
    image = "tiles/sling.png",
    display = "}", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("sling"),
    encumber = 1,
    rarity = 6,
    combat = { sound = "actions/sling", sound_miss = "actions/sling", },

    desc = "A normal unremarkable sling.\n\n",
    name = "sling",
    level_range = {1, 10},
    cost = 3,
    combat = {
        dam = {1,4},
        range = 4,
    },
}


--Bows
newEntity{ base = "BASE_RANGED",
    define_as = "BASE_LBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bow",
    require = { talent = { Talents.T_LONGBOW_PROFICIENCY }, },
    display = "}", color=colors.UMBER,
    moddable_tile = resolvers.moddable_tile("longbow"),
    encumber = 3,
    martial = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    desc = "A normal trusty bow.\n\n",
}

newEntity{ base = "BASE_LBOW",
    name = "longbow",
    image = "tiles/bow_long.png",
    rarity = 5,
    level_range = {1, 10},
--    cost = 75,
    cost = resolvers.value{platinum=1},
    combat = {
        dam = {1,8},
        critical = 3,
        range = 10,
    },
}


newEntity{ base = "BASE_LBOW",
    name = "composite longbow",
    desc = "A curved longbow with an increased range.\n\n",
    rarity = 10,
    level_range = {1, 10},
    image = "tiles/bow_long_composite.png",
    moddable_tile = resolvers.moddable_tile("composite_bow"),
--    cost = 100,
    cost = resolvers.value{silver=225},
    combat = {
        dam = {1,8},
        critical = 3,
        range = 11,
    },
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_SBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bow",
    require = { talent = { Talents.T_SHORTBOW_PROFICIENCY }, },
    display = "}", color=colors.UMBER,
    moddable_tile = resolvers.moddable_tile("shortbow"),
    encumber = 2,
    martial = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bow",
    desc = "A normal trusty short bow.\n\n",
}

newEntity{ base = "BASE_SBOW",
    name = "shortbow",
    image = "tiles/bow_short.png",
    rarity = 5,
    level_range = {1, 10},
--    cost = 30,
    cost = resolvers.value{silver=75},
    combat = {
        dam = {1,6},
        critical = 3,
        range = 6,
    },
}

newEntity{ base = "BASE_SBOW",
    name = "composite shortbow",
    image = "tiles/bow_short_composite.png",
    rarity = 12,
    level_range = {1, 10},
--    cost = 75,
    cost = resolvers.value{silver=175},
    desc = "A curved short bow with an increased range.\n\n",
    combat = {
        dam = {1,6},
        critical = 3,
        range = 7,
    },
}

--Ammo
newEntity{ base = "BASE_RANGED",
    define_as = "BASE_ARROW",
    slot = "QUIVER",
    type = "ammo", subtype="arrow",
    image = "tiles/arrows.png",
    add_name = " (#COMBAT_AMMO#)",
    display = "{", color=colors.UMBER,
    encumber = 3,
    rarity = 7,
    archery_ammo = "arrow",
    ammo = true,
    desc = "Arrows are used with bows to pierce your foes to death.",
    name = "arrows",
    level_range = {1, 10},
--    cost = 1,
    cost = resolvers.value{silver=1},
    combat = {
        capacity = resolvers.rngavground(2,20),
    },
}


newEntity{ base = "BASE_RANGED",
    define_as = "BASE_BOLT",
    slot = "QUIVER",
    type = "ammo", subtype="bolt",
    image = "tiles/bolts.png",
    add_name = " (#COMBAT_AMMO#)",
    display = "{", color=colors.UMBER,
    encumber = 1,
    rarity = 5,
    archery_ammo = "bolt",
    ammo = true,
    desc = "Bolts are used with crossbows to pierce your foes to death.",
    name = "bolts",
    level_range = {1, 10},
--    cost = 1,
    cost = resolvers.value{silver=2},
    combat = {
        capacity = resolvers.rngavground(2,20),
    },
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_BULLET",
    slot = "QUIVER",
    type = "ammo", subtype="bullet",
    image = "tiles/bullets.png",
    add_name = " (#COMBAT_AMMO#)",
    display = "*", color=colors.UMBER,
    encumber = 1,
    rarity = 5,
    archery_ammo = "bullet",
    ammo = true,
    desc = "Bullets are used with slings to kill your foes.",
    name = "bullets",
    level_range = {1, 10},
    cost = 5,
    combat = {
        capacity = resolvers.rngavground(2,20),
    },
}
