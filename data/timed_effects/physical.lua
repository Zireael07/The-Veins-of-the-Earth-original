--Veins of the Earth
--Copyright (C) Zireael 2013-2015


local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Conditions for below 0 hp
newEffect{
	name = "DISABLED",
	desc = "Barely alive",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is barely alive!", "+Disabled" end,
	on_lose = function(self, err) return "#Target# got up from the ground.", "-Disabled" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("movement_speed_bonus", -0.50)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed_bonus", eff.tmpid)
	end,
}

newEffect{
	name = "DYING",
	desc = "Bleeding out",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is bleeding to death!", "+Dying" end,
	on_lose = function(self, err) return "#Target# has become stable.", "-Dying" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move_but_attack", 1)
		eff.particle = self:addParticles(Particles.new("bleeding", 1))
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move_but_attack", eff.tmpid)
		self:removeParticles(eff.particle)
	end,
}

--Load penalties
newEffect{
	name = "HEAVY_LOAD",
	desc = "Encumbered",
	type = "physical",
	status = "detrimental",
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
	status = "detrimental",
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

-- Basic Conditions

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

newEffect{
	name = "UNCONSCIOUS",
	desc = "Lost consciousness",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# fell into slumber!", "+Unconscious" end,
	on_lose = function(self, err) return "#Target# regained consciousness.", "-Unconscious" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end,
}

newEffect{
	name = "FATIGUE",
	desc = "Fatigued",
	long_desc = [["A fatigued character can neither run nor charge and takes a -2 penalty to Strength and Dexterity. Doing anything that would normally cause fatigue causes the fatigued character to become exhausted. After 8 hours of complete rest, fatigued characters are no longer fatigued.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is fatigued!", "+Fatigue" end,
	on_lose = function(self, err) return "#Target# is no longer fatigued", "-Fatigue" end,
	activate = function(self, eff)
		local stat = { [Stats.STAT_STR]=-2, [Stats.STAT_DEX]=-2 }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
		eff.decrease2 = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease2)
	end
}

newEffect{
	name = "STUN",
	desc = "Stunned",
	long_desc = [[A stunned character cannot move and takes a -2 penalty to AC in addition to losing the Dex bonus.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is stunned!", "+Stun" end,
	on_lose = function(self, err) return "#Target# is no longer stunned", "-Stun" end,
	activate = function(self, eff)
		local dexmod = self:getDexMod()
		eff.tmpid = self:addTemporaryValue("never_move", 1)
		self:effectTemporaryValue(eff, "combat_untyped", -2)
		self:effectTemporaryValue(eff, "combat_untyped", -dexmod)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end
}

-- -2 to skill checks
newEffect{
	name = "SHAKEN",
	desc = "Shaken",
	long_desc = [[A shaken character takes a -2 penalty to attack, saves and skill checks.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# looks shaken", "+Shaken" end,
	on_lose = function(self, err) return "#Target# seems to regain his senses", "-Shaken" end,
	activate = function(self, eff)
		eff.attack = self:addTemporaryValue("combat_attack", -2)
		eff.fort = self:addTemporaryValue("fortitude_save", -2)
		eff.reflex = self:addTemporaryValue("reflex_save", -2)
		eff.will = self:addTemporaryValue("will_save", -2)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("combat_attack", eff.attack)
		self:removeTemporaryValue("fortitude_save", eff.fort)
		self:removeTemporaryValue("reflex_save", eff.reflex)
		self:removeTemporaryValue("will_save", eff.will)
	end,
}
