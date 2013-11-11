--Veins of the Earth
--Zireael

game.potion_materials = {"cloudy","hazy","metallic","milky", "misty","scincillating","shimmering","smoky","speckled","spotted","swirling","oily","opaque","pungent", "viscous"}

game.potion_colors = {"red","blue","pink","green","black","white","violet","yellow","teal","gold"}


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
            game.object_material_types["potion"]["potion"][e.name] = rng.tableRemove(game.potion_materials).." "..rng.tableRemove(game.potion_colors)
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
