--Veins of the Earth
--Zireael 2015

load("/data/general/objects/properties/weapons.lua")

newEntity{
    name = "returning ", prefix = true,
    level_range = {5, nil},
    rarity = 4,
    cost = resolvers.value{platinum=2000},
    school = "transmutation",
    returning = true,
}
