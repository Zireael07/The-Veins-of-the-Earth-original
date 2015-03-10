newTalentType{ passive = true, type="bard/bard", name="bard", description="Bard Feats" }

newTalent{
	name = "Bardic Music",
	type = {"bard/bard", 1},
	mode = 'activated',
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
		if not self then return nil end
		local effect = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the bard song effect",{
        --    {name="Fascinate", desc="", effect=self.EFF_FASCINATE}, it affects enemies
            {name="Inspire courage 1", desc="", effect=self.EFF_INSPIRE_COURAGE_I},
        }, function(result, item)
            self:talentDialogReturn(result and item.effect)
            game:unregisterDialog(self:talentDialogGet())
        end))

        if not effect then return nil end

        self:setEffect(effect, 20, {})

		return true
	end,

	info = function(self, t)
		return ([[You start singing, giving you and any allies various bonuses.]])
	end,
}

newTalent{
	name = "Bardic Knowledge",
	type = {"bard/bard", 1},
	mode = 'passive',
	points = 1,
	on_learn = function(self, t)
		local bonus = self.classes["Bard"]/2
        self.skill_bonus_knowledge = self.skill_bonus_knowledge or 0 + bonus
    end,
	on_unlearn = function(self, t)
		local bonus = self.classes["Bard"]/2
	    self.skill_bonus_knowledge = self.skill_bonus_knowledge or 0 - bonus
	end,
	info = function(self, t)
		return ([[You add half your level to your knowledge checks.]])
	end,
}
