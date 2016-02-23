--Veins of the Earth
--Zireael 2013-2016

local Talents = require "engine.interface.ActorTalents"

--Stuff that we're not modifying but needs to be explicitly set to zero to avoid getting OP
newEntity{ define_as = "BASE_EGO",
	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,
	movement_speed = 0,
	combat_attackspeed = 0,
}

--STR +4 DEX + 2 CON +2 AC +3; immune to fear
newEntity{ base = "BASE_EGO",
    name = "dire ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 3,
    hit_die = 4,
    combat_attack = 4,
    combat_natural = 3,
}

--Pounce, Rake, Multiattack, Rend; dmg + 6
newEntity{
    name = "feral ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 15,

    challenge = 2,
    hit_die = 1,
    combat_attack = 6,
}
