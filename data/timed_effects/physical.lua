--Veins of the Earth
--Copyright (C) Zireael 2013-2015

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Load penalties
newEffect{
	name = "HEAVY_LOAD",
	desc = "Encumbered",
	type = "physical",
	status = "neutral",
	on_gain = function(self, err) return end, --"#Target# is encumbered!", "+Load" end,
	on_lose = function(self, err) return end, --"#Target# is no longer encumbered.", "-Load" end,
	activate = function(self, eff)
		eff.loadpenaltyId = self:addTemporaryValue("load_penalty", 6)
		eff.maxdexId = self:addTemporaryValue("max_dex_bonus", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("load_penalty", eff.loadpenaltyId)
		self:removeTemporaryValue("max_dex_bonus", eff.maxdexId)
	end,
}

newEffect{
	name = "MEDIUM_LOAD",
	desc = "Encumbered",
	type = "physical",
	status = "neutral",
	on_gain = function(self, err) return end, --"#Target# is encumbered!", "+Load" end,
	on_lose = function(self, err) return end, --"#Target# is no longer encumbered.", "-Load" end,
	activate = function(self, eff)
		eff.loadpenaltyId = self:addTemporaryValue("load_penalty", 3)
		eff.maxdexId = self:addTemporaryValue("max_dex_bonus", 3)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("load_penalty", eff.loadpenaltyId)
		self:removeTemporaryValue("max_dex_bonus", eff.maxdexId)
	end,
}

--Dummy so that encumbrance can be removed on death temporarily
newEffect{
	name = "ENCUMBERED",
	desc = "Encumbered",
	type = "physical",
	status = "neutral",
	activate = function(self, eff)
		self.encumbered = self:addTemporaryValue("never_move_but_attack", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move_but_attack", self.encumbered)
	end,
}

--Hunger
newEffect{
	name = "HUNGRY",
	desc = "Hungry",
	type = "physical",
	status = "neutral",
	activate = function(self, eff)
        local inc = { [Stats.STAT_STR]=-1, [Stats.STAT_CON]=-1 }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
        eff.decrease2 = self:addTemporaryValue("stat_decrease_con", 1)
    end,
    deactivate = function(self, eff)
        self:removeTemporaryValue("stat_decrease_str", eff.decrease)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease2)
    end,
}

newEffect{
	name = "STARVING",
	desc = "Starving",
	type = "physical",
	status = "neutral",
	activate = function(self, eff)
        local inc = { [Stats.STAT_STR]=-2, [Stats.STAT_CON]=-2 }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
        eff.decrease2 = self:addTemporaryValue("stat_decrease_con", 1)
    end,
    deactivate = function(self, eff)
        self:removeTemporaryValue("stat_decrease_str", eff.decrease)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease2)
    end,
}

newEffect{
	name = "WEAK",
	desc = "Weak",
	type = "physical",
	status = "neutral",
	activate = function(self, eff)
        local inc = { [Stats.STAT_STR]=-4, [Stats.STAT_CON]=-4 }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
        eff.decrease2 = self:addTemporaryValue("stat_decrease_con", 1)
    end,
    deactivate = function(self, eff)
        self:removeTemporaryValue("stat_decrease_str", eff.decrease)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease2)
    end,
}

newEffect{
	name = "TRACKING",
	desc = "Tracking",
	type = "physical",
	status = "neutral",
	activate = function(self, eff)
		self.sense = self:addTemporaryValue("heightened_senses", 2)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("heightened_senses", self.sense)
	end,
}

--knockdowns
newEffect{
	name = "FELL",
	desc = "Fell to the ground",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# fell!", "+Fell" end,
	on_lose = function(self, err) return "#Target# got up from the ground.", "-Fell" end,
	on_merge = function(self, old_eff, new_eff)
        -- Merging has no effect, to prevent repeated knockdowns from stunlocking
        -- a creature.
        return old_eff
    end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end,
}
