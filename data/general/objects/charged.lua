--Veins of the Earth
-- Zireael

local Talents = require "engine.interface.ActorTalents"

--Wands
newEntity{
    define_as = "BASE_WAND",
    slot = "INVEN", 
    type = "wand", subtype = "wand",
    image = "tiles/wand.png",
    display = "-", color=colors.RED,
    encumber = 0,
    rarity = 20,
    multicharge = 50,
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
    max_power = 50,
    power_regen = 0,
    use_talent = {id = Talents.T_MAGIC_MISSILE, level = 1, power = 1 },
--    use_simple = { name = "magic missile",
 --   use = function(self,t)
--    local tg = self:getTalentTarget(t)
--        local x, y = self:getTarget(tg)
--        local _ _, _, _, x, y = self:canProject(tg, x, y)
--        if not x or not y then return nil end

--        local damage = rng.dice(1,4)+1

--        self:projectile(tg, x, y, DamageType.FORCE, damage)    
-- end
}

newEntity{
    base = "BASE_WAND",
    name = "wand of bear endurance",
    unided_name = "a wand",
    identified = false,
    level_range = {1,10},
    cost = 4500,
    max_power = 50,
    power_regen = 0,
    use_talent = { id= Talents.T_BEAR_ENDURANCE, level = 2, power = 1 },
--    use_simple = { name = "bear endurance",
--    use = function(self, who)
--    who:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
--    return {used = true, destroy = true}
--end
--},
}

--Scrolls
newEntity{
    define_as = "BASE_SCROLL",
    slot = "INVEN", 
    type = "scroll", subtype = "scroll",
    image = "tiles/scroll.png",
    display = "?", color=colors.WHITE,
    encumber = 0,
    rarity = 20,
    multicharge = 50,
    name = "A scroll",
    desc = [[A scroll.]],
}

newEntity{
    base = "BASE_SCROLL",
    name = "scroll of magic missile",
    unided_name = "a scroll",
    identified = false,
    level_range = {1, 10},
    cost = 4500,
    max_power = 50,
    power_regen = 0,
    use_talent = { id = Talents.T_MAGIC_MISSILE, level = 1, power = 1},
}

newEntity{
    base = "BASE_SCROLL",
    name = "scroll of bear endurance",
    unided_name = "a scroll",
    identified = false,
    level_range = {1,10},
    cost = 4500,
    max_power = 50,
    power_regen = 0,
    use_talent = { id = Talents. T_BEAR_ENDURANCE, level = 2, power = 1}
--    use_simple = { name = "bear endurance",
--    use = function(self, who)
--    who:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
--    return {used = true, destroy = true}
--end
--},
}