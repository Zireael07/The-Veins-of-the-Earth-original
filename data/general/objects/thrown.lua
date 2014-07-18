--Veins of the Earth
--Zireael 2014

local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_THROWN",
    type = "weapon",
    ranged = true,
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_THROWN",
    define_as = "BASE_DART",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="dart",
    image = "tiles/newtiles/darts.png",
    display = "}", color=colors.SLATE,
    encumber = 0.5,
    rarity = 8,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic dart",
    desc = "An unremarkable dart.\n\n Damage 1d4. Range 2",
}

newEntity{ base = "BASE_DART",
    name = "darts",
    level_range = {1, 10},
    cost = 0.5,
    combat = {
        dam = {1,4},
        range = 2,
    },
}


newEntity{ base = "BASE_THROWN",
    define_as = "BASE_JAVELIN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="javelin",
    image = "tiles/newtiles/javelin.png",
    display = "}", color=colors.SLATE,
    encumber = 2,
    rarity = 10,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic javelin",
    desc = "A normal unremarkable javelin.\n\n Damage 1d6. Range 3",
}

newEntity{ base = "BASE_JAVELIN",
    name = "javelin",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,6},
        range = 3,
    },
}

--More thrown weapons
newEntity{ base = "BASE_THROWN",
    define_as = "BASE_THROWN_AXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/newtiles/handaxe.png",
    display = "\\", color=colors.SLATE,
    encumber = 2,
    rarity = 15,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic thrown axe",
    desc = "A normal unremarkable throwing axe.\n\n Damage 1d6. Range 3",
}

newEntity{ base = "BASE_THROWN_AXE",
    name = "throwing axe",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,6},
        range = 3,
    },
}

newEntity{ base = "BASE_THROWN",
    define_as = "BASE_THROWN_KNIFE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="dagger",
    image = "tiles/newtiles/dagger.png",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 15,
    simple = true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic thrown knife",
    desc = "A normal unremarkable throwing knife.\n\n Damage 1d6. Range 3",
}

newEntity{ base = "BASE_THROWN_KNIFE",
    name = "throwing knife",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,4},
        range = 3,
    },
}


--Exotic thrown weapons
newEntity{ base = "BASE_THROWN",
    define_as = "BASE_BOLAS",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bolas",
    image = "tiles/newtiles/bolas.png",
    display = "}", color=colors.SLATE,
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    encumber = 2,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bolas",
    desc = "A normal bolas.\n\n Damage 1d4. Range 2.",
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



newEntity{ base = "BASE_THROWN",
    define_as = "BASE_SHURIKEN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="dart",
    image = "tiles/shuriken.png",
    display = "}", color=colors.SLATE,
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    encumber = 0.5,
    rarity = 12,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic shuriken",
    desc = "An exotic shuriken.\n\n Damage 1d2. Range 2.",
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

newEntity{ base = "BASE_THROWN",
    define_as = "BASE_NET",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="net",
    image = "tiles/sling.png",
    display = "}", color=colors.SLATE,
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    encumber = 6,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic net",
    desc = "A normal net.\n\n Damage 1d4. Range 2.",
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