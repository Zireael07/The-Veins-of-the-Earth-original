--Veins of the Earth
--Zireael

local Talents = require "engine.interface.ActorTalents"

--Damage reduction 5/magic
newEntity {
	name = "celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
--	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.ACID] = 5,
	[DamageType.COLD] = 5,
	[DamageType.ELECTRIC] = 5,
	 }
}

newEntity {
	name = "fiendish ", prefix = true, instant_resolve=true,
	keywords = {fiendish=true},
	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	level_range = {5, nil},
	rarity = 10,
	infravision = 3,
--	spell_resistance = hit_die + 5,
	challenge = 2,
	resist = { [DamageType.FIRE] = 5,
	[DamageType.COLD] = 5,
	},
}
 --Stat increases, spell-like abilities
newEntity {
	name = "half-celestial ", prefix = true, instant_resolve=true,
	keywords = {celestial=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	infravision = 3,
--	spell_resistance = hit_die + 10,
	combat_natural = 1,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }
}

--Stat increases, spell-like abilities, bite/claw
newEntity {
	name = "half-fiend ", prefix = true, instant_resolve=true,
	keywords = {fiend=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	infravision = 3,
--	spell_resistance = hit_die + 10,
	combat_natural = 1,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	[DamageType.FIRE] = 10,
	 }
}

--Stat increases, breath weapon; bite/claw
newEntity {
	name = "half-dragon ", prefix = true, instant_resolve=true,
	keywords = {dragon=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	infravision = 3,
	combat_natural = 4,
	challenge = 2,
	resist = { [DamageType.ACID] = 10,
	[DamageType.COLD] = 10,
	[DamageType.ELECTRIC] = 10,
	 }
}

newEntity{
	name = " zombie", suffix = true, instant_resolve=true,
	display = 'Z', color=colors.WHITE,
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	infravision = 3,
	challenge = 1,
	combat = { dam= {1,6} },
}

newEntity{
	name = " skeleton", suffix = true, instant_resolve=true,
	display = 's', color=colors.WHITE,
	keywords = {undead=true},
	level_range = {5, nil},
	rarity = 5,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	infravision = 3,
	challenge = 1,
	combat = { dam= {1,6} },
}


--Incursion's special templates
-- +2 Str
--[[newEntity{
	name = "bandit ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	challenge = 2,
--[[	resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
	[Talents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
	[Talents.T_LIGHT_ARMOR_PROFICIENCY]=1,
	[Talents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},]]
--[[}

--+4 Str +4 Con
newEntity{
	name = "chieftain ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	challenge = 2,
	combat_attack = 2,
--	resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
--	[Talents.T_CLEAVE]=1,
--	},
}

--+1 to all attributes
newEntity{
	name = "skilled ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	hit_die = 1,
	combat_attack = 1,
	challenge = 1,
}

--+2 to all attributes
newEntity{
	name = "experienced ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,

	challenge = 2,
	combat_attack = 2,
}]]
