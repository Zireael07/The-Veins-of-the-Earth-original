--Veins of the Earth
--Copyright (C) 2013-2016 Zireael

--Magical traps 
newEntity{ define_as = "TRAP_MAGICAL",
	type = "general", subtype="magical", unided_name = "trap",
	display = '^',
	triggered = function(self, x, y, who)
		local damage = rng.dice(self.dam[1], self.dam[2])
		self:project(x, y, self.damtype, damage) --self.particles and {type=self.particles})
		return true
	end,
}

--Missing: extended bane, ghoul touch, bestow curse, glyph of warding, sepia snake sigil, phantasmal killer, chain lightning, black tentacles, summon monster, destruction, earthquake, power word stun, prismatic spray, word of chaos, energy drain, wail of the banshee
--Ideally they should just replicate spells

--the number of dice should be randomized, from 1 to 9
newEntity { base = "TRAP_MAGICAL",
	name = "burning hands trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {5,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,4}, damtype = DamageType.FIRE,
}

newEntity { base = "TRAP_MAGICAL",
	name = "inflict light wounds trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {5,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,8}, damtype = DamageType.MAGICAL,
}

newEntity { base = "TRAP_MAGICAL",
	name = "fire trap",
	detect_dc = 27, disarm_dc = 27,
	rarity = 15, level_range = {8,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,4}, damtype = DamageType.FIRE,
}

newEntity { base = "TRAP_MAGICAL",
	name = "acid arrow trap",
	detect_dc = 27, disarm_dc = 27,
	rarity = 15, level_range = {8,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,4}, damtype = DamageType.ACID,
}

newEntity { base = "TRAP_MAGICAL",
	name = "lightning bolt trap",
	detect_dc = 27, disarm_dc = 27,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,6}, damtype = DamageType.ELECTRICITY,
}

newEntity { base = "TRAP_MAGICAL",
	name = "fireball trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,6}, damtype = DamageType.FIRE,
}

newEntity { base = "TRAP_MAGICAL",
	name = "flame strike trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {1,6}, damtype = DamageType.FIRE,
}

newEntity { base = "TRAP_MAGICAL",
	name = "acid fog trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {2,6}, damtype = DamageType.ACID,
	--random time from 1-10 rounds
}

newEntity { base = "TRAP_MAGICAL",
	name = "blade barrier trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {3,6}, damtype = DamageType.PHYSICAL,
}

newEntity { base = "TRAP_MAGICAL",
	name = "incendiary cloud trap",
	detect_dc = 26, disarm_dc = 26,
	rarity = 15, level_range = {10,nil},
	color=colors.RED,
	message = "@Target@ is hit by a spell!",
	dam = {3,6}, damtype = DamageType.FIRE,
	--random time from 1-10 rounds
}