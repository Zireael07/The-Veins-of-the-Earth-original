--Veins of the Earth
--Zireael

--Celestials do not drop corpses

--Angels

--fly 100 ft. land 50 ft.; wields heavy mace of disruption +3; stun (DC 22) on two hits in a round; change shape; immunity to acid, cold, petrification; 
--Spell-likes: At will—aid, continual flame, detect evil, discern lies (DC 19), dispel evil (DC 20), dispel magic, holy aura (DC 23), holy smite (DC 19), holy word (DC 22), invisibility (self only), plane shift (DC 22), remove curse (DC 18), remove disease (DC 18), remove fear (DC 16); 7/day—cure light wounds (DC 16), see invisibility; 1/day—blade barrier (DC 21), heal (DC 21). Caster level 12th. The save DCs are Charisma-based. 
newEntity{
        define_as = "BASE_NPC_DEVA",
        type = "outsider",
        display = 'A', color=colors.WHITE,
        body = { INVEN = 10 },
        desc = [[A winged humanoid.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=22, dex=18, con=18, int=18, wis=18, cha=20, luc=12 },
        combat = { dam= {1,8} },
        name = "astral deva",
        level_range = {10, nil}, exp_worth = 4000,
        rarity = 15,
        max_life = resolvers.rngavg(100,105),
        hit_die = 12,
        challenge = 14,
        infravision = 4,
        combat_natural = 15,
        combat_dr = 10,
        spell_resistance = 30,
        skill_concentration = 15,
        skill_knowledge = 15,
        skill_diplomacy = 17,
        skill_escapeartist = 15,
        skill_hide = 15,
        skill_intimidate = 17,
        skill_listen = 19,
        skill_movesilently = 15,
        skill_sensemotive = 15,
        skill_spot = 19,
        alignment = "lawful good",
        resists = {
                [DamageType.FIRE] = 10,
                [DamageType.ELECTRIC] = 10,
        },
}

--fly 90 ft.; wields greatsword +3; change shape; immunity to acid, cold, petrification; regen 10
--Spell-likes: At will—continual flame, dispel magic, holy smite (DC 20), invisibility (self only), lesser restoration (DC 18), remove curse (DC 19), remove disease (DC 19), remove fear (DC 17), speak with dead (DC 19); 3/day—blade barrier (DC 22), flame strike (DC 21), power word stun, raise dead, waves of fatigue; 1/day—earthquake (DC 24), greater restoration (DC 23), mass charm monster (DC 24), waves of exhaustion. Caster level 17th. The save DCs are Charisma-based. 
newEntity{
        define_as = "BASE_NPC_PLANETAR",
        type = "outsider",
        display = 'A', color=colors.GOLD,
        body = { INVEN = 10 },
        desc = [[A winged humanoid.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=25, dex=19, con=20, int=22, wis=23, cha=22, luc=14 },
        combat = { dam= {2,8} },
        name = "planetar",
        level_range = {20, nil}, exp_worth = 4500,
        rarity = 15,
        max_life = resolvers.rngavg(130,135),
        hit_die = 14,
        challenge = 16,
        infravision = 4,
        combat_natural = 18,
        combat_dr = 10,
        spell_resistance = 30,
        skill_concentration = 17,
        skill_knowledge = 15,
        skill_diplomacy = 19,
        skill_escapeartist = 19,
        skill_hide = 13,
        skill_intimidate = 17,
        skill_listen = 17,
        skill_movesilently = 15,
        skill_sensemotive = 17,
        skill_search = 17,
        skill_spot = 17,
        alignment = "lawful good",
        resists = {
                [DamageType.FIRE] = 10,
                [DamageType.ELECTRIC] = 10,
        },
        resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}


--fly 150 ft. land 50 ft.; wields dancing greatsword +5; change shape; immunity to acid, cold, petrification; regen 15
--Spell-likes: At will—aid, animate objects, commune, continual flame, dimensional anchor, greater dispel magic, holy smite (DC 21), imprisonment (DC 26), invisibility (self only), lesser restoration (DC 19), remove curse (DC 20), remove disease (DC 20), remove fear (DC 18), resist energy, summon monster VII, speak with dead (DC 20), waves of fatigue; 3/day—blade barrier (DC 23), earthquake (DC 25), heal (DC 23), mass charm monster (DC 25), permanency, resurrection, waves of exhaustion; 1/day—greater restoration (DC 24), power word blind, power word kill, power word stun, prismatic spray (DC 24), wish. Caster level 20th. The save DCs are Charisma-based. 
newEntity{
        define_as = "BASE_NPC_SOLAR",
        type = "outsider",
        display = 'A', color=colors.YELLOW,
        body = { INVEN = 10 },
        desc = [[A winged humanoid.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=28, dex=20, con=20, int=23, wis=25, cha=25, luc=14 },
        combat = { dam= {1,8} },
        name = "solar",
        level_range = {20, nil}, exp_worth = 16000,
        rarity = 20,
        max_life = resolvers.rngavg(200,205),
        hit_die = 22,
        challenge = 23,
        infravision = 4,
        combat_natural = 20,
        combat_dr = 15,
        spell_resistance = 30,
        skill_concentration = 25,
        skill_knowledge = 25,
        skill_diplomacy = 25,
        skill_escapeartist = 25,
        skill_hide = 22,
        skill_listen = 25,
        skill_movesilently = 25,
        skill_search = 25,
        skill_sensemotive = 25,
        skill_spellcraft = 25,
        skill_spot = 25,
        alignment = "lawful good",
        resists = {
                [DamageType.FIRE] = 10,
                [DamageType.ELECTRIC] = 10,
        },
        resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
          [Talents.T_DODGE]=1,
        },
}

--Guardinals

--fly 90 ft. land 40 ft.; change shape; immunity to electricity, petrification; fear aura DC 17 2 squares
--Lay on hands, true seeing
--Spell-likes: At will—aid, blur (self only), command (DC 14), detect magic, dimension door, dispel magic, gust of wind (DC 15), hold person (DC 16), light, magic circle against evil (self only), magic missile, see invisibility; 3/day—lightning bolt (DC 16). Caster level 8th. The save DCs are Charisma-based. 
newEntity{
        define_as = "BASE_NPC_AVORAL",
        type = "outsider",
        display = 'A', color=colors.BROWN,
        body = { INVEN = 10 },
        desc = [[An impressive winged bird.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=15, dex=23, con=20, int=15, wis=16, cha=16, luc=12 },
        combat = { dam= {2,6} },
        name = "avoral",
        level_range = {10, nil}, exp_worth = 1000,
        rarity = 15,
        max_life = resolvers.rngavg(60,70),
        hit_die = 7,
        challenge = 9,
        infravision = 4,
        combat_natural = 8,
        combat_dr = 10,
        spell_resistance = 25,
        skill_bluff = 9,
        skill_concentration = 10,
        skill_diplomacy = 3,
        skill_handleanimal = 9,
        skill_hide = 10,
        skill_intimidate = 1,
        skill_knowledge = 8,
        skill_listen = 9,
        skill_movesilently = 9,
        skill_sensemotive = 10,
        skill_spellcraft = 10,
        skill_spot = 17,
        alignment = "neutral good",
        resists = {
                [DamageType.COLD] = 10,
                [DamageType.SONIC] = 10,
        },
}

--Roar 4 sq cone holy word + 2d6 sonic; pounce; improved grab; rake 1d6;
--immunity to electricity and petrification, lay on hands, protective aura
newEntity{
        define_as = "BASE_NPC_LEONAL",
        type = "outsider",
        display = 'A', color=colors.DARK_YELLOW,
        body = { INVEN = 10 },
        desc = [[A winged humanoid with a lion head.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=27, dex=17, con=20, int=14, wis=14, cha=15, luc=12 },
        combat = { dam= {1,6} },
        name = "leonal",
        level_range = {10, nil}, exp_worth = 3600,
        rarity = 15,
        max_life = resolvers.rngavg(110,115),
        hit_die = 12,
        challenge = 12,
        infravision = 4,
        combat_natural = 14,
        combat_dr = 10,
        spell_resistance = 28,
        skill_balance = 19,
        skill_concentration = 10,
        skill_diplomacy = 2,
        skill_intimidate = 8,
        skill_jump = 27,
        skill_listen = 15,
        skill_movesilently = 19,
        skill_sensemotive = 15,
        skill_spot = 15,
        skill_survival = 15,
        alignment = "neutral good",
        resists = {
                [DamageType.SONIC] = 10,
                [DamageType.COLD] = 10,
        },
}


--Eladrin
--fly 100 ft. (whirlwind form) land 40 ft.; wields holy scimitar + holy composite longbow; 
--Spell-likes: At will— blur, charm person (DC 13), gust of wind (DC 14), mirror image, wind wall; 2/day—lightning bolt (DC 15), cure serious wounds (DC 15). Caster level 6th. 
newEntity{
        define_as = "BASE_NPC_BRALANI",
        type = "outsider",
        display = 'A', color=colors.UMBER,
        body = { INVEN = 10 },
        desc = [[A winged humanoid.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=18, dex=18, con=17, int=13, wis=14, cha=14, luc=12 },
        combat = { dam= {1,6} },
        name = "bralani",
        level_range = {10, nil}, exp_worth = 1800,
        rarity = 15,
        max_life = resolvers.rngavg(40,45),
        hit_die = 6,
        challenge = 6,
        infravision = 4,
        combat_natural = 6,
        combat_dr = 10,
        spell_resistance = 17,
        skill_concentration = 9,
        skill_diplomacy = 2,
        skill_escapeartist = 9,
        skill_handleanimal = 9,
        skill_hide = 9,
        skill_jump = 6,
        skill_listen = 9,
        skill_movesilently = 9,
        skill_sensemotive = 9,
        skill_spot = 9,
        skill_tumble = 9,
        alignment = "chaotic good",
        resists = {
                [DamageType.FIRE] = 10,
                [DamageType.COLD] = 10,
        },
}

--wields holy greatsword +4 ; immunity to electricity & petrification; protective aura (+4 to AC and +4 to saves vs evil creatures in 2 sq radius)
-- Improved Disarm, Improved Trip; cast as Clr14; AL CG
--Spell-likes: At will—aid, charm monster (DC 17), color spray (DC 14), comprehend languages, continual flame, cure light wounds (DC 14), dancing lights, detect evil, detect thoughts (DC 15), disguise self, dispel magic, hold monster (DC 18), greater invisibility (self only), major image (DC 16), see invisibility, greater teleport (self plus 50 pounds of objects only); 1/day—chain lightning (DC 19), prismatic spray (DC 20), wall of force.
newEntity{
        define_as = "BASE_NPC_GHAELE",
        type = "outsider",
        display = 'A', color=colors.LIGHT_RED,
        body = { INVEN = 10 },
        desc = [[An impressive winged humanoid.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=25, dex=12, con=15, int=16, wis=17, cha=16, luc=12 },
        combat = { dam= {2,6} },
        name = "ghaele",
        level_range = {15, nil}, exp_worth = 4000,
        rarity = 15,
        max_life = resolvers.rngavg(60,70),
        hit_die = 10,
        challenge = 13,
        infravision = 4,
        combat_natural = 14,
        combat_dr = 10,
        spell_resistance = 28,
        skill_concentration = 12,
        skill_diplomacy = 3,
        skill_escapeartist = 13,
        skill_handleanimal = 13,
        skill_hide = 13,
        skill_knowledge = 13,
        skill_listen = 13,
        skill_movesilently = 13,
        skill_sensemotive = 13,
        skill_spot = 13,
        alignment = "chaotic good",
        resists = {
                [DamageType.COLD] = 10,
                [DamageType.FIRE] = 10,
        },
}

--Fly 70 ft.; immunity to poison; constrict 2d6; improved grab; cast spells as Brd6; Extend Spell
--Spell-likes: 3/day—darkness, hallucinatory terrain (DC 18), knock, light; 1/day—charm person (DC 15), speak with animals, speak with plants.
newEntity{
        define_as = "BASE_NPC_LILLEND",
        type = "outsider",
        display = 'A', color=colors.LIGHT_RED,
        body = { INVEN = 10 },
        desc = [[An animated plant.]],

        ai = "dumb_talented_simple", ai_state = { talent_in=3, },
        stats = { str=20, dex=17, con=15, int=14, wis=16, cha=18, luc=12 },
        combat = { dam= {2,6} },
        name = "lillend",
        level_range = {10, nil}, exp_worth = 4000,
        rarity = 25,
        max_life = resolvers.rngavg(40,45),
        hit_die = 7,
        challenge = 7,
        infravision = 4,
        combat_natural = 5,
        skill_concentration = 10,
        skill_diplomacy = 12,
        skill_knowledge = 10,
        skill_listen = 10,
--        skill_perform = 10,
        skill_sensemotive = 10,
        skill_spellcraft = 12,
        skill_spot = 10,
        skill_survival = 14,
        movement_speed_bonus = -0.66,
        alignment = "chaotic good",
        resolvers.talents{ [Talents.T_COMBAT_CASTING]=1 },
        resists = { [DamageType.FIRE] = 10 },
}