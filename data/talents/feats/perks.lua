--Veins of the Earth
--Zireael 2014

newTalent{
	name = "Born Hero",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases all your saves by +2 and AC by 1.]],
	on_learn = function(self, t)
        self.combat_untyped = (self.combat_untyped or 0) + 1
        self.fortitude_save = (self.fortitude_save or 0) + 2
        self.reflex_save = (self.reflex_save or 0) + 2
        self.will_save = (self.will_save or 0) + 2
    end
}

newTalent{
	name = "Poison Immunity",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you immune to poison.]],
	on_learn = function(self, t)
    end
}

newTalent{
	name = "Disease Immunity",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you immune to disease.]],
	on_learn = function(self, t)
    end
}

newTalent{
	name = "Sleep Immunity",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you immune to magical sleep effects.]],
	on_learn = function(self, t)
    end
}

newTalent{
	name = "Paralysis Immunity",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you immune to paralysis.]],
	on_learn = function(self, t)
    end
}

newTalent{
	name = "Confusion Immunity",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you immune to confusion.]],
	on_learn = function(self, t)
    end
}

newTalent{
	name = "Fire Resistance",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you resistant to fire.]],
	on_learn = function(self, t) 
	self.resists[DamageType.FIRE] = (self.resists[DamageType.FIRE] or 0) + 10 end,
	on_unlearn = function(self, t) 
	self.resists[DamageType.FIRE] = (self.resists[DamageType.FIRE] or 0) - 10 end,
}

newTalent{
	name = "Acid Resistance",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you resistant to acid.]],
	on_learn = function(self, t) 
	self.resists[DamageType.ACID] = (self.resists[DamageType.ACID] or 0) + 10 end,
	on_unlearn = function(self, t) 
	self.resists[DamageType.ACID] = (self.resists[DamageType.ACID] or 0) - 10 end,
}

newTalent{
	name = "Cold Resistance",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you resistant to cold.]],
	on_learn = function(self, t) 
	self.resists[DamageType.COLD] = (self.resists[DamageType.COLD] or 0) + 10 end,
	on_unlearn = function(self, t) 
	self.resists[DamageType.COLD] = (self.resists[DamageType.COLD] or 0) - 10 end,
}

newTalent{
	name = "Electricity Resistance",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you resistant to electricity.]],
	on_learn = function(self, t) 
	self.resists[DamageType.ELECTRIC] = (self.resists[DamageType.ELECTRIC] or 0) + 10 end,
	on_unlearn = function(self, t) 
	self.resists[DamageType.ELECTRIC] = (self.resists[DamageType.ELECTRIC] or 0) - 10 end,
}

newTalent{
	name = "Sonic Resistance",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[Makes you resistant to sound.]],
	on_learn = function(self, t) 
	self.resists[DamageType.SONIC] = (self.resists[DamageType.SONIC] or 0) + 10 end,
	on_unlearn = function(self, t) 
	self.resists[DamageType.SONIC] = (self.resists[DamageType.SONIC] or 0) - 10 end,
}
