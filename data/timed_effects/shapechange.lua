--Veins of the Earth
--Zireael 2013-2014

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Various shapechange effects

--Wild shape forms
newEffect{
	name = "WILD_SHAPE_BABOON",
	desc = "Baboon Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a baboon!", "+Wild Shape" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Wild Shape" end,
	activate = function(self, eff)
		local oldcombat_natural = self.combat_natural or 0
		local oldcombat = self.combat.dam

		self.combat_natural = 1
	--	self.combat = { dam= {1,6} },

	--[[	self.replace_display = mod.class.Actor.new{
			image = "tiles/npc/human_sorcerer.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
	deactivate = function(self, eff)
		self.combat_natural = oldcombat_natural
	--	self:removeParticles(eff.particle)
	--[[	self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
}

newEffect{
	name = "WILD_SHAPE_CROCODILE",
	desc = "Crocodile Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a crocodile!", "+Wild Shape" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Wild Shape" end,
	activate = function(self, eff)
		local oldcombat_natural = self.combat_natural or 0
	--	local oldcombat = self.combat.dam

		self.combat_natural = 4
		self.skill_bonus_swim = 8
	--	self.combat = { dam= {1,6} },
	
	--[[	self.replace_display = mod.class.Actor.new{
			image = "tiles/npc/human_sorcerer.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
	deactivate = function(self, eff)
		self.combat_natural = oldcombat_natural
		self.skill_bonus_swim = 0
	--	self:removeParticles(eff.particle)
	--[[	self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
}


--Alter self forms
newEffect{
	name = "ALTER_SELF_HUMAN",
	desc = "Human Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a human!", "+Alter Self" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Alter Self" end,
	activate = function(self, eff)

		self.replace_display = mod.class.Actor.new{
			image = "tiles/npc/human_sorcerer.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
	deactivate = function(self, eff)
	--	self:removeParticles(eff.particle)
		self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
}

newEffect{
	name = "ALTER_SELF_DROW",
	desc = "Drow Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a drow!", "+Alter Self" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Alter Self" end,
	activate = function(self, eff)

		self.replace_display = mod.class.Actor.new{
			image = "tiles/npc/drow_sorcerer.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
	deactivate = function(self, eff)
	--	self:removeParticles(eff.particle)
		self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
}

newEffect{
	name = "ALTER_SELF_LIZARDFOLK",
	desc = "Lizardfolk Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a lizardfolk!", "+Alter Self" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Alter Self" end,
	activate = function(self, eff)
		local oldcombat_natural = self.combat_natural or 0

		self.combat_natural = 5
		self.skill_bonus_balance = 4
		self.skill_bonus_jump = 4
		self.skill_bonus_swim = 1


	--[[	self.replace_display = mod.class.Actor.new{
			image = "tiles/npc/drow_sorcerer.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
	deactivate = function(self, eff)
		self.combat_natural = oldcombat_natural
		self.skill_bonus_balance = 0
		self.skill_bonus_jump = 0
		self.skill_bonus_swim = 0

	--	self:removeParticles(eff.particle)
	--[[	self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)]]
	end,
}

newEffect{
	name = "ALTER_SELF_BUGBEAR",
	desc = "Bugbear Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a bugbear!", "+Alter Self" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Alter Self" end,
	activate = function(self, eff)
		local oldcombat_natural = self.combat_natural or 0

		self.combat_natural = 5
--[[		self.skill_bonus_balance = 4
		self.skill_bonus_jump = 4
		self.skill_bonus_climb = 1]]


		self.replace_display = mod.class.Actor.new{
			image = "tiles/goblin.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
	deactivate = function(self, eff)
		self.combat_natural = oldcombat_natural
--[[		self.skill_bonus_balance = 0
		self.skill_bonus_jump = 0
		self.skill_bonus_climb = 0]]

	--	self:removeParticles(eff.particle)
		self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
}



--Polymorph forms
newEffect{
	name = "POLYMORPH_SELF_CLOAKER",
	desc = "Cloaker Form",
	type = "magical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# turns into a cloaker!", "+Polymorph Self" end,
	on_lose = function(self, err) return "#Target# is no longer transformed.", "-Polymorph Self" end,
	activate = function(self, eff)
		local oldcombat_natural = self.combat_natural or 0
		self.combat_natural = 6
		self.fly = true

		self.replace_display = mod.class.Actor.new{
			image = "tiles/newtiles/cloaker.png",
		}
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
	deactivate = function(self, eff)
		self.combat_natural = oldcombat_natural
		self.fly = false

	--	self:removeParticles(eff.particle)
		self.replace_display = nil
		self:removeAllMOs()
		game.level.map:updateMap(self.x, self.y)
	end,
}

