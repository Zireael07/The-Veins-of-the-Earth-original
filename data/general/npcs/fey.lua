--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Swim 20 ft.; Charisma bonus to saving throws; wild empathy
--Cast spells as Drd7; 3 squares radius blindness Fort DC 17; 3 squares hit stun 2d4 round Fort DC 17
--Spell-likes: 1/day—dimension door.
newEntity{
	define_as = "BASE_NPC_NYMPH",
	type = "fey",
--	image = "tiles/nymph.png",
	display = 'f', color=colors.DARK_GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A beautiful nymph.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=34, dex=10, con=29, int=21, wis=20, cha=20, luc=10 },
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
		{ name = "iron dagger" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}
