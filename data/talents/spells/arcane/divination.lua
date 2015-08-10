newTalentType{
	all_limited=true,
	type="divination",
	name="divination",
	description = "divination blahblah"
}

newArcaneSpell{
	name = "Identify",
	type = {"divination", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = false,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")
		local d d = self:showInventory("Identify which item?", inven, function(o) return not o.identified end, function(o, item)
			if o.identified == false then o.identified = true end
		end)
		return true
	end,
	info = function(self, t)
		return ([[Identifies a single item in your inventory]])
	end,
}

newArcaneSpell{
	name = "Detect Objects",
	type = {"divination", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 0,
	requires_target = false,
	no_npc_use = true,
	action = function(self, t)
		self:setEffect(self.EFF_SENSE, t.getDuration(self, t), {
			range = 10,
			object = 1,
		})
		return true
	end,
	info = function(self, t)
		return ([[Reveals objects in a certain range.]])
	end,
}

newArcaneSpell{
	name = "Detect Monsters",
	type = {"divination", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 0,
	requires_target = false,
	no_npc_use = true,
	action = function(self, t)
		self:setEffect(self.EFF_SENSE, t.getDuration(self, t), {
			range = 10,
			actor = 1,
		})
		return true
	end,
	info = function(self, t)
		return ([[Reveals monsters in a certain range.]])
	end,
}

--Metamagic doesn't apply
newArcaneSpell{
	name = "True Strike",
	type = {"divination", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self, t)
		self:setEffect(self.EFF_TRUE_STRIKE, 1, {})
		return true
	end,
	info = function(self, t)
		return ([[Gain a large bonus to the next attack.]])
	end,
}

newArcaneSpell{
	name = "Know Alignment",
	type = {"divination", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 0,
	requires_target = false,
	no_npc_use = true,
	action = function(self, t)
		self:setEffect(self.EFF_KNOW_ALIGNMENT, t.getDuration(self, t), {})
		return true
	end,
	info = function(self, t)
		return ([[Reveals the monsters' alignment to the caster.]])
	end,
}


newArcaneSpell{
	name = "Magic Mapping",
	type = {"divination", 1},
	mode = 'activated',
	level = 3,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = false,
	no_npc_use = true,
	action = function(self, t)
		self:magicMap(6)
	end,
	info = function(self, t)
		return ([[Reveals some of your surroundings.]])
	end,
}

--Seb's original identify, renamed and shuffled to a higher level
newArcaneSpell{
	name = "Improved Identify",
	type = {"divination", 1},
	mode = 'activated',
	level = 6,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = false,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")
		for k, o in ipairs(inven) do
			if  o.identified == false then
				o.identified = true
			end
		end
		return true
	end,
	info = function(self, t)
		return ([[Identifies items in your inventory]])
	end,
}
