newTalentType{ type="skill/skill", name = "skill", description = "Skills" }



newTalent{
	name = "Intuition",
	type = {"skill/skill",1},
	mode = "activated",
	points = 1,
	cooldown = 0,
	range = 0,
	action = function(self, t)
	
--local function auto_id(npc, player)
	local list = {}
	for inven_id, inven in pairs(self.inven) do
		for item, o in ipairs(inven) do
			if o.identified == false then
				self:skillCheck("intuition", 10)
--				local skill = self:getSkill("intuition")
--				game.log("%d + %d = %d vs DC %d"):format(d, skill, d+skill, dc))
				if true then
					o.identified = true
				else
				end	
			end
		end
	end	

	end,
	info = function(self, t )
		return "Attempt to identify items in your inventory"
	end,
}
