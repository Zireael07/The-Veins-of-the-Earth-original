local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_ARMOR",
    slot = "BODY",
    type = "armor",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

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
    desc = "A simple padded armor. Does not offer much protection.\n\n Light armor. AC +1. Max Dex bonus to AC 8. Spell failure chance 5%.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "cord armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    desc = "Simple cord twined around your body. Offers little protection.\n\n Light armor. AC +1. Max Dex bonus to AC 7. Spell failure chance 5%.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 7,
        spell_fail = 5
    },
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    wielder = {
		combat_armor_ac = 1,
		max_dex_bonus = 8,
		spell_fail = 5
	},
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 10,
    desc = "A set of leather armor.\n\n Light armor. AC +2. Max Dex bonus to AC 6. Spell failure chance 10%.",
    wielder = {
		combat_armor_ac = 2,
		max_dex_bonus = 6,
		spell_fail = 10
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    image = "tiles/studded_armor.png",
    level_range = {1, 10},
    cost = 25,
    wielder = {
		combat_armor_ac = 3,
		max_dex_bonus = 5,
		spell_fail = 15,
		armor_penalty = 1
	},
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt",
    image = "tiles/chain_shirt.png",
    level_range = {1, 10},
    cost = 100,
    desc = "A set of chain links which covers the torso only.\n\n Light armor. AC +5. Max Dex bonus to AC 4. Spell failure chance 20%. Armor check penalty -2.",
    wielder = {
		combat_armor_ac = 4,
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
    desc = "A suit of armour made of mail.\n\n Medium armor. AC +5. Max Dex bonus to AC 2. Spell failure chance 30%. Armor check penalty -5.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail",
    image = "tiles/chain_armor.png",
    level_range = {1, 10},
    cost = 150,
    wielder = {
		combat_armor_ac = 5,
		max_dex_bonus = 2,
		spell_fail = 30,
		armor_penalty = 5
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail",
    image = "tiles/scale_armor.png",
    level_range = {1, 10},
    cost = 50,
    desc = "A suit of armour made of scale.\n\n Medium armor. AC +4. Max Dex bonus to AC 3. Spell failure chance 25%. Armor check penalty -4.",
    wielder = {
		combat_armor_ac = 4,
		max_dex_bonus = 3,
		spell_fail = 25,
		armor_penalty = 4
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate",
    image = "tiles/breastplate.png",
    level_range = {1, 10},
    cost = 200,
    desc = "This armor only covers the torso.\n\n Medium armor. AC +5. Max Dex bonus to AC 3. Spell failure chance 25%. Armor check penalty -4.",
    wielder = {
		combat_armor_ac = 5,
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
    desc = "A suit of armour made of plate.\n\n Heavy armor. AC +7. Max Dex bonus to AC 0. Spell failure chance 40%. Armor check penalty -7.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor",
    image = "tiles/plate_armor.png",
    level_range = {1, 10},
    cost = 600,
    wielder = {
        combat_armor_ac = 7,
        max_dex_bonus = 0,
		spell_fail = 40,
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate",
    image = "tiles/full_plate.png",
    level_range = {1, 10},
    cost = 1500,
    desc = "A suit of full plate armour.\n\n Heavy armor. AC +8. Max Dex bonus to AC 1. Spell failure chance 35%. Armor check penalty -6.",
    wielder = {
        combat_armor_ac = 8,
        max_dex_bonus = 1,
		spell_fail = 35,
		armor_penalty = 6
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "banded mail",
    unided_name = "banded mail",
    image = "tiles/banded_armor.png",
    level_range = {1, 10},
    cost = 250,
    desc = "A suit of banded mail.\n\n Heavy armor. AC +7. Max Dex bonus to AC 0. Spell failure chance 35%. Armor check penalty -6.",
    wielder = {
        combat_armor_ac = 7,
        max_dex_bonus = 0,
		spell_fail = 35,
		armor_penalty = 6
    },
}