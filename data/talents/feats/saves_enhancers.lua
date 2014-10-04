newTalentType{ type="class/saves", name = "Saves enhancing", description = "save enhancers" }


newFeat{
    name = "Toughness",
    type = {"class/saves", 1},
    is_feat = true,
    points = 3,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your Fort save by +3 and HP by 10%.]],
    on_learn = function(self, t)
        self.fortitude_save = self.fortitude_save + 3
        self.max_life = self.max_life * 1.1
    end,
    on_unlearn = function(self, t)
        self.fortitude_save = self.fortitude_save - 3
        self.max_life = self.max_life * 0.9
    end
}

newFeat{
    name = "Dodge",
    type = {"class/saves", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your AC by +3 and your Ref save by +3.]],
    on_learn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) + 3
        self.reflex_save = self.reflex_save + 3
    end,
    on_unlearn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) - 3
        self.reflex_save = self.reflex_save - 3
    end
}

newFeat{
    name = "Iron Will",
    type = {"class/saves", 1},
    is_feat = true,
    points = 3,
    mode = "passive",
    is_feat = true,
    info = [[This feat increases your Will save by +3.]],
    on_learn = function(self, t)
        self.will_save = self.will_save + 3       
    end,
    on_unlearn = function(self, t)
        self.will_save = self.will_save - 3
    end
}