-- Veins of the Earth
-- Copyright (C) 2013-2014 Zireael, Sebsebeleb
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.


local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

load("/data/timed_effects/poisons.lua")
load("/data/timed_effects/spells.lua")
load("/data/timed_effects/shapechange.lua")

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
	name = "ACIDBURN",
	desc = "Burning from acid",
	type = "physical",
	status = "detrimental",
	parameters = { power=1 },
	on_gain = function(self, err) return "#Target# is covered in acid!", "+Acid" end,
	on_lose = function(self, err) return "#Target# is free from the acid.", "-Acid" end,
	on_timeout = function(self, eff)
		DamageType:get(DamageType.ACID).projector(eff.src or self, self.x, self.y, DamageType.ACID, eff.power)
	end,
}

--Magical radiation, Zireael
newEffect{
	name = "MAG_RADIATION",
	desc = "Magical radiation",
	type = "physical",
	status = "detrimental",
	parameters = { power=2 },
	on_gain = function(self, err) return "#Target# is enveloped by underground magical radiation!", "+Radiation" end,
	on_lose = function(self, err) return "#Target# is free from the radiation.", "-Radiation" end,
	on_timeout = function(self, eff)
		DamageType:get(DamageType.FORCE).projector(eff.src or self, self.x, self.y, DamageType.FORCE, eff.power)
	end,
}

--Sebsebeleb
newEffect{
	name = "RAGE",
	desc = "Raging!",
	type = "mental",
	on_gain = function(self, err) return "#Target# is in a furious rage!", "+Rage" end,
	on_lose = function(self, err) return "#Target# has calmed down from the rage", "-Rage" end,
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=4, [Stats.STAT_DEX]=4 }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		self:effectTemporaryValue(eff, "will_save", 2)
		self:effectTemporaryValue(eff, "combat_untyped", -2)
		eff.increase = self:addTemporaryValue("stat_increase_dex", 1)
		eff.increase2 = self:addTemporaryValue("stat_increase_str", 1)
	end,
	deactivate = function(self, eff)
		self:setEffect(self.EFF_FATIGUE, 5, {})
		self:removeTemporaryValue("stat_increase_dex", eff.increase)
		self:removeTemporaryValue("stat_increase_str", eff.increase2)

	end,
}

newEffect{
	name = "BLOOD_VENGANCE",
	desc = "Angry!",
	type = "mental",
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=2, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_str", eff.increase)
	end,
}