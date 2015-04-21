--Veins of the Earth
--Zireael 2014

local Talents = require "engine.interface.ActorTalents"

--Piecemeal armor definitions

-- Light base definitions
newEntity{
    define_as = "BASE_LIGHT_ARMOR_BODY",
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

newEntity{
    define_as = "BASE_LIGHT_ARMOR_ARMS",
    slot = "ARMS",
    type = "armor", subtype="light",
--    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 2,
    rarity = 5,
    name = "light armor",
    desc = "A simple padded armor. Does not offer much protection.\n\n Light armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_LIGHT_ARMOR_LEGS",
    slot = "LEGS",
    type = "armor", subtype="light",
--    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 3,
    rarity = 5,
    name = "light armor",
    desc = "A simple padded armor. Does not offer much protection.\n\n Light armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

--Medium base definitions
newEntity{
    define_as = "BASE_MEDIUM_ARMOR_BODY",
    slot = "BODY",
    type = "armor", subtype="medium",
    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_MEDIUM_ARMOR_PROFICIENCY }, },
    encumber = 15,
    rarity = 5,
    name = "medium armor",
    desc = "A suit of armour made of mail.\n\n Medium armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_MEDIUM_ARMOR_ARMS",
    slot = "ARMS",
    type = "armor", subtype="medium",
--    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 5,
    rarity = 5,
    name = "medium armor",
    desc = "A suit of armour made of mail.\n\n Medium armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_MEDIUM_ARMOR_LEGS",
    slot = "LEGS",
    type = "armor", subtype="medium",
--    moddable_tile = resolvers.moddable_tile("light"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    encumber = 10,
    rarity = 5,
    name = "medium armor",
    desc = "A suit of armour made of mail.\n\n Medium armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

--Heavy base definitions
newEntity{
    define_as = "BASE_HEAVY_ARMOR_BODY",
    slot = "BODY",
    type = "armor", subtype="medium",
    moddable_tile = resolvers.moddable_tile("heavy"),
    require = { talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY }, },
    encumber = 25,
    rarity = 8,
    name = "heavy armor",
    desc = "A suit of armour made of plate.\n\n Heavy armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_HEAVY_ARMOR_ARMS",
    slot = "ARMS",
    type = "armor", subtype="heavy",
--    moddable_tile = resolvers.moddable_tile("heavy"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY }, },
    encumber = 5,
    rarity = 5,
    name = "heavy armor",
    desc = "A suit of armour made of plate.\n\n Heavy armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_HEAVY_ARMOR_LEGS",
    slot = "LEGS",
    type = "armor", subtype="heavy",
--    moddable_tile = resolvers.moddable_tile("heavy"),
    display = "(", color=colors.SLATE,
    require = { talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY }, },
    encumber = 10,
    rarity = 5,
    name = "heavy armor",
    desc = "A suit of armour made of plate.\n\n Heavy armor.",
    egos = "/data/general/objects/properties/armor.lua", egos_chance = { prefix=30, suffix=70},
}


--Light arms pieces
--[[newEntity{ base = "BASE_LIGHT_ARMOR_ARMS",
    name = "lamellar bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    encumber = 5,
    cost = 15,
    desc = "Lamellar bracers worn on your arms. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 3,
        armor_penalty = 1,
        spell_fail = 20
    },
}]]

newEntity{ base = "BASE_LIGHT_ARMOR_ARMS",
    name = "leather bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 2,
    desc = "Leather bracers worn on your arms. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 6,
        spell_fail = 10
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_ARMS",
    name = "padded bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 1,
    desc = "Padded bracers worn on your arms. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 8,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_ARMS",
    name = "studded leather bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    desc = "Studded leather bracers worn on your arms. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 5,
        spell_fail = 15
    },
}

--TO DO: wooden, quilted cloth?

--Medium arms pieces
newEntity{ base = "BASE_MEDIUM_ARMOR_ARMS",
    name = "hide bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 2,
    encumber = 3,
    desc = "Hide bracers worn on your arms. Offer little protection.\n\n Medium armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 4,
        armor_penalty = 2,
        spell_fail = 20
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_ARMS",
    name = "chain bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 25,
    desc = "Chainmail bracers worn on your arms. Offer little protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 2,
        armor_penalty = 3,
        spell_fail = 30
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_ARMS",
    name = "scale bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 10,
    desc = "Scale bracers worn on your arms. Offer little protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 3,
        armor_penalty = 2,
        spell_fail = 25
    },
}

--TO DO: horn lamellar, steel lamellar, mountain pattern

--Heavy arm pieces
newEntity{ base = "BASE_HEAVY_ARMOR_ARMS",
    name = "agile plate bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 425,
    desc = "Well-connected plate bracers worn on your arms. Offer significant protection while allowing for full range of motion.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 0,
        armor_penalty = 7,
        spell_fail = 40
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_ARMS",
    name = "banded bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 50,
    desc = "Banded bracers worn on your arms. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 1,
        armor_penalty = 3,
        spell_fail = 35
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_ARMS",
    name = "splint bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 50,
    desc = "Splint armor bracers worn on your arms. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 0,
        armor_penalty = 4,
        spell_fail = 40
    },
}

--Is there a mistake here? It's worse than agile plate!
newEntity{ base = "BASE_HEAVY_ARMOR_ARMS",
    name = "plate bracers",
--    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 375,
    encumber = 10,
    desc = "Plate bracers worn on your arms. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 1,
        armor_penalty = 7,
        spell_fail = 35
    },
}

--Light leg pieces
newEntity{ base = "BASE_LIGHT_ARMOR_LEGS",
    name = "leather greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 3,
    desc = "Leather greaves worn on your legs. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 6,
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_LEGS",
    name = "padded greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 1,
    desc = "Padded greaves worn on your legs. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 8,
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_LEGS",
    name = "studded leather greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    desc = "Studded leather greaves worn on your legs. Offer little protection.\n\n Light armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 5,
        spell_fail = 10,
    },
}

--TO DO: leather lamellar, quilted, wooden

--Medium leg pieces
newEntity{ base = "BASE_MEDIUM_ARMOR_LEGS",
    name = "chain greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 25,
    desc = "Chainmail greaves worn on your legs. Offer little protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 2,
        armor_penalty = 2,
        spell_fail = 15,
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_LEGS",
    name = "hide greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 25,
    encumber = 7,
    desc = "Hide greaves worn on your legs. Offer little protection.\n\n Light armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 4,
        armor_penalty = 2,
        spell_fail = 10,
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_LEGS",
    name = "scale greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 10,
    desc = "Scale greaves worn on your legs. Offer little protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 3,
        armor_penalty = 2,
        spell_fail = 15,
    },
}

--Heavy leg pieces
newEntity{ base = "BASE_HEAVY_ARMOR_LEGS",
    name = "banded greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 50,
    desc = "Banded greaves worn on your legs. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 1,
        armor_penalty = 3,
        spell_fail = 15,
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_LEGS",
    name = "splint greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 50,
    desc = "Splint greaves worn on your legs. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 0,
        armor_penalty = 4,
        spell_fail = 20,
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_LEGS",
    name = "plate greaves",
    --    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 925,
    desc = "Plate greaves worn on your legs. Offer significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 1,
        armor_penalty = 3,
        spell_fail = 20,
    },
}

--Light torso pieces
newEntity{ base = "BASE_LIGHT_ARMOR_BODY",
    name = "padded armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 3,
    encumber = 5,
    desc = "A simple padded shirt. Does not offer much protection.\n\n Light armor.",
    wielder = {
    --    combat_armor_ac = 1,
        max_dex_bonus = 8,
        spell_fail = 5,
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_BODY",
    name = "leather armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 5,
    desc = "A simple leather cuirass. Does not offer much protection.\n\n Light armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 6,
        spell_fail = 10,
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR_BODY",
    name = "studded leather armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 15,
    desc = "A studded leather cuirass. Does not offer much protection.\n\n Light armor.",
    wielder = {
        combat_armor_ac = 1,
        max_dex_bonus = 5,
        spell_fail = 15,
    },
}

--TO DO: quilted, wooden, leather lamellar, lamellar cuirass

--Medium torso pieces
newEntity{ base = "BASE_MEDIUM_ARMOR_BODY",
    name = "hide armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 10,
    desc = "A stiff leather shirt. Does not offer much protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 2,
        max_dex_bonus = 4,
        armor_penalty = 2,
        spell_fail = 20,
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_BODY",
    name = "scale armor",
    image = "tiles/leather_armor.png",
    level_range = {1, 10},
    cost = 30,
    desc = "A scale cuirass. Does not offer much protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 2,
        max_dex_bonus = 3,
        armor_penalty = 2,
        spell_fail = 25,
    },
}

--Should count as light if worn by itself only
newEntity{ base = "BASE_MEDIUM_ARMOR_BODY",
    name = "chain armor",
    image = "tiles/chain_shirt.png",
    level_range = {1, 10},
    cost = 100,
    encumber = 25,
    desc = "A set of chain links which covers the torso only. Does not offer much protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 4,
        max_dex_bonus = 4,
        armor_penalty = 2,
        spell_fail = 30,
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_BODY",
    name = "armored coat",
    image = "tiles/chain_shirt.png",
    level_range = {1, 10},
    cost = 50,
    encumber = 20,
    desc = "A set of chain links which covers the back only. Does not offer much protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 4,
        max_dex_bonus = 3,
        armor_penalty = 2,
        spell_fail = 20,
    },
}

newEntity{ base = "BASE_MEDIUM_ARMOR_BODY",
    name = "four-mirror armor",
    image = "tiles/breastplate.png",
    level_range = {1, 10},
    cost = 20,
    encumber = 40,
    desc = "Four pieces of plate tied together by leather. Does not offer much protection.\n\n Medium armor.",
    wielder = {
        combat_armor_ac = 5,
        max_dex_bonus = 4,
        armor_penalty = 5,
        spell_fail = 30,
    },
}

--TO DO: Steel lamellar, horn lamellar, mountain pattern

--Heavy torso pieces
newEntity{ base = "BASE_HEAVY_ARMOR_BODY",
    name = "banded armor",
    image = "tiles/banded_armor.png",
    level_range = {1, 10},
    cost = 150,
    encumber = 20,
    desc = "A banded mail cuirass. Offers significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 4,
        max_dex_bonus = 1,
        armor_penalty = 2,
        spell_fail = 35,
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_BODY",
    name = "splint armor",
    image = "tiles/banded_armor.png",
    level_range = {1, 10},
    cost = 100,
    desc = "A splint mail cuirass. Offers significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 4,
        max_dex_bonus = 0,
        armor_penalty = 3,
        spell_fail = 40,
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_BODY",
    name = "agile plate armor",
    image = "tiles/plate_armor.png",
    level_range = {1, 10},
    cost = 400,
    desc = "A plate breastplate, allowing for full range of motion. Offers significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 6,
        max_dex_bonus = 3,
        armor_penalty = 4,
        spell_fail = 25,
    },
}

newEntity{ base = "BASE_HEAVY_ARMOR_BODY",
    name = "plate armor",
    image = "tiles/plate_armor.png",
    level_range = {1, 10},
    cost = 200,
    encumber = 30,
    desc = "A plate breastplate. Offers significant protection.\n\n Heavy armor.",
    wielder = {
        combat_armor_ac = 6,
        max_dex_bonus = 3,
        armor_penalty = 4,
        spell_fail = 35,
    },
}
