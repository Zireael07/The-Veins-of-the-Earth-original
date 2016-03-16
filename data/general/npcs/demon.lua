--Veins of the Earth
--Zireael 2014-2016

local Talents = require("engine.interface.ActorTalents")

local demon_desc = [[It doesn't need to eat, sleep or breathe.]]

--telepathy
newEntity{
    define_as = "BASE_NPC_DEMON",
    type = "demon",
    image = "tiles/mobiles/demon.png",
    display = 'u', color=colors.UMBER,
    rarity = 15,
    body = { INVEN = 10 },
    body_parts = { torso=1, arms=1, legs=1, head=1 },
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
    specialist_desc = [[Babau have a limited range of spell-like abilities. They can at will cast the following: darkness, dispel magic, see invisibility and greater teleport.]],
    uncommon_desc = [[Resistant to many forms of attack, babau are, however, vulnerable to good aligned weapons, and those made of cold iron. They do however have a protective coat of acidic slime which can damage or destroy most things that touch it.]],
	common_desc = [[As well as its natural attacks, a babau can also take advantage of foes that it catches unaware to place a telling blow, much like a trained rogue does. Babau speak Abyssal, Celestial and Draconic.]],
	base_desc = "This gaunt, abyssal creature is a babau, a demon that specialises in stealth and assassination. "..demon_desc.."",
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
    uncommon_desc = [[A dretch will use its summoning ability to call more dretches as soon as battle starts. It can also use stinking cloud and scare once per day.]],
	common_desc = [[While weak and unintelligent, dretches are often used as fodder in demonic armies. Without more powerful demons to keep them in line, they often flee at the first sign of defeat.]],
	base_desc = "This wretched creature is a dretch, a pathetic type of demon. "..demon_desc.."",
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
    specialist_desc = [[Quasits are capable of casting commune to answer questions on behalf of their masters or mortals that summon them for such tasks.]],
    uncommon_desc = [[Quasits are armed with weak but useful abilities, including the ability to change shape.]],
    common_desc = [[The tail of a quasit possesses a sharp, poisonous stinger.]],
	base_desc = "Quasits are weak but insidious demons who often act as advisors and familiars for powerful mortals."..demon_desc.."",
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
    body_parts = { torso=1, arms=1, legs=1, head=1, wing=1 },
    image = "tiles/new/succubus.png",
	name = "succubus",
	sex = "Female",
    desc = [[Appearing to mortals as breathtakingly beautiful, demure women of great magnetism and sensuality, succubi and incubi are the
      social agents and sexual predators of the tanar'ri. They procure favors from powerful mortals, move unseen among the highest levels
      of society and leads the world into darkness, chaos and corruption through its carnal desires.
      The true form of a succubus is a woman with small horns and bat wings.]],
    specialist_desc = [[A mere kiss from a succubus can drain energy from its victim and make him susceptible to suggestion.]],
    uncommon_desc = [[Succubi can assume almost any form and converse in any language. They can teleport at will and are able to charm almost any living creature.]],
    common_desc = ""..demon_desc.."",
    base_desc = [[Succubi are beautiful and seductive demons who tempt mortals to their doom.]],
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
	resolvers.talents{ [Talents.T_MOBILITY]=1,
		[Talents.T_MOBILITY]=1,
		[Talents.T_PERSUASIVE]=1,
	 },
}

newEntity{ base = "BASE_NPC_SUCCUBUS",
	name = "incubus",
    image = "tiles/new/incubus.png",
	sex = "Male",
    desc = [[Appearing to mortals as breathtakingly beautiful, demure men of great magnetism and sensuality, succubi and incubi are the
      social agents and sexual predators of the tanar'ri. They procure favors from powerful mortals, move unseen among the highest levels
      of society and leads the world into darkness, chaos and corruption through its carnal desires.
      The true form of an incubus is a man with tiny horns and cloven hooves.]],
}
