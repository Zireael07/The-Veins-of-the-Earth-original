--Simple weapons

newEntity{
    define_as = "BASE_WEAPON",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon",
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_DAGGER",
    type = "weapon", subtype="dagger",
    display = "|", color=colors.SLATE,
    encumber = 3,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dagger",
    desc = [[A normal trusty dagger. Damage 1d4, threat range 19-20.]],
}

newEntity{ base = "BASE_DAGGER",
    name = "iron dagger",
    level_range = {1, 10},
    cost = 5,
    light = true,
    combat = {
        dam = {1,4},
        threat = 1,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_LSPEAR",
    slot = "MAIN_HAND", 
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic long spear",
    desc = [[A wooden long spear. Damage 1d10, critical x3.]],
}

newEntity{ base = "BASE_LSPEAR",
    name = "long spear",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,8},
        critical = 3,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_SSPEAR",
    slot = "MAIN_HAND", 
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic short spear",
    desc = [[A wooden short spear. Damage 1d6.]],
}

newEntity{ base = "BASE_SSPEAR",
    name = "short spear",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,6},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_HMACE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="mace",
    display = "\\", color=colors.SLATE,
    encumber = 8,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic mace",
    desc = [[A heavy metal mace. Damage 1d8.]],
}

newEntity{ base = "BASE_HMACE",
    name = "heavy mace",
    level_range = {1, 10},
    cost = 12,
    combat = {
        dam = {1,8},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_LMACE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="mace",
    display = "\\", color=colors.SLATE,
    encumber = 4,
    rarity = 5,
    light = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic mace",
    desc = [[A light metal mace. Damage 1d6.]],
}

newEntity{ base = "BASE_LMACE",
    name = "light mace",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_CLUB",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="club",
    display = "\\", color=colors.SLATE,
    encumber = 3,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic club",
    desc = [[A wooden club. Damage 1d6.]],
}

newEntity{ base = "BASE_CLUB",
    name = "club",
    level_range = {1, 10},
    cost = 0,
    combat = {
        dam = {1,6},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_MSTAR",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="morningstar",
    display = "\\", color=colors.SLATE,
    encumber = 6,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic morningstar",
    desc = [[A metal morningstar. Damage 1d8.]],
}

newEntity{ base = "BASE_MSTAR",
    name = "morningstar",
    level_range = {1, 10},
    cost = 8,
    combat = {
        dam = {1,8},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_STAFF",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="staff",
    display = "\\", color=colors.BROWN,
    encumber = 4,
    rarity = 2,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic staff",
    desc = [[A wooden staff. Damage 1d6.]],
}

newEntity{ base = "BASE_STAFF",
    name = "quarterstaff",
    level_range = {1, 10},
    cost = 0,
    combat = {
        dam = {1,6},
    },
}

--Martial weapons

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_LHAMMER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="hammer",
    display = "\\", color=colors.SLATE,
    encumber = 4,
    rarity = 1,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic light hammer",
    desc = [[A light metal hammer. Damage 1d4.]],
}

newEntity{ base = "BASE_LHAMMER",
    name = "light hammer",
    level_range = {1, 10},
    cost = 1,
    light = true,
    combat = {
        dam = {1,4},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_HANDAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="handaxe",
    display = "\\", color=colors.SLATE,
    encumber = 3,
    rarity = 3,
    light = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic handaxe",
    desc = [[A normal handaxe. Damage 1d6. Critical x3.]],
}

newEntity{ base = "BASE_HANDAXE",
    name = "iron handaxe",
    level_range = {1, 10},
    cost = 6,
    combat = {
        dam = {1,6},
        critical = 3,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_KUKRI",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="kukri",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 5,
    light = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic kukri",
    desc = [[A curved blade. Damage 1d4. Threat range 18-20.]],
}

newEntity{ base = "BASE_KUKRI",
    name = "iron kukri",
    level_range = {1, 10},
    cost = 8,
    combat = {
        dam = {1,4},
        threat = 2,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_SHORTSWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="shortsword",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 5,
    light = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic short sword",
    desc = [[A curved short sword. Damage 1d6. Threat range 19-20.]],
}

newEntity{ base = "BASE_SHORTSWORD",
    name = "short sword",
    level_range = {1, 10},
    cost = 10,
    combat = {
        dam = {1,6},
        threat = 1,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_BATTLEAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "\\", color=colors.SLATE,
    encumber = 12,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic battleaxe",
    desc = [[A normal battleaxe. Damage 1d6.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_SWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "|", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sword",
    desc = [[A trusty sword. Damage 1d8. Threat range 18-20.]],
}

newEntity{ base = "BASE_SWORD",
    name = "long sword",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,8},
        threat = 2,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_FLAIL",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="flail",
    display = "/", color=colors.SLATE,
    encumber = 5,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal flail",
    desc = [[A metal flail. Damage 1d8.]],
}

newEntity{ base = "BASE_FLAIL",
    name = "flail",
    level_range = {1, 10},
    cost = 8,
    combat = {
        dam = {1,8},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_RAPIER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="rapier",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 6,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal rapier",
    desc = [[A metal rapier. Damage 1d6. Threat range 18-20.]],
}

newEntity{ base = "BASE_RAPIER",
    name = "rapier",
    level_range = {1, 10},
    cost = 20,
    combat = {
        dam = {1,6},
        threat = 2,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_SCIMITAR",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="scimitar",
    display = "|", color=colors.SLATE,
    encumber = 4,
    rarity = 7,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal scimitar",
    desc = [[A metal scimitar. Damage 1d6. Threat range 18-20.]],
}

newEntity{ base = "BASE_SCIMITAR",
    name = "scimitar",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,6},
        threat = 2,
    },
}

--Range 10 ft.
newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_TRIDENT",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="trident",
    display = "/", color=colors.SLATE,
    encumber = 4,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal trident",
    desc = [[A metal trident. Damage 1d8.]],
}

newEntity{ base = "BASE_TRIDENT",
    name = "trident",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,8},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_WARHAMMER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="hammer",
    display = "\\", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal warhammer",
    desc = [[A metal warhammer. Damage 1d8. Critical x3.]],
}

newEntity{ base = "BASE_WARHAMMER",
    name = "warhammer",
    level_range = {1, 10},
    cost = 12,
    combat = {
        dam = {1,8},
        critical = 3,
    },
}

--Two-handed weapons
newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_FALCHION",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="falchion",
    display = "|", color=colors.SLATE,
    encumber = 8,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal falchion",
    desc = [[A metal falchion. Damage 2d4. Threat range 18-20.]],
}

newEntity{ base = "BASE_FALCHION",
    name = "falchion",
    level_range = {1, 10},
    cost = 75,
    combat = {
        dam = {2,4},
        threat = 2,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_GREATAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    display = "\\", color=colors.SLATE,
    encumber = 12,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a great axe",
    desc = [[A great metal axe. Damage 1d12. Critical x3.]],
}

newEntity{ base = "BASE_GREATAXE",
    name = "greataxe",
    level_range = {1, 10},
    cost = 20,
    combat = {
        dam = {1,12},
        critical = 3,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_GREATCLUB",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="club",
    display = "\\", color=colors.SLATE,
    encumber = 8,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a greatclub",
    desc = [[A huge wooden club. Damage 1d10.]],
}

newEntity{ base = "BASE_GREATCLUB",
    name = "greatclub",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,10},
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_HEAVYFLAIL",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="flail",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a heavy flail",
    desc = [[A heavy flail. Damage 1d10. Threat range 19-20.]],
}

newEntity{ base = "BASE_HEAVYFLAIL",
    name = "heavy flail",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,10},
        threat = 1,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_GREATSWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "|", color=colors.SLATE,
    encumber = 8,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a greatsword",
    desc = [[A metal great two-handed sword. Damage 2d6. Threat range 19-20.]],
}

newEntity{ base = "BASE_GREATSWORD",
    name = "greatsword",
    level_range = {1, 10},
    cost = 50,
    combat = {
        dam = {2,6},
        threat = 1,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_HALBERD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="halberd",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a halberd",
    desc = [[A metal halberd. Damage 1d10. Critical x3.]],
}

newEntity{ base = "BASE_HALBERD",
    name = "halberd",
    level_range = {1, 10},
    cost = 10,
    combat = {
        dam = {1,10},
        critical = 3,
    },
}

newEntity{ base = "BASE_WEAPON",
    define_as = "BASE_SCYTHE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="scythe",
    display = "\\", color=colors.SLATE,
    encumber = 10,
    rarity = 12,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a scythe",
    desc = [[A frightening-looking metal scythe. Damage 2k4. Critical x4.]],
}

newEntity{ base = "BASE_SCYTHE",
    name = "scythe",
    level_range = {1, 10},
    cost = 18,
    combat = {
        dam = {2,4},
        critical = 4,
    },
}