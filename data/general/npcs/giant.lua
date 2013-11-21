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
	level_range = {5, nil}, exp_worth = 1800,
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

--Toughness, Weapon Focus
newEntity{
	define_as = "BASE_NPC_OGRE",
	type = "giant",
	display = "H", color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A dumb brute.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=8, con=15, int=6, wis=10, cha=7, luc=8 },
	combat = { dam= {1,6}, },
	name = "ogre",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat_natural = 4,
	infravision = 4,
	skill_listen = 2,
	skill_spot = 2,
	movement_speed_bonus = 0.33,
	alignment = "chaotic evil",
	resolvers.equip{
		full_id=true,
		{ name = "hide armor" },
		{ name = "greatclub" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "javelin" },
	},
}    

--Change shape, regeneration 5
--Spell-likes: At will—darkness, invisibility; 1/day— charm person (DC 14), cone of cold (DC 18), gaseous form.
newEntity{
	define_as = "BASE_NPC_OGRE_MAGE",
	type = "giant",
	display = "H", color=colors.BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A blue-skinned ogre.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=10, con=17, int=14, wis=14, cha=17, luc=8 },
	combat = { dam= {1,6}, },
	name = "ogre mage",
	level_range = {10, nil}, exp_worth = 2400,
	rarity = 15,
	max_life = resolvers.rngavg(35,40),
	hit_die = 5,
	challenge = 8,
	combat_natural = 4,
	infravision = 4,
	spell_resistance = 19,
	skill_concentration = 8,
	skill_listen = 8,
	skill_spellcraft = 8,
	skill_spot = 8,
	movement_speed_bonus = 0.33,
	alignment = "lawful evil",
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_SLEEP_INNATE]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "greatsword" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "longbow" },
	},
}    

--Regeneration 5, scent; rend 2d6
newEntity{
	define_as = "BASE_NPC_TROLL",
	type = "giant",
	display = "T", color=colors.GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A regenerating ugly brute.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=14, con=23, int=6, wis=9, cha=6, luc=8 },
	combat = { dam= {1,6}, },
	name = "troll",
	level_range = {5, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(60,65),
	hit_die = 6,
	challenge = 5,
	combat_natural = 4,
	infravision = 4,
	skill_listen = 5,
	skill_spot = 6,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	},
}    