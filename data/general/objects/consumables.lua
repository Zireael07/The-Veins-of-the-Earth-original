--Veins of the Earth
--Zireael

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
    name = "food rations",
    image = "tiles/food.png",
    level_range = {1,10},
    cost = 7,
    desc = [[Food rations, enough for a day or two.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 20
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_FOOD",
    name = "spider bread", color=colors.BROWN,
    image = "tiles/food.png",
    level_range = {1,10},
    cost = 15,
    desc == [[Spider bread, a favorite of the dark elves.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 15
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_FOOD",
    name = "beef jerky", color=colors.RED,
    image = "tiles/meat.png",
    level_range = {1,10},
    cost = 10,
    desc = [[Beef jerky. Spoils slowly.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 15
        return {used = true, destroy = true}
  end
  }, 
}
--Remains fresh for 10 turns
newEntity{
    base = "BASE_FOOD",
    name = "fresh corpse", color=colors.GREEN,
    image = "tiles/corpse.png",
    level_range = {1,10},
    cost = 0,
    desc = [[A fresh corpse of some creature.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 10
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_FOOD",
    name = "corpse", color=colors.RED,
    image = "tiles/corpse.png",
    level_range = {1,10},
    cost = 0,
    nutrition = 6,
    desc == [[A corpse of some creature.]],
    use_simple = { name = "eat",
    use = function(self,who)
        who.nutrition = who.nutrition + 6
        return {used = true, destroy = true}
  end
  }, 
}

--Drinks
newEntity{
    base = "BASE_FOOD",
    name = "flask of water",
    image = "tiles/flask.png",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 7,
    quench = 20,
    desc = [[A flask of water. Good to quench your thirst.]],
}

--Stale foodstuffs
newEntity{
    base = "BASE_FOOD",
    name = "stale rations",
    image = "tiles/food.png",
    level_range = {1,10},
    cost = 7,
    nutrition = 0,
    desc = [[Food rations gone stale.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale water",
    image = "tiles/flask.png",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 7,
    quench = 0,
    desc = [[You'd be better off not drinking this water.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale corpse",
    image = "tiles/corpse.png",
    level_range = {1,10},
    cost = 0,
    nutrition = 0,
    desc = [[This corpse looks pretty stale.]],
}