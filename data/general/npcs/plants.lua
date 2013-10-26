--Veins of the Earth
--Zireael

--Constrict, entangle; camouflage, immunity to electricity, resistance to cold & fire 10
newEntity{
	define_as = "BASE_NPC_ASSAVINE",
	type = "plant",
	display = 'P', color=colors.DARK_GREEN,
	body = { INVEN = 10 },
	desc = [[A crawling vine.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=20, dex=10, con=16, int=1, wis=13, cha=9, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_ASSAVINE",
	name = "assasin vine", color=colors.DARK_GREEN,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 20,
	max_life = resolvers.rngavg(28,32),
	hit_die = 4,
	challenge = 3,
	combat_natural = 6,
}