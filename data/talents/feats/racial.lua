newTalentType{ type="racial/general", no_tt_req = true, name = "Racial feats", description = "Racial feats" }

newFeat{
    name = "Drow Nobility",
    type = {"class/general", 1},
    require = {
        --Drow race
    --    stat = { wis = 13 }
    },
    is_feat = true,
    points = 1,
    mode = "passive",
    on_learn = function(self, t)
        self:learnTalent(self.T_LEVITATE_INNATE, true)
        --Feather fall, detect magic
    end
    info = [[Being of noble drow blood, you have superior innate powers.]],
}

newFeat{
    name = "Improved Drow Nobility",
    type = {"class/general", 1},
    require = {
        --Drow race
        stat = { cha = 13 }
    },
    is_feat = true,
    points = 1,
    mode = "passive",
    on_learn = function(self, t)
        --unlearn darkness, learn deeper darkness instead
    end
    info = [[Being of noble drow blood, you have superior innate powers.]],
}

newFeat{
    name = "Greater Drow Nobility",
    type = {"class/general", 1},
    require = {
        --Drow race
        stat = { cha = 13 }
    },
    is_feat = true,
    points = 1,
    mode = "passive",
    on_learn = function(self, t)
        --unlearn innate detect magic, apply it constantly
    end
    info = [[Being of noble drow blood, you have superior innate powers.]],
}
