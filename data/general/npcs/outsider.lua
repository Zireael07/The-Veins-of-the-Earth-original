--Veins of the Earth
--Zireael

--Corporeal instability DC 15 Fort
newEntity{
	define_as = "BASE_NPC_CHAOS_BEAST",
	type = "outsider",
	name = "chaos beast",
	display = 'O', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[A shapechanging beast.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=13, con=13, int=10, wis=10, cha=10, luc=10 },
	combat = { dam= {1,3} },

	level_range = {1, 5}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(40,45),
	hit_die = 4,
	challenge = 7,
	combat_natural = 5,
	spell_resistance = 15,
	skill_climb = 11,
	skill_escapeartist = 11,
	skill_hide = 12,
	skill_jump = 7,
	skill_listen = 11,
	skill_search = 11,
	skill_spot = 11,
	skill_tumble = 11,
	movement_speed_bonus = -0.33,

	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}