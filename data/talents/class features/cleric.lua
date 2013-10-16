newTalentType{ passive=true, type="cleric/cleric", name="cleric", description="Cleric Feats" }

newTalent{
	name = "Lay on Hands", image = "talents/lay_on_hands.png",
	type = {"cleric/cleric", 1},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	d = rng.dice(1,8)
	self:heal(d)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is 1d8.]])
	end,	
}


newTalent{
	name = "Spontanous Conversion",
	type = {"cleric/cleric", 1},
	mode = 'sustained',
	require = { level = 2 },
	points = 1,
	is_feat = true,

	info = [[You can convert your spells into cure spells.]],
}