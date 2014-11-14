newTalentType{ type="class/proficiency", name = "Proficiency", description = "prof feats" }

newFeat{
    name = "Light Armor Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in light armors.]],
}

newFeat{
    name = "Medium Armor Proficiency",
    type = {"class/proficiency", 1},
    require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in medium armors.]],
}

newFeat{
    name = "Heavy Armor Proficiency",
    type = {"class/proficiency", 1},
    require = { talent = { Talents.T_MEDIUM_ARMOR_PROFICIENCY }, },
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in heavy armors.]],
}

newFeat{
    name = "Shield Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in shields.]],
}

--Not newFeats so that don't show up in feat choice
--Split because races
newTalent{
    name = "Longbow Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in longbows.]],
}

newTalent{
    name = "Shortbow Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in shortbows.]],
}

newTalent{
    name = "Long sword Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in long swords.]],
}

newTalent{
    name = "Rapier Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in rapiers.]],
}

newTalent{
    name = "Hand Crossbow Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in hand crossbows.]],
}

newTalent{
    name = "Shortsword Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in shortswords.]],
}

--[[newTalent{
    name = "Light Pick Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",]]
    --info = [[This feat makes you proficient in light picks.]],
--[[}

newTalent{
    name = "Heavy Pick Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",]]
--    info = [[This feat makes you proficient in heavy picks.]],
--}

--Weapon groups
newTalent{
    name = "Axe Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the axe group.]],
    on_learn = function(self, t)
    end
}

newTalent{
    name = "Heavy Blades Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the heavy blades group.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_LONG_SWORD_PROFICIENCY, true)
    end
}

newTalent{
    name = "Light Blades Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the light blades group.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_SHORTSWORD_PROFICIENCY, true)
        self:learnTalent(self.T_RAPIER_PROFICIENCY, true)
    end
}

newTalent{
    name = "Bows Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the bows group.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_LONGBOW_PROFICIENCY, true)
        self:learnTalent(self.T_SHORTBOW_PROFICIENCY, true)
    end
}

newTalent{
    name = "Crossbows Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the crossbows group.]],
--[[    on_learn = function(self, t)
--        self:learnTalent(self.T_HAND_CROSSBOW_PROFICIENCY, true)
    end]]
}

newTalent{
    name = "Flails Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the flails group.]],
--[[    on_learn = function(self, t)
    end]]
}

newTalent{
    name = "Hammers Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the hammers group.]],
--[[    on_learn = function(self, t)
    end]]
}

--TO DO: Monk weapons
--TO DO: Natural weapons

newTalent{
    name = "Polearms Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the polearms group.]],
--[[    on_learn = function(self, t)
    end]]
}

newTalent{
    name = "Spears Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the spears group.]],
--[[    on_learn = function(self, t)
    end]]
}

newTalent{
    name = "Thrown Group Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    info = [[This feat makes you proficient in all weapons from the thrown group.]],
--[[    on_learn = function(self, t)
    end]]
}

--Lump the above together
newFeat{
    name = "Simple Weapon Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in simple weapons.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_CROSSBOWS_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_HAMMERS_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_SPEARS_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_THROWN_GROUP_PROFICIENCY, true)
    end
}

newFeat{
    name = "Martial Weapon Proficiency",
    type = {"class/proficiency", 1},
    require = { talent = { Talents.T_SIMPLE_WEAPON_PROFICIENCY }, },
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in martial weapons.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_AXE_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_HEAVY_BLADES_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_LIGHT_BLADES_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_BOWS_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_FLAILS_GROUP_PROFICIENCY, true)
        self:learnTalent(self.T_POLEARMS_GROUP_PROFICIENCY, true)
    end
}

--Contains hand crossbows
newFeat{
    name = "Exotic Weapon Proficiency",
    type = {"class/proficiency", 1},
    require = {
        special = {
            fct = function(self, t, offset) 
            --Base attack bonus 1
            if self:attr("combat_bab") and self:attr("combat_bab") >= 1 then return true
            else return false end 
            end,
            desc = "Base attack bonus 1",
        }
    },
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat makes you proficient in exotic weapons.]],
    on_learn = function(self, t)
        self:learnTalent(self.T_HAND_CROSSBOW_PROFICIENCY)
    end
}