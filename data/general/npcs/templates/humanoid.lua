--Veins of the Earth
--Zireael

--Damage reduction 5/magic
newEntity {
	name = "celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},
	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.ACID] = 5,
	[DamageType.COLD] = 5,
	[DamageType.ELECTRIC] = 5,
	 }
}

newEntity {
	name = "fiendish ", prefix = true, instant_resolve=true,
	keywords = {fiendish=true},
	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.FIRE] = 5,
	[DamageType.COLD] = 5,
	 }
}
 --Stat increases, spell-like abilities
newEntity {
	name = "half-celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},
	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
	spell_resistance = hit_die + 10,
	combat_def = 1,
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
	spell_resistance = hit_die + 10,
	combat_def = 1,
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
	combat_def = 4,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }
}

--Undead templates
newEntity {
	name = " skeleton", suffix = true, instant_resolve = true,
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,
	infravision = 3,
	combat = { dam= {1,6} },
}

newEntity {
	name = " zombie", suffix = true, instant_resolve = true,
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,
	combat = { dam= {1,6} },
}