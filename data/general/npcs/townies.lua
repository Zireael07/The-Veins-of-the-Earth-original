--Veins of the Earth
--Zireael 2014-2015

local Talents = require("engine.interface.ActorTalents")

--Basics
newEntity{
    define_as = "BASE_NPC_NEUTRAL_T",
    type = "humanoid",
    body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
    ai = "humanoid_level", ai_state = { talent_in=3, ai_move="move_astar", },
    combat = { dam= {1,6} },
    faction = "neutral",
    open_door = true,
    show_portrait = true,
    resolvers.talents{ [Talents.T_SHOOT]=1,
    --give the simple weapon proficiency warrior/fighter/wizard class all have
    [Talents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
    },
    resolvers.wounds()
}

--Drow
newEntity{ define_as = "BASE_NPC_DROW_T",
    base = "BASE_NPC_NEUTRAL_T",
    name = "drow townie",
    display = 'h', color=colors.BLACK,
    subtype = "drow",
    image = "tiles/new/drow_rogue.png",

    level_range = {1, nil}, exp_worth = 400,
    max_life = resolvers.rngavg(3,5),
    stats = { str=13, dex=13, con=10, int=12, wis=9, cha=10, luc=10 },
    hit_die = 1,
    challenge = 1,
    desc = [[A dark silhouette.]],
    specialist_desc = [[Drow do not sleep or dream, and are immune to sleep effects. Instead, they refresh themselves by entering a meditative reverie for a few hours a night. Drow are resistant to magic, but once per day they can use spell-like abilities to create dancing lights, darkness, and faerie fire, which they use to disorient their foes.]],
    uncommon_desc = [[A drow’s sharp senses are attuned to life underground. Drow can see so well in the dark that sudden exposure to bright light can blind them.]],
    common_desc = [[Drow are known for their evil natures, matriarchal cultures, and zealous worship of malign, arachnid gods. They are more delicate than humans, but also more dextrous and more cunning. Drow are talented spellcasters, with drow women holding all divine roles. Culturally, drow train their children with the rapier, short sword, and hand crossbow, and they often poison their weapons.]],
    base_desc = [[This lithe, ebon-skinned humanoid is a dark elf, also known as a drow. These suberttanean elves speak both Elven and Undercommon, and typically also speak Common. Some drow also learn oher racial languages or a form of sign language known only to them.]],

    infravision = 6,
    skill_hide = 1,
    skill_movesilently = 1,
    skill_listen = 2,
    skill_search = 3,
    skill_spot = 2,
    alignment = "Neutral Evil",
    languages = {"Undercommon", "Drow"},
}


newEntity{ define_as = "BASE_NPC_DROW_NOBLE",
    base = "BASE_NPC_DROW_T",
    name = "female drow noble",
    image = "tiles/new/drow_noble_female.png",
    rarity = 6,
    max_life = resolvers.rngavg(13,15),
    stats = { str=13, dex=15, con=9, int=12, wis=13, cha=12, luc=10 },

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "rapier", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=4,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", },
    },

    resolvers.class()
--    can_talk = "shop",
}

newEntity{
    base = "BASE_NPC_DROW_NOBLE",
    name = "male drow noble",
    image = "tiles/mobiles/drow_noble_male.png",
    rarity = 5,
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow commoner",
    image = "tiles/new/drow_commoner.png",
    rarity = 2,
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger",  },
    },
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow female courtesan",
    image = "tiles/new/drow_courtesan_female.png",
    max_life = resolvers.rngavg(5,10),
    rarity = 5,
    stats = { str=8, dex=16, con=10, int=14, wis=9, cha=19, luc=10 },
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    can_talk = "female_courtesan",
    resolvers.classes{Rogue=1},
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow male courtesan",
    max_life = resolvers.rngavg(5,10),
    rarity = 5,
    stats = { str=8, dex=16, con=10, int=14, wis=9, cha=19, luc=10 },
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    can_talk = "male_courtesan",
    resolvers.classes{Rogue=1},
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow guard",
    image = "tiles/mobiles/npc/drow_fighter.png",
    max_life = resolvers.rngavg(15,20),
    rarity = 4,

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "rapier", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    resolvers.classes{Fighter=2},
}

--Based on PF Monster Codex
newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow house guard",
    image = "tiles/UT/drow_house_guard.png",
    stats = { str=14, dex=17, con=11, int=10, wis=12, cha=10, luc=10 },
    max_life = resolvers.rngavg(20,25),
    rarity = 8,
    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "rapier", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    resolvers.classes{Fighter=3},
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow house captain",
    image = "tiles/UT/drow_house_guard.png",
    stats = { str=14, dex=18, con=11, int=10, wis=12, cha=10, luc=10 },
    max_life = resolvers.rngavg(50,55),
    rarity = 10,
    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "rapier", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    resolvers.classes{Fighter=7},
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow priest",
    image = "tiles/mobiles/npc/drow_priest.png",
    max_life = resolvers.rngavg(30,35),
    rarity = 6,
    stats = { str=10, dex=12, con=12, int=14, wis=18, cha=15, luc=12 },
    resolvers.equip{
        full_id=true,
        { name = "full plate", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "heavy metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light flail", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    resolvers.classes{Cleric=5},
}

newEntity{
    base = "BASE_NPC_DROW_T",
    define_as = "BASE_NPC_DROW_BANK",
    name = "drow banker",
    image = "tiles/mobiles/npc/drow_fighter.png",
    max_life = resolvers.rngavg(15,20),
    rarity = 4,

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "rapier", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "bolts", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    can_talk = "banker",
    resolvers.classes{Fighter=2},
}
