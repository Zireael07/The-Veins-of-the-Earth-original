--Veins of the Earth
--Zireael 2013-2015

--Constructs do NOT leave corpses

local Talents = require("engine.interface.ActorTalents")
local DamageType = require "engine.DamageType"

local construct_desc = [[It can see in the dark. It is immune to mind-affecting effects, such as charms, compulsions or phantasms. It is immune to poison, sleep effects, paralysis, stunning, disease, death effects, and necromancy effects. It is immune to critical hits, ability damage, ability drain or energy drain. They do not eat, sleep or breathe.]]

--Immunity to magic
newEntity{
	define_as = "BASE_NPC_GOLEM",
	type = "construct",
	image = "tiles/golem.png",
	display = 'C', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A hand-crafted servile creature.]],

	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=25, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {1,6} },
	alignment = "Neutral",
--	movement_speed_bonus = -0.33,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	infravision = 4,
	combat_dr = 5,
	resolvers.wounds(),
	resolvers.talents{ [Talents.T_RAGE]=1 },
}

--Cursed wound, haste
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "clay golem", color=colors.LIGHT_BROWN,
	level_range = {10, nil}, exp_worth = 3000,
	rarity = 15,
	max_life = resolvers.rngavg(88,92),
	hit_die = 11,
	challenge = 10,
	combat_dr = 10,
	combat_natural = 13,
}

newEntity{
	base = "BASE_NPC_GOLEM",
	name = "flesh golem", color=colors.UMBER,
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 15,
	max_life = resolvers.rngavg(77,80),
	hit_die = 9,
	challenge = 7,
	combat_dr = 5,
	combat_natural = 10,
	stats = { str=21, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,8} },
}

--Breath weapon 1 sq 1d4 Con pri, 3d4 Con sec Fort DC 19
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "iron golem", color=colors.DARK_GRAY,
	level_range = {15, nil}, exp_worth = 4000,
	rarity = 20,
	max_life = resolvers.rngavg(128,132),
	hit_die = 18,
	challenge = 13,
	combat_dr = 15,
	combat_natural = 23,
	stats = { str=33, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,10} },
}

--Slow cooldown 2
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "stone golem", color=colors.GRAY,
	level_range = {15, nil}, exp_worth = 3300,
	rarity = 15,
	max_life = resolvers.rngavg(105,110),
	hit_die = 14,
	challenge = 11,
	combat_natural = 19,
	stats = { str=29, dex=9, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {2,10} },
}

--Slow cooldown 2
newEntity{
	base = "BASE_NPC_GOLEM",
	name = "greater stone golem", color=colors.GRAY,
	level_range = {20, nil}, exp_worth = 4800,
	rarity = 25,
	max_life = resolvers.rngavg(270,275),
	hit_die = 42,
	challenge = 16,
	combat_natural = 21,
	stats = { str=37, dex=7, con=1, int=1, wis=11, cha=1, luc=10 },
	combat = { dam= {4,8} },
}

--Fly 50 ft; poison pri sleep 10 rounds, sec sleep 5d6x10 rounds
newEntity{
	define_as = "BASE_NPC_HOMUNCULUS",
	type = "construct",
	image = "tiles/golem.png",
	display = 'C', color=colors.LIGHT_BROWN,
	body = { INVEN = 10 },
	desc = [[A wizard's miniature servant.]],
	specialist_desc = [[A homunculus’ body is formed from a mixture of clay, ashes, mandrake root, spring water, and one pint of the creator’s blood. Destroying a homunculus instantly strikes a painful blow to its master.]],
	uncommon_desc = [[A homunculus cannot speak, but it is linked telepathically to its creator. So long as a homunculus remains relatively nearby, the creature’s master also sees and hears everything its minion witnesses. A homunculus never willingly wanders beyond the range of the telepathic link with its master.]],
	common_desc = [[Homunculi are usually created by arcane spellcasters, who primarily use them as spies. Although it is not a fearsome combatant, a homunculus can inject sleep-inducing venom with its bite.]],
	base_desc = "This misshapen little bat-winged creature is a homunculus, a magical creation. "..construct_desc.."",

	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=8, dex=15, con=1, int=10, wis=12, cha=6, luc=12 },
	combat = { dam= {1,4} },
	name = "homunculus",
	level_range = {1, 25}, exp_worth = 400,
	rarity = 15,
	max_life = resolvers.rngavg(9,13),
	hit_die = 2,
	challenge = 1,
	infravision = 4,
	combat_natural = 2,
	skill_hide = 12,
	skill_listen = 3,
	skill_spot = 3,
	alignment = "Neutral",
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	resolvers.wounds()
}

--Fast healing 5, vampiric touch,
newEntity{
	define_as = "BASE_NPC_INEVITABLE",
	type = "construct",
	image = "tiles/golem.png",
	display = 'C', color=colors.GOLD,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A metal humanoid.]],

	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=14, dex=13, con=1, int=10, wis=17, cha=16, luc=10 },
	combat = { dam= {1,6} },
	alignment = "Lawful Neutral",
	rarity = 20,
	infravision = 4,
	combat_dr = 10,
	spell_resistance = 22,
	resolvers.wounds(),
	resolvers.talents{ [Talents.T_COMBAT_CASTING]=1,
		[Talents.T_ALERTNESS]=1,
	 },
}

--Spell-likes: At will—discern lies (DC 17), disguise self, fear (DC 17), hold person (DC 16), invisibility, locate creature, suggestion (DC 16); 1/day—hold monster (DC 17), mark of justice; 1/week— geas/quest.
newEntity{
	base = "BASE_NPC_INEVITABLE",
	name = "kolyarut",
	level_range = {15, nil}, exp_worth = 3600,
	max_life = resolvers.rngavg(90,95),
	hit_die = 13,
	challenge = 12,
	combat_natural = 10,
	skill_diplomacy = 2,
	skill_listen = 8,
	skill_search = 5,
	skill_sensemotive = 9,
	skill_spot = 8,
--	resolvers.talents{ [Talents.T_COMBAT_CASTING]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "banded mail" },
		{ name = "longsword" },
	},
}

--Awesome Blow, Imp Bull Rush
--Spell-likes: At will—air walk, dimension door, fear (DC 18), greater command (DC 19), greater dispel magic, mass inflict light wounds (DC 19), locate creature, true seeing; 1/day—chain lightning (DC 20), circle of death (DC 20), mark of justice, wall of force;
newEntity{
	base = "BASE_NPC_INEVITABLE",
	name = "marut",
	level_range = {15, nil}, exp_worth = 4500,
	max_life = resolvers.rngavg(110,115),
	hit_die = 15,
	challenge = 15,
	combat = { dam= {2,6} },
	stats = { str=35, dex=13, con=1, int=10, wis=17, cha=18, luc=10 },
	combat_natural = 15,
	skill_concentration = 12,
	skill_diplomacy = 2,
	skill_knowledge = 9,
	skill_listen = 13,
	skill_search = 9,
	skill_sensemotive = 9,
	skill_spot = 13,
	resolvers.generic(function(e)
		if rng.percent(50) then
			e.melee_project = { [DamageType.SONIC] = {3, 6} }
		else
			e.melee_project = { [DamageType.ELECTRIC] = {3, 6} }
		end
	end),

--	resolvers.talents{ [Talents.T_COMBAT_CASTING]=1,
--	[Talents.T_POWER_ATTACK]=1
--	},
	resolvers.equip{
		full_id=true,
		{ name = "full plate" },
	},
}

--Spell-likes: At will—clairaudience/clairvoyance, dimensional anchor, dispel magic, fear (DC 16), hold person (DC 15), locate creature, true seeing; 3/day—hold monster (DC 17), mark of justice;
newEntity{
	base = "BASE_NPC_INEVITABLE",
	name = "zelekhut",
	desc = [[A metal centaur.]],
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(70,75),
	hit_die = 8,
	challenge = 9,
	combat = { dam= {2,6} },
	stats = { str=21, dex=11, con=1, int=10, wis=17, cha=15, luc=10 },
	combat_natural = 9,
	spell_resistance = 20,
	skill_diplomacy = 2,
	skill_knowledge = 9,
	skill_listen = 6,
	skill_search = 9,
	skill_sensemotive = 9,
	skill_spot = 6,
	resolvers.equip{
		full_id=true,
		{ name = "plate armor" },
		{ name = "spiked chain" },
	},
}

--Fast healing 5, shield other, spell storing
newEntity{
	define_as = "BASE_NPC_SHIELD_GUARDIAN",
	type = "construct",
	image = "tiles/golem.png",
	display = 'C', color=colors.GOLD,
	body = { INVEN = 10 },
	desc = [[A wizard's miniature servant.]],

	ai = "animal_level", ai_state = { talent_in=3, },
	stats = { str=22, dex=10, con=1, int=1, wis=10, cha=1, luc=10 },
	combat = { dam= {1,8} },
	name = "shield guardian",
	level_range = {8, 25}, exp_worth = 2500,
	rarity = 15,
	max_life = resolvers.rngavg(110,115),
	hit_die = 15,
	challenge = 8,
	infravision = 4,
	combat_natural = 14,
	alignment = "Neutral",
	resolvers.wounds()
}
