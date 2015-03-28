--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

--Swim 20 ft.; Charisma bonus to saving throws; wild empathy
--Cast spells as Drd7; 3 squares radius blindness Fort DC 17; 3 squares hit stun 2d4 round Fort DC 17
--Spell-likes: 1/day—dimension door.
newEntity{
	define_as = "BASE_NPC_NYMPH",
	type = "fey",
	image = "tiles/newtiles/nymph.png",
	display = 'f', color=colors.DARK_GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A beautiful nymph.]],

	ai = "humanoid_level", ai_state = { talent_in=3, },
	stats = { str=10, dex=17, con=12, int=16, wis=17, cha=19, luc=10 },
	combat = { dam= {2,8} },
	name = "nymph",
	level_range = {15, nil}, exp_worth = 2000,
	rarity = 20,
	max_life = resolvers.rngavg(25,30),
	hit_die = 6,
	challenge = 7,
	alignment = "chaotic good",
	infravision = 1,
	combat_dr = 10,
	combat_protection = 4,
	skill_concentration = 9,
	skill_diplomacy = 2,
	skill_escapeartist = 9,
	skill_handleanimal = 10,
	skill_heal = 9,
	skill_listen = 9,
	skill_movesilently = 9,
	skill_sensemotive = 9,
	skill_spot = 9,
	skill_swim  = 8,
	resolvers.talents{ [Talents.T_FINESSE]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "dagger" },
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "shortbow" },
	},
	faction = "good",
	resolvers.wounds()
}

newEntity{
	define_as = "BASE_NPC_SATYR",
	type = "fey",
	image = "tiles/satyr.png",
	display = 'f', color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A humanoid with hooves for feet.]],

	ai = "humanoid_level", ai_state = { talent_in=3, },
	stats = { str=10, dex=13, con=12, int=12, wis=13, cha=13, luc=12 },
	combat = { dam= {1,6} },
	name = "satyr",
	level_range = {1, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 5,
	--bumped due to DR and high AC; 4 in Incursion
	challenge = 5,
	alignment = "chaotic neutral",
	infravision = 1,
	combat_dr = 5,
	combat_natural = 4,
	skill_bluff = 8,
	skill_diplomacy = 2,
	skill_hide = 12,
	skill_intimidate = 2,
	skill_knowledge = 8,
	skill_listen = 14,
	skill_movesilently = 12,
	skill_spot = 14,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "dagger" },
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "shortbow" },
	},
	faction = "good",
	resolvers.wounds()
}
