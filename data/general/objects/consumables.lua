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
    name = "a potion of heal light wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal light wounds",
    use = function(self,who)
        who:heal(rng.dice(1,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal moderate wounds",
    unided_name = "a potion",
    identified = false,
    level_range = {4,10},
    cost = 300,
    use_simple = { name = "heal moderate wounds",
    use = function(self,who)
        who:heal(rng.dice(2,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

--Consumables
newEntity{
    define_as = "BASE_FOOD",
    slot = "INVEN",
    type = "food",
    display = "%", color=colors.WHITE,
    encumber = 0,
    rarity = 8,
    name = "Food",
    desc = [[Some food.]],
}


newEntity{
    base = "BASE_FOOD",
    name = "food rations",
    level_range = {1,10},
    cost = 7,
    nutrition = 20,
    desc = [[Food rations, enough for a day or two.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "spider bread", color=colors.BROWN,
    level_range = {1,10},
    cost = 15,
    nutrition = 15,
    desc == [[Spider bread, a favorite of the dark elves.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "beef jerky", color=colors.RED,
    level_range = {1,10},
    cost = 10,
    nutrition = 15,
    desc = [[Beef jerky. Spoils slowly.]],
}
--Remains fresh for 10 turns
newEntity{
    base = "BASE_FOOD",
    name = "fresh corpse", color=colors.GREEN,
    level_range = {1,10},
    cost = 0,
    nutrition = 10,
    desc = [[A fresh corpse of some creature.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "corpse", color=colors.RED,
    level_range = {1,10},
    cost = 0,
    nutrition = 6,
    desc == [[A corpse of some creature.]],
}

--Drinks
newEntity{
    base = "BASE_FOOD",
    name = "flask of water",
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
    level_range = {1,10},
    cost = 7,
    nutrition = 0,
    desc = [[Food rations gone stale.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale water",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 7,
    quench = 0,
    desc = [[You'd be better off not drinking this water.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale corpse",
    level_range = {1,10},
    cost = 0,
    nutrition = 0,
    desc = [[This corpse looks pretty stale.]],
}