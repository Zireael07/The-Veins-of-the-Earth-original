--Veins of the Earth
--Zireael 2014-2015

newEntity{
        define_as = "BASE_NPC_ROC",
        type = "animal",
        image = "tiles/mobiles/roc.png",
        display = 'b', color=colors.GOLD,
        body = { INVEN = 10 },
        desc = [[An immense bird.]],
        specialist_desc = [[Most rocs have dark brown or golden plumage. Red, black, or white rocs are said to exist, but sighting such a bird is an ill omen.]],
        uncommon_desc = [[Rocs usually hunt within 10 miles of their massive, mountaintop aeries. If a snatched creature offers little resistance, rocs sometimes carry it back to their nests to feed their hatchlings.]],
        common_desc = [[Rocs prey upon lesser creatures much like raptors a fraction their size. Their preferred tactic is to swoop low, use their talons to snatch up a creature—which might be as big as an elephant—and then carry the hapless prey hundreds of feet into the air before flinging it back to earth.]],
        base_desc = "This unbelievably huge raptor is a roc, a bird of immense size and strength.",

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
