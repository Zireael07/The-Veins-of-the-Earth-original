--Veins of the Earth
--Zireael

newEntity{
        define_as = "BASE_NPC_ALLIP",
        type = "undead", subtype = "allip",
        display = 'N', color=colors.BLACK,
        body = { INVEN = 10 },
        desc = [[An incorporeal undead.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=1, dex=12, con=1, int=11, wis=11, cha=18, luc=6 },
        combat = { dam= {2,6} },
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}

--incorporeal, 1d4 Wisdom drain, hypnotism DC 16 in 4 tiles
newEntity{
        base = "BASE_NPC_ALLIP",
        name = "allip", color=colors.BLACK,
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
}
