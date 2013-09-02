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
	display = 'l', color=colors.LIGHT_BLUE,
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
