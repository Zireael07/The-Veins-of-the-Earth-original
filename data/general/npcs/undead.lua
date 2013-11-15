--Veins of the Earth
--Zireael

--incorporeal, 1d4 Wisdom drain, hypnotism DC 16 in 4 tiles
newEntity{
        define_as = "BASE_NPC_ALLIP",
        type = "undead", subtype = "allip",
        display = 'N', color=colors.BLACK,
        body = { INVEN = 10 },
        desc = [[An incorporeal undead.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=1, dex=12, con=1, int=11, wis=11, cha=18, luc=6 },
        combat = { dam= {2,6} },
        name = "allip",
        level_range = {5, 15}, exp_worth = 900,
        rarity = 10,
        max_life = resolvers.rngavg(35,40),
        hit_die = 3,
        challenge = 5,
        infravision = 4,
        combat_protection = 4,
        skill_hide = 7,
        skill_intimidate = 3,
        skill_jump = 17,
        skill_listen = 6,
        skill_search = 3,
        skill_spot = 6,
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}

--death gaze 3 squares Fort DC 15; immunity to electricity
newEntity{
        define_as = "BASE_NPC_BODAK",
        type = "undead",
        display = 'N', color=colors.DARK_GRAY,
        body = { INVEN = 10 },
        desc = [[A thin, emaciated creature.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=13, dex=15, con=1, int=6, wis=12, cha=12, luc=6 },
        combat = { dam= {1,8} },
        name = "bodak",
        level_range = {10, nil}, exp_worth = 2400,
        rarity = 10,
        max_life = resolvers.rngavg(55,60),
        hit_die = 9,
        challenge = 8,
        infravision = 4,
        combat_natural = 8,
        skill_listen = 10,
        skill_movesilently = 8,
        skill_spot = 10,
        resists = {
                [DamageType.ACID] = 10,
                [DamageType.COLD] = 10,
        },
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}

--Energy drain, trap essence, spell deflection (nothing or placing the spell-likes on cooldown) [banishment, chaos hammer, confusion, crushing despair, detect thoughts, dispel evil, dominate person, fear, geas/quest, holy word, hypnotism, imprisonment, magic jar, maze, suggestion, trap the soul, or any form of charm or compulsion.]
--Spell-likes:: confusion (DC 17), control undead (DC 20), ghoul touch (DC 15), lesser planar ally, ray of enfeeblement, spectral hand, suggestion (DC 16), true seeing. 
newEntity{
        define_as = "BASE_NPC_DEVOURER",
        type = "undead",
        display = 'N', color=colors.LIGHT_BLUE,
        body = { INVEN = 10 },
        desc = [[A terrible bony creature.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=28, dex=10, con=1, int=16, wis=16, cha=17, luc=6 },
        combat = { dam= {1,6} },
        name = "devourer",
        level_range = {10, nil}, exp_worth = 2400,
        rarity = 20,
        max_life = resolvers.rngavg(75,80),
        hit_die = 12,
        challenge = 11,
        spell_resistance = 21,
        infravision = 4,
        combat_natural = 14,
        skill_climb = 15,
        skill_concentration = 18,
        skill_diplomacy = 2,
        skill_jump = 15,
        skill_listen = 15,
        skill_movesilently = 15,
        skill_search = 7,
        skill_spot = 15,
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}
