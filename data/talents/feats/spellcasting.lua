newTalentType{ type="class/spellcasting", name = "Spellcasting", description = "spellcasting stuffs" }

--More stuff from Incursion
newFeat{
    name = "Lore of Acid",
    type = {"class/spellcasting", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases the acid damage done by your spells by 20%.]],
    on_learn = function(self, t)
        self.inc_damage = { [engine.DamageType.ACID] = 20 }
    end,
    on_unlearn = function(self, t)
        self.inc_damage = nil
    end
}

newFeat{
    name = "Lore of Flames",
    type = {"class/spellcasting", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases the fire damage done by your spells by 20%.]],
    on_learn = function(self, t)
        self.inc_damage = { [engine.DamageType.FIRE] = 20 }
    end,
    on_unlearn = function(self, t)
        self.inc_damage = nil
    end
}

newFeat{
    name = "Lore of Rime",
    type = {"class/spellcasting", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases the cold damage done by your spells by 20%.]],
    on_learn = function(self, t)
        self.inc_damage = { [engine.DamageType.COLD] = 20 }
    end,
    on_unlearn = function(self, t)
        self.inc_damage = nil
    end
}

newFeat{
    name = "Lore of Storms",
    type = {"class/spellcasting", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases the lightning damage done by your spells by 20%.]],
    on_learn = function(self, t)
        self.inc_damage = { [engine.DamageType.LIGHTNING] = 20 }
    end,
    on_unlearn = function(self, t)
        self.inc_damage = nil
    end
}