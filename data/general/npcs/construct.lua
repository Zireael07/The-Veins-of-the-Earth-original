--Veins of the Earth
--Zireael

--Constructs do NOT leave corpses

local Talents = require("engine.interface.ActorTalents")

--Immunity to magic
newEntity{
	define_as = "BASE_NPC_GOLEM",
	type = "construct",
--	image = "tiles/golem.png",
	display = 'C', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A hand-crafted servile creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=25, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {1,6} },
	alignment = "neutral",
	movement_speed_bonus = -0.33,
	infravision = 4,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_RAGE]=1 },
}

--Cursed wound, haste
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "clay golem", color=colors.LIGHT_BROWN,
	level_range = {10, nil}, exp_worth = 3000,
	rarity = 15,
	max_life = resolvers.rngavg(88,92),
	hit_die = 11,
	challenge = 10,
	combat_dr = 10,
	combat_natural = 13,
}

newEntity{
	base = "BASE_NPC_GOLEM",
	name = "flesh golem", color=colors.UMBER,
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 15,
	max_life = resolvers.rngavg(77,80),
	hit_die = 9,
	challenge = 7,
	combat_dr = 5,
	combat_natural = 10,
	stats = { str=21, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,8} },
}

--Breath weapon 1 sq 1d4 Con pri, 3d4 Con sec Fort DC 19
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "iron golem", color=colors.DARK_GRAY,
	level_range = {15, nil}, exp_worth = 4000,
	rarity = 20,
	max_life = resolvers.rngavg(128,132),
	hit_die = 18,
	challenge = 13,
	combat_dr = 15,
	combat_natural = 23,
	stats = { str=33, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,10} },
}

--Slow cooldown 2
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "stone golem", color=colors.GRAY,
	level_range = {15, nil}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(105,110),
	hit_die = 14,
	challenge = 11,
	combat_natural = 19,
	stats = { str=29, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,10} },
}

--Slow cooldown 2
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "greater stone golem", color=colors.GRAY,
	level_range = {20, nil}, exp_worth = 4800,
	rarity = 25,
	max_life = resolvers.rngavg(270,275),
	hit_die = 42,
	challenge = 16,
	combat_natural = 21,
	stats = { str=37, dex=7, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {4,8} },
}

--Fly 50 ft; poison pri sleep 10 rounds, sec sleep 5d6x10 rounds
newEntity{
	define_as = "BASE_NPC_HOMUNCULUS",
	type = "construct",
--	image = "tiles/griffon.png",
	display = 'C', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[A wizard's miniature servant.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=8, dex=15, con=1, int=10, wis=12, cha=6, luc=12 },
	combat = { dam= {1,4} },
	name = "homunculus",
	level_range = {1, 25}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(9,13),
	hit_die = 2,
	challenge = 1,
	infravision = 4,
	combat_natural = 2,
	skill_hide = 12,
	skill_listen = 3,
	skill_spot = 3,
	alignment = "neutral",
	movement_speed_bonus = -0.33,
}