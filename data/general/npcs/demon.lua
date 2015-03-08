--Veins of the Earth
--Zireael 2014-2015

local Talents = require("engine.interface.ActorTalents")

local demon_desc = [[It doesn't need to eat, sleep or breathe.]]

--Immune to electricity and poison, telepathy
newEntity{
  define_as = "BASE_NPC_DEMON",
  type = "demon",
  image = "tiles/demon.png",
  display = 'u', color=colors.UMBER,
  rarity = 15,
  body = { INVEN = 10 },
  ai = "dumb_talented_simple", ai_state = { talent_in=3, },
  alignment = "chaotic evil",
  resists = { [DamageType.ACID] = 10,
              [DamageType.COLD] = 10,
              [DamageType.FIRE] = 10,
  },
  resolvers.wounds()
}

--Protective slime 1d8 acid
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_BABAU",
	display = 'u', color=colors.WHITE,
	level_range = {10, 15}, exp_worth = 2700,
    max_life = resolvers.rngavg(65,70),
    hit_die = 7,
    challenge = 6,
	desc = [[A human-sized demon.]],
	common_desc = [[]],
	base_desc = ""..demon_desc.."",
	stats = { str=21, dex=12, con=20, int=14, wis=13, cha=16, luc=8 },
	combat = { dam= {1,6} },
	sneak_attack = 2,
	combat_natural = 8,
	spell_resistance = 14,
	skill_climb = 7,
	skill_hide = 18,
	skill_listen = 18,
	skill_movesilently = 18,
	infravision = 6,
  resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--1/day—scare (DC 12), stinking cloud (DC 13). Multiattack
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_DRETCH",
	display = 'u', color=colors.TAN,
	level_range = {10, 15}, exp_worth = 600,
    max_life = resolvers.rngavg(10,15),
    hit_die = 2,
    challenge = 2,
	desc = [[A small demon.]],
	common_desc = [[]],
	base_desc = ""..demon_desc.."",
	stats = { str=12, dex=10, con=14, int=5, wis=11, cha=11, luc=8 },
	combat = { dam= {1,6} },
	combat_natural = 5,
	skill_hide = 9,
	skill_listen = 5,
	skill_movesilently = 5,
	skill_spot = 5,
	infravision = 6,
}

--Poison, alternate form, fast healing 2,
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_QUASIT",
	display = 'u', color=colors.BLACK,
	level_range = {10, 15}, exp_worth = 600,
    max_life = resolvers.rngavg(10,15),
    hit_die = 3,
    challenge = 2,
	desc = [[A tiny winged demon.]],
	common_desc = [[]],
	base_desc = ""..demon_desc.."",
	stats = { str=8, dex=17, con=10, int=10, wis=12, cha=10, luc=8 },
	combat = { dam= {1,3} },
	combat_natural = 5,
	skill_bluff = 6,
	skill_hide = 14,
	skill_knowledge = 6,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_search = 6,
	skill_spellcraft = 6,
	skill_spot = 5,
	infravision = 6,
}
