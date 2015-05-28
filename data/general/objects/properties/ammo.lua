--Veins of the Earth
--Zireael 2015

load("/data/general/objects/properties/weapons.lua")

--60 arrows/bolts/etc.
newEntity{
    name = "efficient ", prefix = true,
    keywords = {capacity=true},
    level_range = {5, nil},
	rarity = 2,
	cost = resolvers.value{platinum=1800},
	school = "conjuration",
	combat = {
		capacity = 50,
	},
}

--Based on something that was once in the web articles
newEntity{
    name = " of Maeve", suffix = true,
    keywords = {capacity=true},
    level_range = {11, nil},
    rarity = 10,
    cost = resolvers.value{platinum=8000}, --eyeballed
    school = "conjuration",
    infinite = true,
}
