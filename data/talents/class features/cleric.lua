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
	name = "Turn Undead", image = "talents/turn_undead.png",
	type = {"cleric/cleric", 1},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	radius = 1,
	target = function(self, t)
		return {type="ball", range=self:getTalentRange(t), radius=self:getTalentRadius(t)}
	end,
	get_max_hd = function(self, t)
		local d = rng.dice(1,20) + self:getStat("cha")
		local max_hd = 0
		if not self or not self.level then return end

		if d <= 0 then max_hd = self.level - 4
		elseif d <= 3 then max_hd = self.level - 3
		elseif d <= 6 then max_hd = self.level - 2
		elseif d <= 9 then max_hd = self.level - 1
		elseif d <= 12 then max_hd = self.level
		elseif d <= 15 then max_hd = self.level + 1
		elseif d <= 18 then max_hd = self.level + 2
		elseif d <= 22 then max_hd = self.level + 3
		else max_hd = self.level + 4 end

		return max_hd
--		return 8
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		-- Find potential targets in the area

		local targets = {}
		local grids = self:project(tg, x, y, function(px, py)
			local actor = game.level.map(px, py, Map.ACTOR)
			if actor and actor.keywords and actor.keywords.undead then targets[#targets+1] = actor end
		end)

		-- Take the creatures with the weakest hd and discard the rest
		table.sort(targets, function(a,b) return a.hit_die > b.hit_die end)
		local final_targets = {}
		local max_hd = t.get_max_hd(self, t)
		local i = 1
		local stop = false

		while not stop do
			local t = targets[i]
			if t and t.hit_die <= max_hd then 
				final_targets[#final_targets+1] = t
				i = i + 1
			else
				stop = true
			end
		end

		local duration = 5
		-- Apply fear
		for i, target in ipairs(final_targets) do	target:setEffect(target.EFF_FEAR, duration, {})
		end
		return true
	end,

	info = function(self, t)
		return ([[You damage any undead in radius or cause them to flee.]])
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