--Veins of the Earth
--Zireael

local Talents = require "engine.interface.ActorTalents"

newEntity{
	define_as = "BASE_DIGGER",
	slot = "TOOL",
	type = "tool", subtype="digger",
	image = "tiles/pickaxe.png",
	display = "\\", color=colors.STEEL_BLUE,
	encumber = 3,
	rarity = 20,
	desc = [[Allows you to dig.]],
	carrier = {
		learn_talent = { [Talents.T_DIG] = 1, },
	},
}

newEntity{ base = "BASE_DIGGER",
	name = "iron pickaxe",
	level_range = {1, 20},
	cost = 3,
	digspeed = 20,
}