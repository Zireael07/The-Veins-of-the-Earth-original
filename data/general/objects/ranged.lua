--Veins of the Earth
--Zireael 2013-2014

--Ranged weapons
newEntity{
    define_as = "BASE_RANGED",
    type = "weapon",
    ranged = true,
    ammo_type = "arrow",
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_HXBOW",
    slot = "MAIN_HAND",
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
    name = "a generic crossbow",
    desc = "A normal trusty heavy crossbow.\n\n Damage 1d10. Threat range 19-20. Range 12.",
}

newEntity{ base = "BASE_HXBOW",
    name = "heavy crossbow",
    image = "tiles/crossbow_heavy.png",
    level_range = {1, 10},
    cost = 50,
    combat = {
        dam = {1,10},
        threat = 1,
        range = 12,
    },
}

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_LXBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="crossbow",
    image = "tiles/crossbow_light.png",
    display = "}", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("bow"),
    encumber = 8,
    rarity = 6,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic crossbow",
    desc = "A normal trusty light crossbow.\n\n Damage 1d8. Threat range 19-20. Range 8.",
}
--Range 80 ft.
newEntity{ base = "BASE_LXBOW",
    name = "light crossbow",
    level_range = {1, 10},
    cost = 50,
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
    name = "a generic sling",
    desc = "A normal unremarkable sling.\n\n Damage 1d4. Range 4",
}

newEntity{ base = "BASE_SLING",
    name = "sling",
    level_range = {1, 10},
    cost = 0,
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
    display = "}", color=colors.UMBER,
    encumber = 3,
    rarity = 5,
    martial = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bow",
    desc = "A normal trusty bow.\n\n Damage 1d10. Critical x3. Range 10",
}

newEntity{ base = "BASE_LBOW",
    name = "longbow",
    image = "tiles/longbow.png",
    level_range = {1, 10},
    cost = 75,
    combat = {
        dam = {1,8},
        critical = 3,
        range = 10,
    },
}


newEntity{ base = "BASE_LBOW",
    name = "composite longbow",
    desc = "A curved longbow with an increased range.\n\n Damage 1d10. Critical x3. Range 11",
    level_range = {1, 10},
    image = "tiles/longbow.png",
    cost = 100,
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
    display = "}", color=colors.UMBER,
    encumber = 2,
    rarity = 5,
    martial = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bow",
    desc = "A normal trusty short bow.\n\n Damage 1d6. Critical x3. Range 6",
}

newEntity{ base = "BASE_SBOW",
    name = "shortbow",
    image = "tiles/shortbow.png",
    level_range = {1, 10},
    cost = 30,
    combat = {
        dam = {1,6},
        critical = 3,
        range = 6,
    },
}

newEntity{ base = "BASE_SBOW",
    name = "composite shortbow",
    image = "tiles/shortbow.png",
    level_range = {1, 10},
    cost = 75,
    desc = "A curved short bow with an increased range.\n\n Damage 1d6. Critical x3. Range 7",
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
    display = "{", color=colors.UMBER,
    encumber = 3,
    rarity = 7,
    archery_ammo = "arrow",
    desc = "Arrows are used with bows to pierce your foes to death.",
}

newEntity{ base = "BASE_ARROW",
    name = "arrows",
    level_range = {1, 10},
    cost = 1,
    combat = {
        capacity = 20,
    },
}   

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_BOLT",
    slot = "QUIVER",
    type = "ammo", subtype="bolt",
    image = "tiles/bolts.png",
    display = "{", color=colors.UMBER,
    encumber = 1,
    rarity = 5,
    archery_ammo = "bolt",
    desc = "Bolts are used with crossbows to pierce your foes to death.",
} 

newEntity{ base = "BASE_BOLT",
    name = "bolts",
    level_range = {1, 10},
    cost = 1,
    combat = {
        capacity = 10,
    },
}   

newEntity{ base = "BASE_RANGED",
    define_as = "BASE_BULLET",
    slot = "QUIVER",
    type = "ammo", subtype="bullet",
    image = "tiles/bullets.png",
    display = "{", color=colors.UMBER,
    encumber = 1,
    rarity = 5,
    archery_ammo = "bullet",
    desc = "Bullets are used with slings to kill your foes.",
} 

newEntity{ base = "BASE_BULLET",
    name = "bullets",
    level_range = {1, 10},
    cost = 0.1,
    combat = {
        capacity = 10,
    },
}   