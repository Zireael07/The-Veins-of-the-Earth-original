newTalentType{ type="class/combat", name = "Combat", description = "combat passive feats" }

newFeat{
    name = "Finesse",
    type = {"class/combat", 1},
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
    is_perk = true,
    fighter = true,
    points = 1,
    mode = "passive",
    info = [[With a light weapon, rapier, whip, or spiked chain made for a creature of your size category, you may use your Dexterity modifier instead of your Strength modifier on attack rolls. If you carry a shield, its armor check penalty applies to your attack rolls.]],
}

newFeat{
    name = "Monkey Grip",
    type = {"class/combat", 1},
    points = 1,
    mode = "passive",
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
    fighter = true,
    info = [[This feat allows you to wield a two-handed weapon in one hand, albeit at a -2 penalty.]],
}

--Taken from Incursion
newFeat{
    name = "Shield Focus",
    type = {"class/combat", 1},
    require = {
        talent = { Talents.T_SHIELD_PROFICIENCY },
    },
    points = 1,
    mode = "passive",
    fighter = true,
    info = [[When wielding a shield, you gain a +2 bonus to AC in addition to the shield's bonus.]],
}

newFeat{
    name = "Armor Optimisation",
    type = {"class/combat", 1},
    require = {
        talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY },
    },
    points = 1,
    mode = "passive",
    fighter = true,
    info = [[Your armor check penalty is reduced by 1/3.]],
}
