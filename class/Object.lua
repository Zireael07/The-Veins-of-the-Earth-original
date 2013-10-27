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
    engine.interface.ActorTalents
    
))

function _M:init(t, no_default)
    t.encumber = t.encumber or 0

    engine.Object.init(self, t, no_default)
    engine.interface.ObjectActivable.init(self, t)
    engine.interface.ObjectIdentify.init(self, t)
    engine.interface.ActorTalents.init(self, t)
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

--- Gets the full name of the object
function _M:getName(t)
    t = t or {}
    local qty = self:getNumber()
    local name = self.name

    --Special naming for potions & scrolls
    local set_name = 0
    local pattern = rng.table{"cloudy","hazy","metallic","milky", "misty","scincillating","shimmering","smoky","speckled","spotted","swirling","oily","opaque","pungent", "viscous"}
    local colors = rng.table{"red","blue","pink","green","black","white","violet","yellow","teal","gold"}

    local label = rng.table{"abbil", "abban","alae","alartae","akh","belbau","belbol","bol","dro","dalharil","dalharuk","dalninil","dalninuk","dhaerow","dobluth","darthiir","faer","faern","hargluk","harl","harluth","Har'oloth","ilhar","ilharn","ilythiiri","jal","malla","maglust","natha","obsul","orbb","phor","pholor","phuul","plynn","qu'ellar","rivvil", "rivvin","ssin'urn","ssussun","xun","xundus","tagnik", "tagnik'zur","tluth","ulartae","valsharess","veldruk", "veldriss", "veldrin","z'ress", }

    if set_name == 0 then
        if self.type == "potion" and self.identified == false then 
            if rng.chance(50) then set_name = set_name + 1
                return "a "..colors.." potion"    
            else set_name = set_name + 1 
                return "a "..pattern.." "..colors.." potion" end
        set_name = 1
        end   
        if self.type == "scroll" and self.identified == false then
            if rng.chance(30) then  set_name = set_name + 1
              return "a scroll labeled "..label
            elseif rng.chance(70) then set_name = set_name + 1
                return "a scroll labeled "..label.." "..label 
                
            else set_name = set_name + 1
            return "a scroll labeled "..label.." "..label.." "..label     
            end
        end
    else end

    if self.identified == false and not t.force_id and self:getUnidentifiedName() then name = self:getUnidentifiedName() end
    
    if qty == 1 or t.no_count then return name
    else return qty.." "..name
    end
end

--- Gets the full desc of the object
function _M:getDesc()
    local str = self.desc

    --Expand tooltips!
    if self.slot_forbid == "OFFHAND" then str = str.."\nYou must wield this weapon with both hands." end

    if self.type == "weapon" and self.light then str = str.."\nThis is a light weapon." end
    if self.type == "weapon" and self.martial then str = str.."\nThis is a martial weapon." end
    if self.type == "weapon" and self.simple then str = str.."\nThis is a a simple weapon." end
    if self.type == "weapon" and self.reach then str = str.."\nThis is a reach weapon." end
    if self.type == "weapon" and self.exotic then str = str.."\nThis is an exotic weapon." end
    
    --Describing magic items
    if self.type == "weapon" and self.identified == true then 
        local magic_bonus = self.combat.magic_bonus
        if magic_bonus and magic_bonus > 0 then str = str.."\n#GOLD#This weapon grants a +"..(magic_bonus).." magic bonus to attack and damage" end
    elseif self.type == "armor" and self.identified == true then 
        local magic_armor = self.wielder.combat_magic_armor
        if magic_armor and magic_armor > 0 then str = str.."\n#GOLD#This armor grants a +"..(magic_armor).." magic bonus to AC" end
    elseif self.type == "shield" and self.identified == true then
    local magic_shield = self.wielder.combat_magic_shield
        if magic_shield and magic_shield > 0 then str = str.."\n#GOLD#This shield grants a +"..(magic_shield).." magic bonus to AC" end 
    elseif self.type == "amulet" and self.identified == true then
        local natural = self.wielder.combat_natural
        if natural and natural > 0 then str = str.."\n#GOLD#This amulet grants a +"..(natural).." natural armor bonus to AC" end
    elseif self.type == "ring" and self.identified == true then
          local protection = self.wielder.combat_protection
          if protection and protection > 0 then str = str.."\n#GOLD#This ring grants a +"..(protection).." protection bonus to AC" end
    else end

    return str

end

function _M:tooltip(x, y)
    local str = self:getDesc()
--    if config.settings.cheat then str = str .."\nUID: "..self.uid end
    
    --Tooltip cue for multiple objects
    local nb = game.level.map:getObjectTotal(x, y)
    if nb == 2 then str = str.."\n---\nYou see one more object."
    elseif nb > 2 then str = str.."\n---\nYou see "..(nb-1).." more objects."
    end
    return str
end