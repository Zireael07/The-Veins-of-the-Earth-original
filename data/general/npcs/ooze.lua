--Veins of the Earth
--Zireael 2013-2016

--Oozes do not leave corpses
local ooze_desc = ""

--Blindsight 60 ft
newEntity{
	define_as = "BASE_NPC_OOZE",
	type = "ooze",
	image = "tiles/new/ooze.png",
	display = 'j', color=colors.WHITE,
	body = { INVEN = 10 },
	body_parts = { torso=1, arms=1, legs=1, head=1 },
	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=17, dex=1, con=22, int=1, wis=1, cha=1, luc=10 },
	combat = { dam= {1,6} },
	rarity = 15,
	alignment = "Neutral",
	emote_anger = "*slosh*",
	blood_color = colors.BLACK,
	resolvers.wounds()
}

--Climb 20 ft.; +2d6 acid on hit, constrict 2d6 + acid, clone
newEntity{ base = "BASE_NPC_OOZE",
	define_as = "BASE_NPC_BLACK_PUDDING",
	display = 'j', color=colors.BLACK,
	desc = [[A black ooze.]],
	specialist_desc = [[Any weapon striking a black pudding is immediately subjected to the ooze’s acid and may be instantly dissolved. In addition, the pudding’s amorphous mass is utterly unharmed by attempts to hack it to pieces. Instead, slashing or piercing weapons split the pudding in half, creating two smaller — but otherwise just as dangerous — puddings.]],
	uncommon_desc = [[A black pudding continuously secretes acid that digests prey even as they struggle to escape the pudding’s grasp. Black pudding acid dissolves organic materials and metal, but not stone.]],
	common_desc = [[A black pudding is a mindless predator that attacks creatures by lashing out with its pseudopods, then attemps to crush them to death.]],
	base_desc = "This inky black blob is a black pudding. "..ooze_desc.."",

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
	specialist_desc = [[A gelatinous cube continuously secretes acid, which it uses to slowly digest creatures it has absorbed. A cube’s acid canot affect metal or stone, however, so precious items (such as coins or jewels) are often left visibly suspended within the cube.]],
	uncommon_desc = [[A gelatinous cube continuously secretes an anesthetizing slime that can paralyze any creature that touches it. Paralyzed creatures are soon engulfed.]],
	common_desc = [[A gelatinous cube is a mindless scavenger that feeds by sliding down passageways, absorbing everything it moves over — including smaller creatures. A gelatinous cube is immune to electricity.]],
	base_desc = "This sliding, nearly transparent wall is a gelatinous cube. "..ooze_desc.."",
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
	specialist_desc = [[A gray ooze is nearly transparent and virtually invisible when submerged in water.]],
	uncommon_desc = [[A gray ooze continuously secretes acid, which the gray ooze uses to digest its prey. A gray ooze’s acid dissolves organic matter and metal, but not stone. A gray ooze’s acid can instantly dissolve metal or wooden armor or weapons that touch it, rendering them useless.]],
	common_desc = [[A gray ooze is a mindless predator. It attacks like a serpent by lashing out with a pseudopod and attempting to constrict its prey. A gray ooze is immune to cold and fire.]],
	base_desc = "This seemingly harmless pool of water is actually a gray ooze. "..ooze_desc.."",
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
	image = "tiles/new/ochre_jelly.png",
	desc = [[An ochre jelly.]],
	specialist_desc = [[An ochre jelly’s amorphous body is utterly unharmed by attempts to hack it to pieces. In fact, attacks using electricity or slashing or piercing weapons cause the ooze to split into two smaller — but otherwise just as deadly — ochre jellies.]],
	uncommon_desc = [[An ochre jelly continuously secretes acid, which it uses to digest its grappled prey. An ochre jelly’s acid only dissolves flesh.]],
	common_desc = [[An ochre jelly is a mindless predator that attacks prey by lashing out with its pseudopods. An ochre jelly is unharmed by electricity.]],
	base_desc = "This mustard-colored creeping pool of slime is an ochre jelly. "..ooze_desc.."",
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
