newTalentType{ type="class/twf", name = "Two Weapon Fighting", description = "twf feat line" }

newFeat{
    name = "Two Weapon Fighting",
    type = {"class/twf", 1},
    require = {
        stat = {dex = 15}
    },
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat makes you proficient in fighting with two weapons, reducing the penalties.]],
}

newFeat{
    name = "Two Weapon Defense",
    type = {"class/twf", 1},
    require = {
        stat = {dex = 15},
        talent = { Talents.T_TWO_WEAPON_FIGHTING },
    },
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat gives you a +1 shield bonus to AC when fighting with two weapons.]],
}

newFeat{
    name = "Improved Two Weapon Fighting",
    type = {"class/twf", 1},
    require = {
        stat = {dex = 17},
        talent = { Talents.T_TWO_WEAPON_FIGHTING },
        special = {
            fct = function(self, t, offset) 
            --Base attack bonus 6
            if self:attr("combat_bab") and self:attr("combat_bab") >= 6 then return true
            else return false end
            end,
            desc = "Base attack bonus 6",        
        }
    },
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat gives you an additional offhand attack when fighting with two weapons.]],
}

newFeat{
    name = "Greater Two Weapon Fighting",
    type = {"class/twf", 1},
    require = {
        stat = {dex = 19},
        talent = { Talents.T_TWO_WEAPON_FIGHTING, Talents.T_IMPROVED_TWO_WEAPON_FIGHTING },
        special = {
            fct = function(self, t, offset) 
            --Base attack bonus 11
            if self:attr("combat_bab") and self:attr("combat_bab") >= 11 then return true
            else return false end
            end,
            desc = "Base attack bonus 11",       
        }
    },
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat gives you a third offhand attack when fighting with two weapons.]],
}

