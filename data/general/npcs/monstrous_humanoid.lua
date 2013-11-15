--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")


newEntity{
	define_as = "BASE_NPC_CENTAUR",
	type = "monstrous humanoid",
	name = "centaur",
	display = 'q', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
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