--Veins of the Earth
-- Zireael

--TO DO: Make it work using use_talent

local Talents = require "engine.interface.ActorTalents"

--Wands
newEntity{
    define_as = "BASE_WAND",
    slot = "INVEN", 
    type = "wand", subtype = "wand",
    image = "tiles/wand.png",
    display = "-", color=colors.RED,
    encumber = 0,
    name = "A wand",
    desc = [[A wand.]],
}

newEntity{
    base = "BASE_WAND",
    name = "wand of magic missile",
    unided_name = "a wand",
    identified = false,
    level_range = {1,10},
    cost = 4500,
    rarity = 20,
 --[[   max_power = 50,
    power_regen = 1,
    use_talent = {id = Talents.T_MAGIC_MISSILE, level = 1, power = 1 },]]
    multicharge = 50,
    use_simple = { name = "magic missile",
    use = function(self,t)
        local tg = {type="bolt", range=5, talent=t, display={display='*',color=colors.ORCHID}}
        local x, y = self:getTarget(tg)
        local _ _, _, _, x, y = self:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        self:projectile(tg, x, y, DamageType.FORCE, damage)    
end
},
}

newEntity{
    base = "BASE_WAND",
    name = "wand of bear endurance",
    unided_name = "a wand",
    identified = false,
    level_range = {1,10},
    cost = 4500,
    rarity = 20,
--[[    max_power = 50,
    power_regen = 1,
    use_talent = { id= Talents.T_BEAR_ENDURANCE, level = 2, power = 1 },]]
    use_simple = { name = "bear endurance",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    return {used = true, destroy = true}
end
},
}

game.scroll_materials = {"abbil", "abban","alae","alartae","akh","belbau","belbol","bol","dro","dalharil","dalharuk","dalninil","dalninuk","dhaerow","dobluth","darthiir","faer","faern","hargluk","harl","harluth","Har'oloth","ilhar","ilharn","ilythiiri","jal","malla","maglust","natha","obsul","orbb","phor","pholor","phuul","plynn","qu'ellar","rivvil", "rivvin","ssin'urn","ssussun","xun","xundus","tagnik", "tagnik'zur","tluth","ulartae","valsharess","veldruk", "veldriss", "veldrin","z'ress" }

--Scrolls
newEntity{
    define_as = "BASE_SCROLL",
    slot = "INVEN", 
    type = "scroll", subtype = "scroll",
    image = "tiles/scroll.png",
    display = "?", color=colors.WHITE,
    encumber = 0,
--    multicharge = 50,
    name = "a scroll", instant_resolve = true,
    desc = [[A scroll.]],
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

newEntity{
    base = "BASE_SCROLL",
    name = "scroll of magic missile",
    unided_name = "a scroll",
    identified = false,
    level_range = {1, 10},
    cost = 4500,
    rarity = 2,
--[[    max_power = 50,
    power_regen = 1,
    use_talent = { id = Talents.T_MAGIC_MISSILE, level = 1, power = 1},]]
    multicharge = 50,
    use_simple = { name = "magic missile",
    use = function(self,t)
    local tg = {type="bolt", range=5, talent=t, display={display='*',color=colors.ORCHID}}
        local x, y = self:getTarget(tg)
        local _ _, _, _, x, y = self:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        self:projectile(tg, x, y, DamageType.FORCE, damage)    
end
},
}

newEntity{
    base = "BASE_SCROLL",
    name = "scroll of bear endurance",
    unided_name = "a scroll",
    identified = false,
    level_range = {1,10},
    cost = 4500,
    rarity = 2,
--[[    max_power = 50,
    power_regen = 1,
    use_talent = { id = Talents. T_BEAR_ENDURANCE, level = 2, power = 1}]]
    multicharge = 50,
    use_simple = { name = "bear endurance",
    use = function(self, who)
       who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    return {used = true, destroy = true}
end
},
}