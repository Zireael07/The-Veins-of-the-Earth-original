--Veins of the Earth
--Zireael 2013-2014

--Tools or kits
newEntity{
    define_as = "BASE_TOOL",
    slot = "TOOL",
    type = "tool", subtype = "skill",
    image = "tiles/kit.png",
    display = "^", color=colors.YELLOW,
    encumber = 1,
    rarity = 10,
--    cost = 100,
    cost = resolvers.value{silver=25},
    name = "tool kit",
    desc = [[tool kit.]],
}

newEntity{
    base = "BASE_TOOL",
    name = "healing kit",
    level_range = {1,10},
    wielder = {
    skill_bonus_heal = 2
  }, 
}

newEntity{
    base = "BASE_TOOL",
    name = "lockpicking kit",
    level_range = {1,10},
    wielder = {
    skill_bonus_openlock = 2
  }, 
}

newEntity{
    base = "BASE_TOOL",
    name = "survival kit",
    level_range = {1,10},
    wielder = {
    skill_bonus_survival = 2
  }, 
}