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