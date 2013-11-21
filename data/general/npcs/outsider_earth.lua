--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Burrow 20 ft.; tremorsense 5 sq; earth glide; immunity to cold & fire; Multiattack, Toughness
newEntity{
	define_as = "BASE_NPC_XORN",
	type = "outsider", subtype = "earth",
	image = "tiles/elemental.png",
	display = 'O', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
	desc = [[An earthen creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
	combat = { dam= {2,8} },
	rarity = 15,
	infravision = 4,
	combat_dr = 5,
	skill_hide = 10,
	alignment = "neutral",
	resists = { [DamageType.ELECTRIC] = 10, },
}

newEntity{
	base = "BASE_NPC_XORN",
	name = "minor xorn",
	level_range = {5, nil}, exp_worth = 900,
	max_life = resolvers.rngavg(20,25),
	hit_die = 3,
	challenge = 3,
	combat_natural = 13,
	skill_intimidate = 3,
	skill_knowledge = 6,
	skill_listen = 6,
	skill_movesilently = 3,
	skill_search = 6,
	skill_survival = 6,
	skill_spot = 8,
}

--Cleave, Toughness
newEntity{
	base = "BASE_NPC_XORN",
	name = "average xorn",
	level_range = {5, nil}, exp_worth = 1800,
	max_life = resolvers.rngavg(45,50),
	hit_die = 7,
	challenge = 6,
	stats = { str=17, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
	combat = { dam= {4,6} },
	combat_natural = 14,
	skill_intimidate = 10,
	skill_knowledge = 10,
	skill_listen = 10,
	skill_movesilently = 10,
	skill_search = 10,
	skill_survival = 10,
	skill_spot = 10,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

--Awesome Blow, Cleave, Great Cleave, Imp Bull Rush
newEntity{
	base = "BASE_NPC_XORN",
	name = "elder xorn",
	level_range = {10, nil}, exp_worth = 2500,
	max_life = resolvers.rngavg(125,130),
	hit_die = 15,
	challenge = 8,
	stats = { str=25, dex=10, con=19, int=10, wis=11, cha=10, luc=10 },
	combat = { dam= {4,8} },
	combat_natural = 15,
	skill_hide = 14,
	skill_intimidate = 18,
	skill_knowledge = 18,
	skill_listen = 18,
	skill_movesilently = 18,
	skill_search = 22,
	skill_survival = 18,
	skill_spot = 22,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}