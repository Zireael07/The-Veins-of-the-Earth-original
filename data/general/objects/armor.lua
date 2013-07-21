local Talents = require "engine.interface.ActorTalents"

--Armors
newEntity{
    define_as = "BASE_LIGHT_ARMOR",
    slot = "BODY",
    type = "armor", subtype="light",
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 10,
    rarity = 5,
    name = "light armor",
    desc = [[A simple padded armor. Doesn't protect from much.]],
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor",
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
		combat_def = 1,
		max_dex_bonus = 8,
--		spell_fail = 5
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +1",
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 2,
        max_dex_bonus = 8
--        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    level_range = {1, 10},
    cost = 10,
    wielder = {
		combat_def = 2,
		max_dex_bonus = 6,
--		spell_fail = 10
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +1",
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 3,
        max_dex_bonus = 6,
--		spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    level_range = {1, 10},
    cost = 25,
    wielder = {
		combat_def = 3,
		max_dex_bonus = 5,
--		spell_fail = 15
		armor_penalty = 1
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +1",
    level_range = {1, 10},
    cost = 2025,
    wielder = {
        combat_def = 4,
        max_dex_bonus = 5,
--		spell_fail = 15
		armor_penalty = 1
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt",
    level_range = {1, 10},
    cost = 100,
    wielder = {
		combat_def = 4,
		max_dex_bonus = 4,
--		spell_fail = 20
		armor_penalty = 2
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +1",
    level_range = {1, 10},
    cost = 2100,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 4,
--		spell_fail = 20
		armor_penalty = 2
    },
}

newEntity{
    define_as = "BASE_MEDIUM_ARMOR",
    slot = "BODY",
    type = "armor", subtype="medium",
    display = "]", color=colors.SLATE,
    require = { talent = { Talents.T_MEDIUM_ARMOR_PROFICIENCY }, },
    encumber = 40,
    rarity = 2,
    name = "medium armor",
    desc = [[A suit of armour made of mail.]],
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail",
    level_range = {1, 10},
    cost = 150,
    wielder = {
		combat_def = 5,
		max_dex_bonus = 2,
--		spell_fail = 30
		armor_penalty = 5
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +1",
    level_range = {1, 10},
    cost = 2150,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 2,
--		spell_fail = 30
		armor_penalty = 5
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail",
    level_range = {1, 10},
    cost = 50,
    wielder = {
		combat_def = 4,
		max_dex_bonus = 3,
--		spell_fail = 25
		armor_penalty = 4
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +1",
    level_range = {1, 10},
    cost = 2050,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 3,
--		spell_fail = 25
		armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate",
    level_range = {1, 10},
    cost = 200,
    wielder = {
		combat_def = 5,
		max_dex_bonus = 3,
--		spell_fail = 25
		armor_penalty = 4 
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +1",
    level_range = {1, 10},
    cost = 2200,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 3,
--		spell_fail = 25
		armor_penalty = 4
    },
}

newEntity{
    define_as = "BASE_HEAVY_ARMOR",
    slot = "BODY",
    type = "armor", subtype="heavy",
    display = "[", color=colors.SLATE,
    require = { talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY }, },
    encumber = 50,
    rarity = 8,
    name = "heavy armor",
    desc = [[A suit of armour made of plate.]],
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor",
    level_range = {1, 10},
    cost = 600,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 0,
--		spell_fail = 40
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +1",
    level_range = {1, 10},
    cost = 2600,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 0,
--		spell_fail = 40
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate",
    level_range = {1, 10},
    cost = 1500,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 1,
--		spell_fail = 35
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +1",
    level_range = {1, 10},
    cost = 3500,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 1,
--		spell_fail = 35
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail",
    level_range = {1, 10},
    cost = 250,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 0,
--		spell_fail = 35
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +1",
    level_range = {1, 10},
    cost = 2250,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 1,
--		spell_fail = 35
		armor_penalty = 6
    },
}
