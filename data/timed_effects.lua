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

load("/data/timed_effects/basic.lua")
load("/data/timed_effects/special.lua")
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
		DamageType:get(DamageType.FORCE).projector(eff.src or self, self.x, self.y, DamageType.FORCE, {dam=eff.power, save_dc=10} )
	end,
}
