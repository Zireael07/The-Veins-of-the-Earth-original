--Veins of the Earth
--Zireael 2013-2015

--Poison vials
newEntity{
    define_as = "BASE_VIAL",
    slot = "INVEN",
    type = "vial", subtype = "vial",
    display = "!", color=colors.SLATE,
    image = "tiles/object/poison_vial.png",
    encumber = 0,
    identified = false,
    rarity = 15,
    cost = 0,
    level_range = {5,10}, --since that's where poisons start to show up
    name = "a vial", unided_name = "a vial",
    desc = [[A vial.]],
    addons = "/data/general/objects/properties/poisons.lua",
}
