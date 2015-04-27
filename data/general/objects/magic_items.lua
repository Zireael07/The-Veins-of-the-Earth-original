--Veins of the Earth
-- Zireael 2013-2014

local Talents = require "engine.interface.ActorTalents"

--Potions
game.potion_materials = {}

local potion_cloudy = {"cloudy", "cloudy red", "cloudy blue", "cloudy pink", "cloudy green", "cloudy black", "cloudy white", "cloudy violet", "cloudy yellow", "cloudy teal", "cloudy gold"}
local potion_hazy = {"hazy", "hazy red", "hazy blue", "hazy pink", "hazy green", "hazy black", "hazy white", "hazy violet", "hazy yellow", "hazy teal", "hazy gold"}
local potion_metallic = {"metallic", "metallic red", "metallic blue", "metallic pink", "metallic green", "metallic black", "metallic white", "metallic violet", "metallic yellow", "metallic teal", "metallic gold"}
local potion_milky = {"milky", "milky red", "milky blue", "milky pink", "milky green", "milky black", "milky white", "milky violet", "milky yellow", "milky teal", "milky gold"}
local potion_misty = {"misty", "misty red", "misty blue", "misty pink", "misty green", "misty black", "misty white", "misty violet", "misty yellow", "misty teal", "misty gold"}
local potion_scin = {"scincillating"}
local potion_shimmer = {"shimmering", "shimmering red", "shimmering blue", "shimmering pink", "shimmering green", "shimmering black", "shimmering white", "shimmering violet", "shimmering yellow", "shimmering teal", "shimmering gold"}
local potion_smoky = {"smoky", "smoky red", "smoky blue", "smoky pink", "smoky green", "smoky black", "smoky white", "smoky violet", "smoky yellow", "smoky teal", "smoky gold"}
local potion_speckled = {"speckled", "speckled red", "speckled blue", "speckled pink", "speckled green", "speckled black", "speckled white", "speckled violet", "speckled yellow", "speckled teal", "speckled gold"}
local potion_spotted = { "spotted", "spotted red", "spotted blue", "spotted pink", "spotted green", "spotted black", "spotted white", "spotted violet", "spotted yellow", "spotted teal", "spotted gold"}
local potion_swirl = {"swirling", "swirling red", "swirling blue", "swirling pink", "swirling green", "swirling black", "swirling white", "swirling violet", "swirling yellow", "swirling teal", "swirling gold"}
local potion_oil = {"oily", "oily red", "oily blue", "oily pink", "oily green", "oily black", "oily white", "oily violet", "oily teal", "oily gold"}
local potion_opaque = {"opaque", "opaque red", "opaque blue", "opaque pink", "opaque green", "opaque black", "opaque white", "opaque violet", "opaque teal", "opaque gold"}
local potion_pungent = {"pungent", "pungent green"}
local potion_viscous = {"viscous", "viscous red", "viscous blue", "viscous pink", "viscous green", "viscous black", "viscous white", "viscous violet", "viscous teal", "viscous gold"}

table.append(game.potion_materials, potion_cloudy)
table.append(game.potion_materials, potion_hazy)
table.append(game.potion_materials, potion_metallic)
table.append(game.potion_materials, potion_milky)
table.append(game.potion_materials, potion_misty)
table.append(game.potion_materials, potion_scin)
table.append(game.potion_materials, potion_shimmer)
table.append(game.potion_materials, potion_smoky)
table.append(game.potion_materials, potion_speckled)
table.append(game.potion_materials, potion_spotted)
table.append(game.potion_materials, potion_swirl)
table.append(game.potion_materials, potion_oil)
table.append(game.potion_materials, potion_opaque)
table.append(game.potion_materials, potion_pungent)
table.append(game.potion_materials, potion_viscous)

newEntity{
    define_as = "BASE_POTION",
    slot = "INVEN",
    type = "potion", subtype = "potion",
    image = "tiles/potion.png",
    display = "!", color=colors.RED,
    name = "potion", instant_resolve = true,
    unided_name = "potion",
    identified = false,
    cost = 0,
    level_range = {1,10},
    encumber = 0,
    rarity = 5,
    desc = [[A potion.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/potions.lua", egos_chance = {suffix=100},
--[[    resolvers.genericlast(function(e)
        game.object_material_types = game.object_material_types or {}
        game.object_material_types["potion"] = game.object_material_types["potion"] or {}
        game.object_material_types["potion"]["potion"] = game.object_material_types["potion"]["potion"] or {}
        if not game.object_material_types["potion"]["potion"][e.name] then
            game.object_material_types["potion"]["potion"][e.name] = rng.tableRemove(game.potion_materials)
        end
        e.unided_name = "a "..game.object_material_types["potion"]["potion"][e.name].." "..e.unided_name
    end),]]
}

--Mushrooms (should give nutrition in addition to potion effects)
newEntity{
    define_as = "BASE_MUSHROOM",
    slot = "INVEN",
    type = "potion", subtype = "mushroom",
    image = "tiles/mushroom_yellow.png",
    display = ",", color=colors.YELLOW,
    name = "mushroom", --instant_resolve = true,
    unided_name = "mushroom",
    identified = false,
    cost = 0,
    level_range = {1,10},
    encumber = 0,
    rarity = 10,
    desc = [[An edible mushroom.]],
    egos = "/data/general/objects/properties/potions.lua", egos_chance = {suffix=100},
}

--Tattoos
newEntity{
    define_as = "BASE_TATTOO",
    slot = "INVEN",
    name = "tattoo",
    unided_name = "tattoo",
    identified = false,
    cost = 0,
    level_range = {1,10},
    rarity = 10,
    type = "scroll", subtype = "tattoo",
    display = "?", color=colors.RED,
    encumber = 0,
    desc = [[A tattoo.]],
}

--Rods
newEntity{
    define_as = "BASE_ROD",
    slot = "INVEN",
    name = "rod",
    unided_name = "rod",
    identified = false,
    cost = 0,
    level_range = {1,10},
    rarity = 10,
    slot = "INVEN",
    type = "wand", subtype = "rod",
    image = "tiles/wand.png",
    display = "-", color=colors.GREEN,
    encumber = 0,
    desc = [[A rod.]],
}



--Charged items
newEntity{
    define_as = "BASE_WAND",
    name = "wand",
    unided_name = "wand",
    identified = false,
    level_range = {1,10},
    cost = 10,
    rarity = 2,
    slot = "INVEN",
    type = "wand", subtype = "wand",
    image = "tiles/wand.png",
    display = "-", color=colors.RED,
    encumber = 0,
    multicharge = 50,
    desc = [[A wand.]],
    egos = "/data/general/objects/properties/charged.lua", egos_chance = {suffix=100},
}

game.scroll_materials = {"abbil", "abban","alae","alartae","akh","belbau","belbol","bol","dro","dalharil","dalharuk","dalninil","dalninuk","dhaerow","dobluth","darthiir","faer","faern","hargluk","harl","harluth","Har'oloth","ilhar","ilharn","ilythiiri","jal","malla","maglust","natha","obsul","orbb","phor","pholor","phuul","plynn","qu'ellar","rivvil", "rivvin","ssin'urn","ssussun","xun","xundus","tagnik", "tagnik'zur","tluth","ulartae","valsharess","veldruk", "veldriss", "veldrin","z'ress" }

newEntity{
    define_as = "BASE_SCROLL",
    name = "scroll", instant_resolve = true,
    unided_name = "scroll",
    identified = false,
    level_range = {1, 10},
    rarity = 2,
    cost = 50,
    slot = "INVEN",
    type = "scroll", subtype = "scroll",
    image = "tiles/scroll.png",
    display = "?", color=colors.WHITE,
    encumber = 0,
    multicharge = 50,
    desc = [[A scroll.]],
    egos = "/data/general/objects/properties/charged.lua", egos_chance = {suffix=100},
    resolvers.genericlast(function(e)
        game.object_material_types = game.object_material_types or {}
        game.object_material_types["scroll"] = game.object_material_types["scroll"] or {}
        game.object_material_types["scroll"]["scroll"] = game.object_material_types["scroll"]["scroll"] or {}
        if not game.object_material_types["scroll"]["scroll"][e.name] then
            game.object_material_types["scroll"]["scroll"][e.name] = rng.tableRemove(game.scroll_materials)
        end
        e.unided_name = e.unided_name.." labeled "..game.object_material_types["scroll"]["scroll"][e.name]
    end),
}
