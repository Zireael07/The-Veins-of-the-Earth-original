newTalentType{	all_limited=true, type="abjuration_both", name="abjuration",
description = "abjuration blahblah"
}

--Protection Spells
newArcaneDivineSpell{
	name = "Protection from Alignment",
	type = {"abjuration_both", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 1,
	requires_target = true,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		-- Choose effect
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired alignment to ward from",{
			{name="evil", desc=""},
			{name="good", desc=""},
			{name="chaos", desc=""},
			{name="law", desc=""},
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

			if not result then return nil end

		--[[	if result then
				local effect = "EFF_PROTECT_"..result:upper()
				target:setEffect(self.effect, t.getDuration(self, t), {})
				end]]

			if result == "evil" then target:setEffect(self.EFF_PROTECT_EVIL, t.getDuration(self, t), {}) end
			if result == "good" then target:setEffect(self.EFF_PROTECT_GOOD, t.getDuration(self, t), {}) end
			if result == "chaos" then target:setEffect(self.EFF_PROTECT_CHAOS, t.getDuration(self, t), {}) end
			if result == "law" then target:setEffect(self.EFF_PROTECT_LAW, t.getDuration(self, t), {}) end

		return true
	end,
	info = function(self, t)
		return ([[You create a magical ward which repels a certain alignment.]])
	end,
}

--based on Inc: +1 DR per 2 caster levels max 5
newArcaneDivineSpell{
	name = "Endure Elements",
	type = {"abjuration_both", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 1,
	requires_target = true,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 150
		else return 100 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		-- Choose effect
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired energy type to ward from",{
			{name="acid", desc=""},
			{name="cold", desc=""},
			{name="fire", desc=""},
			{name="electricity", desc=""},
			{name="sonic", desc=""}
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

			if not result then return nil end

		--[[	if result then
				local effect = "EFF_PROTECT_"..result:upper()
				target:setEffect(self.effect, t.getDuration(self, t), {power=10})
				end]]

			if result == "acid" then target:setEffect(self.EFF_PROTECT_ACID, t.getDuration(self, t), {power=3}) end
			if result == "cold" then target:setEffect(self.EFF_PROTECT_COLD, t.getDuration(self, t), {power=3}) end
			if result == "fire" then target:setEffect(self.EFF_PROTECT_FIRE, t.getDuration(self, t), {power=3}) end
			if result == "electricity" then target:setEffect(self.EFF_PROTECT_ELECTRIC, t.getDuration(self, t), {power=3}) end
			if result == "sonic" then target:setEffect(self.EFF_PROTECT_SONIC, t.getDuration(self, t), {power=3}) end

		return true
	end,
	info = function(self, t)
		return ([[You create a minor magical ward which protects from a certain element.]])
	end,
}


newArcaneDivineSpell{
	name = "Resist Energy",
	type = {"abjuration_both", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 1,
	requires_target = true,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 150
		else return 100 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		-- Choose effect
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired energy type to ward from",{
			{name="acid", desc=""},
			{name="cold", desc=""},
			{name="fire", desc=""},
			{name="electricity", desc=""},
			{name="sonic", desc=""}
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

			if not result then return nil end

		--[[	if result then
				local effect = "EFF_PROTECT_"..result:upper()
				target:setEffect(self.effect, t.getDuration(self, t), {power=10})
				end]]

			if result == "acid" then target:setEffect(self.EFF_PROTECT_ACID, t.getDuration(self, t), {power=10}) end
			if result == "cold" then target:setEffect(self.EFF_PROTECT_COLD, t.getDuration(self, t), {power=10}) end
			if result == "fire" then target:setEffect(self.EFF_PROTECT_FIRE, t.getDuration(self, t), {power=10}) end
			if result == "electricity" then target:setEffect(self.EFF_PROTECT_ELECTRIC, t.getDuration(self, t), {power=10}) end
			if result == "sonic" then target:setEffect(self.EFF_PROTECT_SONIC, t.getDuration(self, t), {power=10}) end

		return true
	end,
	info = function(self, t)
		return ([[You create a magical ward which protects from a certain element.]])
	end,
}

newArcaneDivineSpell{
	name = "Protection From Energy",
	type = {"abjuration_both", 1},
	mode = 'activated',
	level = 3,
	points = 1,
	tactical = { BUFF = 2 },
	range = 1,
	requires_target = true,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 150
		else return 100 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		-- Choose effect
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired energy type to ward from",{
			{name="acid", desc=""},
			{name="cold", desc=""},
			{name="fire", desc=""},
			{name="electricity", desc=""},
			{name="sonic", desc=""}
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

			if not result then return nil end

		--[[	if result then
				local effect = "EFF_PROTECT_"..result:upper()
				target:setEffect(self.effect, t.getDuration(self, t), {power=10})
				end]]

			if result == "acid" then target:setEffect(self.EFF_PROTECT_ACID, t.getDuration(self, t), {power=15}) end
			if result == "cold" then target:setEffect(self.EFF_PROTECT_COLD, t.getDuration(self, t), {power=15}) end
			if result == "fire" then target:setEffect(self.EFF_PROTECT_FIRE, t.getDuration(self, t), {power=15}) end
			if result == "electricity" then target:setEffect(self.EFF_PROTECT_ELECTRIC, t.getDuration(self, t), {power=15}) end
			if result == "sonic" then target:setEffect(self.EFF_PROTECT_SONIC, t.getDuration(self, t), {power=15}) end

		return true
	end,
	info = function(self, t)
		return ([[You create a magical ward which protects from a certain element.]])
	end,
}

newArcaneDivineSpell{
	name = "Stoneskin",
	type = {"abjuration_both", 1},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 1,
	requires_target = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
	--	if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end

		target:setEffect(self.EFF_STONESKIN, t.getDuration(self, t), {})

		return true
	end,
	info = function(self, t)
		return ([[The target's skin becomes hard as stone, providing DR 10/adamantine.]])
	end,
}
