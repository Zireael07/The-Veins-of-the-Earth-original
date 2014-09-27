--Veins of the Earth
--Zireael

--Poison vials
newEntity{
    define_as = "BASE_VIAL",
    slot = "INVEN",
    type = "potion", subtype = "vial",
    display = "!", color=colors.SLATE,
    image = "tiles/poison_vial.png",
    encumber = 0,
    name = "a potion",
    desc = [[A potion.]],
}

--Weak poisons
newEntity{
    base = "BASE_VIAL",
    name = "vial of black adder venom",
    unided_name = "a potion",
    identified = false,
    rarity = 5,
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
    base = "BASE_VIAL",
    name = "vial of toadstool poison",
    unided_name = "a potion",
    identified = false,
    rarity = 5,
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
    base = "BASE_VIAL",
    name = "vial of arsenic",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of id moss",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of black adder venom",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of small centipede poison",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of bloodroot",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of greenblood oil",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of blue whinnis",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of medium spider venom",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of large scorpion venom",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of giant wasp poison",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of nitharit",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of sassone",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of shadow essence",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of malyss root paste",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of terinav",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of lich dust",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of dark reaver powder",
    unided_name = "a potion",
    identified = false,
    level_range = {10,15},
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of purple worm poison",
    unided_name = "a potion",
    identified = false,
    level_range = {10,15},
    rarity = 15,
--    cost = 700,
    cost = resolvers.value{gold=700},
   use_simple = { name = "apply poison",
    use = function(self,who)
        who.poison = "purpleworm"
        return {used = true, destroy = true}
  end
  },
}


--Strong poisons

newEntity{
    base = "BASE_VIAL",
    name = "vial of black lotus extract",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of dragon bile",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of ungol dust",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "a vial of insanity mist",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of burnt othur",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of wyvern poison",
    unided_name = "a potion",
    identified = false,
    rarity = 15,
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
    base = "BASE_VIAL",
    name = "vial of deathblade",
    unided_name = "a potion",
    identified = false,
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