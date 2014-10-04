newTalentType{ type="class/skill", name = "Skill enhancing", description = "skill improv feats" }

newFeat{
    name = "Acrobatic",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Jump and Tumble skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_jump = (self.skill_bonus_jump or 0) + 2
        self.skill_bonus_tumble = (self.skill_bonus_tumble or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_jump = self.skill_bonus_jump - 2
        self.skill_bonus_tumble = self.skill_bonus_tumble - 2
    end
}

newFeat{
    name = "Agile",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Balance and Escape Artist skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_balance  = (self.skill_bonus_balance or 0) + 2
        self.skill_bonus_escapeartist = (self.skill_bonus_escapeartist or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_balance  = (self.skill_bonus_balance or 0) - 2
        self.skill_bonus_escapeartist = (self.skill_bonus_escapeartist or 0) - 2
    end
}

newFeat{
    name = "Alertness",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Listen and Spot skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_listen = (self.skill_bonus_listen or 0) + 2
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_listen = (self.skill_bonus_listen or 0) - 2
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) - 2
    end
}

newFeat{
    name = "Animal Affinity",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Handle Animal and Ride skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_handleanimal = (self.skill_bonus_handleanimal or 0) + 2
        self.skill_bonus_ride = (self.skill_bonus_ride or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_handleanimal = (self.skill_bonus_handleanimal or 0) - 2
        self.skill_bonus_ride = (self.skill_bonus_ride or 0) - 2
    end
}

newFeat{
    name = "Artist",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Diplomacy skill by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) + 2
--        self.skill_bonus_perform = (self.skill_bonus_perform or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) - 2
--        self.skill_bonus_perform = (self.skill_bonus_perform or 0) - 2
    end
}


newFeat{
    name = "Athletic",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Climb and Swim skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_climb  = (self.skill_bonus_climb or 0) + 2
        self.skill_bonus_swim = (self.skill_bonus_swim or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_climb  = (self.skill_bonus_climb or 0) - 2
        self.skill_bonus_swim = (self.skill_bonus_swim or 0) - 2
    end
}

newFeat{
    name = "Combat Casting",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Concentration skill by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_concentration = (self.skill_bonus_concentration or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_concentration = (self.skill_bonus_concentration or 0) - 2
    end
}

newFeat{
    name = "Deft Hands",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Pickpocket skill by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_pickpocket = (self.skill_bonus_pickpocket or 0) + 2
--        self.skill_bonus_userope = (self.skill_bonus_userope or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_pickpocket = (self.skill_bonus_pickpocket or 0) - 2
--        self.skill_bonus_userope = (self.skill_bonus_userope or 0) + 2
    end
}

newFeat{
    name = "Investigator",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Search skill by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_search = (self.skill_bonus_search or 0) + 2
--        self.skill_bonus_gatherinfo = (self.skill_bonus_gatherinfo or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_search = (self.skill_bonus_search or 0) - 2
--        self.skill_bonus_gatherinfo = (self.skill_bonus_gatherinfo or 0) - 2
    end
}

newFeat{
    name = "Magical Aptitude",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Spellcraft and Use Magic Device skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) + 2
        self.skill_bonus_usemagic = (self.skill_bonus_usemagic or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) - 2
        self.skill_bonus_usemagic = (self.skill_bonus_usemagic or 0) - 2
    end
}

newFeat{
    name = "Magical Talent",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Spellcraft and Knowledge skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) + 2
        self.skill_bonus_knowledge = (self.skill_bonus_knowledge or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) - 2
        self.skill_bonus_knowledge = (self.skill_bonus_knowledge or 0) - 2
    end
}

newFeat{
    name = "Negotiator",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Diplomacy and Sense Motive skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) + 2
        self.skill_bonus_sensemotive = (self.skill_bonus_sensemotive or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) - 2
        self.skill_bonus_sensemotive = (self.skill_bonus_sensemotive or 0) - 2
    end
}

newFeat{
    name = "Nimble Fingers",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Disable Device and Open Lock skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_disabledevice = (self.skill_bonus_disabledevice or 0) + 2
        self.skill_bonus_openlock = (self.skill_bonus_openlock or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_disabledevice = (self.skill_bonus_disabledevice or 0) - 2
        self.skill_bonus_openlock = (self.skill_bonus_openlock or 0) - 2
    end
}

newFeat{
    name = "Persuasive",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Bluff and Intimidate skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) + 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) - 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) - 2
    end
}

newFeat{
    name = "Self-sufficient",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Heal and Survival skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_heal = (self.skill_bonus_heal or 0) + 2
        self.skill_bonus_survival = (self.skill_bonus_survival or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_heal = (self.skill_bonus_heal or 0) - 2
        self.skill_bonus_survival = (self.skill_bonus_survival or 0) - 2
    end
}

newFeat{
    name = "Silver Palm",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Bluff skill by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) + 2
--        self.skill_bonus_appraise = (self.skill_bonus_appraise or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) - 2
--        self.skill_bonus_appraise = (self.skill_bonus_appraise or 0) - 2
    end
}

newFeat{
    name = "Stealthy",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Hide and Move Silently skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_hide = (self.skill_bonus_hide or 0) + 2
        self.skill_bonus_movesilently = (self.skill_bonus_movesilently or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_hide = (self.skill_bonus_hide or 0) - 2
        self.skill_bonus_movesilently = (self.skill_bonus_movesilently or 0) - 2
    end
}

newFeat{
    name = "Thug",
    type = {"class/skill", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your Spot and Intimidate skills by +2.]],
    on_learn = function(self, t)
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) + 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) - 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) - 2
    end
}