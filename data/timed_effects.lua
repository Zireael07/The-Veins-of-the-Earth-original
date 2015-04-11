-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael
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

local resolveSource = function(self)
	if self.src and self.src.resolveSource then
		return self.src:resolveSource()
	else
		return self
	end
end

--gets the full name of the effect
local getName = function(self)
	local name = self.effect_id and mod.class.Actor.tempeffect_def[self.effect_id].desc or "effect"
	if self.src and self.src.name then
		return name .." from "..self.src.name:capitalize()
	else
		return name
	end
end


load("/data/timed_effects/physical.lua")
load("/data/timed_effects/poisons.lua")
load("/data/timed_effects/spells.lua")
load("/data/timed_effects/shapechange.lua")


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

--Detection, from ToME 4
newEffect{
	name = "SENSE",
	desc = "Sensing",
	long_desc = function(self, eff) return "Improves senses, allowing the detection of unseen things." end,
	type = "mental",
--	subtype = { sense=true },
	status = "beneficial",
	parameters = { range=10, actor=1, object=0, trap=0 },
	activate = function(self, eff)
		eff.rid = self:addTemporaryValue("detect_range", eff.range)
		eff.aid = self:addTemporaryValue("detect_actor", eff.actor)
		eff.oid = self:addTemporaryValue("detect_object", eff.object)
		eff.tid = self:addTemporaryValue("detect_trap", eff.trap)
		self.detect_function = eff.on_detect
		game.level.map.changed = true
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("detect_range", eff.rid)
		self:removeTemporaryValue("detect_actor", eff.aid)
		self:removeTemporaryValue("detect_object", eff.oid)
		self:removeTemporaryValue("detect_trap", eff.tid)
		self.detect_function = nil
	end,
}
