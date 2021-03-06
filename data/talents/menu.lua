newTalentType{ type="menu", name = "menu", description = "Menu" }

newTalent{
	name = "Attack",
	type = {"menu",1},
	mode = "activated",
	points = 1,
	cooldown = 0,
	range = 0,
    no_npc_use = true,
	no_energy = true,
    hide = true,
	action = function(self, t)
        local talent = self:talentDialog(require("mod.dialogs.TalentMenu").new(self, "special/special"))
		if not talent then return nil end

        if talent then
			self:useTalent(talent)
        end
        return true
	end,
	info = function(self, t )
		return "A menu of attacks. You can choose any attack feat you know."
	end,
}

newTalent{
	name = "Skills",
	type = {"menu",1},
	mode = "activated",
	points = 1,
	cooldown = 0,
	range = 0,
	no_energy = true,
    no_npc_use = true,
    hide = true,
	action = function(self, t)
        local talent = self:talentDialog(require("mod.dialogs.TalentMenu").new(self, "skill/skill"))
		if not talent then return nil end

        if talent then
			self:useTalent(talent)
        end
        return true
	end,
	info = function(self, t )
		return "A menu of skills. You can choose any skill you know."
	end,
}

newTalent{
	name = "Spells",
	type = {"menu",1},
	mode = "activated",
	points = 1,
	cooldown = 0,
	range = 0,
	no_energy = true,
    no_npc_use = true,
    hide = true,
	action = function(self, t)
        local talent = self:talentDialog(require("mod.dialogs.TalentMenu").new(self, "spells"))
		if not talent then return nil end

        if talent then
			self:useTalent(talent)
        end
        return true
	end,
	info = function(self, t )
		return "A menu of spells. You can choose any spell you know."
	end,
}
