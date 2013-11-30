--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

--Outsiders do not drop corpses

--Immunity to fire, vulnerability to cold
newEntity{
	define_as = "BASE_NPC_AZER",
	type = "outsider",
	image = "tiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.FIREBRICK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A flamehaired dwarf wearing a metal kilt.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=13, int=12, wis=12, cha=9, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_AZER",
	name = "azer",
	level_range = {1, 15}, exp_worth = 600,
	rarity = 10,
	max_life = resolvers.rngavg(10,15),
	hit_die = 3,
	challenge = 2,
	infravision = 4,
	spell_resistance = 13,
	combat_natural = 6,
	skill_listen = 5,
	skill_search = 5,
	skill_spot = 5,
	resolvers.equip{
		full_id=true,
		{ name = "warhammer" },
		{ name = "scale armor"},
		{ name = "heavy steel shield" },
	},
	resolvers.inventory {
	full_id=true,
    { name = "short spear" },
	},
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

--1d6 fire damage on hit; immunity to fire, vulnerability to cold, plane shift, change shape
--Spell-likes: At will—detect magic, produce flame, pyrotechnics (DC 14), scorching ray (1 ray only); 3/day—invisibility, wall of fire (DC 16); 1/day—grant up to three wishes (to nongenies only), gaseous form, permanent image (DC 18). 
newEntity{
	define_as = "BASE_NPC_EFREET",
	type = "outsider",
	image = "tiles/djinn.png",
	display = 'O', color=colors.ORANGE,
	body = { INVEN = 10 },
	desc = [[A large humanoid clothed in red and seemingly hovering in air.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=17, con=13, int=12, wis=12, cha=9, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_EFREET",
	name = "efreet",
	level_range = {10, 25}, exp_worth = 2200,
	rarity = 20,
	max_life = resolvers.rngavg(60,65),
	hit_die = 10,
	challenge = 8,
	infravision = 4,
	combat_natural = 5,
	skill_bluff = 13,
	skill_concentration = 13,
	skill_diplomacy = 4,
	skill_intimidate = 15,
	skill_listen = 13,
	skill_movesilently = 13,
	skill_sensemotive = 13,
	skill_spellcraft = 13,
	skill_spot = 13,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_COMBAT_CASTING]=1,
	},
}

--Fly 60 ft.; paralysis 3 sq 1d6 rounds Fort DC 13; improved grab, blood drain
--Immunity to fire, vulnerability to cold
newEntity{
	define_as = "BASE_NPC_RAST",
	type = "outsider",
	image = "tiles/elemental_fire.png",
	display = 'O', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[A large creature of fire.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=12, con=13, int=3, wis=13, cha=12, luc=10 },
	combat = { dam= {1,8} },
}

newEntity{
	base = "BASE_NPC_RAST",
	name = "rast",
	level_range = {5, 25}, exp_worth = 1500,
	rarity = 20,
	max_life = resolvers.rngavg(23,27),
	hit_die = 4,
	challenge = 5,
	infravision = 4,
	combat_natural = 4,
	skill_hide = 7,
	skill_listen = 7,
	skill_movesilently = 7,
	skill_spot = 7,
	movement_speed_bonus = -0.88,
}

--Immunity to fire, vulnerability to cold
--Constrict 1d4 + 1d6 fire, improved grab
newEntity{
	define_as = "BASE_NPC_SALAMANDER",
	type = "outsider",
	image = "tiles/salamander.png",
	display = 'O', color=colors.LIGHT_RED,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A large creature of fire.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=12, dex=13, con=14, int=14, wis=15, cha=13, luc=10 },
	combat = { dam= {1,4} },
	infravision = 4,
	combat_natural = 7,
	movement_speed_bonus = -0.33,
	resolvers.equip{
		full_id=true,
		{ name = "spear" },
	},
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

newEntity{
	base = "BASE_NPC_SALAMANDER",
	name = "flamebrother salamander",
	level_range = {1, nil}, exp_worth = 900,
	rarity = 20,
	max_life = resolvers.rngavg(23,27),
	hit_die = 4,
	challenge = 3,
	combat_natural = 8,
	skill_hide = 11,
	skill_listen = 9,
	skill_movesilently = 5,
	skill_spot = 9,
}

--Constrict 2d6
newEntity{
	base = "BASE_NPC_SALAMANDER",
	name = "salamander",
	level_range = {5, nil}, exp_worth = 1800,
	rarity = 20,
	max_life = resolvers.rngavg(55,60),
	hit_die = 9,
	challenge = 6,
	stats = { str=14, dex=13, con=14, int=14, wis=15, cha=13, luc=10 },
	combat_dr = 10,
	skill_bluff = 10,
	skill_diplomacy = 2,
	skill_hide = 10,
	skill_intimidate = 2,
	skill_listen = 7,
	skill_movesilently = 10,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_POWER_ATTACK]=1
	},
}

--Constrict 2d8; Cleave, Great Cleave
--Spell-likes: 3/day—burning hands (DC 13), fireball (DC 15), flaming sphere (DC 14), wall of fire (DC 16); 1/day—dispel magic, summon monster VII (Huge fire elemental)
newEntity{
	base = "BASE_NPC_SALAMANDER",
	name = "noble salamander",
	level_range = {10, nil}, exp_worth = 3000,
	rarity = 20,
	max_life = resolvers.rngavg(110,115),
	hit_die = 15,
	challenge = 10,
	stats = { str=22, dex=13, con=16, int=16, wis=15, cha=15, luc=10 },
	combat_dr = 15,
	skill_bluff = 17,
	skill_diplomacy = 2,
	skill_hide = 14,
	skill_intimidate = 2,
	skill_listen = 11,
	skill_movesilently = 16,
	skill_spot = 11,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_POWER_ATTACK]=1
	},
}