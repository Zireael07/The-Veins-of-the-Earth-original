--Veins of the Earth
--Zireael 2013-2016

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_WATER",
	type = "outsider", subtype = "water",
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	body_parts = { torso=1, arms=1, legs=1, head=1 },
	ai = "human_level", ai_state = { talent_in=3, },
	alignment = "Neutral",
	blood_color = colors.BLUE,
	resolvers.wounds()
}


--Swim 60 ft. Spell-like: 1/day—summon nature’s ally IV.
newEntity{ base = "BASE_NPC_WATER",
	define_as = "BASE_NPC_TRITON",
	name = "triton",
	image = "tiles/mobiles/triton.png",
	display = 'O', color=colors.DARK_BLUE,
	desc = [[A humanoid with a fish tail instead of legs and covered in silvery scales.]],

	stats = { str=12, dex=10, con=12, int=13, wis=13, cha=11, luc=10 },
	combat = { dam= {1,6} },

	level_range = {1, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 2,
	infravision = 4,
	combat_natural = 6,
	skill_diplomacy = 2,
	skill_hide = 6,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_search = 6,
	skill_sensemotive = 7,
	skill_spot = 6,
	skill_survival = 6,
	skill_swim = 8,
--	movement_speed_bonus = -0.88,
	movement_speed = 0.22,
	alignment = "Neutral Good",
}
