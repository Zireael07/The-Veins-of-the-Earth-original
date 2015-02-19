newTalentType{ 
	all_limited=true,
	type="enchantment",
	name="enchantment",
	description = "enchantment blahblah"
}

newArcaneSpell{
	name = "Charm Person",
	type = {"enchantment", 1},
	display = { image = "talents/charm_person_png"},
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

		--if target.type ~= "humanoid" then return nil end

		if target.type == "humanoid" then
			if target:willSave(13) then game.log("Target resists charm spell!")
			else target:setEffect(target.EFF_CHARM, duration, {}) end
		end
		
		return true
	end,
	info = function(self, t)
		return ([[You charm a single humanoid.]])
	end,	
}

newArcaneSpell{
	name = "Sleep",
	type = {"enchantment",1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	getDuration = function(self, t)  
		if self:isTalentActive(self.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 0,
	radius = 4,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	get_max_hd = function(self, t)
		return 8
	end,
	action = function(self, t)
	local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		-- Find potential targets in the area

		local targets = {}
		local grids = self:project(tg, x, y, function(px, py)
			local actor = game.level.map(px, py, Map.ACTOR)
			if actor then targets[#targets+1] = actor end
		end)

		-- Take the creatures with the weakest hd and discard the rest

		table.sort(targets, function(a,b) return a.hit_die > b.hit_die end)
		local final_targets = {}
		local max_hd = t.get_max_hd(self, t)
		local i = 1
		local stop = false

		while not stop do
			local t = targets[i]
			if t and t.hit_die <= max_hd then --and target:canBe("sleep")
				final_targets[#final_targets+1] = t
				max_hd = max_hd - t.hit_die
				i = i + 1
			else
				stop = true
			end
		end

		local duration = t.getDuration(self, t)
		-- Apply sleep
		for i, target in ipairs(final_targets) do
			if not target:willSave(30) then -- @todo: do real dc  
				target:setEffect(target.EFF_SLEEP, duration, {})
			else
				game.logSeen(target, "%s resist the sleep!", target.name)
			end
		end
		return true
	end,


	info = function(self, t)
		return ([[You put weak creatures to sleep.]])
	end,

}
