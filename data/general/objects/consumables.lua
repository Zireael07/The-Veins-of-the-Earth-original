--Veins of the Earth
--Zireael 2013-2014

--Consumables
newEntity{
    define_as = "BASE_FOOD",
    slot = "INVEN",
    type = "food",
    image = "tiles/food.png",
    display = "%", color=colors.WHITE,
    encumber = 0,
    rarity = 8,
    name = "Food",
    desc = [[Some food.]],
}


newEntity{
    base = "BASE_FOOD",
    name = "food ration",
    image = "tiles/food.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 5,
    desc = [[Food rations, enough for a day or two.]],
    stacking = true,
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 200
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_FOOD",
    name = "spider bread", color=colors.BROWN,
    image = "tiles/food.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 15,
    desc == [[Spider bread, a favorite of the dark elves.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 150
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_FOOD",
    name = "beef jerky", color=colors.RED,
    image = "tiles/meat.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 10,
    desc = [[Beef jerky. Spoils slowly.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 150
        return {used = true, destroy = true}
  end
  }, 
}
--Remains fresh for 10 turns
newEntity{ define_as = "FRESH_CORPSE",
    base = "BASE_FOOD",
    name = "fresh corpse", color=colors.GREEN,
    image = "tiles/newtiles/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    encumber = 50,
    desc = [[A fresh corpse of some creature.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 100
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{ define_as = "CORPSE",
    base = "BASE_FOOD",
    name = "corpse", color=colors.RED,
    image = "tiles/newtiles/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    nutrition = 6,
    encumber = 50,
    desc == [[A corpse of some creature.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 60
        return {used = true, destroy = true}
  end
  }, 
}

--Drinks
newEntity{
    base = "BASE_FOOD",
    name = "flask of water",
    image = "tiles/flask.png",
    type = "food", subtype = "water",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 5,
    stacking = true,
    desc = [[A flask of water. Good to quench your thirst.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 100
        return {used = true, destroy = true}
  end
  },
}

--Stale foodstuffs
newEntity{
    base = "BASE_FOOD",
    name = "stale rations",
    image = "tiles/food.png",
    type = "food", subtype = "water",
    level_range = {1,10},
    cost = 2,
    stacking = true,
    desc = [[Food rations gone stale.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 0
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    base = "BASE_FOOD",
    name = "stale water",
    image = "tiles/flask.png",
    type = "food", subtype = "water",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 2,
    stacking = true,
    desc = [[You'd be better off not drinking this water.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 0
        return {used = true, destroy = true}
  end
  },
}

newEntity{
    base = "BASE_FOOD",
    name = "stale corpse",
    image = "tiles/newtiles/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    encumber = 50,
    desc = [[This corpse looks pretty stale.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 0
        return {used = true, destroy = true}
  end
  },
}