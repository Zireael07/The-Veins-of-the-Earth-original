--Simple weapons

newEntity{
    define_as = "BASE_DAGGER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="dagger",
    display = "|", color=colors.SLATE,
    encumber = 3,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dagger",
    desc = [[A normal trusty dagger.]],
}

newEntity{ base = "BASE_DAGGER",
    name = "iron dagger",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,4},
        threat = 1,
    },
}

newEntity{
    define_as = "BASE_LSPEAR",
    slot = "MAIN_HAND", 
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic long spear",
    desc = [[A wooden long spear.]],
}

newEntity{ base = "BASE_LSPEAR",
    name = "spear",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,8},
        critical = 3,
    },
}

newEntity{
    define_as = "BASE_SSPEAR",
    slot = "MAIN_HAND", 
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic short spear",
    desc = [[A wooden short spear.]],
}

newEntity{ base = "BASE_SSPEAR",
    name = "spear",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_HMACE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="mace",
    display = "\\", color=colors.SLATE,
    encumber = 8,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic mace",
    desc = [[A metal mace.]],
}

newEntity{ base = "BASE_HMACE",
    name = "heavy mace",
    level_range = {1, 10},
    cost = 12,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_LMACE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="mace",
    display = "\\", color=colors.SLATE,
    encumber = 4,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic mace",
    desc = [[A metal mace.]],
}

newEntity{ base = "BASE_LMACE",
    name = "light mace",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_CLUB",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="club",
    display = "\\", color=colors.SLATE,
    encumber = 3,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic club",
    desc = [[A wooden club.]],
}

newEntity{ base = "BASE_CLUB",
    name = "club",
    level_range = {1, 10},
    cost = 0,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_MSTAR",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="morningstar",
    display = "\\", color=colors.SLATE,
    encumber = 6,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic morningstar",
    desc = [[A metal morningstar.]],
}

newEntity{ base = "BASE_MSTAR",
    name = "morningstar",
    level_range = {1, 10},
    cost = 8,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_STAFF",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="staff",
    display = "\\", color=colors.BROWN,
    encumber = 4,
    rarity = 2,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic staff",
    desc = [[A wooden staff.]],
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

newEntity{
    define_as = "BASE_LHAMMER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="hammer",
    display = "\\", color=colors.SLATE,
    encumber = 4,
    rarity = 1,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic light hammer",
    desc = [[A light metal hammer.]],
}

newEntity{ base = "BASE_LHAMMER",
    name = "light hammer",
    level_range = {1, 10},
    cost = 1,
    combat = {
        dam = {1,4},
    },
}

newEntity{
    define_as = "BASE_HANDAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="handaxe",
    display = "\\", color=colors.SLATE,
    encumber = 3,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic handaxe",
    desc = [[A normal handaxe.]],
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

newEntity{
    define_as = "BASE_KUKRI",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="kukri",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic kukri",
    desc = [[A curved blade.]],
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

newEntity{
    define_as = "BASE_SHORTSWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="shortsword",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic short sword",
    desc = [[A curved short sword.]],
}

newEntity{ base = "BASE_KUKRI",
    name = "short sword",
    level_range = {1, 10},
    cost = 10,
    combat = {
        dam = {1,6},
        threat = 1,
    },
}

newEntity{
    define_as = "BASE_BATTLEAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "\\", color=colors.SLATE,
    encumber = 12,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic battleaxe",
    desc = [[A normal battleaxe.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_SWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "|", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sword",
    desc = [[A trusty sword.]],
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

newEntity{
    define_as = "BASE_FLAIL",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="flail",
    display = "/", color=colors.SLATE,
    encumber = 5,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal flail",
    desc = [[A metal flail.]],
}

newEntity{ base = "BASE_FLAIL",
    name = "flail",
    level_range = {1, 10},
    cost = 8,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_RAPIER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="rapier",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 6,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal rapier",
    desc = [[A metal rapier.]],
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

newEntity{
    define_as = "BASE_SCIMITAR",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="scimitar",
    display = "|", color=colors.SLATE,
    encumber = 4,
    rarity = 7,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal scimitar",
    desc = [[A metal scimitar.]],
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
newEntity{
    define_as = "BASE_TRIDENT",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="trident",
    display = "/", color=colors.SLATE,
    encumber = 4,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal trident",
    desc = [[A metal trident.]],
}

newEntity{ base = "BASE_TRIDENT",
    name = "trident",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_WARHAMMER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="hammer",
    display = "\\", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal warhammer",
    desc = [[A metal warhammer.]],
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
newEntity{
    define_as = "BASE_FALCHION",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="falchion",
    display = "|", color=colors.SLATE,
    encumber = 8,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a metal falchion",
    desc = [[A metal falchion.]],
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

newEntity{
    define_as = "BASE_GREATAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    display = "\\", color=colors.SLATE,
    encumber = 12,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a great axe",
    desc = [[A great metal axe.]],
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

newEntity{
    define_as = "BASE_GREATCLUB",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="club",
    display = "\\", color=colors.SLATE,
    encumber = 8,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a greatclub",
    desc = [[A wooden greatclub.]],
}

newEntity{ base = "BASE_GREATCLUB",
    name = "greatclub",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,10},
    },
}

newEntity{
    define_as = "BASE_HEAVYFLAIL",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="flail",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a heavy flail",
    desc = [[A heavy flail.]],
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

newEntity{
    define_as = "BASE_GREATSWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "|", color=colors.SLATE,
    encumber = 8,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a greatsword",
    desc = [[A metal great two-handed sword.]],
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

newEntity{
    define_as = "BASE_HALBERD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="halberd",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a halberd",
    desc = [[A metal great two-handed sword.]],
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

newEntity{
    define_as = "BASE_SCYTHE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="scythe",
    display = "\\", color=colors.SLATE,
    encumber = 10,
    rarity = 12,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a scythe",
    desc = [[A frightening-looking metal scythe.]],
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