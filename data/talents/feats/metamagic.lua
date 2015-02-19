newTalentType{ type="arcane/metamagic", name = "Metamagic", description = "Metamagic" }

newFeat{
	name = "Metamagic: Empower", short_name = "EMPOWER",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
--	getMod = function(self, t) return "empower", 1 end,
	info = [[Increases damage dealt by your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newFeat{
	name = "Metamagic: Enlarge", short_name = "ENLARGE",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
--	getMod = function(self, t) return "enlarge", 1 end,
	info = [[Increases the range of your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newFeat{
	name = "Metamagic: Extend", short_name = "EXTEND",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
--	getMod = function(self, t) return "extend", 1 end,
	info = [[Increases the duration of your next spell by 50%, rounded up]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}

newFeat{
	name = "Metamagic: Maximize", short_name = "MAXIMIZE",
	type = {"arcane/metamagic", 1},
	points = 1,
	mode = "sustained",
	cooldown = 0,
	no_energy = true,
--	getMod = function(self, t) return "maximize", 1 end,
	info = [[Increases all numerical values of your next spell to the max.]],
	activate = function(self, t) return true end,
	deactivate = function(self, t) return true end, 
}