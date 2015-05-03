newTalentType{ type="monster/passive", name = "monster", description = "Monster passive" }

--Immunities
newTalent{
    name = "Acid Immunity",
    type = {"special/special",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to acid.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Cold Immunity",
    type = {"special/special",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to cold.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Fire Immunity",
    type = {"special/special",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to fire.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Electric Immunity",
    type = {"special/special",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to electricity.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Crit Immunity",
    type = {"special/special",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to criticals.]],
}
