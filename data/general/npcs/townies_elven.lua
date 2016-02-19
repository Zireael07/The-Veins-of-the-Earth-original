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
newEntity{ define_as = "BASE_NPC_ELF_T",
    base = "BASE_NPC_NEUTRAL_T",
    name = "elf townie",
    display = 'h', color=colors.LIGHT_GREEN,
    subtype = "elf",
    image = "tiles/mobiles/npc/elf_rogue.png",

    level_range = {1, nil}, exp_worth = 400,
    max_life = resolvers.rngavg(3,5),
    stats = { str=11, dex=13, con=10, int=10, wis=9, cha=8, luc=10 },
    hit_die = 1,
    challenge = 1,
    desc = [[A shady silhouette.]],
    specialist_desc = [[Elves do not sleep or dream, and are immune to sleep effects. Instead, they refresh themselves by entering a meditative reverie for a few hours a night. Numerous elven subraces exist, with the high elf being most common. Elves can also interbreed with humans, producing half-elves.]],
    uncommon_desc = [[An elf has sharp senses, heightened by their attunement to the natural world. Elves see well in dim light and can often sense hidden doors just by passing near them.]],
    common_desc = [[Elves live in harmony with nature and are talented arcanists. Compared to humans, they are dextrous but relatively frail. Culturally, elves receive extensive training with the sword and bow as they mature.]],
    base_desc = [[This willowy humanoid is an elf, a civilized race of nonhumans renowned for their artistry and extreme longevity. They speak both Elven and Common. Some elves also learn other racial languages.]],

    low_light_vision = 2,
    skill_listen = 2,
    skill_search = 3,
    skill_spot = 2,
    alignment = "Chaotic Good",
    languages = {"Common", "Elven"},
    emote_anger = "Wrath of Maeve upon you!",
}

newEntity{
    base = "BASE_NPC_ELF_T",
    name = "elf guard",
    image = "tiles/new/elf_fighter.png",
    max_life = resolvers.rngavg(15,20),
    rarity = 4,

    resolvers.equip{
        full_id=true,
        { name = "chain shirt", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "light metal shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "long sword", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
        { name = "arrows", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
    },
    resolvers.inventory {
    full_id=true,
    { name = "longbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
    },
    resolvers.classes{Fighter=2},
}
