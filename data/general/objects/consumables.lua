--Veins of the Earth
--Zireael 2013-2015

--Consumables
newEntity{
    define_as = "BASE_FOOD",
    slot = "INVEN",
    type = "food", subtype = "food",
    image = "tiles/object/food.png",
    display = "%", color=colors.WHITE,
    encumber = 1,
    level_range = {1,10},
    cost = 1, --1 copper
    name = "Food",
    desc = [[Some food.]],
    base_nutrition = 1500,
--    stacking = true,
}


newEntity{
    base = "BASE_FOOD",
    name = "food ration",
    image = "tiles/object/food.png",
    type = "food", subtype = "ration",
    level_range = {1,10},
    cost = 5,
    rarity = 10,
    desc = [[Food rations, enough for a day or two.]],
    stacking = true,
    nutrition = 1,
}

-- might poison non-drow
newEntity{
    base = "BASE_FOOD",
    name = "spider bread", color=colors.SANDY_BROWN,
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

--Remains fresh for 12 hours; chance for intrinsic gains
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
    freshness = 10,
--    freshness = game.calendar.HOUR*12,
    desc = [[A fresh corpse of some creature.]],
    nutrition = 0.75,
}

--Survival test to avoid poisoning; chance for intrinsic gains;
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
    freshness = game.calendar.DAY*5, --14 days to decay fully, 5 days to go stale
    desc == [[A corpse of some creature.]],
}

--Stale foodstuffs
newEntity{
    base = "BASE_FOOD",
    name = "stale rations",
    image = "tiles/object/food.png",
    type = "food", subtype = "food",
    level_range = {1,10},
    cost = 2,
    rarity = 8,
    stacking = true,
    nutrition = 0,
    desc = [[Food rations gone stale.]],
}

--No intrinsic
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
    freshness = game.calendar.DAY*9, --9 days to decay fully
    desc = [[This corpse looks pretty stale.]],
}

--From DCSS
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

--Fruits, from DCSS
newEntity{ base = "BASE_FOOD",
    define_as = "BASE_FRUIT",
    name = "fruit",
    type = "food", subtype = "fruit",
    display = "%", color=colors.WHITE,
    cost = 0,
    encumber = 0.75,
    stacking = true,
    desc = [[Some tasty fruits.]],
    rarity = 20, --underground, -10 on surface
    nutrition = 0.75, --plus some quench
}

newEntity{ base = "BASE_FRUIT",
    name = "strawberry",
    color = colors.LIGHT_RED,
}

newEntity{ base = "BASE_FRUIT",
    name = "apple",
    color = colors.DARK_GREEN,
}

newEntity{ base = "BASE_FRUIT",
    name = "apricot",
    color = colors.DARK_GREEN,
}

newEntity{ base = "BASE_FRUIT",
    name = "banana",
    color = colors.YELLOW,
}

newEntity{ base = "BASE_FRUIT",
    name = "pear",
    color = colors.YELLOW,
}

newEntity{ base = "BASE_FRUIT",
    name = "strawberry",
    color = colors.LIGHT_RED,
}

newEntity{ base = "BASE_FRUIT",
    name = "orange",
    color = colors.ORANGE,
}

--From DCSS
newEntity{ base = "BASE_FOOD",
    define_as = "HONEYCOMB",
    name = "honeycomb",
    type = "food", subtype = "bee",
    display = "%", color=colors.GOLD,
    level_range = {5,10},
    cost = 0,
    stacking = true,
    rarity = 30,
    desc = [[This is a bee product.]],
    nutrition = 1.5,
}

--Some curative properties
newEntity{ base = "HONEYCOMB",
    name = "royal jelly",
    desc = [[This is a queen bee product.]],
    nutrition = 2,
    rarity = 60,
}

--From DCSS
newEntity{ base = "BASE_FOOD",
    name = "porridge",
    display = "%", color=colors.DARK_TAN,
    nutrition = 0.75,
    encumber = 2,
    stacking = true,
    rarity = 25,
}

newEntity{ base = "BASE_FOOD",
    name = "meat rations",
    display = "%", color=colors.PINK,
    image = "tiles/object/meat_ration.png",
    nutrition = 1.5,
    stacking = true,
    desc = [[Filling rations made of meat.]],
    rarity = 15,
}

--More rations variety
newEntity{ base = "BASE_FOOD",
    name = "large rations",
    subtype = "ration",
    display = "%", color=colors.WHITE,
    nutrition = 2,
    encumber = 2,
    rarity = 20,
    desc = [[Especially large rations.]],
}

--From *band
newEntity{ base = "BASE_FOOD",
    name = "biscuit",
    image = "tiles/object/biscuit.png",
    color = colors.KHAKI,
    nutrition = 0.5,
    stacking = true,
    desc = [[Hard baked biscuits for travelers.]],
    rarity = 8,
}

newEntity{ base = "BASE_FOOD",
    name = "elven bread",
    display = "%", color=colors.LIGHT_BLUE,
    stacking = true,
    desc = [[Elf-made bread.]],
    rarity = 20,
    nutrition = 3,
}

--new
newEntity{
    base = "BASE_FOOD",
    define_as = "EDIBLE_FUNGI",
    name = "edible fungi",
    type = "food", subtype = "fungi",
    display = "%", color=colors.TAN,
    level_range = {1, 10},
    cost = 0,
    rarity = 5,
    stacking = true,
    desc = [[This is a piece of dried edible fungi.]],
    nutrition = 1,
    encumber = 0.5, --1/2 ration
}

newEntity{ base = "BASE_FOOD",
    name = "acorns",
    type = "food", subtype = "acorns",
    color=colors.DARK_UMBER,
    rarity = 30, -- on surface -10
    cost = 0,
    stacking = false,
    desc = [[Some acorns.]],
    nutrition = 0.75,
}

--DRINKS
newEntity{ base = "BASE_FOOD",
    define_as = "BASE_DRINK",
    image = "tiles/object/flask.png",
    type = "drink", subtype = "drink",
    display = "!", color=colors.AQUAMARINE,
    cost = 5,
    stacking = true,
    nutrition = 1,
}

newEntity{
    base = "BASE_DRINK",
    name = "flask of water",
    image = "tiles/new/flask_water.png",
    rarity = 8,
    cost = 5,
    desc = [[A flask of water. Good to quench your thirst.]],
}

newEntity{
    base = "BASE_DRINK",
    name = "stale water",
    rarity = 10,
    cost = 0,
    nutrition = 0,
    desc = [[You'd be better off not drinking this water.]],
}

newEntity{ base = "BASE_DRINK",
    name = "flask of wine",
    image = "tiles/object/wine.png",
    display = "!", color = colors.RED,
    rarity = 15,
    cost = 10,
    desc = [[A flask of deep red wine.]],
    nutrition = 0.75,
}

newEntity{ base = "BASE_DRINK",
    name = "mug of ale",
    image = "tiles/object/beer.png",
    display = "!", color = colors.SANDY_BROWN,
    cost = 6,
    desc = [[A mug of brownish ale.]],
    nutrition = 0.75,
    rarity = 10,
}

newEntity{ base = "BASE_DRINK",
    name = "flask of blood",
    image = "tiles/new/blood.png",
    display = "!", color = colors.CRIMSON,
    cost = 0,
    desc = [[A flask of blood.]],
    nutrition = 0, --unless vampire
    rarity = 30,
}

newEntity{ base = "BASE_DRINK",
    name = "flask of elf wine",
    image = "tiles/new/wine_elven.png",
    display = "!", color = colors.LIGHT_GREEN,
    cost = 30, --3x normal wine
    nutrition = 1,
    rarity = 20,
}

newEntity{ base = "BASE_DRINK",
    name = "flask of drow wine",
    image = "tiles/new/wine_drow.png",
    display = "!", color = colors.LIGHT_TAN,
    cost = 40, --4x normal wine
    desc = [[Drow wine, made from fermented fungi.]],
    nutrition = 1,
    rarity = 15, --underground rarity, +20 on surface
}

newEntity{ base = "BASE_DRINK",
    name = "mug of beer",
    image = "tiles/object/beer.png",
    display = "!", color = colors.YELLOW,
    cost = 4, --cheaper than water
    desc = [[A mug of beer.]],
    nutrition = 0.5,
    rarity = 8,
}

newEntity{ base = "BASE_DRINK",
    name = "cup of milk",
    display = "!", color = colors.WHITE,
    cost = 4, --as beer
    desc = [[From a cow!]],
    nutrition = 1,
    rarity = 18, --underground, -10 on surface
}

newEntity{ base = "BASE_DRINK",
    name = "cup of tea",
    display = "!", color = colors.DARK_TAN,
    cost = 10,
    desc = [[A herbal beverage.]],
    nutrition = 1,
    rarity = 25,
}

newEntity{ base = "BASE_DRINK",
    name = "cup of herbs",
    display = "!", color = colors.DARK_GREEN,
    cost = 15,
    desc = [[A mix of various herbs]],
    nutrition = 1,
    rarity = 30,
}
