--Veins of the Earth
--Zireael 2014-2015

newEntity{
        define_as = "BASE_NPC_ROC",
        type = "animal",
        image = "tiles/roc.png",
        display = 'b', color=colors.GOLD,
        body = { INVEN = 10 },
        desc = [[An immense bird.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=34, dex=15, con=24, int=2, wis=13, cha=11, luc=12 },
        combat = { dam= {2,6} },
        infravision = 1,
        combat_natural = 5,
        skill_listen = 9,
        skill_spot = 13,
--        movement_speed_bonus = 2,
        movement_speed = 2,
        combat_attackspeed = 2,
        fly = true,
        resolvers.wounds()
}

newEntity{
        base = "BASE_NPC_ROC",
        name = "roc",
        level_range = {10, nil}, exp_worth = 2600,
        rarity = 20,
        max_life = resolvers.rngavg(205,210),
        hit_die = 18,
        challenge = 9,
}
