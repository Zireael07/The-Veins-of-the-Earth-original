--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

--Swim 20 ft; ink cloud 8 sq spread, jet (x4 speed once); improved grab, constrict
--Blind-Fight, Imp Crit, Improved Trip
--Spell-likes: 1/day—control weather, control winds, dominate animal (DC 18), resist energy.
newEntity{
	define_as = "BASE_NPC_KRAKEN",
	type = "magical beast", subtype = "aquatic"
--	image = "tiles/kraken.png",
	display = 'B', color=colors.DARK_BLUE,
	body = { INVEN = 10 },
	desc = [[An immense kraken.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=34, dex=10, con=29, int=21, wis=20, cha=20, luc=10 },
	combat = { dam= {2,8} },
	name = "kraken",
	level_range = {15, nil}, exp_worth = 300,
	rarity = 30,
	max_life = resolvers.rngavg(285,290),
	hit_die = 20,
	challenge = 12,
	alignment = "Neutral Evil",
	infravision = 4,
	combat_natural = 10,
	skill_concentration = 15,
	skill_diplomacy = 2,
	skill_intimidate = 11,
	skill_knowledge = 11,
	skill_listen = 25,
	skill_search = 22,
	skill_sensemotive = 12,
	skill_spot = 25,
	skill_swim  = 8,
	skill_usemagic = 11,
	resolvers.wounds(),
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1
	},
}
