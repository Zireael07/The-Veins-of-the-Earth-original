newTalentType{ type="arcane/metamagic", name = "Metamagic", description = "Metamagic" }

newTalent{
	name = "Metamagic: Empower", short_name = "EMPOWER",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
	info = [[Increases damage dealt by your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newTalent{
	name = "Metamagic: Enlarge", short_name = "ENLARGE",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
	info = [[Increases the range of your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newTalent{
	name = "Metamagic: Extend", short_name = "EXTEND",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
	info = [[Increases the duration of your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newTalent{
	name = "Metamagic: Maximize", short_name = "MAXIMIZE",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
	info = [[Increases all numerical values of your next spell to the max.]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}