--Veins of the Earth
--Copyright (C) 2013-2016 Zireael

newEntity{ define_as = "TRAP_GENERAL",
	type = "general", subtype="general", unided_name = "trap",
	display = '^',
	dam = {1, 6}, damtype = DamageType.PHYSICAL,
	triggered = function(self, x, y, who)
	local damage = rng.dice(self.dam[1], self.dam[2])
		self:projectile(who, x, y, self.damtype, damage)
		return true
	end,
}
--Missing: compacting room, flood room

--CR 1 traps
newEntity { base = "TRAP_GENERAL",
	name = "basic arrow trap",
	detect_dc = 20, disarm_dc = 20,
	rarity = 5, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by an arrow!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

newEntity { base = "TRAP_GENERAL",
	name = "fusillade of darts",
	detect_dc = 14, disarm_dc = 20,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a dart!",
	dam = {1,4}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

newEntity { base = "TRAP_GENERAL",
	name = "portcullis trap",
	detect_dc = 20, disarm_dc = 20,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a falling portcullis!",
	dam = {3,6}, damtype = DamageType.PHYSICAL,
	--Blocks passage (spawn wall?)
	combat_attack = 10,
}

newEntity { base = "TRAP_GENERAL",
	name = "razor wire",
	detect_dc = 22, disarm_dc = 15,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ trips over a wire!",
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

newEntity { base = "TRAP_GENERAL",
	name = "rolling rock",
	detect_dc = 20, disarm_dc = 22,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a rolling rock!",
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

newEntity { base = "TRAP_GENERAL",
	name = "swinging block",
	detect_dc = 20, disarm_dc = 20,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a swinging block!",
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 5,
}

newEntity { base = "TRAP_GENERAL",
	name = "scything blade",
	detect_dc = 21, disarm_dc = 20,
	rarity = 15, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a blade!",
	dam = {1,8}, damtype = DamageType.PHYSICAL,
	combat_attack = 8,
}

newEntity { base = "TRAP_GENERAL",
	name = "spear trap",
	detect_dc = 20, disarm_dc = 20,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a spear!",
	dam = {1,8}, damtype = DamageType.PHYSICAL,
	--random target in a straight line
	range = 10, combat_attack = 12,
}

newEntity { base = "TRAP_GENERAL",
	name = "wall blade trap",
	detect_dc = 20, disarm_dc = 20,
	rarity = 15, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a blade!",
	dam = {2,4}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

--CR 2 traps
newEntity { base = "TRAP_GENERAL",
	name = "box of brown mold",
	detect_dc = 22, disarm_dc = 16,
	rarity = 15, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by spores!",
	dam = {1,6}, damtype = DamageType.COLD,
}

newEntity { base = "TRAP_GENERAL",
	name = "bricks",
	detect_dc = 20, disarm_dc = 20,
	rarity = 15, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by falling bricks!",
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 12,
}

newEntity { base = "TRAP_GENERAL",
	name = "javelin trap",
	detect_dc = 20, disarm_dc = 18,
	rarity = 10, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a javelin!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	--random target in a straight line
	range = 6, combat_attack = 16,
}

newEntity { base = "TRAP_GENERAL",
	name = "large net trap",
	detect_dc = 20, disarm_dc = 25,
	rarity = 10, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ is trapped in a net!",
	--dam = {1,6}, damtype = DamageType.PHYSICAL,
	--all in range are entangled
	range = 2, combat_attack = 5,
}

newEntity { base = "TRAP_GENERAL",
	name = "tripping chain",
	detect_dc = 15, disarm_dc = 18,
	rarity = 15, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ is tripped by a chain!",
	--Never move first! if it's true, the attack has a +4 bonus
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 15,
}

--CR 3 traps
newEntity { base = "TRAP_GENERAL",
	name = "ceiling pendulum",
	detect_dc = 15, disarm_dc = 27,
	rarity = 15, level_range = {8,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a swinging pendulum!",
	dam = {1,12}, damtype = DamageType.PHYSICAL,
	combat_attack = 15,
}

newEntity { base = "TRAP_GENERAL",
	name = "hail of needles",
	detect_dc = 22, disarm_dc = 22,
	rarity = 15, level_range = {8,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a hail of needles!",
	dam = {2,4}, damtype = DamageType.PHYSICAL,
	combat_attack = 20,
}

newEntity { base = "TRAP_GENERAL",
	name = "stone blocks",
	detect_dc = 25, disarm_dc = 20,
	rarity = 10, level_range = {8,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by falling stone blocks!",
	dam = {4,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 10,
}

--CR 4 traps
newEntity { base = "TRAP_GENERAL",
	name = "collapsing column",
	detect_dc = 20, disarm_dc = 24,
	rarity = 15, level_range = {10,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a collapsing column!",
	dam = {6,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 15,
}

--CR 5 traps
newEntity { base = "TRAP_GENERAL",
	name = "moving executioner statue",
	detect_dc = 25, disarm_dc = 18,
	rarity = 15, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a moving statue!",
	dam = {1,12}, damtype = DamageType.PHYSICAL, dambonus = 8,
	combat_attack = 16,
}

--CR 6 traps
newEntity { base = "TRAP_GENERAL",
	name = "built-to-collapse wall",
	detect_dc = 14, disarm_dc = 16,
	rarity = 15, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a collapsing wall!",
	dam = {8,6}, damtype = DamageType.PHYSICAL,
	--affects all in range
	combat_attack = 20, range = 2,
}

newEntity { base = "TRAP_GENERAL",
	name = "fusillade of spears",
	detect_dc = 26, disarm_dc = 20,
	rarity = 10, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a fusillade of spears!",
	dam = {1,8}, damtype = DamageType.PHYSICAL,
	--affects all in range
	combat_attack = 21, range = 2,
}

newEntity { base = "TRAP_GENERAL",
	name = "spiked blocks",
	detect_dc = 24, disarm_dc = 20,
	rarity = 10, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by falling spiked blocks!",
	dam = {6,6}, damtype = DamageType.PHYSICAL,
	--affects all in range
	combat_attack = 20, range = 2,
}

newEntity { base = "TRAP_GENERAL",
	name = "whirling poison blades",
	detect_dc = 20, disarm_dc = 20,
	rarity = 10, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by whirling poison blades!",
	dam = {6,6}, damtype = DamageType.PHYSICAL,
	--affects all in range, random poison on hit
	combat_attack = 10, range = 2,
}

--CR 9 
newEntity { base = "TRAP_GENERAL",
	name = "dropping ceiling",
	detect_dc = 20, disarm_dc = 16,
	rarity = 15, level_range = {20,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a dropping ceiling!",
	dam = {12,6}, damtype = DamageType.PHYSICAL,
	--affects all in range, 1 turn delay
	range = 2,
}

--CR 10
newEntity { base = "TRAP_GENERAL",
	name = "crushing room",
	detect_dc = 22, disarm_dc = 16,
	rarity = 15, level_range = {20,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a crushing room!",
	dam = {16,6}, damtype = DamageType.PHYSICAL,
	--affects all in range, 2 turn delay
	range = 2,
}

newEntity { base = "TRAP_GENERAL",
	name = "crushing wall trap",
	detect_dc = 20, disarm_dc = 25,
	rarity = 15, level_range = {20,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a crushing wall!",
	dam = {18,6}, damtype = DamageType.PHYSICAL,
}