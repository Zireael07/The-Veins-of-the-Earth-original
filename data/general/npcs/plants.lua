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

--Shriek 1d3 rounds; AL N
newEntity{
	define_as = "BASE_NPC_SHRIEKER",
	type = "plant",
	display = 'F', color=colors.DARK_BLUE,
	body = { INVEN = 10 },
	desc = [[A purple fungus.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=1, dex=1, con=13, int=1, wis=2, cha=1, luc=10 },
	combat = { dam= {1,6} },
	name = "shrieker",
	level_range = {1, nil}, exp_worth = 300,
	rarity = 10,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	combat_natural = 3,
	movement_speed_bonus = -0.50,
}

--Poison 1d4 STR & 1d4 CON pri & sec
newEntity{
	define_as = "BASE_NPC_VIOLET_FUNGI",
	type = "plant",
	display = 'F', color=colors.VIOLET,
	body = { INVEN = 10 },
	desc = [[A violet fungus.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=8, con=16, int=1, wis=11, cha=9, luc=10 },
	combat = { dam= {1,6} },
	name = "violet fungus",
	level_range = {1, nil}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(15,20),
	hit_die = 2,
	challenge = 3,
	infravision = 1,
	combat_natural = 4,
	movement_speed_bonus = -0.33,
}