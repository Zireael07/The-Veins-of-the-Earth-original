--Veins of the Earth
--Copyright (C) 2013 Zireael

newEntity{ define_as = "TRAP_GENERAL",
	type = "general", subtype="general", unided_name = "trap",
	display = '^',
	triggered = function(self, x, y, who)
		local damage = rng.dice(dam[1], dam[2])
		self:project(x, y, self.damtype, damage) --, self.particles and {type=self.particles})
		return true
	end,
}

--Poisoned traps
--Random poison on hit
newEntity { base = "TRAP_GENERAL",
	name = "poison dart trap",
	detect_dc = 20, disarm_dc = 14,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a dart!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	combat_attack = 8,
}

newEntity { base = "TRAP_GENERAL",
	name = "poison needle trap",
	detect_dc = 22, disarm_dc = 20,
	rarity = 10, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ is hit by a needle!",
	dam = {1,1}, damtype = DamageType.PHYSICAL,
	combat_attack = 8,
}

--Pit traps
--The number of dice should be from 1 to 10
newEntity { base = "TRAP_GENERAL",
	name = "pit trap",
	detect_dc = 20, disarm_dc = 20,
	rarity = 8, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ falls into a pit!",
	dam = {4,6}, damtype = DamageType.PHYSICAL,
	triggered = function(self, x, y, who)
	who:reflexSave(20)
	if save then return true 
	else self:project({type="hit",x=x,y=y}, x, y, self.damtype, self.dam or 10, self.particles and {type=self.particles}) 
		--Nevermove!
		return true end
	end,
}

newEntity { base = "TRAP_GENERAL",
	name = "camouflaged pit trap",
	detect_dc = 24, disarm_dc = 20,
	rarity = 8, level_range = {1,nil},
	color=colors.UMBER,
	message = "@Target@ falls into a pit!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	triggered = function(self, x, y, who)
	who:reflexSave(20)
	if save then return true 
	else self:project({type="hit",x=x,y=y}, x, y, self.damtype, self.dam or 10, self.particles and {type=self.particles})
		--Nevermove!
		return true
	end
	end,
}

newEntity { base = "TRAP_GENERAL",
	name = "spiked pit trap",
	detect_dc = 24, disarm_dc = 19,
	rarity = 10, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ falls into a pit!",
	dam = {2,6}, damtype = DamageType.PHYSICAL,
	--additionally, 1d4 spikes for 1d4 damage
	combat_attack = 10,
	triggered = function(self, x, y, who)
	who:reflexSave(20)
	if save then return true 
	else self:project({type="hit",x=x,y=y}, x, y, self.damtype, self.dam or 10, self.particles and {type=self.particles})
		--Nevermove!
		return true end
	end,
}

newEntity { base = "TRAP_GENERAL",
	name = "well-camouflaged pit trap",
	detect_dc = 27, disarm_dc = 20,
	rarity = 10, level_range = {5,nil},
	color=colors.UMBER,
	message = "@Target@ falls into a pit!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	triggered = function(self, x, y, who)
	who:reflexSave(20)
	if save then return true
	else self:project({type="hit",x=x,y=y}, x, y, self.damtype, self.dam or 10, self.particles and {type=self.particles})
		--Nevermove!
		return true end
	end,
}

newEntity { base = "TRAP_GENERAL",
	name = "wide-mouth pit trap",
	detect_dc = 26, disarm_dc = 25,
	rarity = 10, level_range = {15,nil},
	color=colors.UMBER,
	message = "@Target@ falls into a pit!",
	dam = {1,6}, damtype = DamageType.PHYSICAL,
	range = 3,
	--affects all in range
	triggered = function(self, x, y, who)
	who:reflexSave(20)
	if save then return true 
	else self:project({type="hit",x=x,y=y}, x, y, self.damtype, self.dam or 10, self.particles and {type=self.particles})
		--Nevermove!
		return true end
	end,
}