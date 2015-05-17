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
    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 10,
    rarity = 5,
    name = "light armor",
    desc = "A simple padded armor. Does not offer much protection.\n\n Light armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "cord armor",
    image = "tiles/object/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    desc = "Simple cord twined around your body. Offers little protection.\n\n Light armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 7,
        spell_fail = 5
    },
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor",
    image = "tiles/object/leather_armor.png",
    level_range = {1, 10},
--    cost = 5,
    cost = resolvers.value{platinum=1},
    wielder = {
		combat_armor_ac = 1,
		max_dex_bonus = 8,
		spell_fail = 5
	},
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    image = "tiles/object/leather_armor.png",
    level_range = {1, 10},
--    cost = 10,
    cost = resolvers.value{silver=150},
    desc = "A set of leather armor.\n\n Light armor.",
    wielder = {
		combat_armor_ac = 2,
		max_dex_bonus = 6,
		spell_fail = 10
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    image = "tiles/object/studded_armor.png",
    level_range = {1, 10},
--    cost = 25,
    cost = resolvers.value{silver=525},
    wielder = {
		combat_armor_ac = 3,
		max_dex_bonus = 5,
		spell_fail = 15,
		armor_penalty = 1
	},
}


newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt",
    image = "tiles/object/chain_shirt.png",
    level_range = {1, 10},
--    cost = 100,
    cost = resolvers.value{silver=1250},
    desc = "A set of chain links which covers the torso only.\n\n Light armor.",
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
    moddable_tile = resolvers.moddable_tile("light"),
    encumber = 40,
    rarity = 2,
    name = "medium armor",
    desc = "A suit of armour made of mail.\n\n Medium armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "chain mail",
    image = "tiles/object/chain_armor.png",
    level_range = {1, 10},
--    cost = 150,
    cost = resolvers.value{platinum=2},
    wielder = {
		combat_armor_ac = 5,
		max_dex_bonus = 2,
		spell_fail = 30,
		armor_penalty = 5
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "scale mail",
    image = "tiles/object/scale_armor.png",
    level_range = {1, 10},
--    cost = 50,
    cost = resolvers.value{silver=1700},
    desc = "A suit of armour made of scale.\n\n Medium armor.",
    wielder = {
		combat_armor_ac = 4,
		max_dex_bonus = 3,
		spell_fail = 25,
		armor_penalty = 4
	},
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    name = "breastplate",
    image = "tiles/object/breastplate.png",
    level_range = {1, 10},
--    cost = 200,
    cost = resolvers.value{silver=4500},
    desc = "This armor only covers the torso.\n\n Medium armor.",
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
    moddable_tile = resolvers.moddable_tile("heavy"),
    encumber = 50,
    rarity = 8,
    name = "heavy armor",
    desc = "A suit of armour made of plate.\n\n Heavy armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "plate armor",
    image = "tiles/object/plate_armor.png",
    level_range = {1, 10},
--    cost = 600,
    cost = resolvers.value{silver=6500},
    wielder = {
        combat_armor_ac = 7,
        max_dex_bonus = 0,
		spell_fail = 40,
		armor_penalty = 7
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "full plate",
    image = "tiles/object/full_plate.png",
    level_range = {1, 10},
--    cost = 1500,
    cost = resolvers.value{silver=9000},
    desc = "A suit of full plate armour.\n\n Heavy armor.",
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
    image = "tiles/object/banded_armor.png",
    level_range = {1, 10},
--    cost = 250,
    cost = resolvers.value{platinum=8},
    desc = "A suit of banded mail.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 7,
        max_dex_bonus = 0,
		spell_fail = 35,
		armor_penalty = 6
    },
}
