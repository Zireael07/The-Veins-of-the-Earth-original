--Veins of the Earth
--Zireael

--Constrict, entangle; camouflage, immunity to electricity, resistance to cold & fire 10
newEntity{
	define_as = "BASE_NPC_ASSAVINE",
	type = "plant",
	display = 'P', color=colors.DARK_GREEN,
	body = { INVEN = 10 },
	desc = [[A crawling vine.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=20, dex=10, con=16, int=1, wis=13, cha=9, luc=10 },
	combat = { dam= {1,6} },
	name = "assasin vine",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 20,
	max_life = resolvers.rngavg(28,32),
	hit_die = 4,
	challenge = 3,
	combat_natural = 6,
}

newEntity{
	define_as = "BASE_NPC_FUNGI",
	type = "plant",
	display = 'F', color=colors.WHITE,
	body = { INVEN = 10 },
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=1, dex=1, con=13, int=1, wis=2, cha=1, luc=10 },
	combat = { dam= {1,6} },
	level_range = {1, nil}, exp_worth = 900,
	rarity = 10,
	combat_natural = 4,
	movement_speed_bonus = -0.33,
	alignment = "neutral",
}

--Shriek 1d3 rounds; AL N
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_SHRIEKER",
	color=colors.DARK_BLUE,
	desc = [[A purple fungus.]],
	name = "shrieker",
	exp_worth = 300,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	combat_natural = 3,
	movement_speed_bonus = -0.50,
}

--Poison 1d4 STR & 1d4 CON pri & sec
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_VIOLET_FUNGI",
	display = 'F', color=colors.VIOLET,
	desc = [[A violet fungus.]],
	stats = { str=14, dex=8, con=16, int=1, wis=11, cha=9, luc=10 },
	name = "violet fungus",
	max_life = resolvers.rngavg(15,20),
	hit_die = 2,
	challenge = 3,
	infravision = 1,
}

--Constant greater invisibility
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_PHANTOM_FUNGI",
	color=colors.VIOLET,
	desc = [[A greenish silhouette of a fungus.]],
	stats = { str=14, dex=10, con=16, int=2, wis=11, cha=9, luc=10 },
	name = "phantom fungus",
	max_life = resolvers.rngavg(13,17),
	hit_die = 2,
	challenge = 3,
	infravision = 1,
	movement_speed_bonus = -0.33,
	skill_listen = 4,
	skill_movesilently = 6,
	skill_spot = 4,
}