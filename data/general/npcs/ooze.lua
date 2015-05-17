--Veins of the Earth
--Zireael 2013-2015

--Oozes do not leave corpses

--Blindsight 60 ft
newEntity{
	define_as = "BASE_NPC_OOZE",
	type = "ooze",
	image = "tiles/mobiles/newtiles/mobiles/ooze.png",
	display = 'j', color=colors.WHITE,
	body = { INVEN = 10 },
	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=17, dex=1, con=22, int=1, wis=1, cha=1, luc=10 },
	combat = { dam= {1,6} },
	rarity = 15,
	alignment = "Neutral",
	resolvers.wounds()
}

--Climb 20 ft.; +2d6 acid on hit, constrict 2d6 + acid, clone
newEntity{ base = "BASE_NPC_OOZE",
	define_as = "BASE_NPC_BLACK_PUDDING",
	display = 'j', color=colors.BLACK,
	desc = [[A black ooze.]],
	combat = { dam= {2,6} },
	name = "black pudding",
	level_range = {10, nil}, exp_worth = 2000,
	max_life = resolvers.rngavg(110,115),
	hit_die = 10,
	challenge = 7,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	skill_climb = 8,
}

--Constrict 2d8, acid 3d6
newEntity{
	base = "BASE_NPC_BLACK_PUDDING",
	stats = { str=26, dex=1, con=28, int=1, wis=1, cha=1, luc=10 },
	combat = { dam= {3,6} },
	name = "elder black pudding",
	level_range = {15, nil}, exp_worth = 3600,
	max_life = resolvers.rngavg(110,115),
	hit_die = 10,
	challenge = 12,
}

--Immunity to electricity; acid +1d6 on hit, engulf Ref DC 13, paralysis 3d6 rounds Fort DC 20
newEntity{ base = "BASE_NPC_OOZE",
	define_as = "BASE_NPC_GELATINOUS_CUBE",
	image = "tiles/mobiles/gelatinous_cube.png",
	display = 'j', color=colors.GREEN,
	desc = [[A green cube.]],
	stats = { str=10, dex=1, con=26, int=1, wis=1, cha=1, luc=10 },
	name = "gelatinous cube",
	level_range = {5, nil}, exp_worth = 900,
	max_life = resolvers.rngavg(50,55),
	hit_die = 4,
	challenge = 3,
--	movement_speed_bonus = -0.66,
	movement_speed = 0.33,
}

--Immunity to cold and fire; +1d6 acid on hit; improved grab; constrict 1d6
newEntity{ base = "BASE_NPC_OOZE",
	define_as = "BASE_NPC_GRAY_OOZE",
	display = 'j', color=colors.GRAY,
	desc = [[A gray ooze.]],
	stats = { str=12, dex=1, con=21, int=1, wis=1, cha=1, luc=10 },
	name = "gray ooze",
	level_range = {5, nil}, exp_worth = 1200,
	max_life = resolvers.rngavg(30,35),
	hit_die = 3,
	challenge = 4,
--	movement_speed_bonus = -0.88,
	movement_speed = 0.22,
}

--Climb 10 ft.; +1d4 acid on hit, clone
newEntity{ base = "BASE_NPC_OOZE",
	define_as = "BASE_NPC_OCHRE_JELLY",
	display = 'j', color=colors.OCHRE,
	image = "tiles/mobiles/newtiles/mobiles/ochre_jelly.png",
	desc = [[An ochre jelly.]],
	stats = { str=15, dex=1, con=22, int=1, wis=1, cha=1, luc=10 },
	combat = { dam= {2,4} },
	name = "ochre jelly",
	level_range = {5, nil}, exp_worth = 1500,
	max_life = resolvers.rngavg(70,72),
	hit_die = 6,
	challenge = 5,
	skill_climb = 9,
--	movement_speed_bonus = -0.88,
	movement_speed = 0.22,
}
