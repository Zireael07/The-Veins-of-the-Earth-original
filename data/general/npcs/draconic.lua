--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Scent; immunity to fire, sleep & paralysis; breath weapon 12d6 fire Ref DC 21 half
-- neutral alignment
newEntity{
        define_as = "BASE_NPC_DRAG_TURTLE",
        type = "dragon",
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

--Fly 60 ft.; blindsense 60 ft.; immunity to sleep & paralysis
--Poison - pri sleep 10 rounds sec sleep 1d3 hours Fort DC 14
newEntity{
        define_as = "BASE_NPC_PSEUDODRAGON",
        type = "dragon",
        display = 'D', color=colors.LIGHT_GREEN,
        body = { INVEN = 10 },
        desc = [[A tiny draconic creature in shades of green.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=6, dex=15, con=13, int=10, wis=12, cha=10, luc=14 },
        combat = { dam= {1,3} },
        name = "pseudodragon",
        level_range = {1, nil}, exp_worth = 300,
        rarity = 15,
        max_life = resolvers.rngavg(13,17),
        hit_die = 2,
        challenge = 1,
        infravision = 4,
        spell_resistance = 19,
        combat_natural = 6,
        skill_diplomacy = 2,
        skill_hide = 18,
        skill_listen = 8,
        skill_search = 6,
        skill_sensemotive = 6,
        skill_spot = 8,
        resolvers.talents{ [Talents.T_ALERTNESS]=1 },
        alignment = "neutral good",
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}

--Fly 60 ft; immunity to sleep & paralysis, scent, improved grab
--Poison (wyvern poison 2d6 CON) Fort DC 17
newEntity{
        define_as = "BASE_NPC_WYVERN",
        type = "dragon",
        display = 'D', color=colors.GRAY,
        body = { INVEN = 10 },
        desc = [[A huge flying lizard with a stinging tail.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=19, dex=12, con=15, int=6, wis=12, cha=9, luc=10 },
        combat = { dam= {1,6} },
        name = "wyvern",
        level_range = {10, nil}, exp_worth = 2100,
        rarity = 15,
        max_life = resolvers.rngavg(55,60),
        hit_die = 7,
        challenge = 6,
        infravision = 4,
        combat_natural = 7,
        skill_hide = 6,
        skill_listen = 12,
        skill_movesilently = 10,
        skill_spot = 15,
        movement_speed_bonus = -0.33,
        resolvers.talents{ [Talents.T_ALERTNESS]=1 },
        alignment = "neutral",
        --Hack! Monsters drop corpses now
        resolvers.inventory {
        full_id=true,
        { name = "fresh corpse" }
        },
}