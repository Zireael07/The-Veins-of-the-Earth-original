local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"


--Poisons, Zireael
--1 is WEAK, 1d4 is MIDDLING, 1d6 damage is MEDIUM, 2d6 is STRONG, 3d6 is EXTRASTRONG because numbers are EVIL!!
--Oil of taggit and drow poison simply apply EFF_UNCONSCIOUS instead of having their own entries here

--Nitharit secondary effect; black lotus primary and secondary; othur fumes secondary
newEffect{
	name = "POISON_EXTRASTRONG_CON",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(3,6)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

--Sassone primary effect
newEffect{
	name = "POISON_hp",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
--		local stat = { [Stats.STAT_CON]=-rng.dice(2,12)}
--		self:effectTemporaryValue(eff, "inc_stats", stat)
	end,
}

--Sassone secondary effect; black adder primary & secondary; deathblade primary; demon fever
newEffect{
	name = "POISON_MEDIUM_CON",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,6)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

newEffect{
	name = "POISON_MALYSS_PRI",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_DEX]=-1}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}

newEffect{
	name = "POISON_MALYSS_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(2,4)
		local stat = { [Stats.STAT_DEX]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}
--Terinav root primary; giant wasp primary & secondary
newEffect{
	name = "POISON_MEDIUM_DEX",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_DEX]=-rng.dice(1,6)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}

newEffect{
	name = "POISON_TERINAV_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(2,6)
		local stat = { [Stats.STAT_DEX]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}

--No secondary effect
newEffect{
	name = "POISON_DRAGON_BILE",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(3,6)
		local stat = { [Stats.STAT_STR]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}

newEffect{
	name = "POISON_TOADSTOOL_PRI",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_WIS]=-1}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_wis", eff.decrease)
	end,
}

newEffect{
	name = "POISON_TOADSTOOL_SEC",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local change1 = rng.dice(2,6)
		local change2 = rng.dice(1,4)
		local stat = { [Stats.STAT_WIS]=-change1, [Stats.STAT_INT]=-change2 }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_int", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_int", eff.decrease)
	end,
}
--Arsenic primary; othur fumes primary; greenblood oil primary; blue whinnis primary
newEffect{
	name = "POISON_WEAK_CON",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-1}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

newEffect{
	name = "POISON_ARSENIC_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,8)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

--Poison moss primary; mindfire
newEffect{
	name = "POISON_MIDDLING_INT",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_INT]=-rng.dice(1,4), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_int", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_int", eff.decrease)
	end,
}

newEffect{
	name = "POISON_MOSS_SEC",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_INT]=-rng.dice(2,6), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_int", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_int", eff.decrease)
	end,
}
--Lich dust primary; shadow essence secondary; purple worm secondary
newEffect{
	name = "POISON_STRONG_STR",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=-rng.dice(2,6), }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}
--Lich dust secondary; large scorpion primary & secondary; purple worm primary; red ache
newEffect{
	name = "POISON_MEDIUM_STR",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=-rng.dice(1,6), }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}
--Dark reaver primary; wyvern primary & secondary; deathblade secondary
newEffect{
	name = "POISON_STRONG_CON",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local inc = { [Stats.STAT_CON]=-rng.dice(2,6), }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

newEffect{
	name = "POISON_DARK_REAVER_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,6), [Stats.STAT_STR]=-rng.dice(1,6), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
		eff.decrease2 = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease2)
	end,
}

newEffect{
	name = "POISON_UNGOL_DUST_PRI",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_CHA]=-1}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_cha", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_cha", eff.decrease)
	end,
}

newEffect{
	name = "POISON_UNGOL_DUST_SEC",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(1,6)
		local stat = { [Stats.STAT_CHA]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_cha", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_cha", eff.decrease)
	end,
}

newEffect{
	name = "POISON_INSANITY_MIST_PRI",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(1,4)
		local stat = { [Stats.STAT_WIS]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_wis", eff.decrease)
	end,
}

newEffect{
	name = "POISON_INSANITY_MIST_SEC",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local change = rng.dice(2,6)
		local stat = { [Stats.STAT_WIS]=-change}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_wis", eff.decrease)
	end,
}

--Primary & secondary the same
newEffect{
	name = "POISON_SMALL_CENTIPEDE",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local inc = { [Stats.STAT_DEX]=-rng.dice(1,2), }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}
--No primary effect
newEffect{
	name = "POISON_BLOODROOT_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,4), [Stats.STAT_WIS]=-rng.dice(1,3), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
		eff.decrease2 = self:addTemporaryValue("stat_decrease_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
		self:removeTemporaryValue("stat_decrease_wis", eff.decrease2)
	end,
}

newEffect{
	name = "POISON_GREENBLOOD_SEC",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_STR]=-rng.dice(1,2), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}
--Primary & secondary medium spider; blinding sickness, devil chills
newEffect{
	name = "POISON_MIDDLING_STR",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=-rng.dice(1,4), }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}

newEffect{
	name = "POISON_SHADOW_ESSENCE_PRI",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_STR]=-1}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_str", eff.decrease)
	end,
}

--Diseases, Zireael
newEffect{
	name = "DISEASE_CACKLE_FEVER",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	activate = function(self, eff)
		local stat = { [Stats.STAT_WIS]=-rng.dice(1,6), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_wis", eff.decrease)
	end,
}

newEffect{
	name = "DISEASE_FILTH_FEVER",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_DEX]=-rng.dice(1,3), [Stats.STAT_CON]=-rng.dice(1,3), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
		eff.decrease2 = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease2)
	end,
}

newEffect{
	name = "DISEASE_SHAKES",
	desc = "Poison",
	type = "physical",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_DEX]=-rng.dice(1,8), }
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_dex", eff.decrease)
	end,
}
--Slimy doom
newEffect{
	name = "POISON_MIDDLING_CON",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,4)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}

newEffect{
	name = "POISON_SPELL",
	desc = "Poison",
	type = "mental",
	status = "detrimental",
	parameters = {},
	activate = function(self, eff)
		local stat = { [Stats.STAT_CON]=-rng.dice(1,10)}
		self:effectTemporaryValue(eff, "inc_stats", stat)
		eff.decrease = self:addTemporaryValue("stat_decrease_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_decrease_con", eff.decrease)
	end,
}
