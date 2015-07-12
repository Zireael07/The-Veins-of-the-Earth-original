--Veins of the Earth
--Zireael 2015

--NOTE: maybe mining skill from Incursion?
--TODO: Seneschal skill for high-tier stuff (owning land, fortresses etc.)

newSkill{
    name = "appraise",
    desc = "Used for haggling and determining the price for your items.",
    stat = "cha",
    penalty = "no",
    background = true,
}

newSkill{
    name = "balance",
    desc = "Used for walking on dangerous terrain.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "bluff",
    desc = "Used when lying to NPCs.",
    stat = "cha",
    penalty = "no",
    background = false,
}

newSkill{
    name = "climb",
    desc = "Used for climbing over chasms.",
    stat = "str",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "concentration",
    desc = "Used when spellcasting under duress or while threatened.",
    stat = "int",
    penalty = "no",
    background = false,
}

newSkill{
    name = "craft",
    desc = "Used when crafting or repairing mundane items.",
    stat = "int",
    penalty = "no",
    background = true,
}

newSkill{
    name = "decipher script",
    desc = "Used when deciphering runes or scrolls.",
    stat = "int",
    penalty = "no",
    background = false,
}

newSkill{
    name = "diplomacy",
    desc = "Used when negotiating or persuading NPCs.",
    stat = "cha",
    penalty = "no",
    background = false,
}

newSkill{
    name = "disable device",
    desc = "Used to disable traps.",
    stat = "int",
    penalty = "no",
    background = false,
    rogue_only = true,
}

newSkill{
    name = "escape artist",
    desc = "Used to avoid being entangled or tied up.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

--what is called Animal Empathy in Incursion
newSkill{
    name = "handle animal",
    desc = "Used when dealing with animals.",
    stat = "wis",
    penalty = "no",
    background = true,
}

newSkill{
    name = "heal",
    desc = "Used to heal yourself using a healer kit.",
    stat = "wis",
    penalty = "no",
    background = false,
}

newSkill{
    name = "hide",
    desc = "Used to hide from enemies.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "intimidate",
    desc = "Used to frighten enemies or to intimidate others.",
    stat = "cha",
    penalty = "no",
    background = false,
}

--Let's make it a background skill
newSkill{
    name = "intuition",
    desc = "Used for identifying items.",
    stat = "int",
    penalty = "no",
    background = true,
}

newSkill{
    name = "jump",
    desc = "Used for clearing obstacles.",
    stat = "str",
    penalty = "yes",
    background = false,
}

--PF splits them up and some are background some are not
--Background: engineering, geography, history, nobility
--Adventuring: arcana, dungeon, local, nature, planes, religion
newSkill{
    name = "knowledge",
    desc = "Used to recall various bits of lore.",
    stat = "wis",
    penalty = "no",
    background = true,
}

newSkill{
    name = "listen",
    desc = "Used to detect enemies from a distance.",
    stat = "wis",
    penalty = "no",
    background = false,
}

newSkill{
    name = "move silently",
    desc = "Used to sneak past enemies.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "open lock",
    desc = "Used to open locks.",
    stat = "dex",
    penalty = "no",
    background = false,
}

--what is called sleight of hand in 3.5
newSkill{
    name = "pick pocket",
    desc = "Used to steal from NPCs.",
    stat = "dex",
    penalty = "yes",
    rogue_only = true,
    background = false,
}

newSkill{
    name = "ride",
    desc = "Used to ride mounts.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "search",
    desc = "Used to find traps. #STEEL_BLUE#Only rogues can find traps with a DC over 20.#LAST#",
    stat = "int",
    penalty = "no",
    background = false,
}

newSkill{
    name = "sense motive",
    desc = "Used to detect if someone is lying.",
    stat = "wis",
    penalty = "no",
    background = false,
}

newSkill{
    name = "spellcraft",
    desc = "Used to identify magical effects or spells being cast by others.",
    stat = "int",
    penalty = "no",
    background = false,
}

newSkill{
    name = "spot",
    desc = "Used to spot traps or hiding enemies.",
    stat = "wis",
    penalty = "no",
    background = false,
}

newSkill{
    name = "survival",
    desc = "Used to track, forage and to survive in the wild.",
    stat = "wis",
    penalty = "no",
    background = false,
}

newSkill{
    name = "swim",
    desc = "Used to avoid drowning in water.",
    stat = "str",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "tumble",
    desc = "Used to avoid blows.",
    stat = "dex",
    penalty = "yes",
    background = false,
}

newSkill{
    name = "use magic",
    desc = "Used to manipulate magic items.",
    stat = "int",
    penalty = "no",
    rogue_only = true,
    background = false,
}
