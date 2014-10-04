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


newFeat{
    name = "Simple Weapon Proficiency",
    type = {"class/proficiency", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in simple weapons.]],
}

newFeat{
    name = "Martial Weapon Proficiency",
    type = {"class/proficiency", 1},
    require = { talent = { Talents.T_SIMPLE_WEAPON_PROFICIENCY }, },
    points = 1,
    mode = "passive",
    is_feat = true,
    info = [[This feat makes you proficient in martial weapons.]],
}

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
}