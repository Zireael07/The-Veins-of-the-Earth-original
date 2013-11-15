--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_ETTIN",
	type = "giant",
	display = "H", color=colors.LIGHT_GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A two-headed giant.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=8, con=15, int=6, wis=10, cha=11, luc=8 },
	combat = { dam= {1,4}, },
	name = "ettin",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(60,65),
	hit_die = 10,
	challenge = 6,
	combat_natural = 6,
	infravision = 4,
	skill_listen = 10,
	skill_search = 4,
	skill_spot = 10,
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
--	[Talents.T_SUPERIOR_TWF]=1,
	},
	resolvers.equip{
		full_id=true,
		{ name = "hide armor" },
		{ name = "morningstar" },
		{ name = "morningstar" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "javelin" },
	},
}    