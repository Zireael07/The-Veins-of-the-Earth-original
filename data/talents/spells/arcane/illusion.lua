newTalentType{ 
	all_limited=true,
	spell_list="arcane",
	type="illusion",
	name="illusion",
	description = "illusion magic focuses on disrupting your enemies' senses"
}


newTalent{
	name = "Invisibility",
	type = {"illusion", 1},
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