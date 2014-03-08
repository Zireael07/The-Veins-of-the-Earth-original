--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_CENTAUR",
	type = "monstrous humanoid",
	name = "centaur",
	image = "tiles/newtiles/centaur.png",
	display = 'q', color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A proud centaur.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=14, con=15, int=8, wis=13, cha=11, luc=12 },
	combat = { dam= {1,6} },

	level_range = {1, 5}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat_natural = 2,
	skill_listen = 2,
	skill_movesilently = 2,
	skill_spot = 2,
	skill_survival = 1,
	movement_speed_bonus = 0.66,
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Poison use, immunity to confusion and insanity effects
--Spell-likes: At will—darkness, ghost sound; 1/day— daze (DC 13), sound burst (DC 15). Caster level 3rd
newEntity{
	define_as = "BASE_NPC_DERRO",
	type = "monstrous humanoid",
	name = "derro",
	image = "tiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A small twisted creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=14, con=13, int=10, wis=5, cha=16, luc=6 },
	combat = { dam= {1,6} },

	level_range = {5, nil}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 3,
	spell_resistance = 15,
	combat_natural = 2,
	skill_bluff = 2,
	skill_hide = 8,
	skill_listen = 4,
	skill_movesilently = 4,
	movement_speed_bonus = -0.33,
	alignment = "chaotic evil",
	resolvers.equip{
	full_id=true,
		{ name = "studded leather" },
		{ name = "buckler" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

--Detect thoughts, shapechange; immunity to sleep & charm effects; neutral alignment
newEntity{
	define_as = "BASE_NPC_DOPPELGANGER",
	type = "monstrous humanoid",
	name = "doppelganger",
	image = "tiles/doppelganger.png",
	display = 'h', color=colors.GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A thin grayish humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=12, dex=13, con=12, int=13, wis=12, cha=13, luc=12 },
	combat = { dam= {1,6} },

	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 3,
	combat_natural = 4,
	skill_bluff = 9, --+14 if shapechanged
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_hide = 8,
	skill_listen = 4,
	skill_sensemotive = 4,
	skill_spot = 4,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}

--Fly 60 ft.; Toughness
newEntity{
	define_as = "BASE_NPC_GARGOYLE",
	type = "monstrous humanoid",
	name = "gargoyle",
	image = "tiles/UT/gargoyle.png",
	display = 'Y', color=colors.GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A winged stone statue with a hideous snout.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=14, con=18, int=6, wis=11, cha=7, luc=12 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 1200,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 4,
	challenge = 4,
	combat_natural = 4,
	skill_hide = 12, --including stone bonus
	skill_listen = 4,
	skill_spot = 4,
	combat_dr = 10,
	movement_speed_bonus = 0.33,
	alignment = "chaotic evil",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}

--Swim 60 ft. instead of fly
newEntity{
	base = "BASE_NPC_GARGOYLE",
	name = "kapoacinth",
	color=colors.BLUE,
}

--Blind (immune to gaze attacks, visual effects, illusions); blindsight 4 squares; scent
newEntity{
	define_as = "BASE_NPC_GRIMLOCK",
	type = "monstrous humanoid",
	name = "grimlock",
	image = "tiles/human.png",
	display = 'h', color=colors.DARK_GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A dull gray humanoid with a flat skin on its face.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=13, con=13, int=10, wis=8, cha=6, luc=8 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 300,
	rarity = 8,
	max_life = resolvers.rngavg(10,15),
	hit_die = 1,
	challenge = 1,
	combat_natural = 4,
	skill_climb = 2,
	skill_hide = 12, --including stone bonus
	skill_listen = 6,
	skill_spot = 4,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
	resolvers.equip{
	full_id=true,
		{ name = "studded leather" },
		{ name = "battleaxe" },
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}

--Swim 60 ft., rake 1d4, blindsense 30 ft, light sensitivity
newEntity{
	define_as = "BASE_NPC_SAHUAGIN",
	type = "monstrous humanoid",
	name = "sahuagin",
	image = "tiles/merfolk.png",
	display = 'h', color=colors.DARK_BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A blue-green scaly creature with a humanoid build and a shark's head.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=13, con=12, int=14, wis=13, cha=9, luc=10 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 2,
	combat_natural = 5,
	skill_handleanimal = 3,
	skill_hide = 5, 
	skill_listen = 5,
	skill_spot = 5,
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	[Talents.T_RAGE]=1
	},
	alignment = "lawful evil",
	resolvers.equip{
	full_id=true,
		{ name = "trident" },
		{ name = "bolts (20)" },
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "heavy crossbow" },
	{ name = "fresh corpse" },
	},
}

newEntity{
	define_as = "BASE_NPC_HAG",
	type = "monstrous humanoid",
	image = "tiles/hag.png",
	display = 'u', color=colors.BLUE,
	body = { INVEN = 10 },
	desc = [[A twisted crone bent in two.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=25, dex=12, con=14, int=13, wis=13, cha=10, luc=8 },
	combat = { dam= {1,6} },
	infravision = 3,
	alignment = "chaotic evil",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Improved grab, rake 1d6, rend 2d6, DR 2/bludgeon; Blind-Fight
--Spell-likes: disguise self, fog cloud
newEntity{
	base = "BASE_NPC_HAG",
	name = "annis hag", color=colors.BLUE,
	level_range = {5, 20}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(45,50),
	hit_die = 7,
	challenge = 6,
	spell_resistance = 19,
	combat_natural = 9,
	skill_bluff = 8,
	skill_diplomacy = 2,
	skill_hide = 4,
	skill_intimidate = 2,
	skill_listen = 9,
	skill_spot = 9,
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--Swim 30 ft.; 2d4 STR damage Fort DC 16
--Spell-likes: At will—dancing lights, disguise self, ghost sound (DC 12), invisibility, pass without trace, tongues, water breathing.
newEntity{
	base = "BASE_NPC_HAG",
	name = "green hag", color=colors.DARK_GREEN,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 9,
	challenge = 5,
	infravision = 6,
	spell_resistance = 18,
	combat_natural = 11,
	skill_concentration = 6,
	skill_hide = 8,
	skill_knowledge = 6,
	skill_swim = 8,
	skill_listen = 10,
	skill_spot = 10,
	stats = { str=19, dex=12, con=12, int=13, wis=13, cha=14, luc=8 },
	combat = { dam= {1,4} },
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
}

--2d6 STR damage in FOV; Toughness
newEntity{
	base = "BASE_NPC_HAG",
	name = "sea hag", color=colors.LIGHT_BLUE,
	level_range = {5, 20}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 3,
	challenge = 4,
	spell_resistance = 14,
	combat_natural = 3,
	skill_hide = 3,
	skill_knowledge = 3,
	skill_swim = 8,
	skill_listen = 5,
	skill_spot = 5,
	stats = { str=19, dex=12, con=12, int=10, wis=13, cha=14, luc=8 },
	combat = { dam= {1,4} },
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	},
}

--Fly 80 ft., captivating song
newEntity{
	define_as = "BASE_NPC_HARPY",
	type = "monstrous humanoid",
	name = "harpy",
	display = 'B', color=colors.DARK_GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A winged creature with an ugly face.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=15, con=10, int=7, wis=12, cha=17, luc=10 },
	combat = { dam= {1,3} },

	level_range = {5, nil}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(30,35),
	infravision = 3,
	hit_die = 7,
	challenge = 4,
	combat_natural = 1,
	skill_bluff = 8,
	skill_intimidate = 4,
	skill_listen = 6,
	skill_spot = 2,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_PERSUASIVE]=1
	},
	resolvers.equip{
	full_id=true,
		{ name = "club" },
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}

--Petrifying gaze 3 sq Fort DC 15; poison 1d6 STR pri & 2d6 STR sec Fort DC 14
--Point Blank Shot, Precise Shot feats
newEntity{
	define_as = "BASE_NPC_MEDUSA",
	type = "monstrous humanoid",
	name = "medusa",
	display = 'h', color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A female humanoid hiding her face behind a veil.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=15, con=12, int=12, wis=13, cha=15, luc=12 },
	combat = { dam= {1,4} },

	level_range = {10, 25}, exp_worth = 2000,
	rarity = 18,
	max_life = resolvers.rngavg(30,35),
	hit_die = 6,
	challenge = 7,
	combat_natural = 3,
	skill_bluff = 6,
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_movesilently = 5,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_FINESSE]=1,
	},
	resolvers.equip{
	full_id=true,
		{ name = "shortbow" },
		{ name = "arrows (20)" },
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Powerful charge 4d6
newEntity{
	define_as = "BASE_NPC_MINOTAUR",
	type = "monstrous humanoid",
	name = "minotaur",
	image = "tiles/minotaur.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A giant horned minotaur.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=10, con=15, int=7, wis=10, cha=8, luc=12 },
	combat = { dam= {1,8} },

	level_range = {5, nil}, exp_worth = 1200,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 6,
	challenge = 4,
	combat_natural = 5,
	skill_intimidate = 3,
	skill_listen = 7,
	skill_search = 4,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
	resolvers.equip{
	full_id=true,
		{ name = "greataxe" },
	},
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}
