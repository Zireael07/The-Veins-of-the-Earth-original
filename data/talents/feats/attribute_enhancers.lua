newTalentType{ type="class/attribute", name = "Attribute enhancing", description = "attr improv feats" }

--Taken from Incursion
newFeat{
    name = "Improved Strength",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Strength by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_STR] = (self.inc_stats[self.STAT_STR] or 0) + 1
        self:onStatChange(self.STAT_STR, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_STR] = (self.inc_stats[self.STAT_STR] or 0) - 1
        self:onStatChange(self.STAT_STR, -1)
    end
}

newFeat{
    name = "Improved Dexterity",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Dexterity by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_DEX] or 0) + 1
        self:onStatChange(self.STAT_DEX, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_DEX] or 0) - 1
        self:onStatChange(self.STAT_DEX, -1)
    end
}

newFeat{
    name = "Improved Constitution",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Constitution by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_CON] = (self.inc_stats[self.STAT_CON] or 0) + 1
        self:onStatChange(self.STAT_CON, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_CON] or 0) - 1
        self:onStatChange(self.STAT_CON, -1)
    end
}

newFeat{
    name = "Improved Intelligence",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Intelligence by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_INT] = (self.inc_stats[self.STAT_INT] or 0) + 1
        self:onStatChange(self.STAT_INT, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_INT] = (self.inc_stats[self.STAT_INT] or 0) - 1
        self:onStatChange(self.STAT_INT, -1)
    end
}

newFeat{
    name = "Improved Wisdom",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Wisdom by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_WIS] = (self.inc_stats[self.STAT_WIS] or 0) + 1
        self:onStatChange(self.STAT_WIS, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_WIS] = (self.inc_stats[self.STAT_WIS] or 0) - 1
        self:onStatChange(self.STAT_WIS, -1)
    end
}

newFeat{
    name = "Improved Charisma",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Charisma by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_CHA] = (self.inc_stats[self.STAT_CHA] or 0) + 1
        self:onStatChange(self.STAT_CHA, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_CHA] = (self.inc_stats[self.STAT_CHA] or 0) - 1
        self:onStatChange(self.STAT_CHA, -1)
    end
}

newFeat{
    name = "Improved Luck",
    type = {"class/attribute", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Luck by +1.]],
    on_learn = function(self, t)
        self.inc_stats[self.STAT_LUC] = (self.inc_stats[self.STAT_LUC] or 0) + 1
        self:onStatChange(self.STAT_LUC, 1)
    end,
    on_unlearn = function(self, t)
        self.inc_stats[self.STAT_LUC] = (self.inc_stats[self.STAT_LUC] or 0) - 1
        self:onStatChange(self.STAT_LUC, -1)
    end
}