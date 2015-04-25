--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_EARTH",
	body = { INVEN = 10 },
	ai = "human_level", ai_state = { talent_in=3, },
	alignment = "Neutral",
	resolvers.wounds()
}

--Burrow 20 ft.; tremorsense 5 sq; earth glide; immunity to cold & fire; Multiattack, Toughness
newEntity{ base = "BASE_NPC_EARTH",
	define_as = "BASE_NPC_XORN",
	type = "outsider", subtype = "earth",
	image = "tiles/xorn.png",
	display = 'O', color=colors.LIGHT_BROWN,

	desc = [[An earthen creature.]],
	uncommon_desc = [[Xorns are immune to cold and fire, and they are resistant to electricity. There are several different shapes and sizes of xorns. Some grow to tremendous size and are known as elder xorns. Xorns ignore most creatures (since they cannot digest meat), unless they carry substantial amounts of metal or stone on them.]],
	common_desc = [[Xorns have all-around vision and can glide through earth and stone as if they were swimming -- they do not leave behind any trace of their passage. Xorns can sense the presence of creatures by the small tremors they produce on the ground.]],
	base_desc = [[This bizarre creature is a xorn, a native of the Elemental Plane of Earth. It can see in the dark and cannot be brought back to life by usual means. It can burrow through rock and earth.]],

	stats = { str=15, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
	combat = { dam= {2,8} },
	infravision = 4,
	combat_dr = 5,
	skill_hide = 10,
	resists = { [DamageType.ELECTRIC] = 10, },
}

newEntity{
	base = "BASE_NPC_XORN",
	name = "minor xorn",
	rarity = 15,
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
	rarity = 18,
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
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

--Awesome Blow, Cleave, Great Cleave, Imp Bull Rush
newEntity{
	base = "BASE_NPC_XORN",
	name = "elder xorn",
	rarity = 15,
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
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}
