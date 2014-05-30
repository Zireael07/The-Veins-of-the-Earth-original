newTalentType{ 
	all_limited=true,
	type="transmutation",
	name="transmutation",
	description = "focuses on manipulatting matter and bodies"
}

newArcaneSpell{
	name = "Alter Self",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 5 },
	range = 0,
	requires_target = true,
	action = function(self)
		if not self then return nil end

		game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the humanoid form",{
                {name="Human", desc=""},
                {name="Drow", desc=""},
                {name="Lizardfolk", desc=""},
                },
                function(result)
                if result == "Human" then
                	self.setEffect(self.EFF_ALTER_SELF_HUMAN, 100, {})
                elseif result == "Drow" then
                	self:setEffect(self.EFF_ALTER_SELF_DROW, 100, {})
                elseif result == "Lizardfolk" then
                	self:setEffect(self.EFF_ALTER_SELF_LIZARDFOLK, 100, {})
                end

                end))


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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BULL_STRENGTH, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_EAGLE_SPLENDOR, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_OWL_WISDOM, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_CAT_GRACE, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_FOX_CUNNING, 5, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_LEVITATE, 10, {})
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
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_FLY, 10, {})
		return true
	end,

	info = function(self, t)
		return ([[You can fly (at least for some time).]])
	end,
}

newArcaneSpell{
	name = "Polymorph",
	type = {"transmutation", 1},
	mode = 'activated',
	level = 4,
	points = 1,
	tactical = { BUFF = 5 },
	range = 0,
	requires_target = true,
	action = function(self)
		if not self then return nil end

		game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the new form",{
                {name="Cloaker", desc=""},
                },
                function(result)
                if result == "Cloaker" then
                	self.setEffect(self.EFF_POLYMORPH_SELF_CLOAKER, 100, {})
    --[[            elseif result == "Drow" then
                	self:setEffect(self.EFF_ALTER_SELF_DROW, 100, {})]]
                end

                end))

		return true
	end,
	info = function(self, t)
		return ([[You can polymorph into an aberration, animal, dragon, fey, giant, humanoid, magical beast, monstrous humanoid, ooze, plant, or vermin. The Hit Dice of the assumed form cannot exceed your own Hit Dice, with a cap of 15.

			You gain the form's Strength, Dexterity and Constitution but keep your Intelligence, Wisdom and Charisma and you regain health as though you had rested.
			You gain the form's natural armor bonuses, natural or extraordinary attack forms, bonus skills and feats and movement modes (flying, swimming, burrowing etc.)
			You do not gain their extraordinary special qualities, nor any supernatural or spell-like abilities.]])
	end,
}
