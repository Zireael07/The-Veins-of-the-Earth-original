newTalentType{ type="skill/skill", name = "skill", description = "Skills" }



newTalent{
	name = "Intuition", image = "talents/intuition.png",
	type = {"skill/skill",1},
	mode = "activated",
	points = 1,
	cooldown = 20,
	range = 0,
	action = function(self, t)
	local list = {}
	local inven = game.player:getInven("INVEN")
		i = rng.range(1, #inven)
		local o = inven[i]
			if o.identified == false then
				local check = self:skillCheck("intuition", 10)
				if check then
					o.identified = true
				end	
			else 
				game.log("You pick an item which has already been identified") end
			 return true
	end,
	info = function(self, t )
		return "Attempt to identify items in your inventory"
	end,
}
