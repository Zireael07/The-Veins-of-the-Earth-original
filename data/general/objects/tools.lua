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
    desc = [[This is a wooden case, about a foot long and same wide, and half that in thickness.]],
}

--Can't heal without it?
newEntity{
    base = "BASE_TOOL",
    name = "healing kit",
    level_range = {1,10},
    desc = [[This wooden case, about a foot long and same wide, and half that in thickness, snaps open to reveal a wide
      variety of bandages, scalpels, ointments, antitoxins, disinfectants and alchemical medications.]],
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

newEntity{
    base = "BASE_TOOL",
    name = "climbing kit",
    level_range = {1, 10},
    cost = resolvers.value{silver=30},
    desc = [[This heavy leather pouch includes special tools for knotting rope, pitons, a climbing harness, suction cups for smooth surfaces and other equipment useful to climbers.]],
    wielder = {
        skill_bonus_climb = 4,
    }
}

--Can't Perform without one of these
newEntity{
    base = "BASE_TOOL",
    name = "lute",
    cost = resolvers.value{gold=7},
    desc = [[This is a musical instrument a bard might use when performing.]],
    wielder = {
        skill_bonus_perform = 2,
    }
}

newEntity{
    base = "BASE_TOOL",
    name = "mandolin",
    cost = resolvers.value{gold=30},
    desc = [[This is a musical instrument a bard might use when performing.]],
    wielder = {
        skill_bonus_perform = 2,
    }
}

newEntity{
    base = "BASE_TOOL",
    name = "flute",
    cost = resolvers.value{silver=2},
    desc = [[This is a musical instrument a bard might use when performing.]],
    wielder = {
        skill_bonus_perform = 2,
    }
}

newEntity{
    base = "BASE_TOOL",
    name = "horn",
    cost = resolvers.value{silver=5},
    desc = [[Horns come in all shapes and sizes, and are often associated with the nobility. Some are enchanted to produce a magical effect when blown (activated).]],
    wielder = {
        skill_bonus_perform = 2,
    }
}

--Secondary bonus to Search, Decipher Script, Craft, Handle Device that stacks
newEntity{
    base = "BASE_TOOL",
    name = "viewing lens",
    level_range = {1, 10},
    cost = resolvers.value{gold=300},
    desc = [[As much a sign of nobility as fine clothing or servants, a viewing lens is an expertly manufactured concave glass that
      magnifies whatever is seen through it. The level of skill as a glassblower needed to create such a finely-crafted item is
      rare on Theyra, making it a valuable tool drawing high prices from specialists in many fields.
      It is thus highly useful when using the Search, Decipher Script, Craft or Handle Device skills,]],
    wielder = {
        skill_bonus_search = 2,
        skill_bonus_craft = 2,
        skill_bonus_handledevice = 2,
    }
}

--Can't Craft without it
newEntity{
    base = "BASE_TOOL",
    name = "craftsman's tools",
    level_range = {1, 10},
    cost = resolvers.value{silver=120},
    desc = [[The craftsman's tool set consists of a dozen different miniature hammers, picks and bevels, needles and thread,
      tiny tubes of glue and grease, files for use on metal and wood-carving knives and various ungents and oils used to
      treat and smooth surfaces and clear away rust.]],
}

--Can't Handle device without it
newEntity{
    base = "BASE_TOOL",
    name = "mechanical tools",
    level_range = {1, 10},
    cost = resolvers.value{silver=150},
    desc = [[This tiny steel snap-case contains a number of miniature screwdrivers, replacement gears, long-spoon
      wire cutters and so forth. It is useful for anyone building or repairing clockwork devices -- and is thus
      of primary important to gnomes -- and also to adventurers who want to be able to disarm traps in a dungeon.]],
}

--Can't Disguise without it
newEntity{
    base = "BASE_TOOL",
    name = "disguise kit",
    level_range = {1, 10},
    cost = resolvers.value{silver=150},
    desc = [[This wooden case, about a foot long and same wide, and half that in thickness, snaps open to reveal a wide
      variety of dyes, makeup, contact lenses, prosthetics, mirrors and straps. It also contains a wide variety of
      clothing bearing a minor magical enchantment that allows it to occupy far less space then it normally would.]],
}


--For when I figure out how to do alchemy
newEntity{
    base = "BASE_TOOL",
    name = "alchemy set",
    cost = resolvers.value{gold=500},
    level_range = {1, 10},
    desc = [[An alchemy set is a heavy wooden box about the size of a briefcase, filled with a variety of reagents along with glassware,
      miniature burners, testing strips and magical measuring instruments.
      It also contains fold-out charts describing elemental correspondances and literally hundres of strange powders and ingredients.]],
}
