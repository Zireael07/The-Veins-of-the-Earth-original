newTalentType{ 
	all_limited=true,
	type="divination",
	name="divination",
	description = "divination blahblah"
}

newArcaneSpell{	
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
		local d d = self:showInventory("Identify which item?", inven, function(o) return not o.identified end, function(o, item)
			if o.identified == false then o.identified = true end
		end)
		return true
	end,
	info = function(self, t)
		return ([[Identifies a single item in your inventory]])
	end,
}

--Seb's original identify, renamed and shuffled to a higher level
newArcaneSpell{	
	name = "Improved Identify",
	type = {"divination", 1},
	mode = 'activated',
	level = 6,
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

