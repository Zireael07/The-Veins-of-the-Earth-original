newTalentType{ 
	all_limited=true,
	spell_list="arcane",
	type="divination",
	name="divination",
	description = "divination blahblah"
}

newTalent{	
	name = "Identify",
	type = {"divination", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = false,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")
		for k, o in ipairs(inven) do
			if  o.identified == false then
				o.identified = true
			end
		end
		return true
	end,
	info = function(self, t)
		return ([[Identifies items in your inventory]])
	end,
}