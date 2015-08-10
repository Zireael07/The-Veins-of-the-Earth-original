newTalentType{
	all_limited=true,
	type="transmutation_divine",
	name="transmutation",
	description = "focuses on manipulating matter and bodies"
}

newDivineSpell{
	name = "Entangle",
	type = {"transmutation_divine", 1},
	display = { image = "entangle.png"},
	mode = 'activated',
	level = 1,
	points = 1,
--	tactical = { BUFF = 2 },
	range = 5,
	radius = 3,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	getSave = function(self, t)
		return self:getSpellDC(t)
	end,
	target = function(self, t)
		return {type="ball", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent = t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)
		local save = t.getSave(self, t)

		if target and target:reflexSave(save) then game.log("Target resists the spell!")
			target:setEffect(target.EFF_SLOW, duration, {})
		else target:setEffect(target.EFF_ENTANGLE, duration, {})
		end
	end,

	info = function(self, t)
		return ([[You make grass and weeds wrap around the target, ensnaring them. If they escape, they are still slowed]])
	end,
}

newDivineSpell{
	name = "Longstrider",
	type = {"transmutation_divine", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 960
		else return 600 end
	end,
	range = 0,
	action = function(self, t)
	if not self then return nil end
		self:setEffect(self.EFF_LONGSTRIDER, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You move quicker.]])
	end
}
