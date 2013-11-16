--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Corporeal instability DC 15 Fort
newEntity{
	define_as = "BASE_NPC_CHAOS_BEAST",
	type = "outsider",
	name = "chaos beast",
	display = 'O', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[A shapechanging beast.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=13, con=13, int=10, wis=10, cha=10, luc=10 },
	combat = { dam= {1,3} },

	level_range = {1, 5}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(40,45),
	hit_die = 4,
	challenge = 7,
	combat_natural = 5,
	spell_resistance = 15,
	skill_climb = 11,
	skill_escapeartist = 11,
	skill_hide = 12,
	skill_jump = 7,
	skill_listen = 11,
	skill_search = 11,
	skill_spot = 11,
	skill_tumble = 11,
	movement_speed_bonus = -0.33,

	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Immunity to poison, petrification & cold
newEntity{
	define_as = "BASE_NPC_FORMIAN",
	type = "animal",
	image = "tiles/ant.png",
	display = 'O', color=colors.BROWN,
	body = { INVEN = 10 },
	desc = [[It looks like a cross between an ant and a centaur.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=14, con=13, int=6, wis=10, cha=9, luc=10 },
	combat = { dam= {1,4} },
	skill_climb = 9,
	skill_movesilently = 8,
	movement_speed_bonus = 0.33,
	resists = {
                [DamageType.FIRE] = 10,
                [DamageType.ELECTRIC] = 10,
                [DamageType.SONIC] = 10,
    },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian worker",
	level_range = {1, 10}, exp_worth = 150,
	rarity = 10,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/2,
	combat_natural = 5,
	skill_hide = 4,
	skill_listen = 4,
	skill_search = 4,
	skill_spot = 4,
	resolvers.talents{ [Talents.T_CSW_INNATE]=1, },
}

--Poison 1d6 STR primary & sec DC 14
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian warrior",
	level_range = {1, 10}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat = { dam= {2,4} },
	stats = { str=17, dex=16, con=14, int=10, wis=12, cha=11, luc=10 },
	combat_natural = 5,
	spell_resistance = 18,
	skill_hide = 7,
	skill_jump = 11,
	skill_listen = 7,
	skill_movesilently = 7,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

--Poison 1d6 STR primary & sec DC 15
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian taskmaster",
	level_range = {5, 15}, exp_worth = 2000,
	rarity = 10,
	max_life = resolvers.rngavg(40,45),
	hit_die = 6,
	challenge = 7,
	combat = { dam= {2,4} },
	stats = { str=18, dex=16, con=14, int=11, wis=16, cha=19, luc=10 },
	combat_natural = 6,
	spell_resistance = 21,
	skill_diplomacy = 2,
	skill_hide = 9,
	skill_intimidate = 8,
	skill_listen = 9,
	skill_search = 7,
	skill_spot = 8,
	skill_movesilently = 9,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

--Poison 2d6 DEX primary & sec DC 20, fast healing 2
--Spell-likes: At will—charm monster (DC 17), clairaudience/clairvoyance, detect chaos, detect thoughts (DC 15), magic circle against chaos, greater teleport; 1/day—dictum (DC 20), order’s wrath (DC 17). 
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian myrmarch",
	level_range = {10, 15}, exp_worth = 3000,
	rarity = 10,
	max_life = resolvers.rngavg(100,105),
	hit_die = 12,
	challenge = 10,
	combat = { dam= {2,4} },
	stats = { str=19, dex=18, con=18, int=16, wis=16, cha=17, luc=10 },
	combat_natural = 14,
	spell_resistance = 25,
	skill_climb = 15,
	skill_concentration = 15,
	skill_diplomacy = 17,
	skill_hide = 11,
	skill_knowledge = 15,
	skill_listen = 15,
	skill_movesilently = 16,
	skill_search = 15,
	skill_sensemotive = 15,
	skill_spot = 15,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1
	 },
}

--Fast healing 2
--Cast spells as Sor17
--Spell-likes: At will—calm emotions (DC 17), charm monster (DC 19), clairaudience/clairvoyance, detect chaos, detect thoughts, dictum (DC 22), divination, hold monster (DC 20), magic circle against chaos, order’s wrath (DC 19), shield of law (DC 23), true seeing.
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian queen",
	level_range = {10, 15}, exp_worth = 3000,
	rarity = 50,
	max_life = resolvers.rngavg(190,195),
	hit_die = 20,
	challenge = 17,
	combat = { dam= {1,1} }, --it should be 0
	stats = { str=1, dex=1, con=20, int=20, wis=20, cha=21, luc=14 },
	combat_natural = 14,
	spell_resistance = 30,
	skill_bluff = 23,
	skill_concentration = 23,
	skill_diplomacy = 27,
	skill_intimidate = 25,
	skill_knowledge = 25,
	skill_listen = 25,
	skill_sensemotive = 25,
	skill_spellcraft = 25,
	skill_spot = 25,
	skill_usemagic = 25,
	movement_speed_bonus = -0.50,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	[Talents.T_TOUGHNESS]=1,
	 },
}