--Veins of the Earth
--Zireael 2013-2015

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Basic conditions from SRD
--in alphabetical order per SRD

newEffect{
 name = "BLEED",
 desc = "Bleeding",
 type = "physical",
 status = "detrimental",
 on_gain = function(self, err) return "#Target# is bleeding!", "+Bleed" end,
 on_lose = function(self, err) return "#Target# got up from the ground.", "-Bleed" end,
}

--Dummy for concealment
newEffect{
	name = "BLIND",
	desc = "Blinded",
	long_desc = [[The character cannot see. He takes a -2 penalty to Armor Class and loses his Dexterity bonus to AC (if any).
		All opponents are considered to have total concealment (50% miss chance) to the blinded character.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# loses sight!", "+Blind" end,
	on_lose = function(self, err) return "#Target# regains sight.", "-Blind" end,

}

--Confused
--Cowering
--Dazzled
--Deafened

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

newEffect{
	name = "ENTANGLE",
	desc = "Entangled",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is entangled!", "+Entangle" end,
	on_lose = function(self, err) return "#Target# breaks free.", "-Entangle" end,
	activate = function(self, eff)
		local inc = { [Stats.STAT_DEX]=-4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)

		eff.tmpid = self:addTemporaryValue("movement_speed_bonus", -0.50)
		eff.attack = self:addTemporaryValue("combat_attack", -2)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed_bonus", eff.tmpid)
		self:removeTemporaryValue("combat_attack", eff.attack)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}

--Next stage of fatigue
newEffect{
	name = "EXHAUSTION",
	desc = "Exhausted",
	long_desc = [["An exhausted creature moves at half speed and takes a -6 penalty to Strength and Dexterity. After 1 hours of complete rest, exhausted characters are now fatigued.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is fatigued!", "+Fatigue" end,
	on_lose = function(self, err) return "#Target# is no longer fatigued", "-Fatigue" end,
	activate = function(self, eff)
		local stat = { [Stats.STAT_STR]=-2, [Stats.STAT_DEX]=-2 }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
		eff.decrease2 = self:addTemporaryValue("stat_decrease_dex", 1)
		eff.tmpid = self:addTemporaryValue("movement_speed_bonus", -0.50)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease2)
		self:removeTemporaryValue("movement_speed_bonus", eff.tmpid)
	end
}

newEffect{
	name = "FASCINATE",
	desc = "Fascinated",
	type = "mental",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# is fascinated!", "+Fascinate" end,
	on_lose = function(self, err) return "#Target# is no longer fascinated.", "-Fascinate" end,
	activate = function(self, eff)
		eff.listen = self:addTemporaryValue("skill_bonus_listen", -4)
		eff.spot = self:addTemporaryValue("skill_bonus_spot", -4)
    end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("skill_bonus_listen", eff.listen)
		self:removeTemporaryValue("skill_bonus_spot", eff.spot)
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

--Helpless
--Incorporeal

--+2 attack against sighted, ignores their Dex mod to AC
newEffect{
	name = "INVISIBLE",
	desc = "Invisible",
	type = "physical",
	status = "beneficial",
	parameters = { power=1 },
	on_gain = function(self, err) return "#Target# fades from sight!", "+Invisible" end,
	on_lose = function(self, err) return "#Target# reappears!", "-Invisible" end,
	activate = function(self, eff)
		eff.invis = self:addTemporaryValue("stealth", eff.power)
	--[[	if not self.shader then
			eff.set_shader = true
			self.shader = "invis_edge"
			self:removeAllMOs()
			game.level.map:updateMap(self.x, self.y)
		end]]
	end,
	deactivate = function(self, eff)
	--[[	if eff.set_shader then
			self.shader = nil
			self:removeAllMOs()
			game.level.map:updateMap(self.x, self.y)
		end]]
		self:removeTemporaryValue("stealth", eff.invis)
	end,
}

--Nauseated
--Panicked
--Paralyzed


newEffect{
	name = "PETRIFY",
	desc = "Petrified",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is turned into stone!", "+Stone" end,
	on_lose = function(self, err) return "#Target# is no longer petrified.", "-Stone" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move", 1)
    end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end,
}


--Note: not the same as the knockdown ("fell") effect
--attacker: penalty -4 on attack and can't use ranged
--defender: -4 to AC vs melee, +4 to AC vs ranged
newEffect{
	name = "PRONE",
	desc = "Prone",
    type = "physical",
    status = "beneficial", --?
	long_desc = [[The character is on the ground.]],
	on_gain = function(self, err) return "#Target# falls to the ground!", "+Prone" end,
	on_lose = function(self, err) return "#Target# stands up.", "-Prone" end,
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

--Sickened
--Staggered

--Drop everything held
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
