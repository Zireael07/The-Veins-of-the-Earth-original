--Veins of the Earth
--Zireael 2013-2015

newEntity{
	define_as = "BASE_NPC_VERMIN",
	type = "vermin",
	body = { INVEN = 10 },
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	resolvers.wounds()
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SPIDER",
	image = "tiles/spider.png",
	display = 'r', color=colors.BROWN,
	desc = [[A small spider.]],

	stats = { str=3, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	infravision = 4,
	skill_climb = 8,
	skill_hide = 4,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "tiny spider",
	level_range = {1, 4}, exp_worth = 100,
	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "small spider",
	level_range = {1, 4}, exp_worth = 135,
	rarity = 3,
	max_life = resolvers.rngavg(3,6),
	hit_die = 1,
	challenge = 1/3,
	stats = { str=7, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "medium spider",
	level_range = {1, 4}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(3,6),
	hit_die = 2,
	challenge = 1,
	stats = { str=11, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "large spider",
	level_range = {5, 20}, exp_worth = 3000,
	rarity = 9,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 4,
	stats = { str=15, dex=17, con=12, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "huge spider",
	level_range = {7, 20}, exp_worth = 3300,
	rarity = 40,
	max_life = resolvers.rngavg(50,55),
	hit_die = 8,
	challenge = 8,
	stats = { str=19, dex=17, con=14, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "medium_spider"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_ANT",
	image = "tiles/ant.png",
	display = 'a', color=colors.BROWN,
	desc = [[A giant ant.]],

	stats = { str=10, dex=10, con=10, int=1, wis=11, cha=9, luc=10 },
	combat = { dam= {1,6} },
	infravision = 4,
	skill_climb = 8,
	combat_natural = 7,
}

newEntity{
	base = "BASE_NPC_ANT",
	name = "giant ant worker", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 4,
	max_life = resolvers.rngavg(8,11),
	hit_die = 2,
	challenge = 1,
}

--Acid sting 1d4
newEntity{
	base = "BASE_NPC_ANT",
	name = "giant ant soldier", color=colors.BROWN,
	level_range = {5, 20}, exp_worth = 600,
	rarity = 4,
	max_life = resolvers.rngavg(10,13),
	hit_die = 2,
	challenge = 2,
	stats = { str=14, dex=10, con=13, int=1, wis=13, cha=11, luc=10 },
	combat = { dam= {2,4} },
}

newEntity{
	base = "BASE_NPC_ANT",
	image = "tiles/ant_queen.png",
	name = "giant ant queen", color=colors.BROWN,
	level_range = {5, 20}, exp_worth = 300,
	rarity = 4,
	max_life = resolvers.rngavg(10,13),
	hit_die = 4,
	challenge = 2,
	stats = { str=16, dex=9, con=13, int=1, wis=13, cha=11, luc=10 },
	combat = { dam= {2,6} },
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_CENTIPEDE",
	image = "tiles/centipede.png",
	display = 'w', color=colors.BROWN,
	desc = [[A giant centipede.]],

	stats = { str=1, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	infravision = 4,
	skill_climb = 10,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "tiny centipede", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 50,
	rarity = 4,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/8,
	skill_hide = 16,
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "small centipede", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 100,
	rarity = 6,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
	skill_hide = 14,
	stats = { str=5, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "medium centipede", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 200,
	rarity = 8,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1/2,
	skill_hide = 8,
	stats = { str=9, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "large centipede", color=colors.BROWN,
	level_range = {5, 20}, exp_worth = 400,
	rarity = 6,
	max_life = resolvers.rngavg(12,14),
	hit_die = 3,
	challenge = 1,
	skill_hide = 4,
	stats = { str=13, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "huge centipede", color=colors.BROWN,
	level_range = {8, 20}, exp_worth = 600,
	rarity = 10,
	max_life = resolvers.rngavg(32,35),
	hit_die = 6,
	challenge = 2,
	stats = { str=17, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "gargantuan centipede", color=colors.BROWN,
	level_range = {10, 20}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(64,68),
	hit_die = 12,
	challenge = 6,
	stats = { str=23, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,8} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "colossal centipede", color=colors.BROWN,
	level_range = {15, 20}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(130,135),
	hit_die = 24,
	challenge = 9,
	stats = { str=27, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "small_centipede"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SCORPION",
	image = "tiles/scorpion.png",
	display = 'w', color=colors.TAN,
	desc = [[A giant scorpion.]],

	stats = { str=3, dex=10, con=14, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,2} },
	infravision = 4,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "tiny scorpion",
	level_range = {1, 20}, exp_worth = 100,
	rarity = 4,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1/4,
	skill_hide = 12,
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "small scorpion",
	level_range = {1, 20}, exp_worth = 200,
	rarity = 6,
	max_life = resolvers.rngavg(5,7),
	hit_die = 1,
	challenge = 1/2,
	skill_hide = 8,
	skill_climb = 3,
	stats = { str=9, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "medium scorpion",
	level_range = {1, 20}, exp_worth = 400,
	rarity = 6,
	max_life = resolvers.rngavg(12,14),
	hit_die = 2,
	challenge = 1,
	skill_hide = 4,
	skill_climb = 4,
	stats = { str=13, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "large scorpion",
	level_range = {5, 20}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(31,34),
	hit_die = 5,
	challenge = 3,
	skill_climb = 4,
	stats = { str=19, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "huge scorpion",
	level_range = {8, 20}, exp_worth = 2100,
	rarity = 10,
	max_life = resolvers.rngavg(72,77),
	hit_die = 10,
	challenge = 7,
	skill_climb = 4,
	stats = { str=23, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	poison = "large_scorpion"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_FBEETLE",
	image = "tiles/beetle.png",
	display = 'x', color=colors.FIREBRICK,
	desc = [[A giant fire beetle.]],
	stats = { str=10, dex=10, con=11, int=1, wis=10, cha=7, luc=12 },
	combat = { dam= {2,4} },
	infravision = 4,
}

newEntity{
	base = "BASE_NPC_FBEETLE",
	name = "giant fire beetle", color=colors.FIREBRICK,
	level_range = {1, 20}, exp_worth = 135,
	rarity = 4,
	max_life = resolvers.rngavg(3,5),
	resist = { [DamageType.FIRE] = 5, },
	hit_die = 1,
	challenge = 1/3,
	combat_natural = 6,
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SBEETLE",
	image = "tiles/beetle.png",
	display = 'x', color=colors.DARK_GREEN,
	desc = [[A giant stag beetle.]],
	stats = { str=23, dex=10, con=17, int=1, wis=10, cha=9, luc=12 },
	combat = { dam= {4,6} },
	infravision = 4,
}

newEntity{
	base = "BASE_NPC_SBEETLE",
	name = "giant stag beetle", color=colors.DARK_GREEN,
	level_range = {5, 20}, exp_worth = 1200,
	rarity = 12,
	max_life = resolvers.rngavg(50,54),
	hit_die = 7,
	challenge = 4,
	combat_natural = 10,
}
