newTalentType{ 
	all_limited=true,
	type="transmutation",
	name="transmutation",
	description = "focuses on manipulating matter and bodies"
}

newArcaneSpell{
	name = "Expeditious Retreat",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_EXPEDITIOUS_RETREAT, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You double your speed temporarily.]])
	end,	
}


newArcaneSpell{
	name = "Alter Self",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 5 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 150 
		else return 100 end
	end,
	range = 0,
	requires_target = true,
	action = function(self, t)
		if not self then return nil end

		local effect = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the humanoid form",{
			{name="Human", desc="", effect=self.EFF_ALTER_SELF_HUMAN},
			{name="Drow", desc="", effect=self.EFF_ALTER_SELF_DROW},
			{name="Lizardfolk", desc="", effect=self.EFF_ALTER_SELF_LIZARDFOLK},
		}, function(result, item)
			self:talentDialogReturn(result and item.effect)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not effect then return nil end

		self:setEffect(effect, t.getDuration(self, t), {})
		return true
	end,
	info = function(self, t)
		return ([[You can change your shape to a humanoid. The Hit Dice of the assumed form cannot exceed your own Hit Dice, with a cap of 5.

			You gain the form's natural armor bonuses, natural attack forms, bonus skills and feats and movement modes (flying, swimming, burrowing etc.).
			You do NOT gain any of the form's special qualities or extraordinary attack forms or spell-like abilities.]])
	end,
}


--Arcane versions of buff spells
--Need to stay because specialization
newArcaneSpell{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE_ARCANE",
	type = {"transmutation", 1},
	display = { image = "talents/bear_endurance.png"},
	image = "talents/bear_endurance.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BEAR_ENDURANCE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Constitution by +4.]])
	end,	
}

newArcaneSpell{
	name = "Bull's Strength", short_name = "BULL_STRENGTH_ARCANE",
	type = {"transmutation", 1},
	display = { image = "talents/bull_strength.png"},
	image = "talents/bull_strength.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BULL_STRENGTH, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Strength by +4.]])
	end,	
}

newArcaneSpell{
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR_ARCANE",
	type = {"transmutation", 1},
	display = { image = "talents/eagle_splendor.png"},
	image = "talents/eagle_splendor.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_EAGLE_SPLENDOR, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Charisma by +4.]])
	end,	
}

newArcaneSpell{
	name = "Owl's Wisdom", short_name = "OWL_WISDOM_ARCANE",
	type = {"transmutation", 1},
	display = { image = "talents/owl_wisdom.png"},
	image = "talents/owl_wisdom.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_OWL_WISDOM, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Wisdom by +4.]])
	end,	
}

newArcaneSpell{
	name = "Cat's Grace",
	type = {"transmutation", 1},
	display = { image = "talents/cat_grace.png"},
	image = "talents/cat_grace.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
		if not self then return nil end
		self:setEffect(self.EFF_CAT_GRACE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Dexterity by +4.]])
	end,	
}

newArcaneSpell{
	name = "Fox's Cunning",
	type = {"transmutation", 1},
	display = { image = "talents/fox_cunning.png"},
	image = "talents/fox_cunning.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_FOX_CUNNING, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Intelligence by +4.]])
	end,	
}


newArcaneSpell{
	name = "Levitate",
	type = {"transmutation", 1},
	display = { image = "talents/levitate.png"},
	mode = "activated",
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 15 
		else return 10 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_LEVITATE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You start levitating.]])
	end,
}

newArcaneSpell{
	name = "Fly",
	type = {"transmutation", 1},
	display = { image = "talents/fly.png"},
	mode = "activated",
	level = 3,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 15 
		else return 10 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_FLY, t.getDuration(self,t), {})
		return true
	end,

	info = function(self, t)
		return ([[You can fly (at least for some time).]])
	end,
}

newArcaneSpell{
	name = "Haste",
	type = {"transmutation", 1},
	display = { image = "talents/haste.png"},
	image = "talents/haste.png",
	mode = 'activated',
	level = 3,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_HASTE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your AC, attack and reflex save by +1. Your speed is increased by 30 feet.]])
	end,	
}


newArcaneSpell{
	name = "Polymorph",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 4,
	points = 1,
	tactical = { BUFF = 5 },
	getDuration = function(self, t)  
		if self:isTalentActive(who.T_EXTEND) then return 150 
		else return 100 end
	end,
	range = 0,
	requires_target = true,
	action = function(self, t)
		if not self then return nil end

		local effect = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the new form", {
			{name="Cloaker", desc="", effect=self.EFF_POLYMORPH_SELF_CLOAKER},
		}, function(result, item)
			self:talentDialogReturn(result and item.effect)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not effect then return nil end

		self:setEffect(effect, t.getDuration(self, t), {})
		return true
	end,
	info = function(self, t)
		return ([[You can polymorph into an aberration, animal, dragon, fey, giant, humanoid, magical beast, monstrous humanoid, ooze, plant, or vermin. The Hit Dice of the assumed form cannot exceed your own Hit Dice, with a cap of 15.

			You gain the form's Strength, Dexterity and Constitution but keep your Intelligence, Wisdom and Charisma and you regain health as though you had rested.
			You gain the form's natural armor bonuses, natural or extraordinary attack forms, bonus skills and feats and movement modes (flying, swimming, burrowing etc.)
			You do not gain their extraordinary special qualities, nor any supernatural or spell-like abilities.]])
	end,
}

newArcaneSpell{
	name = "Transmute Stone to Mud",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 5,
	points = 1,
	tactical = { BUFF = 5 },
	range = 1,
	target = function(self, t)
		return {type="bolt", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)

		local tg = {type="bolt", range=1, nolock=true}
		local x, y = self:getTarget(tg)
		if not x or not y then return nil end

		self:project(tg, x, y, engine.DamageType.DIG, 1)

	return true
	end,
	info = function (self, t)
		return ([[Transmute stone to mud, effectively digging]])
	end,
}
