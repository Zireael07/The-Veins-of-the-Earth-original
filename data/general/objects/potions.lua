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
    use_simple = { name = "quaff",
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
    use_simple = { name = "quaff",
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
    cost = 750,
    use_simple = { name = "quaff",
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
    cost = 900,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.3)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal serious wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 1200,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.5)
        return {used = true, destroy = true}
  end
  }, 
}


newEntity{
    base = "BASE_POTION",
    name = "a potion of inflict light wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(-who.max_life*0.1)
        return {used = true, destroy = true}
 end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of bear endurance",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of bull strength",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_BULL_STRENGTH, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of eagle splendor",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_EAGLE_SPLENDOR, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of owl wisdom",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_OWL_WISDOM, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cat grace",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_CAT_GRACE, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of fox cunning",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_FOX_CUNNING, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of mage armor",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_MAGE_ARMOR, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}


newEntity{
    base = "BASE_POTION",
    name = "a potion of poison",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(self.EFF_POISON1d10CON, 6, {})
        return {used = true, destroy = true}
  end
  }, 
}
