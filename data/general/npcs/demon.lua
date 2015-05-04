--Veins of the Earth
--Zireael 2014-2015

local Talents = require("engine.interface.ActorTalents")

local demon_desc = [[It doesn't need to eat, sleep or breathe.]]

--telepathy
newEntity{
  define_as = "BASE_NPC_DEMON",
  type = "demon",
  image = "tiles/demon.png",
  display = 'u', color=colors.UMBER,
  rarity = 15,
  body = { INVEN = 10 },
  ai = "human_level", ai_state = { talent_in=3, },
  alignment = "Chaotic Evil",
  resists = { [DamageType.ACID] = 10,
              [DamageType.COLD] = 10,
              [DamageType.FIRE] = 10,
  },
  resolvers.talents{[Talents.T_POISON_IMMUNITY]=1,
    [Talents.T_ELECTRIC_IMMUNITY]=1,
  },
  resolvers.wounds()
}

--Protective slime 1d8 acid
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_BABAU",
	display = 'ü', color=colors.WHITE,
    name = "babau",
	level_range = {10, 15}, exp_worth = 2700,
    max_life = resolvers.rngavg(65,70),
    hit_die = 7,
    challenge = 6,
	desc = [[Babaus are sneaky and sly. They attack the most powerful foe first, hoping to eliminate the true threats quickly and then toy with
    the rest. When ambushing their opponents, they make excellent use of the combination of multiple attacks and sneak attacks. A slimy red jelly
    coats the babau's skin.]],
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
	skill_move_silently = 18,
	infravision = 6,
    resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--1/day—scare (DC 12), stinking cloud (DC 13). Multiattack
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_DRETCH",
	display = 'ü', color=colors.TAN,
    name = "dretch",
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
	skill_move_silently = 5,
	skill_spot = 5,
	infravision = 6,
}

--Poison, alternate form, fast healing 2,
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_QUASIT",
	display = 'i', color=colors.BLUE,
    name = "quasit",
	level_range = {10, 15}, exp_worth = 600,
    max_life = resolvers.rngavg(10,15),
    hit_die = 3,
    challenge = 2,
	desc = [[These creatures are among the weakest of demonkind, often sent to the prime material plane to serve as familiars to
      chaotic and evil mages. A quasit is a two-foot tall humanoid with sharp claws, spiky horns and bat wings.]],
	common_desc = [[]],
	base_desc = ""..demon_desc.."",
	stats = { str=8, dex=17, con=10, int=10, wis=12, cha=10, luc=8 },
	combat = { dam= {1,3} },
	combat_natural = 5,
	skill_bluff = 6,
	skill_hide = 14,
	skill_knowledge = 6,
	skill_listen = 6,
	skill_move_silently = 6,
	skill_search = 6,
	skill_spellcraft = 6,
	skill_spot = 5,
	infravision = 6,
}

--DR 10/cold iron or good, tongues
newEntity{ base = "BASE_NPC_DEMON",
	define_as = "BASE_NPC_SUCCUBUS",
	display = 'ū', color=colors.PURPLE,
    image = "tiles/newtiles/succubus.png",
	name = "succubus",
	sex = "Female",
    desc = [[Appearing to mortals as breathtakingly beautiful, demure women of great magnetism and sensuality, succubi and incubi are the
      social agents and sexual predators of the tanar'ri. They procure favors from powerful mortals, move unseen among the highest levels
      of society and leads the world into darkness, chaos and corruption through its carnal desires.
      The true form of a succubus is a woman with small horns and bat wings.]],
	rarity = 10,
	level_range = {6,12}, exp_worth = 1200,
	max_life = resolvers.rngavg(30,35),
	hit_die = 6,
	challenge = 7,
	stats = { str=13, dex=13, con=13, int=16, wis=14, cha=26, luc=8 },
	combat = { dam= {1,6} },
	skill_concentration = 9,
	skill_escape_artist = 9,
	skill_hide = 9,
	skill_move_silently = 9,
	skill_intimidate = 9,
	skill_knowledge = 9,
	skill_bluff = 9,
	skill_diplomacy = 3,
	skill_disguise = 7,
	skill_listen = 9,
	skill_search = 10,
	skill_spot = 16,
	infravision = 6,
	combat_natural = 9,
	spell_resistance = 18,
	resolvers.talents{ [Talents.T_DODGE]=1,
		[Talents.T_MOBILITY]=1,
		[Talents.T_PERSUASIVE]=1,
	 },
}

newEntity{ base = "BASE_NPC_SUCCUBUS",
	name = "incubus",
    image = "tiles/newtiles/incubus.png",
	sex = "Male",
    desc = [[Appearing to mortals as breathtakingly beautiful, demure men of great magnetism and sensuality, succubi and incubi are the
      social agents and sexual predators of the tanar'ri. They procure favors from powerful mortals, move unseen among the highest levels
      of society and leads the world into darkness, chaos and corruption through its carnal desires.
      The true form of an incubus is a man with tiny horns and cloven hooves.]],
}
