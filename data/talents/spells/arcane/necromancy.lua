newTalentType{ 
	all_limited=true,
	spell_list = "arcane", 
	type="necromancy", 
	name="necromancy", 
	description = "necromancy magic deals with the creation magical creatures and substances"
}


newTalent{
	name = "Ghoul Touch",
	type = {"necromancy",1},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = 4 --1d6+2

		if target:fortitudeSave(15) then game.log("Target resists the spell!")
		else 
			if target:canBe("paralysis") then target:setEffect(target.EFF_GHOUL_TOUCH, duration, {}) end
		end

		return true
	end,
	info = "The target you touch is afflicted with a terrible ailment.", 
}