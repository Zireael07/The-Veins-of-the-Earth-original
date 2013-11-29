--Veins of the Earth
--Zireael

local Talents = require "engine.interface.ActorTalents"

--Exotic ranged weapons

newEntity{
    define_as = "BASE_EXOTIC_RANGED",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon",
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_EXOTIC_RANGED",
    define_as = "BASE_HANDXBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="crossbow",
    image = "tiles/crossbow_light.png",
    display = "}", color=colors.SLATE,
    encumber = 2,
    rarity = 10,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic hand crossbow",
    desc = "A normal trusty hand crossbow.\n\n Damage 1d4. Threat range 19-20.",
}

newEntity{ base = "BASE_HANDXBOW",
    name = "hand crossbow",
    level_range = {1, 10},
    cost = 100,
    combat = {
        dam = {1,4},
        threat = 1,
        range = 3,
    },
}

newEntity{ base = "BASE_EXOTIC_RANGED",
    define_as = "BASE_BOLAS",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bolas",
    image = "tiles/sling.png",
    display = "}", color=colors.SLATE,
    encumber = 2,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bolas",
    desc = "A normal bolas.\n\n Damage 1d4.",
}

newEntity{ base = "BASE_BOLAS",
    name = "bolas",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,4},
        range = 2,
    },
}

newEntity{ base = "BASE_EXOTIC_RANGED",
    define_as = "BASE_SHURIKEN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="dart",
    image = "tiles/newtiles/darts.png",
    display = "}", color=colors.SLATE,
    encumber = 0.5,
    rarity = 12,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic shuriken",
    desc = "An exotic shuriken.\n\n Damage 1d2.",
}

newEntity{ base = "BASE_SHURIKEN",
    name = "shuriken",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,2},
        range = 2,
    },
}

newEntity{ base = "BASE_EXOTIC_RANGED",
    define_as = "BASE_NET",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="net",
    image = "tiles/sling.png",
    display = "}", color=colors.SLATE,
    encumber = 6,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic net",
    desc = "A normal net.\n\n Damage 1d4.",
}

newEntity{ base = "BASE_NET",
    name = "net",
    level_range = {1, 10},
    cost = 20,
    combat = {
        dam = {1,4}, --should be entangled
        range = 2,
    },
}