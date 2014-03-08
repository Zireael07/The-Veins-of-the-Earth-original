-- Veins of the Earth
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

 require "engine.class"
require "engine.Object"
require "engine.interface.ObjectActivable"
require "engine.interface.ObjectIdentify"

local Stats = require("engine.interface.ActorStats")
local Talents = require("engine.interface.ActorTalents")
local DamageType = require("engine.DamageType")

module(..., package.seeall, class.inherit(
    engine.Object,
    engine.interface.ObjectActivable,
    engine.interface.ObjectIdentify,
    engine.interface.ActorTalents,
    engine.interface.ActorInventory
))

function _M:init(t, no_default)
    t.encumber = t.encumber or 0

    engine.Object.init(self, t, no_default)
    engine.interface.ObjectActivable.init(self, t)
    engine.interface.ObjectIdentify.init(self, t)
    engine.interface.ActorTalents.init(self, t)
    --Inventory!
    engine.interface.ActorInventory.init(self, t)
end

function _M:canAct()
    if self.power_regen or self.use_talent then return true end
    return false
end

function _M:act()
    self:regenPower()
    self:cooldownTalents()
    self:useEnergy()
end

function _M:use(who, typ, inven, item)
    inven = who:getInven(inven)
    if self:wornInven() and not self.lost == "INVEN" and not self.wielded and not self.use_no_wear then
        game.logPlayer(who, "You must wear this object to use it!")
        return
    end

    local types = {}
    if self:canUseObject() then types[#types+1] = "use" end

    if not typ and #types == 1 then typ = types[1] end

    if typ == "use" then
        local ret = {self:useObject(who, inven, item)}
        if ret[1] then
            if self.use_sound then game:playSoundNear(who, self.use_sound) end
            who:useEnergy(game.energy_to_act * (inven.use_speed or 1))
        end
        return unpack(ret)
    end
end 

function _M:descAttribute(attr)
    if attr == "STATBONUS" then
        local stat, i = next(self.wielder.inc_stats)
        return i > 0 and "+"..i or tostring(i)
    elseif attr == "RESIST" then
        local stat, i = next(self.wielder.resists)
        return (i and i > 0 and "+"..i or tostring(i))
    elseif attr == "COMBAT_AMMO" then
        local c = self.combat
        return c.capacity
    end
end

--- Gets the full name of the object
function _M:getName(t)
    t = t or {}
    local qty = self:getNumber()
    local name = self.name

    if self.identified == false and not t.force_id and self:getUnidentifiedName() then name = self:getUnidentifiedName() end
    
    --Display ammo capacity correctly
    if self.combat and self.combat.capacity then
        name = name.." ("..self.combat.capacity..")"
    end


    --Does this even work?
    name = name:gsub("~", ""):gsub("&", "a"):gsub("#([^#]+)#", function(attr)
        return self:descAttribute(attr)
    end)

    if not t.no_add_name and self.add_name and self:isIdentified() then
    name = name .. self.add_name:gsub("#([^#]+)#", function(attr)
            return self:descAttribute(attr)
        end)
    end


    if qty == 1 or t.no_count then return name
    else return qty.." "..name
    end
end

--[[ 
    --Describing special materials    
    if self.keywords then
    if self.keywords.mithril and self.identified == true then str = str.."\n#GOLD#This armor is made of mithril, reducing the armor check penalty by 3 and spell failure chance by 10% and increasing max Dex bonus to AC by 2." end
    if self.keywords.adamantine and self.identified == true then str = str.."\n#GOLD#This armor is made of adamantine, reducing damage taken by 1 and armor check penalty by 1." end
    if self.keywords.dragonhide and self.identified == true then str = str.."\n#GOLD#This armor is made of dragonhide, giving the wearer fire resistance 20 and reducing the armor check penalty by 1." end
    if self.keywords.darkwood and self.identified == true then str = str.."\n#GOLD#This shield is made of darkwood, reducing armor check penalty by 2" end
  ]]


--- Gets the full textual desc of the object without the name and requirements
function _M:getTextualDesc()
    local desc = tstring{}

    desc:add(true)

    
   
    if self.multicharge and self:isIdentified() then desc:add(("%d charges remaining."):format(self.multicharge or 0), true) end
        
        --General stuff to be shown always
        if self.desc then desc:add(self.desc) end
        
        if self.slot_forbid == "OFFHAND" then desc:add("You must wield this weapon with two hands.", true) end
        if self.light then desc:add("This is a light weapon", true) end
        if self.martial then desc:add("This is a martial weapon", true) end
        if self.simple then desc:add("This is a simple weapon", true) end
        if self.reach then desc:add("This is a reach weapon", true) end
        if self.exotic then desc:add("This is an exotic weapon", true) end

    if self:isIdentified() then
           if self.wielder then
            desc:add({"color","SANDY_BROWN"}, "\nWhen equipped:", {"color", "LAST"}, true)

        local desc_wielder = function(w)
            if w.skill_bonus_hide then desc:add(("#GOLD#This armor grants a +%d bonus to Hide skill."):format(w.skill_bonus_hide or 0), true) end
            if w.skill_bonus_movesilently then desc:add(("#GOLD#This armor grants a +%d bonus to Move Silently skill."):format(w.skill_bonus_movesilently or 0), true) end
            if w.skill_bonus_escapeartist then desc:add(("#GOLD#This armor grants a +%d bonus to Escape Artist skill."):format(w.skill_bonus_escapeartist or 0), true) end
            if w.spell_resistance then desc:add(("#GOLD#Spell resistance +%d"):format(w.spell_resistance or 0), true) end
            if w.combat_magic_armor then desc:add(("#GOLD#This armor grants a +%d magic bonus to AC."):format(w.combat_magic_armor or 0), true) end
            if w.combat_magic_shield then desc:add(("#GOLD#This shield grants a +%d magic bonus to AC."):format(w.combat_magic_shield or 0), true) end
            if w.combat_natural then desc:add(("#GOLD#This item grants a +%d natural armor bonus to AC."):format(w.combat_natural or 0), true) end
            if w.combat_protection then desc:add(("#GOLD#This item grants a +%d protection bonus to AC."):format(w.combat_protection or 0), true) end
        end
        
        desc_wielder(self.wielder)
        end
    else

        desc:add("\nUnidentified.")
    end
    
    return desc
end

--- Gets the full desc of the object
function _M:getDesc(name_param)
    local desc = tstring{}
    name_param = name_param or {}
    name_param.do_color = true

    desc:merge(self:getName(name_param):toTString())

    desc:merge(self:getTextualDesc())

    return desc
end

function _M:tooltip(x, y)
    local str = self:getDesc()
    --Tooltip cue for multiple objects
    local nb = game.level.map:getObjectTotal(x, y)
    if nb == 2 then str:add(true, "---", true, "You see one more object.")
    elseif nb > 2 then str:add(true, "---", true, "You see "..(nb-1).." more objects.")
    end
    
    return str
end

--- Can it stacks with others of its kind ?
function _M:canStack(o)
    return engine.Object.canStack(self, o)
end

function _M:on_identify()
    game.logSeen(game.player, "Identified: %s", self.name)
end