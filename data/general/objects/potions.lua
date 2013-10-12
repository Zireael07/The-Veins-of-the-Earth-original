--Veins of the Earth
--Zireael

--Potions
newEntity{
    define_as = "BASE_POTION",
    slot = "INVEN",
    type = "potion", subtype = "potion",
    display = "!", color=colors.RED,
    encumber = 0,
    rarity = 5,
    name = "a potion",
    desc = [[A potion.]],
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cure light wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "cure light wounds",
    use = function(self,who)
        who:heal(rng.dice(1,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cure moderate wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {4,10},
    cost = 300,
    use_simple = { name = "cure moderate wounds",
    use = function(self,who)
        who:heal(rng.dice(2,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal light wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal light wounds",
    use = function(self,who)
        who:heal(who.max_life*0.1)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal moderate wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal moderate wounds",
    use = function(self,who)
        who:heal(who.max_life*0.3)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal moderate wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal moderate wounds",
    use = function(self,who)
        who:heal(who.max_life*0.3)
        return {used = true, destroy = true}
  end
  }, 
}


--newEntity{
--    base = "BASE_POTION",
--   name = "a potion of inflict light wounds",
--    unided_name = "a potion",
--    identified = false,
--    level_range = {1,10},
--    cost = 50,
--    use_simple = { name = "heal light wounds",
--    use = function(self,who)
--        who:heal(who.max_life*0.1)
--        return {used = true, destroy = true}
--  end
--  }, 
--}

newEntity{
    base = "BASE_POTION",
    name = "a potion of bear endurance",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal moderate wounds",
    use = function(self,who)
        who:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}