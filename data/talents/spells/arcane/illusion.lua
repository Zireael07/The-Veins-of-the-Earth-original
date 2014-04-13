newTalentType{ 
	all_limited=true,
	spell_list="arcane",
	type="illusion",
	name="illusion",
	description = "illusion magic focuses on distrupting your enemies' senses"
}


newTalent{
	name = "Sleep",
	type = {"illusion",1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
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

		local duration = 5
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

newTalent{
	name = "Invisibility",
	type = {"enchantment", 1},
	display = { image = "invisibility.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_INVISIBLE, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You turn invisible.]])
	end,	
}

newTalent{
	name = "Blindness/Deafness", short_name = "BLINDNESS_DEAFNESS",
	type = {"illusion",1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	get_effect = function(self, t)
		local d = require("mod.dialogs.BlindnessDeafness").new(t)

		game:registerDialog(d)
		
		local co = coroutine.running()
		d.unload = function() coroutine.resume(co, t.choice) end --This is currently bugged, only works if the player has already summoned,
		if not coroutine.yield() then return nil end
		return t.choice
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local choice = t.get_effect(self, t)

		if choice == "Blindness" then
			if target:canBe("blind") then
				target:setEffect(target.EFF_BLIND, 5, {})
			end
		elseif choice == "Deafness" then
			if target:canBe("deaf") then

			end
		else
			return nil
		end

		return true
	end,


	info = function(self, t)
		return ([[You blind the target for 5 turns]])
	end,

}