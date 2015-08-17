--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_WATER",
	type = "outsider", subtype = "water",
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	ai = "human_level", ai_state = { talent_in=3, },
	alignment = "Neutral",
	resolvers.wounds()
}

--Improved grab, ink cloud, no flanking bonuses for enemies;
--Blind-Fight feat
newEntity{ base = "BASE_NPC_WATER",
	define_as = "BASE_NPC_TOJANIDA",
	image = "tiles/mobiles/tojanida.png",
	display = 'O', color=colors.LIGHT_BLUE,
	body = { INVEN = 10 },
	desc = [[A creature with seven stalks extending from the shell.]],

	stats = { str=14, dex=13, con=15, int=10, wis=12, cha=9, luc=10 },
	combat = { dam= {2,6} },
	rarity = 15,
	infravision = 4,
	skill_diplomacy = 1,
	skill_hide = 10,
	skill_knowledge = 6,
	skill_swim = 8,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_ACID_IMMUNITY]=1,
	[Talents.T_COLD_IMMUNITY]=1,
	},
	resists = {
        [DamageType.FIRE] = 10,
        [DamageType.ELECTRIC] = 10,
    },
}

--Bump them all up a'la Inc
newEntity{
	base = "BASE_NPC_TOJANIDA",
	name = "juvenile tojanida",
	level_range = {5, 15}, exp_worth = 900,
	max_life = resolvers.rngavg(15,20),
	hit_die = 4,
	challenge = 3,
	combat_natural = 10,
	skill_escapeartist = 6,
	skill_listen = 6,
	skill_search = 6,
	skill_sensemotive = 6,
	skill_spot = 8,
}

newEntity{
	base = "BASE_NPC_TOJANIDA",
	name = "adult tojanida",
	level_range = {5, 15}, exp_worth = 1500,
	max_life = resolvers.rngavg(40,45),
	hit_die = 7,
	challenge = 8,
	stats = { str=16, dex=13, con=15, int=10, wis=12, cha=9, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 12,
	skill_escapeartist = 10,
	skill_listen = 10,
	skill_search = 14,
	skill_sensemotive = 10,
	skill_spot = 14,
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--Cleave, Imp Sunder
newEntity{
	base = "BASE_NPC_TOJANIDA",
	name = "elder tojanida",
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(125,130),
	hit_die = 7,
	challenge = 10,
	stats = { str=22, dex=13, con=19, int=10, wis=12, cha=9, luc=10 },
	combat = { dam= {4,6} },
	combat_natural = 13,
	skill_escapeartist = 18,
	skill_hide = 14,
	skill_knowledge = 18,
	skill_listen = 20,
	skill_search = 21,
	skill_sensemotive = 16,
	skill_spot = 24,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
--	[Talents.T_POWER_ATTACK]=1
	},
}


--Swim 60 ft. Spell-like: 1/day—summon nature’s ally IV.
newEntity{ base = "BASE_NPC_WATER",
	define_as = "BASE_NPC_TRITON",
	name = "triton",
	image = "tiles/mobiles/triton.png",
	display = 'O', color=colors.DARK_BLUE,
	desc = [[A humanoid with a fish tail instead of legs and covered in silvery scales.]],

	stats = { str=12, dex=10, con=12, int=13, wis=13, cha=11, luc=10 },
	combat = { dam= {1,6} },

	level_range = {1, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 2,
	infravision = 4,
	combat_natural = 6,
	skill_diplomacy = 2,
	skill_hide = 6,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_search = 6,
	skill_sensemotive = 7,
	skill_spot = 6,
	skill_survival = 6,
	skill_swim = 8,
--	movement_speed_bonus = -0.88,
	movement_speed = 0.22,
	alignment = "Neutral Good",
}
