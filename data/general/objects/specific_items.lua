--Veins of the Earth
--Zireael 2013-2014

--Specific magic items, such as Holy Avenger or Dragonshield

newEntity{
    define_as = "HOLY_AVENGER",
	name = "Holy Avenger",
    unided_name = "long sword",
	slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/longsword.png",
    display = "|", color=colors.SLATE,
    encumber = 4,
    rarity = 20,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An ornate sword.\n\n Damage 1d8+2. Threat range 18-20.",
    level_range = {1, 10},
--    cost = 120630,
    cost = resolvers.value{platinum=12060},
    combat = {
        dam = {1,8},
        threat = 2,
        magic_bonus = 2,
    },
    on_wear = function(self, who)
       if who.descriptor and who.descriptor.class == "Paladin" then
        self.combat.magic_bonus = 5
    end
    end,
}

newEntity{
    define_as = "DWARVEN_THROWER",
    name = "dwarven thrower",
    unided_name = "warhammer",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="hammer",
    image = "tiles/hammer.png",
    display = "\\", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    level_range = {1, 10},
--    cost = 12,
    combat = {
        dam = {1,8},
        critical = 3,
        magic_bonus = 2,
    },

    desc = "A dwarven-made metal warhammer.\n\n Damage 1d8+2. Critical x3.",
    on_wear = function(self, who)
       if who.descriptor and who.descriptor.race == "Dwarf" then
        self.combat.magic_bonus = 3
        --returning, range 3
    end
    end,
}

newEntity{
    define_as = "FLAME_TONGUE",
    name = "flame tongue",
    unided_name = "longsword",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/longsword.png",
    display = "|", color=colors.SLATE,
    encumber = 3,
    rarity = 20,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A flaming sword.\n\n Damage 1d8+1. Threat range 18-20.",
    level_range = {1, 10},
--    cost = 20715,
    cost = resolvers.value{platinum=2070},
    combat = {
        dam = {1,8},
        threat = 2,
        magic_bonus = 1,
    },
    on_wear = function(self, who)
        --1/day fiery ray 4d6
    end,
}

newEntity{
    define_as = "LUCKBLADE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="shortsword",
    image = "tiles/dagger.png",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 20,
    light = true,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "Luckblade",
    unided_name = "shortsword",
    level_range = {1, 10},
--    cost = 22010,
    cost = resolvers.value{platinum=2200},
    combat = {
        dam = {1,6},
        threat = 1,
        magic_bonus = 2,
        fortitude_save = 1,
        reflex_save = 1,
        will_save = 1,
    },
    --1/day reroll one roll

    desc = "A curved short sword.\n\n Damage 1d6+1. Threat range 19-20.",
}

newEntity{
    define_as = "NINE_LIVES",
    name = "Nine Lives Stealer",
    unided_name = "longsword",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/longsword.png",
    display = "|", color=colors.SLATE,
    encumber = 4,
    rarity = 20,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An ornate sword.\n\n Damage 1d8+2. Threat range 18-20.",
    level_range = {1, 10},
--    cost = 23060,
    cost = resolvers.value{platinum=2300},
    combat = {
        dam = {1,8},
        threat = 2,
        magic_bonus = 2,
        --on critical, Fort DC 20 or death nine times
    },
    on_wear = function(self, who)
        if who.descriptor and who.descriptor.alignment == "Lawful Good" or who.descriptor.alignment == "Neutral Good" or who.descriptor.alignment == "Chaotic Good" then
        --2 negative levels
    end

    end,
}

newEntity{
    define_as = "OATHBOW",
    name = "Oathbow",
    unided_name = "longbow",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="bow",
    display = "}", color=colors.UMBER,
    image = "tiles/longbow.png",
    encumber = 3,
    martial = true,
    unique=true,
    combat = { sound = "actions/arrow", sound_miss = "actions/arrow", },

    desc = "A white curved longbow.\n\n Damage 1d10+2. Critical x3. Range 11",
    
    rarity = 50,
    level_range = {1, 10},
--    cost = 25600,
    cost = resolvers.value{platinum=2560},
    combat = {
        dam = {1,8},
        critical = 3,
        range = 11,
        magic_bonus = 2,
        --swear to kill an enemy - magic_bonus = 5  +2d6 dmg but no magic bonus against others
    },
}

newEntity{
    define_as = "SUNBLADE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="shortsword",
    image = "tiles/dagger.png",
    display = "|", color=colors.SLATE,
    encumber = 2,
    rarity = 20,
    light = true,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "Sunblade",
    unided_name = "shortsword",
    level_range = {1, 10},
--    cost = 50335,
    cost = resolvers.value{platinum=5040},
    combat = {
        dam = {1,6},
        threat = 1,
        magic_bonus = 2,
    },
    --magic_bonus +4 against evil, double dmg against undead; 1/day daylight

    desc = "A curved short sword.\n\n Damage 1d10+2. Threat range 19-20.",
    on_wear = function(self, who)
        if who.descriptor and who.descriptor.alignment == "Lawful Evil" or who.descriptor.alignment == "Neutral Evil" or who.descriptor.alignment == "Chaotic Evil" then
        --2 negative levels
    end

    end,
}

newEntity{
    define_as = "SWORD_PLANES",
    name = "Sword of the Planes",
    unided_name = "longsword",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/longsword.png",
    display = "|", color=colors.SLATE,
    encumber = 4,
    rarity = 20,
    martial = true,
    unique=true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An ornate sword.\n\n Damage 1d8+1. Threat range 18-20.",
    level_range = {1, 10},
--    cost = 22315,
    cost = resolvers.value{platinum=2230},
    combat = {
        dam = {1,8},
        threat = 2,
        magic_bonus = 1,
        --magic_bonus = 4 against outsiders
    },
}

-- TO DO: Javelin of Lightning