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
		return True
	end,
	info = "The target you touch is afflicted with a terrible ailment.", 
}