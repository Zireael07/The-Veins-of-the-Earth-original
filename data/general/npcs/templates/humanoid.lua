--Veins of the Earth
--Zireael 2013-2016

local Talents = require "engine.interface.ActorTalents"

--Stuff that we're not modifying but needs to be explicitly set to zero to avoid getting OP
newEntity{ define_as = "BASE_EGO",
	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,
	movement_speed = 0,
	combat_attackspeed = 0,
}

newEntity{ base = "BASE_EGO",
	name = " zombie", suffix = true, instant_resolve=true,
	display = 'Z', color=colors.WHITE,
	shader = "dual_hue",
	shader_args = { hue_color1={0.2,0.2,0.2,1}, hue_color2={0.4,0.4,0.4,1} },
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,
	type = "undead",

	infravision = 3,
	challenge = 1,
	combat = { dam= {1,6} },
}

newEntity{ base = "BASE_EGO",
	name = " skeleton", suffix = true, instant_resolve=true,
	display = 's', color=colors.WHITE,
	shader = "dual_hue",
	shader_args = { hue_color1={0.2,0.2,0.2,1}, hue_color2={0,1,1,1} },
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,
	type = "undead",

	infravision = 3,
	challenge = 1,
	combat = { dam= {1,6} },
}

--Damage reduction 5/magic
newEntity { base = "BASE_EGO",
	name = "celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},
	shader = "dual_hue",
	shader_args = { hue_color1={0,0.8,0.8,1}, hue_color2={0,1,1,1} },

	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
--	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.ACID] = 5,
	[DamageType.COLD] = 5,
	[DamageType.ELECTRIC] = 5,
	 }
}

newEntity { base = "BASE_EGO",
	name = "fiendish ", prefix = true, instant_resolve=true,
	keywords = {fiendish=true},

	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
--	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.FIRE] = 5,
	[DamageType.COLD] = 5,
	},
}
 --Stat increases, spell-like abilities
newEntity {
	name = "half-celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},
	level_range = {5, nil},
	rarity = 10,

	infravision = 3,
--	spell_resistance = hit_die + 10,
	combat_natural = 1,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }
}

--Stat increases, spell-like abilities, bite/claw
newEntity {
	name = "half-fiend ", prefix = true, instant_resolve=true,
	keywords = {fiend=true},
	level_range = {5, nil},
	rarity = 10,

	infravision = 3,
--	spell_resistance = hit_die + 10,
	combat_natural = 1,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	[DamageType.FIRE] = 10,
	 }
}

--Stat increases, breath weapon; bite/claw
newEntity {
	name = "half-dragon ", prefix = true, instant_resolve=true,
	keywords = {dragon=true},
	level_range = {5, nil},
	rarity = 10,

	infravision = 3,
	combat_natural = 4,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }
}
