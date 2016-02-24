--Veins of the Earth
--Zireael 2013-2016

local Talents = require "engine.interface.ActorTalents"

--Stuff that we're not modifying but needs to be explicitly set to zero to avoid getting OP
newEntity{ define_as = "BASE_EGO",
--	max_life = 0,
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
newEntity { base = "BASE_EGO",
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
newEntity { base = "BASE_EGO",
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
newEntity { base = "BASE_EGO",
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

--Str -4, Dex +4, Wis +4, Cha +4; Alertness, Dodge, Mobility, Finesse; Nature Sense
--Spell-likes: faerie fire, sleep, dimension door
newEntity{ base = "BASE_EGO",
	name = "half-fey ", prefix = true, instant_resolve = true,
	keywords = {fey=true},
	level_range = {5, nil},
	rarity = 10,

	type = "fey",
	infravision = 3,
	challenge = 2,
}

--Elemental-y (from Incursion)
--Fire immunity, 1d10 fire aura
newEntity{ base = "BASE_EGO",
	name = "flame ", prefix = true, instant_resolve = true,
	keywords = {flame=true},
	level_range = {5, nil},
	rarity = 20,

	type = "elemental",
	color=colors.DARK_RED,
	challenge = 2,
}

--Str +4, Dex -2; AC +6; earthmeld, tremorsense 6 tiles
newEntity{ base = "BASE_EGO",
	name = "earthen ", prefix = true, instant_resolve = true,
	keywords = {earthen=true},
	level_range = {5, nil},
	rarity = 20,

	type = "elemental",
	color=colors.SANDY_BROWN,
	challenge = 2,
}

--Dex +6, flight
newEntity{ base="BASE_EGO",
	name = "gaseous ", prefix = true, instant_resolve = true,
	keywords = {gaseous=true},
	level_range = {5, nil},
	rarity = 20,

	type = "elemental",
	color=colors.WHITE,
	challenge = 2,
}

--1d4 slam + engulf DC 20
newEntity{ base = "BASE_EGO",
	name = "aqueous ", prefix = true, instant_resolve = true,
	keywords = {aqueous=true},
	level_range = {5, nil},
	rarity = 20,

	type = "elemental",
	color=colors.DARK_BLUE,
	challenge = 2,
}

--Special from Incursion
--confusion DC 14 gaze; Spot +6 Search +6
newEntity{ base = "BASE_EGO",
	name = "three-eyed ", prefix = true, instant_resolve = true,
	keywords = {eyed=true},
	level_range = {15, nil},
	rarity = 55,

	challenge = 3,
	infravision = 3,
}

--Dex +4, Int +8, Wis +6, Cha +4; Tentacles 1d8, devour, evasion, SR 35
--spell-likes: "true strike", "distance distortion", "evard's black tentacles", "displacement", "confusion";
newEntity{ base = "BASE_EGO",
	name = "pseudonatural ", prefix = true, instant_resolve = true,
	keywords = {pseudonatural=true},
	level_range = {15, nil},
	rarity = 80,

	color=colors.PINK,
	challenge = 4,
	combat_attack = 2,
	hit_die = 3,
}

--TODO: ethereal CR +3, incorporeal, only touch attacks
