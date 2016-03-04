--Veins of the Earth
--Zireael 2015-2016

local Talents = require("engine.interface.ActorTalents")

newEntity{
    define_as = "BASE_NPC_TRAINER",
    type = "humanoid",
    display = 'h',
    level_range = {1, nil},
    max_life = resolvers.rngavg(5,8),
    stats = { str=13, dex=13, con=12, int=12, wis=9, cha=10, luc=10 },
    hit_die = 1,
    challenge = 1,
    alignment = "Neutral",
    languages = {"Common", "Undercommon"},

    body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
    ai = "humanoid_level", ai_state = { talent_in=1, ai_move="move_astar", },
    combat = { dam= {1,6} },
    faction = "neutral",
    open_door = true,
    show_portrait = true,

    resolvers.equip{
        full_id=true,
        { name = "chainmail", not_properties={"cursed"}, veins_drops={"npc"}, add_levels=4, veins_level=resolvers.npc_drops_level  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops={"npc"}, add_levels=4, veins_level=resolvers.npc_drops_level  },
        { name = "longsword", not_properties={"cursed"}, veins_drops={"npc"}, add_levels=4, veins_level=resolvers.npc_drops_level  },
        { name = "arrows", not_properties={"cursed"}, veins_drops={"npc"}, add_levels=4, veins_level=resolvers.npc_drops_level  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "shortbow", add_levels=4  },
    { name = "food ration" },
    },
    resolvers.trainer_class(),
    can_talk = "trainer",

    resolvers.talents{ [Talents.T_SHOOT]=1,
    --give the simple weapon proficiency warrior/fighter/wizard class all have
    [Talents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
    },
    resolvers.wounds()
}

newEntity{ base = "BASE_NPC_TRAINER",
    name = "human trainer",
    subtype = "human",
    color=colors.WHITE,
    image = "tiles/new/human_fighter.png",
    rarity = 5,
    emote_anger = "I will kill you!",
}

newEntity{ base = "BASE_NPC_TRAINER",
    name = "drow trainer",
    subtype = "drow",
    color=colors.BLACK,
    image = "tiles/mobiles/npc/drow_fighter.png",
    rarity = 5,
    emote_anger = "Oloth plynn d'jal!",
}
