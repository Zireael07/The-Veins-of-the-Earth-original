newTalentType{ type="arcane/metamagic", name = "meta magic", description = "Meta Magic" }

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