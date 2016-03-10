newTalentType{ type="class/saves", name = "Saves enhancing", description = "save enhancers" }


newFeat{
    name = "Great Fortitude",
    type = {"class/saves", 1},
    is_feat = true,
    points = 3,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your Fort save by +3 plus +1 per every 2 levels.]],
    on_learn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.fortitude_save = self.fortitude_save + 3 + bonus
    end,
    on_unlearn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.fortitude_save = self.fortitude_save - 3 - bonus
    end
}

newFeat{
    name = "Lightning Reflexes",
    type = {"class/saves", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your Ref save by +3 plus +1 per every 2 levels.]],
    on_learn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.reflex_save = self.reflex_save + 3 + bonus
    end,
    on_unlearn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.reflex_save = self.reflex_save - 3 - bonus
    end
}

newFeat{
    name = "Iron Will",
    type = {"class/saves", 1},
    is_feat = true,
    points = 3,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your Will save by +3 + 1 per every 2 levels.]],
    on_learn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.will_save = self.will_save + 3 + bonus
    end,
    on_unlearn = function(self, t)
        local bonus = math.round_simple(self.level/2)
        self.will_save = self.will_save - 3 - bonus
    end
}
