newTalentType{ type="monster/passive", name = "monster", description = "Monster passive" }

--Immunities
newTalent{
    name = "Acid Immunity",
    type = {"monster/passive",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to acid.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Cold Immunity",
    type = {"monster/passive",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to cold.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Fire Immunity",
    type = {"monster/passive",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to fire.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Electric Immunity",
    type = {"monster/passive",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to electricity.]],
	on_learn = function(self, t)
    end
}

newTalent{
    name = "Crit Immunity",
    type = {"monster/passive",1},
    mode = "passive",
    points = 1,
    info = [[Makes you immune to criticals.]],
}
