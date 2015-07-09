--Veins of the Earth
--Zireael 2013-2015

--Consumables
newEntity{
    define_as = "BASE_FOOD",
    slot = "INVEN",
    type = "food",
    image = "tiles/object/food.png",
    display = "%", color=colors.WHITE,
    encumber = 0,
    name = "Food",
    desc = [[Some food.]],
    base_nutrition = 1500,
--    stacking = true,
}


newEntity{
    base = "BASE_FOOD",
    name = "food ration",
    image = "tiles/object/food.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 5,
    rarity = 10,
    desc = [[Food rations, enough for a day or two.]],
    stacking = true,
    nutrition = 1,
}

newEntity{
    base = "BASE_FOOD",
    name = "spider bread", color=colors.BROWN,
    image = "tiles/object/food.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 15,
    rarity = 15,
    desc == [[Spider bread, a favorite of the dark elves.]],
    stacking = true,
    nutrition = 1,
}

newEntity{
    base = "BASE_FOOD",
    name = "beef jerky", color=colors.RED,
    image = "tiles/object/meat.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 10,
    rarity = 18,
    stacking = true,
    desc = [[Beef jerky. Spoils slowly.]],
    nutrition = 1.5,
}
--Remains fresh for 10 turns
newEntity{ define_as = "FRESH_CORPSE",
    base = "BASE_FOOD",
    name = "fresh corpse", color=colors.GREEN,
    image = "tiles/new/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    stacking = false,
    rarity = 14,
    encumber = 50,
    desc = [[A fresh corpse of some creature.]],
    nutrition = 0.75,
}

newEntity{ define_as = "CORPSE",
    base = "BASE_FOOD",
    name = "corpse", color=colors.RED,
    image = "tiles/new/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    stacking = false,
    rarity = 8,
    nutrition = 0.5,
    encumber = 50,
    desc == [[A corpse of some creature.]],
}

--Drinks
newEntity{
    base = "BASE_FOOD",
    name = "flask of water",
    image = "tiles/object/flask.png",
    type = "food", subtype = "water",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    rarity = 8,
    cost = 5,
    stacking = true,
    nutrition = 1,
    desc = [[A flask of water. Good to quench your thirst.]],
}

--Stale foodstuffs
newEntity{
    base = "BASE_FOOD",
    name = "stale rations",
    image = "tiles/object/food.png",
    type = "food", subtype = "water",
    level_range = {1,10},
    cost = 2,
    rarity = 8,
    stacking = true,
    nutrition = 0,
    desc = [[Food rations gone stale.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale water",
    image = "tiles/object/flask.png",
    type = "food", subtype = "water",
    display = "%", color=colors.AQUAMARINE,
    level_range = {1,10},
    cost = 2,
    rarity = 8,
    stacking = true,
    nutrition = 0,
    desc = [[You'd be better off not drinking this water.]],
}

newEntity{
    base = "BASE_FOOD",
    name = "stale corpse",
    image = "tiles/new/corpse.png",
    type = "food", subtype = "corpse",
    level_range = {1,10},
    cost = 0,
    stacking = false,
    rarity = 8,
    encumber = 50,
    nutrition = 0,
    desc = [[This corpse looks pretty stale.]],
}

newEntity{ base = "BASE_FOOD",
    define_as = "BASE_CHUNK",
    name = "chunk of meat",
    image = "tiles/object/meat.png",
    type = "food", subtype = "meat",
    level_range = {1, 10},
    cost = 0,
    rarity = 10,
    stacking = true,
    desc = [[This is a chunk of meat.]],
    encumber = 10, --eyeballed
    nutrition = 0.18, --1/6 corpse nutrition
}

newEntity{
    base = "BASE_CHUNK",
    name = "chunk of stale meat",
    desc = [[This is a chunk of stale meat.]],
    rarity = 12,
    nutrition = 0,
}
