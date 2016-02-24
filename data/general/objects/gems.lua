--Veins of the Earth
--Zireael 2016

newEntity{ define_as = "BASE_GEM",
    unided_name = "gem",
    identified = false,
    level_range = {1, 10},

    slot = "INVEN",
    type = "gem", subtype = "gem",
    display = "*", color=colors.ANTIQUE_WHITE,
    image = "tiles/new/gem.png",
    encumber = 0,
    stacking = true,
    desc = [[This is a piece of polished rock, 1/4″ in diameter.]],
}

--First tier (10 gp base) 4d4 gp
newEntity{ base = "BASE_GEM",
    rarity = 2,
    name = "malachite",
    image = "tiles/new/gem_malachite.png",
    color=colors.DARK_GREEN,
    cost = resolvers.value{gold=10},
}

newEntity{ base = "BASE_GEM",
    rarity = 2,
    name = "turquoise",
    image = "tiles/new/gem_turquoise.png",
    color=colors.AQUAMARINE,
    cost = resolvers.value{gold=10},
}

newEntity{ base = "BASE_GEM",
    rarity = 2,
    name = "obsidian",
    image = "tiles/new/gem_dark.png",
    color=colors.BLACK,
    cost = resolvers.value{gold=10},
}

newEntity{ base = "BASE_GEM",
    rarity = 2,
    name = "hematite",
    image = "tiles/new/gem_neg.png",
    color=colors.SLATE,
    cost = resolvers.value{gold=10},
}

--Second tier (50 gp base) 2d4x10
newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "bloodstone",
    image = "tiles/new/gem_blood.png",
    color=colors.DARK_RED,
    cost = resolvers.value{gold=50},
}

newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "citrine",
    image = "tiles/new/gem_citrine.png",
    color=colors.YELLOW,
    cost = resolvers.value{gold=50},
}

newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "moonstone",
    image = "tiles/new/gem_moon.png",
    color=colors.LIGHT_STEEL_BLUE,
    cost = resolvers.value{gold=50},
}

newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "onyx",
    image = "tiles/new/gem_neg.png",
    color=colors.DARK_SLATE,
    cost = resolvers.value{gold=50},
}

newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "rose quartz",
    image = "tiles/new/gem_rose.png",
    color=colors.PINK,
    cost = resolvers.value{gold=50},
}

newEntity{ base = "BASE_GEM",
    rarity = 5,
    name = "clear quartz",
    image = "tiles/new/gem_clear.png",
    color=colors.LIGHT_SLATE,
    cost = resolvers.value{gold=50},
}

--Third tier (100 gp base) 4d4x10
newEntity{ base = "BASE_GEM",
    rarity = 10,
    name = "amber",
    image = "tiles/new/gem_amber.png",
    color=colors.YELLOW,
    cost = resolvers.value{gold=100},
}

newEntity{ base = "BASE_GEM",
    rarity = 10,
    name = "amethyst",
    image = "tiles/new/gem_amethyst.png",
    color=colors.VIOLET,
    cost = resolvers.value{gold=100},
}

newEntity{ base = "BASE_GEM",
    rarity = 10,
    name = "jade",
    image = "tiles/new/gem_jade.png",
    color=colors.TEAL,
    cost = resolvers.value{gold=100},
}

newEntity{ base = "BASE_GEM",
    rarity = 10,
    name = "coral",
    image = "tiles/new/gem_coral.png",
    color=colors.CRIMSON,
    cost = resolvers.value{gold=100},
}

newEntity{ base = "BASE_GEM",
    rarity = 10,
    name = "garnet",
    image = "tiles/new/gem_garnet.png",
    color=colors.FIREBRICK,
    cost = resolvers.value{gold=100},
}

--Fourth tier (500 gp base) 2d4x100
newEntity{ base = "BASE_GEM",
    rarity = 15,
    name = "aquamarine",
    image = "tiles/new/gem_aqua.png",
    color=colors.LIGHT_STEEL_BLUE,
    cost = resolvers.value{gold=500},
}

newEntity{ base = "BASE_GEM",
    rarity = 15,
    name = "topaz",
    image = "tiles/new/gem_topaz.png",
    color=colors.GOLD,
    cost = resolvers.value{gold=500},
}

newEntity{ base = "BASE_GEM",
    rarity = 15,
    name = "alexandrite",
    image = "tiles/new/gem_orchid.png",
    color=colors.DARK_ORCHID,
    cost = resolvers.value{gold=500},
}

--Fifth tier (1000 gp base) 4d4x100
newEntity{ base = "BASE_GEM",
    rarity = 25,
    name = "emerald",
    image = "tiles/new/gem_emerald.png",
    color=colors.LIGHT_GREEN,
    cost = resolvers.value{gold=1000},
}

newEntity{ base = "BASE_GEM",
    rarity = 25,
    name = "sapphire",
    image = "tiles/new/gem_blue.png",
    color=colors.DARK_BLUE,
    cost = resolvers.value{gold=1000},
}

newEntity{ base = "BASE_GEM",
    rarity = 25,
    name = "black star sapphire",
    color=colors.DARK_SLATE,
    image = "tiles/new/gem_neg.png",
    cost = resolvers.value{gold=1000},
}

newEntity{ base = "BASE_GEM",
    rarity = 25,
    name = "star ruby",
    image = "tiles/new/gem_starruby.png",
    color=colors.DARK_RED,
    cost = resolvers.value{gold=1000},
}

--Top tier (5000 gp base) 2d4x1000
newEntity{ base = "BASE_GEM",
    rarity = 25,
    name = "diamond",
    color=colors.ANTIQUE_WHITE,
    cost = resolvers.value{gold=5000},
}

newEntity{ base = "BASE_GEM",
    rarity = 35,
    name = "jacinth",
    image = "tiles/new/gem_orange.png",
    color=colors.ORANGE,
    cost = resolvers.value{gold=5000},
}
