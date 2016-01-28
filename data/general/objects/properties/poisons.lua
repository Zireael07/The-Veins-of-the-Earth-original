--Veins of the Earth
--Zireael 2013-2016

--Weak poisons
newEntity{
    name = " of black adder venom", suffix = true, addon = true,
    rarity = 5,
    fake_ego = true,
    level_range = {5,10},
--    cost = 120,
    cost = resolvers.value{gold=120},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "black_adder"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of toadstool poison", suffix = true, addon = true,
    rarity = 5,
    fake_ego = true,
    level_range = {5,10},
--    cost = 180,
    cost = resolvers.value{gold=180},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "toadstool"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of arsenic", suffix = true, addon = true,
    rarity = 25,
    fake_ego = true,
    level_range = {5,10},
--    cost = 120,
    cost = resolvers.value{gold=120},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "arsenic"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of id moss",
    rarity = 20,
    fake_ego = true,
    level_range = {5,10},
--    cost = 125,
    cost = resolvers.value{gold=125},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "idmoss"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of black adder venom", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {5,10},
--    cost = 120,
    cost = resolvers.value{gold=120},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "blackadder"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of small centipede poison", suffix = true, addon = true,
    rarity = 10,
    fake_ego = true,
    level_range = {1,10},
--    cost = 90,
    cost = resolvers.value{gold=90},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "small_centipede"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = "vial of bloodroot", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {5,10},
--    cost = 100,
    cost = resolvers.value{gold=100},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "bloodroot"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of greenblood oil", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {5,10},
--    cost = 100,
    cost = resolvers.value{gold=100},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "greenblood"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of blue whinnis", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {5,10},
--    cost = 120,
    cost = resolvers.value{gold=120},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "whinnis"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of medium spider venom", suffix = true, addon = true,
    rarity = 5,
    fake_ego = true,
    level_range = {5,10},
--    cost = 150,
    cost = resolvers.value{gold=150},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "medium_spider"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of large scorpion venom", suffix = true, addon = true,
    rarity = 10,
    fake_ego = true,
    level_range = {5,10},
--    cost = 200,
    cost = resolvers.value{gold=200},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "large_scorpion"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of giant wasp poison", suffix = true, addon = true,
    rarity = 10,
    fake_ego = true,
    level_range = {5,10},
--    cost = 210,
    cost = resolvers.value{gold=210},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "giantwasp"
        return {used = true, destroy = true}
  end
  },
}


--Middling poisons

newEntity{
    name = " of nitharit", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {10,15},
--    cost = 650,
    cost = resolvers.value{gold=650},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "nitharit"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of sassone", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {10,15},
--    cost = 300,
    cost = resolvers.value{gold=300},
  use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "sassone"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of shadow essence", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {10,15},
--    cost = 250,
    cost = resolvers.value{gold=250},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "shadowessence"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of malyss root paste", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {10,15},
--    cost = 500,
    cost = resolvers.value{gold=500},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "malyss"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of terinav", suffix = true, addon = true,
    rarity = 15,
    fake_ego = true,
    level_range = {10,15},
--    cost = 750,
    cost = resolvers.value{gold=750},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "terinav"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of lich dust", suffix = true, addon = true,
    rarity = 35,
    fake_ego = true,
    level_range = {10,15},
--    cost = 250,
    cost = resolvers.value{gold=250},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "lichdust"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of dark reaver powder", suffix = true, addon = true,
    level_range = {10,15},
    rarity = 15,
    fake_ego = true,
--    cost = 300,
    cost = resolvers.value{gold=300},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "darkreaver"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of purple worm poison", suffix = true, addon = true,
    level_range = {10,15},
    rarity = 25,
    fake_ego = true,
--    cost = 700,
    cost = resolvers.value{gold=700},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "purpleworm"
        return {used = true, destroy = true}
  end
  },
}


--Strong poisons (insanely rare)

newEntity{
    name = " of black lotus extract", suffix = true, addon = true,
    rarity = 45,
    fake_ego = true,
    level_range = {30,45},
--    cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "blacklotus"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of dragon bile", suffix = true, addon = true,
    rarity = 55,
    fake_ego = true,
    level_range = {15,20},
--    cost = 1500,
    cost = resolvers.value{gold=1500},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "dragon"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = "  of ungol dust", suffix = true, addon = true,
    rarity = 40,
    fake_ego = true,
    level_range = {15,20},
--    cost = 1000,
    cost = resolvers.value{gold=1000},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "ungoldust"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of insanity mist", suffix = true, addon = true,
    rarity = 65,
    fake_ego = true,
    level_range = {15,20},
--    cost = 1500,
    cost = resolvers.value{gold=1000},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "insanitymist"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of burnt othur", suffix = true, addon = true,
    rarity = 45,
    fake_ego = true,
    level_range = {20,25},
--    cost = 2100,
    cost = resolvers.value{gold=2100},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "burnt_othur"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of wyvern poison", suffix = true, addon = true,
    rarity = 45,
    fake_ego = true,
    level_range = {20,25},
--    cost = 3000,
    cost = resolvers.value{gold=3000},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "wyvern"
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    name = " of deathblade", suffix = true, addon = true,
    rarity = 75,
    fake_ego = true,
    level_range = {20,25},
--    cost = 1800,
    cost = resolvers.value{gold=1800},
    use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "deathblade"
        return {used = true, destroy = true}
  end
  },
}
