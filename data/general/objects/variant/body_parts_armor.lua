--Veins of the Earth
--Zireael 2016

local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_OUTFIT",
    slot = "BODY",
    type = "armor",
    material = "leather",
}

newEntity{
    define_as = "BASE_ARMOR",
    slot = "BODY",
    type = "armor",
    addons = "/data/general/objects/properties/bonus_armor.lua",
    egos = "/data/general/objects/properties/armor.lua",
    durability = resolvers.armor_durability(),
    egos_chance = resolvers.ego_chance(), -- egos_chance = { prefix=30, suffix=70},
}

--Armors
newEntity{ base = "BASE_ARMOR",
    define_as = "BASE_LIGHT_ARMOR",
    slot = "BODY",
    type = "armor", subtype="light",
    moddable_tile = resolvers.moddable_tile("leather"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 10,
    material = "leather",
    name = "light armor",
    desc = "A simple padded armor. Does not offer much protection.\n\n Light armor.",
--    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    define_as = "BASE_LEATHER_ARMOR",
    name = "leather armor", short_name = "leather",
    image = "tiles/object/armor_leather.png",
    level_range = {1, 10},
    rarity = 5,
--    cost = 10,
    cost = resolvers.value{silver=150},
    desc = "A set of leather armor.\n\n Light armor.",
    wielder = {
		combat_armor = 2,
		max_dex_bonus = 6,
		spell_fail = 10
    	},
}

newEntity{ base = "BASE_ARMOR",
    define_as = "BASE_MEDIUM_ARMOR",
    slot = "BODY",
    type = "armor", subtype="medium",
    display = "]", color=colors.SLATE,
    require = { talent = { Talents.T_MEDIUM_ARMOR_PROFICIENCY }, },
    moddable_tile = resolvers.moddable_tile("mail"),
    encumber = 40,
    name = "medium armor",
    material = "steel",
    desc = "A suit of armour made of mail.\n\n Medium armor.",
}

newEntity{ base = "BASE_MEDIUM_ARMOR",
    define_as = "BASE_CHAIN_MAIL",
    name = "chain mail", short_name = "mail",
    image = "tiles/object/chain_armor.png",
    level_range = {1, 10},
    rarity = 12,
--    cost = 150,
    cost = resolvers.value{platinum=2},
    wielder = {
		combat_armor = 5,
		max_dex_bonus = 2,
		spell_fail = 30,
		armor_penalty = 5
	},
}

newEntity{ base = "BASE_ARMOR",
    define_as = "BASE_HEAVY_ARMOR",
    slot = "BODY",
    type = "armor", subtype="heavy",
    display = "[", color=colors.SLATE,
    require = { talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY }, },
    moddable_tile = resolvers.moddable_tile("heavy"),
    encumber = 50,
    name = "heavy armor",
    material = "steel",
    desc = "A suit of armour made of plate.\n\n Heavy armor.",
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    define_as = "BASE_PLATE_ARMOR",
    name = "plate armor", short_name = "plate",
    image = "tiles/object/plate_armor.png",
    level_range = {1, 10},
    rarity = 18,
--    cost = 600,
    cost = resolvers.value{silver=6500},
    wielder = {
        combat_armor = 7,
        max_dex_bonus = 0,
		spell_fail = 40,
		armor_penalty = 7
    },
}

local function newArmor(base, name, location, slot, ac)
    newEntity{ base = base,
        name = name,
        slot = slot,
        wielder = {
            ["combat_armor_"..location] = ac,
        }
    }
end

newArmor("BASE_LEATHER_ARMOR", "leather armor", "torso", "BODY", 2)
newArmor("BASE_CHAIN_MAIL", "chain mail", "torso", "BODY", 5)
newArmor("BASE_PLATE_ARMOR", "plate armor", "torso", "BODY", 7)

newArmor("BASE_LEATHER_ARMOR", "leather bracers", "arms", "ARMS", 2)
newArmor("BASE_CHAIN_MAIL", "chain bracers", "arms", "ARMS", 5)
newArmor("BASE_PLATE_ARMOR", "plate bracers", "arms", "ARMS", 7)

newArmor("BASE_LEATHER_ARMOR", "leather greaves", "legs", "LEGS", 2)
newArmor("BASE_CHAIN_MAIL", "chain greaves", "legs", "LEGS", 5)
newArmor("BASE_PLATE_ARMOR", "plate greaves", "legs", "LEGS", 7)

newArmor("BASE_LEATHER_ARMOR", "leather helmet", "head", "HELM", 2)
newArmor("BASE_CHAIN_MAIL", "chain helmet", "head", "HELM", 5)
newArmor("BASE_PLATE_ARMOR", "plate helmet", "head", "HELM", 7)
