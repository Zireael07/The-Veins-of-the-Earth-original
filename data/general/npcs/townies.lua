--Veins of the Earth
--Zireael 2014-2015

local Talents = require("engine.interface.ActorTalents")

--Basics
newEntity{
    define_as = "BASE_NPC_NEUTRAL_T",
    type = "humanoid",
    body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
    ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_astar", },
    combat = { dam= {1,6} },
    faction = "neutral",
    open_door = true,
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
    image = "tiles/newtiles/drow_rogue.png",

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
}


newEntity{ define_as = "BASE_NPC_DROW_NOBLE",
    base = "BASE_NPC_DROW_T",
    name = "female drow noble",
    image = "tiles/newtiles/drow_noble_female.png",
    rarity = 3,
    max_life = resolvers.rngavg(13,15),
    stats = { str=13, dex=15, con=9, int=12, wis=13, cha=12, luc=10 },

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}  },
        { name = "light metal shield", not_properties={"cursed"}  },
        { name = "rapier", not_properties={"cursed"}  },
        { name = "bolts", not_properties={"cursed"}  },
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
    image = "tiles/newtiles/drow_noble_male.png",
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow commoner",
    rarity = 2,
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger",  },
    },
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow female courtesan",
    rarity = 5,
    stats = { str=8, dex=16, con=10, int=14, wis=9, cha=19, luc=10 },
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger",  },
    },
    can_talk = "female_courtesan",
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow male courtesan",
    rarity = 5,
    stats = { str=8, dex=16, con=10, int=14, wis=9, cha=19, luc=10 },
    resolvers.equipnoncursed{
        full_id=true,
        { name = "dagger",  },
    },
    can_talk = "male_courtesan",
}

newEntity{
    base = "BASE_NPC_DROW_T",
    name = "drow guard",
    rarity = 4,

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}  },
        { name = "light metal shield", not_properties={"cursed"}  },
        { name = "rapier", not_properties={"cursed"}  },
        { name = "bolts", not_properties={"cursed"}  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "hand crossbow", },
    },
}
