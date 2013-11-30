--Veins of the Earth
--Zireael

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

--Fly 80 ft.
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_EAGLE",
	display = 'e', color=colors.YELLOW,
	desc = [[A proud eagle.]],
	stats = { str=18, dex=17, con=12, int=10, wis=14, cha=10, luc=12 },
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
}

newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_SHOCKLIZARD",
	display = 'q', color=colors.LIGHT_BLUE,
	desc = [[A lizard with light blue markings on its back.]],
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
}

newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_ANKHEG",
	image = "tiles/ankheg.png",
	display = 'B', color=colors.DARK_UMBER,
	desc = [[A large chitin-covered insect.]],
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
}

--Poison, spells, web, shapechange
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_ARANEA",
	image = "tiles/aranea.png",
	display = 's', color=colors.DARK_RED,
	desc = [[A large spider.]],
	stats = { str=11, dex=15, con=14, int=14, wis=13, cha=14, luc=12 },
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
}

--Petrifying gaze 3 squares Fort DC 13, Blind-Fight
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_BASILISK",
	image = "tiles/lizard.png",
	display = 'R', color=colors.UMBER,
	desc = [[A large dull brown reptile.]],
	stats = { str=15, dex=8, con=15, int=2, wis=12, cha=11, luc=8 },
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
}

--Speed 40 ft. breath weapon 2 squares cooldown 10 7d6 electric Ref DC 19; constrict 2d8, rake 1d4, immunity to electricity, scent
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_BEHIR",
	image = "tiles/lizard.png",
	display = 'R', color=colors.DARK_BLUE,
	desc = [[A large reptile in various shades of blue.]],
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
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

--Blink, dimension door; speed 40 ft.
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_BLINKDOG",
	image = "tiles/wolf.png",
	display = 'd', color=colors.DARK_BLUE,
	desc = [[A faintly shimmering canine.]],
	stats = { str=10, dex=17, con=10, int=10, wis=13, cha=11, luc=12 },
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
}

--Scent, tremorsense 4 squares
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_BULETTE",
	image = "tiles/lizard.png",
	display = 'B', color=colors.BROWN,
	desc = [[A terrifying beast with a shark's head.]],
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
}

--Fly 50 ft., scent; breath weapon 3d8 Ref DC 17 in a random color
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_CHIMERA",
	image = "tiles/gorgon.png",
	display = 'B', color=colors.BLACK,
	desc = [[A terrifying beast with multiple heads.]],
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
}

--Fly 60 ft.; petrification DC 12 on hit
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_COCKATRICE",
	image = "tiles/lizard.png",
	display = 'B', color=colors.BROWN,
	desc = [[A small sandy-colored creature with a rooster's comb.]],
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
}

--Fly 30 ft.; darkness, improved grab, constrict 1d4, blindsight 6 squares
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_DARKMANTLE",
	image = "tiles/bat.png",
	display = 'B', color=colors.BLACK,
	desc = [[A monster which resembles a stalactite.]],
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
}

--Acid spray (4d8 2 squares cone or 8d8 4 squares line Ref DC 17, immunity to acid, scent
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_DIGESTER",
	image = "tiles/lizard.png",
	display = 'B', color=colors.LIGHT_BROWN,
	desc = [[An eternally hungry monster.]],
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
}

--Fly 30 ft.; roar 10 squares fatigue Will DC 15; scent
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_DRAGONNE",
	image = "tiles/lizard.png",
	display = 'D', color=colors.LIGHT_BROWN,
	desc = [[An eternally hungry monster.]],
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
}

--Burrow 10 ft.; immunity to cold, vulnerability to cold; 
--Weapon Focus, Improved Natural Attack; 1d8 cold on hit; 3 sq cone 15d6 cold Ref DC 22 half once per hour
--An explosion upon death: 12d6 cold & 8d6 physical in 10 sq ball Ref DC 22
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_FROST_WORM",
	image = "tiles/worm.png",
	display = 'w', color=colors.LIGHT_BLUE,
	desc = [[A huge bluish worm.]],
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
}

--Climb 40 ft.; scent, rend 2d4
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_GIRALLON",
	image = "tiles/gorilla.png",
	display = 'Y', color=colors.WHITE,
	desc = [[A large gorilla covered in white fur.]],
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
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_TOUGHNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
}

--Scent, trample 1d8 Ref DC 19 half; breath weapon cone 5 squares turn to stone
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_GORGON",
	image = "tiles/gorgon.png",
	display = 'q', color=colors.DARK_GRAY,
	desc = [[A large aggressive quadruped.]],
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
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
}

--scent; improved grab, rend 2d6; Cleave, Imp Bull Rush; 
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_GRAY_RENDER",
	image = "tiles/gorilla.png",
	display = 'h', color=colors.DARK_GRAY,
	desc = [[A large aggressive humanoid with long claws.]],
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
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--Fly 80 ft.; pounce, rake 1d6
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_GRIFFON",
	image = "tiles/griffon.png",
	display = 'B', color=colors.GOLD,
	desc = [[A cross between a lion and an eagle.]],
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
	resolvers.talents{ [Talents.T_IRON_WILL]=1 },
}

--Fly 100 ft.; scent
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_HIPPOGRIFF",
	image = "tiles/griffon.png",
	display = 'B', color=colors.BROWN,
	desc = [[A cross between a horse and an eagle.]],
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
	movement_speed_bonus = 0.66,
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--Scent, scare Will DC 13
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_KRENSHAR",
	image = "tiles/cat.png",
	display = 'c', color=colors.WHITE,
	desc = [[A feline carnivore.]],
	stats = { str=11, dex=14, con=11, int=6, wis=13, cha=8, luc=12 },
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
	movement_speed_bonus = 0.33,
}

--Wisdom drain 1d4; Spring Attack
--Spell-likes: At will—disguise self, ventriloquism; 3/day—charm monster (DC 15), major image (DC 14), mirror image, suggestion (DC 14); 1/day—deep slumber (DC 14). 
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_LAMIA",
	image = "tiles/cat.png",
	display = 'c', color=colors.DARK_YELLOW,
	desc = [[A feline creature.]],
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
}

--Fly 60 ft.; magic circle against evil; pounce, rake 1d6, spells as Clr7; Blind-Fight
--Spell-likes: 2/day—greater invisibility (self only); 1/day—dimension door. 
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_LAMMASU",
	image = "tiles/cat.png",
	display = 'c', color=colors.GOLD,
	desc = [[A creature with a lion's body and a humanoid head with an impressive headdress.]],
	stats = { str=23, dex=12, con=17, int=16, wis=17, cha=14, luc=12 },
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
}

--Fly 50 ft; scent; spikes 1d4 range 30 ft.; Weapon Focus
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_MANTICORE",
	image = "tiles/gorgon.png",
	display = 'B', color=colors.BLACK,
	desc = [[A manticore.]],
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
}

--Fly 70 ft; 
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_OWL_GIANT",
	image = "tiles/owl.png",
	display = 'b', color=colors.BROWN,
	desc = [[A giant owl.]],
	stats = { str=18, dex=17, con=12, int=10, wis=14, cha=10, luc=12 },
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
}

--Scent, improved grab
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_OWLBEAR",
	image = "tiles/owlbear.png",
	display = 'B', color=colors.LIGHT_BROWN,
	desc = [[A giant owlbear.]],
	stats = { str=21, dex=12, con=21, int=2, wis=12, cha=10, luc=10 },
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
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--Scent
--Spell-likes: At will—detect good and detect evil within a 60-foot radius.
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_PEGASUS",
	image = "tiles/pegasus.png",
	display = 'q', color=colors.WHITE,
	desc = [[A beautiful winged horse.]],
	stats = { str=18, dex=15, con=16, int=10, wis=13, cha=13, luc=12 },
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
}

--Climb 20 ft; Poison pri & sec 1d8 CON Fort DC 17, ethereal jaunt
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_PHASE_SPIDER",
	image = "tiles/spider.png",
	display = 's', color=colors.GREEN,
	desc = [[A spider with green markings.]],
	stats = { str=17, dex=17, con=16, int=7, wis=13, cha=10, luc=12 },
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
}

--Burrow 20 ft. swim 10 ft.; improved grab, swallow whole, tremorsense 4 squares
--Poison pri 1d6 STR sec 2d6 STR Fort DC 25
--Cleave, Imp Bull Rush, Awesome Blow, Weapon Focus
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_PURPLE_WORM",
	image = "tiles/worm_purple.png",
	display = 'w', color=colors.RED,
	desc = [[A giant purple worm.]],
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
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--Trample 2d6, vorpal tusks; fast healing 10, scent
--Awesome Blow, Diehard, Endurance, Imp Bull Rush
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_RAZOR_BOAR",
	image = "tiles/boar.png",
	display = 'B', color=colors.BROWN,
	desc = [[A boar with razor sharp tusks.]],
	stats = { str=27, dex=13, con=17, int=2, wis=14, cha=9, luc=12 },
	name = "razor boar",
	level_range = {5, 25}, exp_worth = 3000,
	rarity = 15,
	max_life = resolvers.rngavg(125,130),
	hit_die = 10,
	challenge = 5,
	infravision = 4,
	combat_natural = 16,
	combat_dr = 5,
	spell_resistance = 21,
	skill_listen = 6,
	skill_survival = 6,
	skill_spot = 6,
	movement_speed_bonus = 0.66,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
--	[Talents.T_POWER_ATTACK]=1 
	},
}

--Burrow 20 ft; swallow whole; tremorsense 5 squares; heat - 8d6 fire dam 1 sq radius
--Awesome Blow, Imp Bull Rush
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_REMORHAZ",
	image = "tiles/remorhaz.png",
	display = 'B', color=colors.LIGHT_BLUE,
	desc = [[A frost worm with a glowing tail end.]],
	stats = { str=26, dex=13, con=21, int=5, wis=12, cha=10, luc=12 },
	combat = { dam= {2,8} },
	name = "remorhaz",
	level_range = {10, nil}, exp_worth = 3000,
	rarity = 25,
	max_life = resolvers.rngavg(70,75),
	hit_die = 7,
	challenge = 7,
	infravision = 4,
	combat_natural = 9,
	skill_listen = 7,
	skill_spot = 7,
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--Strand range 5 squares - drag 1 sq closer each round; 2d8 STR damage Fort DC 18; Weapon Focus
--Immunity to electricity, vulnerability to fire
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_ROPER",
	image = "tiles/worm.png",
	display = 'B', color=colors.GRAY,
	desc = [[A gray stone with strands.]],
	stats = { str=19, dex=13, con=17, int=12, wis=16, cha=12, luc=12 },
	combat = { dam= {2,6} },
	name = "roper",
	level_range = {15, nil}, exp_worth = 3600,
	rarity = 25,
	max_life = resolvers.rngavg(80,85),
	hit_die = 10,
	challenge = 12,
	spell_resistance = 30,
	infravision = 4,
	combat_natural = 13,
	skill_climb = 8,
	skill_hide = 9,
	skill_listen = 12,
	skill_spot = 12,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
}

--Swim 40 ft., hold breath (6xCON), scent, rend 2d6
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_SEA_CAT",
	image = "tiles/cat.png",
	display = 'c', color=colors.LIGHT_BLUE,
	desc = [[A boar with razor sharp tusks.]],
	stats = { str=19, dex=12, con=17, int=2, wis=13, cha=10, luc=12 },
	name = "sea cat",
	level_range = {5, nil}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 6,
	challenge = 4,
	infravision = 4,
	combat_natural = 7,
	skill_listen = 7,
	skill_swim = 8,
	skill_spot = 6,
	movement_speed_bonus = -0.88,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1 
	},
}

--Fly 40 ft., blood drain 1d4 CON when grappling
--TOO SMALL to drop corpse
newEntity{ 
	define_as = "BASE_NPC_STIRGE",
	type = "magical beast",
	image = "tiles/stirge.png",
	display = 'w', color=colors.LIGHT_RED,
	body = { INVEN = 10 },
	desc = [[A boar with razor sharp tusks.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=3, dex=19, con=10, int=1, wis=12, cha=6, luc=10 },
	combat = { dam= {1,1} },
	name = "stirge",
	level_range = {1, nil}, exp_worth = 150,
	rarity = 15,
	max_life = resolvers.rngavg(4,6),
	hit_die = 6,
	challenge = 1/2,
	infravision = 4,
	skill_hide = 10,
	skill_listen = 3,
	skill_spot = 3,
	movement_speed_bonus = -0.88,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_FINESSE]=1 
	},
	alignment = "neutral",
}

--Fly 60 ft; scent; freedom of movement; implant, poison pri none sec paralysis 1d8+5 weeks
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_SPIDER_EATER",
	image = "tiles/eagle.png",
	display = 'b', color=colors.LIGHT_RED,
	desc = [[A boar with razor sharp tusks.]],
	stats = { str=21, dex=13, con=21, int=2, wis=12, cha=10, luc=10 },
	combat = { dam= {1,8} },
	name = "spider eater",
	level_range = {5, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 4,
	challenge = 5,
	infravision = 4,
	combat_natural = 3,
	skill_listen = 9,
	skill_spot = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1 
	},
}

--Magic circle against evil; immunity to poison, charm, and compulsion; scent, wild empathy
--Spell-likes: detect evil at will, 1/day greater teleport, cure moderate wounds; 3/day cure light wounds
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_UNICORN",
	image = "tiles/newtiles/unicorn.png",
	display = 'b', color=colors.LIGHT_RED,
	desc = [[A beautiful unicorn.]],
	stats = { str=20, dex=17, con=21, int=10, wis=21, cha=24, luc=18 },
	combat = { dam= {1,8} },
	name = "unicorn",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 4,
	challenge = 3,
	infravision = 4,
	combat_natural = 5,
	skill_jump = 16,
	skill_listen = 5,
	skill_movesilently = 5,
	skill_spot = 5,
	skill_survival = 2,
	movement_speed_bonus = 0.88,
	alignment = "chaotic good",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--1d6 cold damage, scent, trip; breath weapon 2 sq cone cooldown 2 4d6 cold Ref DC 16 half
--Immunity to cold, vulnerability to fire
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_WINTER_WOLF",
	image = "tiles/wolf.png",
	display = 'w', color=colors.LIGHT_BLUE,
	desc = [[A white-blue wolf.]],
	stats = { str=18, dex=13, con=16, int=9, wis=13, cha=10, luc=10 },
	combat = { dam= {1,8} },
	name = "winter wolf",
	level_range = {5, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 6,
	challenge = 5,
	infravision = 4,
	combat_natural = 6,
	skill_listen = 5,
	skill_movesilently = 6,
	skill_spot = 5,
	movement_speed_bonus = 0.66,
	alignment = "neutral evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--Trip, scent
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_WORG",
	image = "tiles/wolf.png",
	display = 'w', color=colors.LIGHT_BROWN,
	desc = [[A large brownish-gray wolf.]],
	stats = { str=17, dex=15, con=15, int=6, wis=14, cha=10, luc=10 },
	combat = { dam= {1,6} },
	name = "worg",
	level_range = {5, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(30,35),
	hit_die = 4,
	challenge = 2,
	infravision = 4,
	combat_natural = 2,
	skill_hide = 2,
	skill_listen = 4,
	skill_movesilently = 4,
	skill_spot = 4,
	movement_speed_bonus = 0.66,
	alignment = "neutral evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--Fly 60 ft;  Multiattack, Snatch; Blind (blindsight 10 sq)
--Sonic lance 6d6 hit sonic 5 sq range; explosion 2d6 physical rad 1 sq
--vulnerability to sonic, immune to gaze attacks, visual effects, illusions
newEntity{ base = "BASE_NPC_MAGBEAST",
	define_as = "BASE_NPC_YRTHAK",
	image = "tiles/UT/gargoyle.png",
	display = 'Y', color=colors.LIGHT_BROWN,
	desc = [[A large blind gargoyle with a long tongue.]],
	stats = { str=20, dex=14, con=17, int=7, wis=13, cha=11, luc=10 },
	combat = { dam= {2,8} },
	name = "yrthak",
	level_range = {10, nil}, exp_worth = 2700,
	rarity = 25,
	max_life = resolvers.rngavg(100,105),
	hit_die = 12,
	challenge = 9,
	combat_natural = 6,
	skill_listen = 11,
	skill_movesilently = 8,
	movement_speed_bonus = -0.33,
	alignment = "neutral",
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

--Swim 20 ft., fast healing 11 + number of heads; scent
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
--	[Talents.T_TOUGHNESS]=1
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
