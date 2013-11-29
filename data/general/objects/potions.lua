--Veins of the Earth
--Zireael

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

--game.potion_colors = {"red","blue","pink","green","black","white","violet","yellow","teal","gold"}


--Potions
newEntity{
    define_as = "BASE_POTION",
    slot = "INVEN",
    type = "potion", subtype = "potion",
    image = "tiles/potion.png",
    display = "!", color=colors.RED,
    encumber = 0,
    rarity = 5,
    name = "potion", instant_resolve = true,
    desc = [[A potion.]],
    resolvers.genericlast(function(e)
        game.object_material_types = game.object_material_types or {}
        game.object_material_types["potion"] = game.object_material_types["potion"] or {}
        game.object_material_types["potion"]["potion"] = game.object_material_types["potion"]["potion"] or {}
        if not game.object_material_types["potion"]["potion"][e.name] then
            game.object_material_types["potion"]["potion"][e.name] = rng.tableRemove(game.potion_materials)
        end
        e.unided_name = "a "..game.object_material_types["potion"]["potion"][e.name].." "..e.unided_name
    end),
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cure light wounds",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(rng.dice(1,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cure moderate wounds",
    unided_name = "potion",
    identified = false,
    level_range = {4,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(rng.dice(2,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal light wounds",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 750,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.1)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal moderate wounds",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 900,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.3)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of heal serious wounds",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 1200,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.5)
        return {used = true, destroy = true}
  end
  }, 
}


newEntity{
    base = "BASE_POTION",
    name = "a potion of inflict light wounds",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(-who.max_life*0.1)
        return {used = true, destroy = true}
 end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of bear endurance",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of bull strength",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of eagle splendor",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_EAGLE_SPLENDOR, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of owl wisdom",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_OWL_WISDOM, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of cat grace",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_CAT_GRACE, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of fox cunning",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 300,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_FOX_CUNNING, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion of mage armor",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_MAGE_ARMOR, 5, {})
        return {used = true, destroy = true}
  end
  }, 
}


newEntity{
    base = "BASE_POTION",
    name = "a potion of poison",
    unided_name = "potion",
    identified = false,
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:setEffect(who.EFF_POISON1d10CON, 6, {})
        return {used = true, destroy = true}
  end
  }, 
}
