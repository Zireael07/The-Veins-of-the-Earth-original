--Veins of the Earth
--Zireael

newEntity{
	define_as = "BASE_NPC_EAGLE",
	type = "magical beast",
	display = 'e', color=colors.YELLOW,
	body = { INVEN = 10 },
	desc = [[A proud eagle.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=17, con=12, int=10, wis=14, cha=10, luc=12 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_EAGLE",
	name = "giant eagle", color=colors.YELLOW,
	level_range = {1, 5}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(2,5),
	hit_die = 4,
	challenge = 3,
	skill_listen = 2,
	skill_spot = 13,
	skill_survival = 1,
}

newEntity{
	define_as = "BASE_NPC_SHOCKLIZARD",
	type = "magical beast",
	display = 'q', color=colors.LIGHT_BLUE,

	body = { INVEN = 10 },
	desc = [[A lizard with light blue markings on its back.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=15, con=13, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,4} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_SHOCKLIZARD",
	name = "shocker lizard", color=colors.YELLOW,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 8,
	max_life = resolvers.rngavg(12,15),
	hit_die = 2,
	challenge = 2,
	infravision = 3,
	skill_climb = 11,
	skill_hide = 9,
	skill_jump = 7,
	skill_listen = 3,
	skill_spot = 3,
	skill_swim = 10,
}

newEntity{
	define_as = "BASE_NPC_ANKHEG",
	type = "magical beast",
	display = 'B', color=colors.DARK_UMBER,
	body = { INVEN = 10 },
	desc = [[A large chitin-covered insect.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=10, con=17, int=1, wis=13, cha=6, luc=6 },
	combat = { dam= {2,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_ANKHEG",
	name = "ankheg", color=colors.DARK_UMBER,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(25,30),
	hit_die = 3,
	challenge = 3,
	combat_natural = 8,
	skill_climb = 3,
	skill_listen = 5,
	skill_spot = 2,
}

--Poison, spells, web, shapechange
newEntity{
	define_as = "BASE_NPC_ARANEA",
	type = "magical beast",
	display = 's', color=colors.DARK_RED,
	body = { INVEN = 10 },
	desc = [[A large chitin-covered insect.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=15, con=14, int=14, wis=13, cha=14, luc=12 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_ARANEA",
	name = "aranea", color=colors.DARK_RED,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(20,25),
	hit_die = 3,
	challenge = 4,
	infravision = 4,
	combat_natural = 1,
	skill_climb = 10,
	skill_listen = 5,
	skill_spot = 5,
	skill_concentration = 6,
}