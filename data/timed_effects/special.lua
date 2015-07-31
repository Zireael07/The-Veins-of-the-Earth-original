--Veins of the Earth
--Zireael 2013-2015

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Talents
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
		-- 6 rounds equal one minute; fatigue lasts for 5 mins = 30 rounds
		self:setEffect(self.EFF_FATIGUE, 30, {})
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


--Items
--For expeditious armor
newEffect{
	name = "EXPEDITIOUS_RETREAT_MINOR",
	desc = "Boost speed",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 0.33)
		--never attack but move? uh...
	--	eff.tmpid = self:addTemporaryValue("never_move", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed", eff.speed)
	end,
}
