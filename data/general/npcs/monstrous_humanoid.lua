--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")


newEntity{
	define_as = "BASE_NPC_CENTAUR",
	type = "monstrous humanoid",
	name = "centaur",
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
	resolvers.equip{
	full_id=true,
		{ name = "studded leather" },
		{ name = "buckler" },
		{ name = "bolts (20)" },
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
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}

--Fly 60 ft.; AL CE
newEntity{
	define_as = "BASE_NPC_GARGOYLE",
	type = "monstrous humanoid",
	name = "gargoyle",
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
	resolvers.talents{ [Talents.T_TOUGHNESS]=1, },
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