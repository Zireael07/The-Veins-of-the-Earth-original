--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")
local DamageType = require "engine.DamageType"

--Elementals do not drop corpses!
local elemental_desc = ""

newEntity{
	define_as = "BASE_NPC_ELEMENTAL",
	type = "elemental",
	body = { INVEN = 10 },
	ai = "human_level", ai_state = { talent_in=3, },
	resolvers.wounds()
}


--Fly 100 ft.; whirlwind
newEntity{ base = "BASE_NPC_ELEMENTAL",
	define_as = "BASE_NPC_ELEMENTAL_AIR",
	image = "tiles/mobiles/elemental_air.png",
	display = 'E', color=colors.WHITE,
	desc = [[An air elemental.]],
	specialist_desc = [[Air elementals grow larger and more powerful over the course of their centuries-long existence. “Larval” elementals, called elementites, travel in swarms. The largest air elementals, called monoliths and primal elementals, are the size of tornados.]],
	uncommon_desc = [[More powerful air elementals are generally resistant to physical harm. An air elemental can transform itself into a vortex of whirling winds, picking up foes and battering them while they hang suspended in the air.]],
	common_desc = [[An air elemental batters foes with its forceful winds. Its mastery over the air around it allows it to keep airborne foes off balance, helping it avoid their attacks.]],
	base_desc = "This creature is an air elemental, a living manifestation of wind and air. Air elementals speak Auran. "..elemental_desc.."",

	stats = { str=10, dex=17, con=10, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,4} },
	skill_listen = 2,
	skill_spot = 8,
	combat_natural = 3,
	infravision = 4,
	resolvers.talents{ [Talents.T_FINESSE]=1, },
	fly = true,
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "small air elemental", color=colors.WHITE,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(8,10),
	hit_die = 2,
	challenge = 1,
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "medium air elemental", color=colors.WHITE,
	level_range = {5, 20}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	stats = { str=12, dex=21, con=14, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,6} },
	skill_listen = 3,
	skill_spot = 9,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "large air elemental", color=colors.WHITE,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(57,62),
	hit_die = 8,
	challenge = 5,
	stats = { str=14, dex=25, con=16, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,6} },
	combat_natural = 4,
	skill_listen = 5,
	skill_spot = 9,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}
--Spring Attack, Combat Reflexes
newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "huge air elemental", color=colors.WHITE,
	level_range = {10, 30}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(135,140),
	hit_die = 16,
	challenge = 7,
	stats = { str=18, dex=29, con=18, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 2,
	skill_listen = 10,
	skill_spot = 15,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	},
}

--Spring Attack, Combat Reflexes, Blind-Fight
newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "greater air elemental", color=colors.WHITE,
	level_range = {10, 30}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(175,180),
	hit_die = 21,
	challenge = 9,
	stats = { str=20, dex=31, con=18, int=8, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 6,
	skill_listen = 12,
	skill_spot = 16,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
--	[Talents.T_POWER_ATTACK]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--Spring Attack, Combat Reflexes, Blind-Fight, Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_AIR",
	name = "elder air elemental", color=colors.WHITE,
	level_range = {15, 30}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(200,205),
	hit_die = 24,
	challenge = 11,
	stats = { str=22, dex=33, con=18, int=10, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 6,
	skill_listen = 29,
	skill_spot = 29,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
--	[Talents.T_POWER_ATTACK]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--Earth glide, push
newEntity{ base = "BASE_NPC_ELEMENTAL",
	define_as = "BASE_NPC_ELEMENTAL_EARTH",
	image = "tiles/mobiles/elemental_earth.png",
	display = 'E', color=colors.BROWN,
	desc = [[An earth elemental.]],
	specialist_desc = [[Earth elementals grow larger and more powerful over the course of their centuries-long existence. “Larval” elementals, called elementites, travel in swarms. The largest earth elementals, the monoliths and primal elementals, are the size of mountains.]],
	uncommon_desc = [[More powerful earth elementals are generally resistant to physical harm. An earth elemental can glide through earth and stone (but not metal) as easily as a fish swims through water. An earth elemental can also use its solid mass to shove foes with a particularly effective bull rush. Casting move earth on an area containing a burrowing earth elemental can stun the creature and fling it back several paces.]],
	common_desc = [[An earth elemental pummels foes with its stony fists. Its mastery over the earth makes its attacks more effective when both it and its opponent are touching the ground.]],
	base_desc = "This creature is an earth elemental, a living manifestation of soil and stone. Earth elementals speak Terran. "..elemental_desc.."",

	stats = { str=17, dex=8, con=13, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,6} },
	skill_listen = 2,
	skill_spot = 8,
	combat_natural = 8,
	infravision = 4,
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "small earth elemental", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(8,10),
	hit_die = 2,
	challenge = 1,
}

--Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "medium earth elemental", color=colors.BROWN,
	level_range = {5, 20}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	stats = { str=21, dex=8, con=17, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,8} },
	combat_natural = 8,
	skill_listen = 3,
	skill_spot = 9,
}

--Cleave, Great Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "large earth elemental", color=colors.BROWN,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(65,70),
	hit_die = 8,
	challenge = 5,
	stats = { str=25, dex=8, con=19, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 9,
	skill_listen = 5,
	skill_spot = 9,
	combat_dr = 5,
}
--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "huge earth elemental", color=colors.BROWN,
	level_range = {10, 30}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(150,155),
	hit_die = 16,
	challenge = 7,
	stats = { str=29, dex=8, con=21, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 9,
	skill_listen = 10,
	skill_spot = 15,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_IRON_WILL]=1, },
}

--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "greater earth elemental", color=colors.BROWN,
	level_range = {10, 30}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(198,203),
	hit_die = 21,
	challenge = 9,
	stats = { str=31, dex=8, con=21, int=8, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 11,
	skill_listen = 12,
	skill_spot = 16,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_EARTH",
	name = "elder earth elemental", color=colors.BROWN,
	level_range = {15, 30}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(225,230),
	hit_die = 24,
	challenge = 11,
	stats = { str=33, dex=8, con=21, int=10, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 13,
	skill_listen = 29,
	skill_spot = 29,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--vulnerability to cold, burn (catch fire for 1d4 rounds)
newEntity{ base = "BASE_NPC_ELEMENTAL",
	define_as = "BASE_NPC_ELEMENTAL_FIRE",
	image = "tiles/mobiles/elemental_fire.png",
	display = 'E', color=colors.RED,
	desc = [[A fire elemental.]],
	specialist_desc = [[Fire elementals grow larger and more powerful over the course of their centuries-long existence. “Larval” elementals, called elementites, travel in swarms. The largest fire elmentals, the monoliths and primal elementals, are the size of forest fires.]],
	uncommon_desc = [[Fire elementals are immune to fire, and more powerful elementals are generally resistant to physical harm. However, they are vulnerable to cold and cannot enter water or any nonflammable liquid.]],
	common_desc = [[A fire elemental bashes foes with its fists. In addition to the sheer strength of its blows, its living flames burn whatever it touches.]],
	base_desc = "This creature is an fire elemental, a living manifestation of roaring flames. A fire elemental speaks Ignan. "..elemental_desc.."",

	stats = { str=10, dex=13, con=10, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,4} },
	skill_listen = 2,
	skill_spot = 8,
	combat_natural = 4,
	infravision = 4,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	resolvers.talents{ [Talents.T_FINESSE]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_FIRE_IMMUNITY]=1,
	},
	melee_project = { [DamageType.FIRE] = {1, 4} },
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "small fire elemental", color=colors.RED,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(8,10),
	hit_die = 2,
	challenge = 1,
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "medium fire elemental", color=colors.RED,
	level_range = {5, 20}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	stats = { str=12, dex=17, con=14, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,6} },
	skill_listen = 3,
	skill_spot = 9,
	resolvers.talents{ [Talents.T_MOBILITY]=1, },
	melee_project = { [DamageType.FIRE] = {1, 6} },
}
--Spring Attack
newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "large fire elemental", color=colors.RED,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(57,62),
	hit_die = 8,
	challenge = 5,
	stats = { str=14, dex=21, con=16, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,6} },
	combat_natural = 3,
	skill_listen = 5,
	skill_spot = 9,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_MOBILITY]=1, },
	melee_project = { [DamageType.FIRE] = {2, 6} },
}
--Spring Attack, Combat Reflexes
newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "huge fire elemental", color=colors.RED,
	level_range = {10, 30}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(135,140),
	hit_die = 16,
	challenge = 7,
	stats = { str=18, dex=25, con=18, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 2,
	skill_listen = 10,
	skill_spot = 15,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	[Talents.T_ALERTNESS]=1,
	},
	melee_project = { [DamageType.FIRE] = {2, 8} },
}

--Spring Attack, Combat Reflexes, Blind-Fight
newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "greater fire elemental", color=colors.RED,
	level_range = {10, 30}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(175,180),
	hit_die = 21,
	challenge = 9,
	stats = { str=20, dex=27, con=18, int=8, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 6,
	skill_listen = 12,
	skill_spot = 16,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	[Talents.T_ALERTNESS]=1,
	},
	melee_project = { [DamageType.FIRE] = {2, 8} },
}

--Spring Attack, Combat Reflexes, Blind-Fight, Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_FIRE",
	name = "elder fire elemental", color=colors.RED,
	level_range = {15, 30}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(200,205),
	hit_die = 24,
	challenge = 11,
	stats = { str=22, dex=29, con=18, int=10, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 6,
	skill_listen = 29,
	skill_spot = 29,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	[Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
	melee_project = { [DamageType.FIRE] = {2, 8} },
}

--Swim 90 ft.; drench, vortex
newEntity{ base = "BASE_NPC_ELEMENTAL",
	define_as = "BASE_NPC_ELEMENTAL_WATER",
	image = "tiles/mobiles/elemental_water.png",
	display = 'E', color=colors.BLUE,
	desc = [[A water elemental.]],
	specialist_desc = [[Water elementals grow larger and more powerful over the course of their centuries-long existence. “Larval” elementals, called elementites, travel in swarms. The largest water elementals, the monoliths and primal elementals, are the size of tidal waves.]],
	uncommon_desc = [[More powerful water elementals are generally resistant to physical harm. A water elemental can transform itself into a small whirlpool, sucking foes to the bottom and battering them with its rushing currents.]],
	common_desc = [[A water elemental batters foes with its fist-like waves. Its mastery over water makes its attacks more effective if both it and its opponent are touching water. However, a water elemental’s attacks are much less effective if either it or its foe are touching the ground. It can easily overturn watercraft smaller than itself, and its touch extinguishes open flames.]],
	base_desc = "This creature is a water elemental, a living manifestation of flowing water. A water elemental speaks Aquan. "..elemental_desc.."",

	stats = { str=14, dex=10, con=13, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,6} },
	skill_listen = 2,
	skill_spot = 8,
	combat_natural = 8,
	infravision = 4,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "small water elemental", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(8,10),
	hit_die = 2,
	challenge = 1,
}

--Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "medium water elemental", color=colors.BLUE,
	level_range = {5, 20}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	stats = { str=16, dex=12, con=17, int=4, wis=11, cha=11, luc=10 },
	combat = { dam= {1,8} },
	combat_natural = 8,
	skill_listen = 3,
	skill_spot = 9,
}

--Cleave, Great Cleave
newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "large water elemental", color=colors.BLUE,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(65,70),
	hit_die = 8,
	challenge = 5,
	stats = { str=20, dex=14, con=19, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	combat_natural = 8,
	skill_listen = 5,
	skill_spot = 9,
	combat_dr = 5,
}
--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "huge water elemental", color=colors.BLUE,
	level_range = {10, 30}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(150,155),
	hit_die = 16,
	challenge = 7,
	stats = { str=24, dex=18, con=21, int=6, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 9,
	skill_listen = 10,
	skill_spot = 15,
	combat_dr = 5,
	resolvers.talents{ [Talents.T_IRON_WILL]=1, },
}

--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "greater water elemental", color=colors.BLUE,
	level_range = {10, 30}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(198,203),
	hit_die = 21,
	challenge = 9,
	stats = { str=26, dex=20, con=21, int=8, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 11,
	skill_listen = 12,
	skill_spot = 16,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--Cleave, Great Cleave, Awesome Blow, Improved Bull Rush
newEntity{
	base = "BASE_NPC_ELEMENTAL_WATER",
	name = "elder water elemental", color=colors.BLUE,
	level_range = {15, 30}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(225,230),
	hit_die = 24,
	challenge = 11,
	stats = { str=28, dex=22, con=21, int=10, wis=11, cha=11, luc=10 },
	combat = { dam= {2,10} },
	combat_natural = 13,
	skill_listen = 29,
	skill_spot = 29,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--Commented out due to no invis yet
--Fly 30 ft.; constant innate invisibility; Weapon Focus
--[[newEntity{
	define_as = "BASE_NPC_INVISIBLE_STALKER",
	type = "elemental", subtype = "air",
--	image = "tiles/mobiles/wraith.png",
	display = "E", color=colors.DARK_GRAY,
	body = { INVEN = 10 },]]
--desc = [[An invisible creature.]],

--[[	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=19, con=14, int=14, wis=15, cha=11, luc=10 },
	combat = { dam= {2,6}, },
	name = "invisible stalker",
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 8,
	challenge = 7,
	combat_natural = 3,
	infravision = 4,
	skill_listen = 11,
	skill_search = 11,
	skill_spot = 11,
	fly = true,
}]]

--vulnerability to cold, melt weapons, combustion 1d8 fire for 1d4+2 rounds
newEntity{ base = "BASE_NPC_ELEMENTAL",
	define_as = "BASE_NPC_MAGMIN",
	subtype = "fire",
	image = "tiles/mobiles/elemental_fire.png",
	display = "E", color=colors.DARK_RED,
	desc = [[A small fiery being.]],

	stats = { str=15, dex=11, con=13, int=8, wis=10, cha=10, luc=10 },
	combat = { dam= {1,3}, },
	name = "magmin",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 3,
	combat_dr = 5,
	combat_dr_to_hit = 1,
	combat_natural = 6,
	infravision = 4,
	skill_climb = 1,
	skill_spot = 3,
	alignment = "Chaotic Neutral",
	resolvers.talents{ [Talents.T_FIRE_IMMUNITY]=1, },
}
