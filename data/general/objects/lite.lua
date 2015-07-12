--Veins of the Earth
--Zireael 2013-2015


--Light sources
newEntity{
    define_as = "BASE_LIGHT",
    slot = "LITE",
    type = "lite", subtype = "lite",
    image = "tiles/object/torch.png",
    display = "~", color=colors.YELLOW,
    encumber = 0,
    rarity = 10,
    name = "torch",
    desc = [[A torch.]],
}

--Should last 5000 turns
newEntity{
    base = "BASE_LIGHT",
    add_name = " (#LITE#)",
    name = "torch",
    level_range = {1,10},
    cost = 4,
    fuel_max = 5000,
    fuel = resolvers.rngavground(500, 4000),
    wielder = {
    lite=2
  },
}

--Unlimited
newEntity{
    base = "BASE_LIGHT",
    name = "everlasting torch",
    level_range = {10, nil},
--    cost = 5000,
    cost = resolvers.value{platinum=5000},
    wielder = {
    lite=2
  },
}

--Should last 7500 turns
newEntity{
    base = "BASE_LIGHT",
    name = "lantern",
    image = "tiles/object/lantern.png",
    level_range = {5,nil},
    add_name = " (#LITE#)",
--    cost = 7,
    cost = resolvers.value{silver=10},
    fuel_max = 7500,
    fuel = resolvers.rngavground(1000,5000),
    wielder = {
    lite=3
  },
}

--Burnt out torch
newEntity{
    base = "BASE_LIGHT",
    name = "burnt out torch",
    level_range = {1,10},
    fuel_max = 0,
    fuel = 0,
    cost = 0,
}

--Burnt out lantern
newEntity{
    base = "BASE_LIGHT",
    name = "burnt out lantern",
    image = "tiles/object/lantern.png",
    level_range = {5,nil},
    fuel_max = 0,
    fuel = 0,
    cost = 0,
}
