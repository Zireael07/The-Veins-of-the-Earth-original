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
		spell_fail = 5
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +1",
    unided_name = "padded armor",
    identified = false,
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 2,
        max_dex_bonus = 8,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +2",
    unided_name = "padded armor",
    identified = false,
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 3,
        max_dex_bonus = 8,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +3",
    unided_name = "padded armor",
    identified = false,
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 4,
        max_dex_bonus = 8,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +4",
    unided_name = "padded armor",
    identified = false,
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 5,
        max_dex_bonus = 8,
       spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor +5",
    unided_name = "padded armor",
    identified = false,
    level_range = {1, 10},
    cost = 5,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    wielder = {
        combat_def = 6,
        max_dex_bonus = 8,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    level_range = {1, 10},
    cost = 10,
    wielder = {
		combat_def = 2,
		max_dex_bonus = 6,
		spell_fail = 10
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +1",
    unided_name = "leather armor",
    identified = false,
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 3,
        max_dex_bonus = 6,
		spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +2",
    unided_name = "leather armor",
    identified = false,
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 4,
        max_dex_bonus = 6,
        spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +3",
    unided_name = "leather armor",
    identified = false,
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 6,
        spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +4",
    unided_name = "leather armor",
    identified = false,
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 6,
        spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor +5",
    unided_name = "leather armor",
    identified = false,
    level_range = {1, 10},
    cost = 1010,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 6,
        spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    level_range = {1, 10},
    cost = 25,
    wielder = {
		combat_def = 3,
		max_dex_bonus = 5,
		spell_fail = 15,
		armor_penalty = 1
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +1",
    unided_name = "studded leather",
    identified = false,
    level_range = {1, 10},
    cost = 2025,
    wielder = {
        combat_def = 4,
        max_dex_bonus = 5,
		spell_fail = 15,
		armor_penalty = 1
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +2",
    unided_name = "studded leather",
    identified = false,
    level_range = {1, 10},
    cost = 8025,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 5,
        spell_fail = 15,
        armor_penalty = 1
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +3",
    unided_name = "studded leather",
    identified = false,
    level_range = {1, 10},
    cost = 16025,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 5,
        spell_fail = 15,
        armor_penalty = 1
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +4",
    unided_name = "studded leather",
    identified = false,
    level_range = {1, 10},
    cost = 32025,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 5,
        spell_fail = 15,
        armor_penalty = 1
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather +5",
    unided_name = "studded leather",
    identified = false,
    level_range = {1, 10},
    cost = 50025,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 5,
        spell_fail = 15,
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
		spell_fail = 20,
		armor_penalty = 2
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +1",
    unided_name = "chain shirt",
    identified = false,
    level_range = {1, 10},
    cost = 2100,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 4,
		spell_fail = 20,
		armor_penalty = 2
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +2",
    unided_name = "chain shirt",
    identified = false,
    level_range = {1, 10},
    cost = 4100,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 4,
        spell_fail = 20,
        armor_penalty = 2
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +3",
    unided_name = "chain shirt",
    identified = false,
    level_range = {1, 10},
    cost = 8100,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 4,
        spell_fail = 20,
        armor_penalty = 2
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +4",
    unided_name = "chain shirt",
    identified = false,
    level_range = {1, 10},
    cost = 16100,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 4,
        spell_fail = 20,
        armor_penalty = 2
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +5",
    unided_name = "chain shirt",
    identified = false,
    level_range = {1, 10},
    cost = 32100,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 4,
      spell_fail = 20,
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
		spell_fail = 30,
		armor_penalty = 5
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +1",
    unided_name = "chain mail",
    identified = false,
    level_range = {1, 10},
    cost = 2150,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 2,
		spell_fail = 30,
		armor_penalty = 5
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +2",
    unided_name = "chain mail",
    identified = false,
    level_range = {1, 10},
    cost = 4150,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 2,
        spell_fail = 30,
        armor_penalty = 5
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +3",
    unided_name = "chain mail",
    identified = false,
    level_range = {1, 10},
    cost = 8150,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 2,
        spell_fail = 30,
        armor_penalty = 5
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +4",
    unided_name = "chain mail",
    identified = false,
    level_range = {1, 10},
    cost = 16150,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 2,
        spell_fail = 30,
        armor_penalty = 5
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail +5",
    unided_name = "chain mail",
    identified = false,
    level_range = {1, 10},
    cost = 50150,
    wielder = {
        combat_def = 10,
        max_dex_bonus = 2,
        spell_fail = 30,
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
		spell_fail = 25,
		armor_penalty = 4
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +1",
    unided_name = "scale mail",
    identified = false,
    level_range = {1, 10},
    cost = 2050,
    wielder = {
        combat_def = 5,
        max_dex_bonus = 3,
		spell_fail = 25,
		armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +2",
    unided_name = "scale mail",
    identified = false,
    level_range = {1, 10},
    cost = 4050,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +3",
    unided_name = "scale mail",
    identified = false,
    level_range = {1, 10},
    cost = 8050,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +4",
    unided_name = "scale mail",
    identified = false,
    level_range = {1, 10},
    cost = 16050,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail +5",
    unided_name = "scale mail",
    identified = false,
    level_range = {1, 10},
    cost = 50050,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 3,
        spell_fail = 25,
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
		spell_fail = 25,
		armor_penalty = 4 
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +1",
    unided_name = "breastplate",
    identified = false,
    level_range = {1, 10},
    cost = 2200,
    wielder = {
        combat_def = 6,
        max_dex_bonus = 3,
		spell_fail = 25,
		armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +2",
    unided_name = "breastplate",
    identified = false,
    level_range = {1, 10},
    cost = 4200,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +3",
    unided_name = "breastplate",
    identified = false,
    level_range = {1, 10},
    cost = 8200,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +4",
    unided_name = "breastplate",
    identified = false,
    level_range = {1, 10},
    cost = 16200,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 3,
        spell_fail = 25,
        armor_penalty = 4
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate +5",
    unided_name = "breastplate",
    identified = false,
    level_range = {1, 10},
    cost = 50200,
    wielder = {
        combat_def = 10,
        max_dex_bonus = 3,
        spell_fail = 25,
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
		spell_fail = 40,
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +1",
    unided_name = "plate armor",
    identified = false,
    level_range = {1, 10},
    cost = 2600,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 0,
		spell_fail = 40,
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +2",
    unided_name = "plate armor",
    identified = false,
    level_range = {1, 10},
    cost = 4600,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 0,
        spell_fail = 40,
        armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +3",
    unided_name = "plate armor",
    identified = false,
    level_range = {1, 10},
    cost = 8600,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 0,
        spell_fail = 40,
        armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +4",
    unided_name = "plate armor",
    identified = false,
    level_range = {1, 10},
    cost = 16600,
    wielder = {
        combat_def = 10,
        max_dex_bonus = 0,
        spell_fail = 40,
        armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor +5",
    unided_name = "plate armor",
    identified = false,
    level_range = {1, 10},
    cost = 50600,
    wielder = {
        combat_def = 11,
        max_dex_bonus = 0,
        spell_fail = 40,
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
		spell_fail = 35,
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +1",
    unided_name = "full plate",
    identified = false,
    level_range = {1, 10},
    cost = 3500,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 1,
		spell_fail = 35,
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +2",
    unided_name = "full plate",
    identified = false,
    level_range = {1, 10},
    cost = 5500,
    wielder = {
        combat_def = 10,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +3",
    unided_name = "full plate",
    identified = false,
    level_range = {1, 10},
    cost = 9500,
    wielder = {
        combat_def = 11,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +4",
    unided_name = "full plate",
    identified = false,
    level_range = {1, 10},
    cost = 17500,
    wielder = {
        combat_def = 12,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate +5",
    unided_name = "full plate",
    identified = false,
    level_range = {1, 10},
    cost = 51500,
    wielder = {
        combat_def = 13,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail",
    unided_name = "banded mail",
    level_range = {1, 10},
    cost = 250,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 0,
		spell_fail = 35,
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +1",
    unided_name = "banded mail",
    identified = false,
    level_range = {1, 10},
    cost = 2250,
    wielder = {
        combat_def = 7,
        max_dex_bonus = 1,
		spell_fail = 35,
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +2",
    identified = false,
    level_range = {1, 10},
    cost = 4250,
    wielder = {
        combat_def = 8,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +3",
    unided_name = "banded mail",
    level_range = {1, 10},
    cost = 8250,
    wielder = {
        combat_def = 9,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +4",
    unided_name = "banded mail",
    identified = false,
    level_range = {1, 10},
    cost = 16250,
    wielder = {
        combat_def = 10,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail +5",
    unided_name = "banded mail",
    identified = false,
    level_range = {1, 10},
    cost = 50250,
    wielder = {
        combat_def = 11,
        max_dex_bonus = 1,
        spell_fail = 35,
        armor_penalty = 6
    },
}
