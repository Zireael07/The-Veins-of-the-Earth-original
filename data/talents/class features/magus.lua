newTalentType{ passive=true, type="magus", name="magus", description="Magus Feats" }

newTalent{
	name = "Spell combat",
	type = {"magus", 1},
	mode = 'sustained',
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
    activate = function(self, t) return true end,
	deactivate = function(self, t) return true end,
	info = function(self, t)
		return ([[You can attack and cast spells at the same time, attacking at -2 penalty.]])
	end,
}
