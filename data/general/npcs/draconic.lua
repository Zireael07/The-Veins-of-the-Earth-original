--Veins of the Earth
--Zireael

--Scent; immunity to fire, sleep & paralysis; breath weapon 12d6 fire Ref DC 21 half
-- neutral alignment
newEntity{
        define_as = "BASE_NPC_DRAG_TURTLE",
        type = "dragon", subtype = "allip",
        display = 'D', color=colors.DARK_GREEN,
        body = { INVEN = 10 },
        desc = [[An immense turtle.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=27, dex=10, con=21, int=12, wis=13, cha=12, luc=10 },
        combat = { dam= {4,6} },
        name = "dragon turtle",
        level_range = {10, 15}, exp_worth = 2700,
        rarity = 10,
        max_life = resolvers.rngavg(135,140),
        hit_die = 12,
        challenge = 9,
        infravision = 1,
        combat_natural = 15,
        skill_diplomacy = 2,
        skill_hide = 7,
        skill_intimidate = 14,
        skill_listen = 14,
        skill_search = 14,
        skill_sensemotive = 14,
        skill_spot = 14,
        skill_survival = 14,
        skill_swim = 13,
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}
