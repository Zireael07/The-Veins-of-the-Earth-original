--Exotic ranged weapons

newEntity{
    define_as = "BASE_HANDXBOW",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="crossbow",
    display = "}", color=colors.SLATE,
    encumber = 2,
    rarity = 10,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic hand crossbow",
    desc = [[A normal trusty hand crossbow.]],
}
--Range 30 ft.
newEntity{ base = "BASE_HANDXBOW",
    name = "hand crossbow",
    level_range = {1, 10},
    cost = 100,
    combat = {
        dam = {1,4},
        threat = 1,
        range = 9,
    },
}

newEntity{
    define_as = "BASE_BOLAS",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bolas",
    display = "}", color=colors.SLATE,
    encumber = 2,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic bolas",
    desc = [[A normal bolas.]],
}
--Range 10 ft.
newEntity{ base = "BASE_BOLAS",
    name = "bolas",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,4},
        range = 3,
    },
}

newEntity{
    define_as = "BASE_SHURIKEN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="dart",
    display = "}", color=colors.SLATE,
    encumber = 0.5,
    rarity = 12,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic shuriken",
    desc = [[A normal shuriken.]],
}
--Range 10 ft.
newEntity{ base = "BASE_SHURIKEN",
    name = "shuriken",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,2},
        range = 3,
    },
}

newEntity{
    define_as = "BASE_NET",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="net",
    display = "}", color=colors.SLATE,
    encumber = 6,
    rarity = 8,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },
    name = "a generic net",
    desc = [[A normal net.]],
}
--Range 10 ft.
newEntity{ base = "BASE_NET",
    name = "net",
    level_range = {1, 10},
    cost = 20,
    combat = {
        dam = {1,4}, --should be entangled
        range = 3,
    },
}