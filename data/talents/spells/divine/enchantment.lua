newTalentType{
	all_limited=true,
	type="enchantment_divine",
	name="enchantment",
	description = "enchantment blahblah"
}

newDivineSpell{
	name = "Charm Animal",
	type = {"enchantment_divine", 1},
	display = { image = "talents/charm_animal.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 5,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)

		local save = self:getSpellDC(t)

		--if target.type ~= "animal" then return nil end

		if target.type == "animal" then
			if target:willSave(save) then game.log("Target resists charm spell!")
			else target:setEffect(target.EFF_CHARM, duration, {}) end
		end

		return true
	end,
	info = function(self, t)
		return ([[You charm a single animal.]])
	end,
}
