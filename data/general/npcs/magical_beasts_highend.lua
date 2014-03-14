--Veins of the Earth
--Zireael 2014

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_MAGBEAST",
	type = "magical beast",
	body = { INVEN = 10 },
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=10, con=10, int=10, wis=10, cha=10, luc=10 },
	combat = { dam= {1,6} },
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Augmented critical, frightful presence DC 36 Will, improved grab, rush, swallow whole
--30% chance to deflect all lines and cones and magic missiles
--immunity to fire, poison, disease, energy drain, and ability damage, regeneration 40, scent,
--Awesome Blow, Blind-Fight, Cleave, Great Cleave, Imp Bull Rush
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_TARRASQUE",
	image = "tiles/eagle.png",
	display = 'B', color=colors.WHITE,
	desc = [[A boar with razor sharp tusks.]],
	stats = { str=45, dex=16, con=35, int=3, wis=14, cha=14, luc=14 },
	combat = { dam= {4,8} },
	name = "tarrasque",
	level_range = {20, nil}, exp_worth = 6000,
	rarity = 55,
	max_life = resolvers.rngavg(860,865),
	hit_die = 48,
	challenge = 20,
	infravision = 4,
	combat_dr = 15,
	spell_resistance = 32,
	combat_natural = 22,
	skill_listen = 15,
	skill_search = 14,
	skill_spot = 15,
	skill_survival = 12,
	movement_speed_bonus = -0.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_IRON_WILL]=1,
--	[Talents.T_POWER_ATTACK]=1
	},
}

--Pounce
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_SPHINX",
	image = "tiles/sphinx.png",
	display = 'B', color=colors.LIGHT_YELLOW,
	desc = [[A resplendent feline-like creature with powerful claws.]],
	stats = { str=25, dex=10, con=19, int=16, wis=17, cha=17, luc=12 },
	combat = { dam= {1,6} },
	rarity = 20,
	infravision = 4,
	skill_listen = 15,
	skill_spot = 15,
	alignment = "neutral",
}

--Fly 80 ft.; rake 2d4; roar (40 sq fear Will DC 19); spells as Clr7 + Good, Healing, Protection
--Cleave, Great Cleave, Track feats
newEntity{
	base = "BASE_NPC_SPHINX",
	name = "androsphinx",
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(115, 120),
	combat = { dam= {2,4} },
	hit_die = 12,
	challenge = 9,
	combat_natural = 12,
	skill_intimidate = 13,
	skill_knowledge = 15,
	skill_survival = 15,
	movement_speed_bonus = 0.88,
	alignment = "chaotic good",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
--	[Talents.T_POWER_ATTACK]=1 
	},
}

--Fly 60 ft., rake 1d6; Cleave feat
newEntity{
	base = "BASE_NPC_SPHINX",
	name = "criosphinx",
	level_range = {10, nil}, exp_worth = 2100,
	max_life = resolvers.rngavg(80, 85),
	stats = { str=23, dex=10, con=17, int=10, wis=11, cha=11, luc=12 },
	combat = { dam= {2,6} },
	hit_die = 10,
	challenge = 7,
	combat_natural = 10,
	skill_intimidate = 8,
	skill_listen = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
--	[Talents.T_POWER_ATTACK]=1 
	},
}

--Fly 60 ft., rake 1d6
--Spell-likes: 3/day—clairaudience/clairvoyance, detect magic, read magic, see invisibility; 1/day—comprehend languages, locate object, dispel magic, remove curse (DC 18), legend lore. 
newEntity{
	base = "BASE_NPC_SPHINX",
	name = "gynosphinx",
	level_range = {10, nil}, exp_worth = 2500,
	max_life = resolvers.rngavg(50, 55),
	stats = { str=19, dex=12, con=13, int=18, wis=19, cha=19, luc=12 },
	hit_die = 8,
	challenge = 8,
	combat_natural = 10,
	skill_bluff = 11,
	skill_concentration = 11,
	skill_diplomacy = 4,
	skill_intimidate = 9,
	skill_listen = 13,
	skill_sensemotive = 11,
	skill_spot = 13,
	resolvers.talents{ [Talents.T_COMBAT_CASTING]=1,
	[Talents.T_IRON_WILL]=1 
	},
}

--Fly 90 ft; rake 1d6; Cleave feat 
newEntity{
	base = "BASE_NPC_SPHINX",
	name = "hieracosphinx",
	level_range = {10, nil}, exp_worth = 1500,
	max_life = resolvers.rngavg(65, 70),
	stats = { str=21, dex=14, con=15, int=6, wis=15, cha=10, luc=12 },
	combat = { dam= {1,10} },
	hit_die = 9,
	challenge = 5,
	combat_natural = 7,
	skill_listen = 7,
	skill_spot = 11,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
--	[Talents.T_POWER_ATTACK]=1 
	},
}


--HYDRAS

--Swim 20 ft., fast healing 11 + number of heads; scent
--Toughness
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_HYDRA",
	image = "tiles/hydra.png",
	display = 'B', color=colors.WHITE,
	desc = [[A multiheaded monstrosity.]],
	stats = { str=17, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
	combat = { dam= {1,10} },
	rarity = 20,
	infravision = 4,
	skill_listen = 6,
	skill_spot = 6,
	skill_swim = 8,
	movement_speed_bonus = -0.66,
	resolvers.talents{ [Talents.T_IRON_WILL]=1,
	},
}

newEntity{
	base = "BASE_NPC_HYDRA",
	name = "five-headed hydra",
	level_range = {5, nil}, exp_worth = 1200,
	max_life = resolvers.rngavg(55,60),
	hit_die = 5,
	challenge = 4,
	combat_natural = 4,
}

--Weapon Focus
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "six-headed hydra",
	level_range = {5, nil}, exp_worth = 1500,
	max_life = resolvers.rngavg(65,70),
	hit_die = 6,
	challenge = 5,
	combat_natural = 5,
	skill_spot = 7,
}

--Weapon Focus
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "seven-headed hydra",
	level_range = {10, nil}, exp_worth = 1800,
	max_life = resolvers.rngavg(75,80),
	hit_die = 7,
	challenge = 6,
	combat_natural = 6,
	skill_listen = 7,
	skill_spot = 7,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eight-headed hydra",
	level_range = {10, nil}, exp_worth = 2000,
	max_life = resolvers.rngavg(85,90),
	hit_die = 8,
	challenge = 7,
	combat_natural = 7,
	skill_listen = 7,
	skill_spot = 8,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "nine-headed hydra",
	level_range = {10, nil}, exp_worth = 2300,
	max_life = resolvers.rngavg(95,100),
	hit_die = 9,
	challenge = 8,
	combat_natural = 8,
	skill_listen = 8,
	skill_spot = 8,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "ten-headed hydra",
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(95,100),
	hit_die = 10,
	challenge = 9,
	combat_natural = 9,
	skill_listen = 8,
	skill_spot = 9,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eleven-headed hydra",
	level_range = {10, nil}, exp_worth = 3000,
	max_life = resolvers.rngavg(105,110),
	hit_die = 11,
	challenge = 10,
	combat_natural = 10,
	skill_listen = 9,
	skill_spot = 9,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "twelve-headed hydra",
	level_range = {15, nil}, exp_worth = 3300,
	max_life = resolvers.rngavg(115,120),
	hit_die = 12,
	challenge = 11,
	combat_natural = 11,
	skill_listen = 9,
	skill_spot = 10,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 17 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "five-headed pyrohydra",
	level_range = {10, nil}, exp_worth = 1800,
	max_life = resolvers.rngavg(55,60),
	hit_die = 5,
	challenge = 6,
	combat_natural = 4,
}

--Weapon Focus; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 17 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "six-headed pyrohydra",
	level_range = {10, nil}, exp_worth = 2000,
	max_life = resolvers.rngavg(65,70),
	hit_die = 6,
	challenge = 7,
	combat_natural = 5,
	skill_spot = 7,
}

--Weapon Focus; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 18 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "seven-headed pyrohydra",
	level_range = {10, nil}, exp_worth = 2300,
	max_life = resolvers.rngavg(75,80),
	hit_die = 7,
	challenge = 8,
	combat_natural = 6,
	skill_listen = 7,
	skill_spot = 7,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 18 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eight-headed pyrohydra",
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(85,90),
	hit_die = 8,
	challenge = 9,
	combat_natural = 7,
	skill_listen = 7,
	skill_spot = 8,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 19 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "nine-headed pyrohydra",
	level_range = {10, nil}, exp_worth = 3000,
	max_life = resolvers.rngavg(95,100),
	hit_die = 9,
	challenge = 10,
	combat_natural = 8,
	skill_listen = 8,
	skill_spot = 8,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 19 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "ten-headed pyrohydra",
	level_range = {15, nil}, exp_worth = 3300,
	max_life = resolvers.rngavg(95,100),
	hit_die = 10,
	challenge = 11,
	combat_natural = 9,
	skill_listen = 8,
	skill_spot = 9,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 20 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eleven-headed pyrohydra",
	level_range = {15, nil}, exp_worth = 3600,
	max_life = resolvers.rngavg(105,110),
	hit_die = 11,
	challenge = 12,
	combat_natural = 10,
	skill_listen = 9,
	skill_spot = 9,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to fire; breath weapon 2 sq hit 3d6 fire x no of heads DC 20 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "twelve-headed pyrohydra",
	level_range = {15, nil}, exp_worth = 4000,
	max_life = resolvers.rngavg(115,120),
	hit_die = 12,
	challenge = 13,
	combat_natural = 11,
	skill_listen = 9,
	skill_spot = 10,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 17 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "five-headed cryohydra",
	level_range = {10, nil}, exp_worth = 1800,
	max_life = resolvers.rngavg(55,60),
	hit_die = 5,
	challenge = 6,
	combat_natural = 4,
}

--Weapon Focus; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 17 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "six-headed cryohydra",
	level_range = {10, nil}, exp_worth = 2000,
	max_life = resolvers.rngavg(65,70),
	hit_die = 6,
	challenge = 7,
	combat_natural = 5,
	skill_spot = 7,
}

--Weapon Focus; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 18 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "seven-headed cryohydra",
	level_range = {10, nil}, exp_worth = 2300,
	max_life = resolvers.rngavg(75,80),
	hit_die = 7,
	challenge = 8,
	combat_natural = 6,
	skill_listen = 7,
	skill_spot = 7,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 18 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eight-headed cryohydra",
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(85,90),
	hit_die = 8,
	challenge = 9,
	combat_natural = 7,
	skill_listen = 7,
	skill_spot = 8,
	skill_swim = 12,
	stats = { str=19, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 19 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "nine-headed cryohydra",
	level_range = {10, nil}, exp_worth = 3000,
	max_life = resolvers.rngavg(95,100),
	hit_die = 9,
	challenge = 10,
	combat_natural = 8,
	skill_listen = 8,
	skill_spot = 8,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 19 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "ten-headed cryohydra",
	level_range = {15, nil}, exp_worth = 3300,
	max_life = resolvers.rngavg(95,100),
	hit_die = 10,
	challenge = 11,
	combat_natural = 9,
	skill_listen = 8,
	skill_spot = 9,
	skill_swim = 13,
	stats = { str=21, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 20 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "eleven-headed cryohydra",
	level_range = {15, nil}, exp_worth = 3600,
	max_life = resolvers.rngavg(105,110),
	hit_die = 11,
	challenge = 12,
	combat_natural = 10,
	skill_listen = 9,
	skill_spot = 9,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}

--Weapon Focus, Blind-Fight; immunity to cold; breath weapon 2 sq hit 3d6 cold x no of heads DC 20 cooldown 5 rounds
newEntity{
	base = "BASE_NPC_HYDRA",
	name = "twelve-headed cryohydra",
	level_range = {15, nil}, exp_worth = 4000,
	max_life = resolvers.rngavg(115,120),
	hit_die = 12,
	challenge = 13,
	combat_natural = 11,
	skill_listen = 9,
	skill_spot = 10,
	skill_swim = 14,
	stats = { str=23, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
}
