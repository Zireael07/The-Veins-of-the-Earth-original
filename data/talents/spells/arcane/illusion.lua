newTalentType{
	all_limited=true,
	type="illusion",
	name="illusion",
	description = "illusion magic focuses on disrupting your enemies' senses"
}


newArcaneSpell{
	name = "Invisibility",
	type = {"illusion", 1},
	display = { image = "invisibility.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 0,
	action = function(self, t)
	if not self then return nil end
		self:setEffect(self.EFF_INVISIBLE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You turn invisible.]])
	end,
}

newArcaneSpell{
	name = "Blindness/Deafness", short_name = "BLINDNESS_DEAFNESS",
	type = {"illusion",1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 4,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	getSave = function(self, t)
		return self:getSpellDC(t)
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		-- Choose effect
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired effect",{
			{name="blindness", desc=""},
			{name="deafness", desc=""},
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not result then return nil end

		local save = t.getSave(self, t)

		if result == "blindness" then
			if target:canBe("blind") then
				if not target:fortitudeSave(save) then
					target:setEffect(target.EFF_BLIND, t.getDuration(self, t), {})
				end
			end
		elseif result == "deafness" then
			if target:canBe("deaf") then
				if not target:fortitudeSave(save) then
				--target:setEffect(target.EFF_DEAF, t.getDuration(self, t), {})
				end
			end
		else
			return nil
		end

		return true
	end,


	info = function(self, t)
		return ([[You blind the target for 5 turns.]])
	end,

}
