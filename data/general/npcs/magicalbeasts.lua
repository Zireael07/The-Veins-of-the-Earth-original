--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Fly 80 ft.
newEntity{
	define_as = "BASE_NPC_EAGLE",
	type = "magical beast",
	display = 'e', color=colors.YELLOW,
	body = { INVEN = 10 },
	desc = [[A proud eagle.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=17, con=12, int=10, wis=14, cha=10, luc=12 },
	combat = { dam= {1,6} },
	name = "giant eagle", color=colors.YELLOW,
	image = "tiles/eagle.png",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat_natural = 2,
	skill_listen = 2,
	skill_spot = 13,
	skill_survival = 1,
	movement_speed_bonus = -0.66,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
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
	name = "shocker lizard",
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
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
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
	name = "ankheg",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(25,30),
	hit_die = 3,
	challenge = 3,
	combat_natural = 8,
	skill_climb = 3,
	skill_listen = 5,
	skill_spot = 2,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Poison, spells, web, shapechange
newEntity{
	define_as = "BASE_NPC_ARANEA",
	type = "magical beast",
	image = "tiles/aranea.png",
	display = 's', color=colors.DARK_RED,
	body = { INVEN = 10 },
	desc = [[A large spider.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=15, con=14, int=14, wis=13, cha=14, luc=12 },
	combat = { dam= {1,6} },
	name = "aranea",
	level_range = {10, nil}, exp_worth = 900,
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
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Petrifying gaze 3 squares Fort DC 13, Blind-Fight
newEntity{
	define_as = "BASE_NPC_BASILISK",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'R', color=colors.UMBER,
	body = { INVEN = 10 },
	desc = [[A large dull brown reptile.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=8, con=15, int=2, wis=12, cha=11, luc=8 },
	combat = { dam= {1,6} },
	name = "basilisk",
	level_range = {5, 15}, exp_worth = 1200,
	rarity = 10,
	max_life = resolvers.rngavg(40,45),
	hit_die = 6,
	challenge = 5,
	infravision = 4,
	combat_natural = 7,
	skill_hide = 4,
	skill_listen = 6,
	skill_spot = 6,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Speed 40 ft. breath weapon 2 squares cooldown 10 7d6 electric Ref DC 19; constrict 2d8, rake 1d4, immunity to electricity, scent
newEntity{
	define_as = "BASE_NPC_BEHIR",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'R', color=colors.DARK_BLUE,
	body = { INVEN = 10 },
	desc = [[A large reptile in various shades of blue.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=26, dex=13, con=21, int=7, wis=14, cha=12, luc=12 },
	combat = { dam= {2,4} },
	name = "behir",
	level_range = {10, nil}, exp_worth = 2400,
	rarity = 10,
	max_life = resolvers.rngavg(90,95),
	hit_die = 9,
	challenge = 8,
	infravision = 4,
	combat_natural = 9,
	skill_climb = 8,
	skill_hide = 4,
	skill_listen = 2,
	skill_spot = 2,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Blink, dimension door; speed 40 ft.
newEntity{
	define_as = "BASE_NPC_BLINKDOG",
	type = "magical beast",
	image = "tiles/wolf.png",
	display = 'd', color=colors.DARK_BLUE,
	body = { INVEN = 10 },
	desc = [[A faintly shimmering canine.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=17, con=10, int=10, wis=13, cha=11, luc=12 },
	combat = { dam= {1,6} },
	name = "blink dog",
	level_range = {1, 20}, exp_worth = 600,
	rarity = 10,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 2,
	infravision = 4,
	combat_natural = 3,
	skill_sensemotive = 1,
	skill_listen = 2,
	skill_spot = 2,
	skill_survival = 3,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Scent, tremorsense 4 squares
newEntity{
	define_as = "BASE_NPC_BULETTE",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'B', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[A terrifying beast with a shark's head.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=27, dex=15, con=20, int=2, wis=13, cha=6, luc=12 },
	combat = { dam= {2,8} },
	name = "bulette",
	level_range = {10, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(90,95),
	hit_die = 9,
	challenge = 7,
	infravision = 4,
	combat_natural = 10,
	skill_jump = 10,
	skill_listen = 8,
	skill_spot = 2,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 50 ft., scent; breath weapon 3d8 Ref DC 17 in a random color
newEntity{
	define_as = "BASE_NPC_CHIMERA",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'B', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A terrifying beast with multiple heads.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=13, con=17, int=4, wis=13, cha=10, luc=8 },
	combat = { dam= {2,6} },
	name = "chimera",
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 15,
	max_life = resolvers.rngavg(70,75),
	hit_die = 9,
	challenge = 7,
	infravision = 4,
	combat_natural = 8,
	skill_listen = 8,
	skill_spot = 8,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 60 ft.; petrification DC 12 on hit
newEntity{
	define_as = "BASE_NPC_COCKATRICE",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'B', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[A terrifying beast with a shark's head.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=6, dex=17, con=11, int=2, wis=13, cha=9, luc=12 },
	combat = { dam= {2,8} },
	name = "cockatrice",
	level_range = {10, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 5,
	challenge = 3,
	infravision = 4,
	skill_listen = 6,
	skill_spot = 6,
	resolvers.talents{ [Talents.T_DODGE]=1, },
	movement_speed_bonus = -0.33,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 30 ft.; darkness, improved grab, constrict 1d4, blindsight 6 squares
newEntity{
	define_as = "BASE_NPC_DARKMANTLE",
	type = "magical beast",
	image = "tiles/bat.png",
	display = 'B', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A monster which resembles a stalactite.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=16, dex=10, con=11, int=2, wis=13, cha=9, luc=12 },
	combat = { dam= {1,4} },
	name = "darkmantle",
	level_range = {1, nil}, exp_worth = 300,
	rarity = 10,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	infravision = 4,
	skill_listen = 5,
	skill_hide = 10,
	skill_spot = 5,
	movement_speed_bonus = -0.33,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Acid spray (4d8 2 squares cone or 8d8 4 squares line Ref DC 17, immunity to acid, scent
newEntity{
	define_as = "BASE_NPC_DIGESTER",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'B', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
	desc = [[An eternally hungry monster.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=15, con=17, int=2, wis=12, cha=10, luc=8 },
	combat = { dam= {1,8} },
	name = "digester",
	level_range = {10, nil}, exp_worth = 1800,
	rarity = 10,
	max_life = resolvers.rngavg(65,70),
	hit_die = 8,
	challenge = 6,
	infravision = 4,
	combat_natural = 5,
	skill_jump = 18,
	skill_listen = 5,
	skill_hide = 7,
	skill_spot = 5,
	movement_speed_bonus = 0.66,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 30 ft.; roar 10 squares fatigue Will DC 15; scent
newEntity{
	define_as = "BASE_NPC_DRAGONNE",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'D', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
	desc = [[An eternally hungry monster.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=15, con=17, int=6, wis=12, cha=12, luc=10 },
	combat = { dam= {2,6} },
	name = "dragonne",
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 10,
	max_life = resolvers.rngavg(75,80),
	hit_die = 9,
	challenge = 7,
	infravision = 4,
	combat_natural = 6,
	skill_listen = 10,
	skill_spot = 10,
	movement_speed_bonus = 0.33,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Burrow 10 ft.; immunity to cold, vulnerability to cold; 
--Weapon Focus, Improved Natural Attack; 1d8 cold on hit; 3 sq cone 15d6 cold Ref DC 22 half once per hour
--An explosion upon death: 12d6 cold & 8d6 physical in 10 sq ball Ref DC 22
newEntity{
	define_as = "BASE_NPC_FROST_WORM",
	type = "magical beast",
	image = "tiles/lizard.png",
	display = 'w', color=colors.LIGHT_BLUE,
	body = { INVEN = 10 },
	desc = [[A huge bluish worm.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=26, dex=10, con=20, int=2, wis=11, cha=11, luc=10 },
	combat = { dam= {2,8} },
	name = "frost worm",
	level_range = {10, nil}, exp_worth = 3600,
	rarity = 10,
	max_life = resolvers.rngavg(145,150),
	hit_die = 14,
	challenge = 12,
	infravision = 4,
	combat_natural = 10,
	skill_hide = 3,
	skill_listen = 5,
	skill_spot = 5,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Climb 40 ft.; scent, rend 2d4
newEntity{
	define_as = "BASE_NPC_GIRALLON",
	type = "magical beast",
--	image = "tiles/gorilla.png",
	display = 'Y', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A large gorilla covered in white fur.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=22, dex=17, con=14, int=2, wis=12, cha=7, luc=10 },
	combat = { dam= {1,4} },
	name = "girallon",
	level_range = {10, nil}, exp_worth = 1800,
	rarity = 10,
	max_life = resolvers.rngavg(55,60),
	hit_die = 14,
	challenge = 6,
	infravision = 4,
	combat_natural = 3,
	skill_climb = 8,
	skill_listen = 5,
	skill_spot = 5,
	alignment = "neutral",
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_TOUGHNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Scent, trample 1d8 Ref DC 19 half; breath weapon cone 5 squares turn to stone
newEntity{
	define_as = "BASE_NPC_GORGON",
	type = "magical beast",
--	image = "tiles/gorilla.png",
	display = 'q', color=colors.DARK_GRAY,
	body = { INVEN = 10 },
	desc = [[A large aggressive quadruped.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=10, con=21, int=2, wis=12, cha=9, luc=10 },
	combat = { dam= {1,8} },
	name = "gorgon",
	level_range = {10, nil}, exp_worth = 2400,
	rarity = 10,
	max_life = resolvers.rngavg(80,85),
	hit_die = 8,
	challenge = 8,
	infravision = 4,
	combat_natural = 10,
	skill_listen = 8,
	skill_spot = 13,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--scent; improved grab, rend 2d6; Cleave, Imp Bull Rush; 
newEntity{
	define_as = "BASE_NPC_GRAY_RENDER",
	type = "magical beast",
--	image = "tiles/gorilla.png",
	display = 'h', color=colors.DARK_GRAY,
	body = { INVEN = 10 },
	desc = [[A large aggressive humanoid with long claws.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=10, con=24, int=3, wis=12, cha=8, luc=10 },
	combat = { dam= {2,6} },
	name = "gray render",
	level_range = {10, nil}, exp_worth = 2400,
	rarity = 10,
	max_life = resolvers.rngavg(120,125),
	hit_die = 10,
	challenge = 8,
	infravision = 4,
	combat_natural = 9,
	skill_hide = 2,
	skill_spot = 9,
	skill_survival = 2,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 80 ft.; pounce, rake 1d6
newEntity{
	define_as = "BASE_NPC_GRIFFON",
	type = "magical beast",
--	image = "tiles/griffon.png",
	display = 'B', color=colors.GOLD,
	body = { INVEN = 10 },
	desc = [[A cross between a lion and an eagle.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=15, con=16, int=5, wis=13, cha=8, luc=12 },
	combat = { dam= {2,6} },
	name = "griffon",
	level_range = {10, 25}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(60,65),
	hit_die = 7,
	challenge = 4,
	infravision = 4,
	combat_natural = 5,
	skill_jump = 4,
	skill_listen = 5,
	skill_spot = 9,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_IRON_WILL]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 100 ft.; scent
newEntity{
	define_as = "BASE_NPC_HIPPOGRIFF",
	type = "magical beast",
--	image = "tiles/griffon.png",
	display = 'B', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[A cross between a horse and an eagle.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=15, con=16, int=2, wis=13, cha=8, luc=12 },
	combat = { dam= {1,4} },
	name = "hippogriff",
	level_range = {1, 25}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 3,
	challenge = 2,
	infravision = 4,
	combat_natural = 3,
	skill_listen = 3,
	skill_spot = 7,
	alignment = "neutral",
	movement_speed_bonus = 0.66,
	resolvers.talents{ [Talents.T_DODGE]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Scent, scare Will DC 13
newEntity{
	define_as = "BASE_NPC_KRENSHAR",
	type = "magical beast",
--	image = "tiles/cat.png",
	display = 'c', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A feline carnivore.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=14, con=11, int=6, wis=13, cha=8, luc=12 },
	combat = { dam= {1,6} },
	name = "krenshar",
	level_range = {1, 25}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	infravision = 4,
	combat_natural = 3,
	skill_hide = 2,
	skill_jump = 9,
	skill_listen = 2,
	skill_movesilently = 4,
	alignment = "neutral",
	movement_speed_bonus = 0.33,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Wisdom drain 1d4; Spring Attack
--Spell-likes: At will—disguise self, ventriloquism; 3/day—charm monster (DC 15), major image (DC 14), mirror image, suggestion (DC 14); 1/day—deep slumber (DC 14). 
newEntity{
	define_as = "BASE_NPC_LAMIA",
	type = "magical beast",
--	image = "tiles/cat.png",
	display = 'c', color=colors.DARK_YELLOW,
	body = { INVEN = 10 },
	desc = [[A feline creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=15, con=12, int=13, wis=15, cha=12, luc=12 },
	combat = { dam= {1,4} },
	name = "lamia",
	level_range = {5, 25}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(55,60),
	hit_die = 9,
	challenge = 6,
	infravision = 4,
	combat_natural = 6,
	skill_bluff = 13,
	skill_concentration = 9,
	skill_diplomacy = 2,
	skill_hide = 8,
	skill_intimidate = 2,
	skill_spot = 9,
	alignment = "chaotic evil",
	movement_speed_bonus = 0.88,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	[Talents.T_IRON_WILL]=1,
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 60 ft.; magic circle against evil; pounce, rake 1d6, spells as Clr7; Blind-Fight
--Spell-likes: 2/day—greater invisibility (self only); 1/day—dimension door. 
newEntity{
	define_as = "BASE_NPC_LAMMASU",
	type = "magical beast",
--	image = "tiles/cat.png",
	display = 'c', color=colors.GOLD,
	body = { INVEN = 10 },
	desc = [[A feline creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=12, con=17, int=16, wis=17, cha=14, luc=12 },
	combat = { dam= {1,6} },
	name = "lammasu",
	level_range = {10, 25}, exp_worth = 2400,
	rarity = 15,
	max_life = resolvers.rngavg(55,60),
	hit_die = 7,
	challenge = 8,
	infravision = 4,
	combat_natural = 9,
	skill_concentration = 10,
	skill_diplomacy = 2,
	skill_knowledge = 10,
	skill_listen = 10,
	skill_sensemotive = 10,
	skill_spot = 12,
	alignment = "lawful good",
	resolvers.talents{ [Talents.T_IRON_WILL]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 50 ft; scent; spikes 1d4 range 30 ft.; Weapon Focus
newEntity{
	define_as = "BASE_NPC_MANTICORE",
	type = "magical beast",
--	image = "tiles/cat.png",
	display = 'B', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A manticore.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=20, dex=15, con=19, int=7, wis=12, cha=9, luc=8 },
	combat = { dam= {2,4} },
	name = "manticore",
	level_range = {5, 25}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(55,60),
	hit_die = 6,
	challenge = 5,
	infravision = 4,
	combat_natural = 5,
	skill_listen = 4,
	skill_spot = 8,
	alignment = "lawful evil",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Fly 70 ft; 
newEntity{
	define_as = "BASE_NPC_OWL_GIANT",
	type = "magical beast",
--	image = "tiles/owl.png",
	display = 'b', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[A giant owl.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=17, con=12, int=10, wis=14, cha=10, luc=12 },
	combat = { dam= {1,6} },
	name = "giant owl",
	level_range = {5, 25}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	infravision = 2,
	combat_natural = 2,
	skill_knowledge = 2,
	skill_listen = 15,
	skill_movesilently = 5,
	skill_spot = 8,
	movement_speed_bonus = -0.88,
	alignment = "neutral good",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Scent, improved grab
newEntity{
	define_as = "BASE_NPC_OWLBEAR",
	type = "magical beast",
--	image = "tiles/owlbear.png",
	display = 'B', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
	desc = [[A giant owlbear.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=12, con=21, int=2, wis=12, cha=10, luc=10 },
	combat = { dam= {1,6} },
	name = "owlbear",
	level_range = {5, 25}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 5,
	challenge = 4,
	infravision = 2,
	combat_natural = 4,
	skill_listen = 7,
	skill_spot = 7,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Scent
--Spell-likes: At will—detect good and detect evil within a 60-foot radius.
newEntity{
	define_as = "BASE_NPC_PEGASUS",
	type = "magical beast",
--	image = "tiles/pegasus.png",
	display = 'q', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A beautiful winged horse.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=15, con=16, int=10, wis=13, cha=13, luc=12 },
	combat = { dam= {1,6} },
	name = "pegasus",
	level_range = {5, 25}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(30,35),
	hit_die = 4,
	challenge = 3,
	infravision = 4,
	combat_natural = 2,
	skill_diplomacy = 2,
	skill_listen = 7,
	skill_sensemotive = 7,
	skill_spot = 7,
	alignment = "chaotic good",
	resolvers.talents{ [Talents.T_IRON_WILL]=1 },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Climb 20 ft; Poison pri & sec 1d8 CON Fort DC 17, ethereal jaunt
newEntity{
	define_as = "BASE_NPC_PHASE_SPIDER",
	type = "magical beast",
--	image = "tiles/pegasus.png",
	display = 's', color=colors.GREEN,
	body = { INVEN = 10 },
	desc = [[A spider with green markings.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=17, con=16, int=7, wis=13, cha=10, luc=12 },
	combat = { dam= {1,6} },
	name = "phase spider",
	level_range = {5, 25}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 5,
	challenge = 5,
	infravision = 4,
	combat_natural = 2,
	skill_climb = 8,
	skill_movesilently = 8,
	skill_spot = 3,
	movement_speed_bonus = 0.33,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Burrow 20 ft. swim 10 ft.; improved grab, swallow whole, tremorsense 4 squares
--Poison pri 1d6 STR sec 2d6 STR Fort DC 25
--Cleave, Imp Bull Rush, Awesome Blow, Weapon Focus
newEntity{
	define_as = "BASE_NPC_PURPLE_WORM",
	type = "magical beast",
--	image = "tiles/purple_worm.png",
	display = 'w', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[A giant purple worm.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=17, con=16, int=7, wis=13, cha=10, luc=12 },
	combat = { dam= {2,8} },
	name = "purple worm",
	level_range = {15, nil}, exp_worth = 1500,
	rarity = 25,
	max_life = resolvers.rngavg(200,205),
	hit_die = 16,
	challenge = 12,
	infravision = 4,
	combat_natural = 11,
	skill_listen = 19,
	skill_swim = 8,
	movement_speed_bonus = -0.33,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}


--Swim 20 ft., fast healing 11 + number of heads; scent
newEntity{
	define_as = "BASE_NPC_HYDRA",
	type = "magical beast",
--	image = "tiles/hydra.png",
	display = 'B', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A multiheaded monstrosity.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=12, con=20, int=2, wis=10, cha=9, luc=10 },
	combat = { dam= {1,10} },
	rarity = 20,
	infravision = 4,
	skill_listen = 6,
	skill_spot = 6,
	skill_swim = 8,
	movement_speed_bonus = -0.66,
	resolvers.talents{ [Talents.T_IRON_WILL]=1,
--	[Talents.T_TOUGHNESS]=1
	},
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
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