--Veins of the Earth
--Zireael 2013-2015

load("data/general/objects/properties/materials_armor.lua")

--Shields only material

newEntity {
	name = "darkwood ", prefix = true,
	keywords = {darkwood=true},
	level_range = {3, nil},
	rarity = 5,
--	cost = 500,
	cost = resolvers.value{gold=500},
	wielder = {
		armor_penalty = -2,
	}
}
