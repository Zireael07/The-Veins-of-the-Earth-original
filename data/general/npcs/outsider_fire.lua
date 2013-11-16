--Veins of the Earth
--Zireael

--Immunity to fire, vulnerability to cold
newEntity{
	define_as = "BASE_NPC_AZER",
	type = "outsider",
	image = "tiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.FIREBRICK,
	body = { INVEN = 10 },
	desc = [[A flamehaired dwarf wearing a metal kilt.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=13, int=12, wis=12, cha=9, luc=10 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
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
--	image = "tiles/npc/dwarf_fighter.png",
	display = 'O', color=colors.LIGHT_RED,
	body = { INVEN = 10 },
	desc = [[A large humanoid clothed in red and seemingly hovering in air.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=17, con=13, int=12, wis=12, cha=9, luc=10 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},	
}

newEntity{
	base = "BASE_NPC_EFREET",
	name = "efreet",
	level_range = {10, 25}, exp_worth = 600,
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