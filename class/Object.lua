-- Veins of the Earth
-- Zireael 2013-2015
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
--require "engine.interface.ObjectIdentify"
require "mod.class.interface.ObjectIdentify"

local Stats = require("engine.interface.ActorStats")
local Talents = require("engine.interface.ActorTalents")
local DamageType = require("engine.DamageType")

module(..., package.seeall, class.inherit(
    engine.Object,
    engine.interface.ObjectActivable,
--    engine.interface.ObjectIdentify,
    mod.class.interface.ObjectIdentify,
    engine.interface.ActorTalents,
    engine.interface.ActorInventory
))

_M.flavors_def = {}

function _M:init(t, no_default)
    t.encumber = t.encumber or 0
    t.appraised = false
    t.school_id = false

    engine.Object.init(self, t, no_default)
    engine.interface.ObjectActivable.init(self, t)
--    engine.interface.ObjectIdentify.init(self, t)
    mod.class.interface.ObjectIdentify.init(self,t)
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

--- Setup minimap color for this entity
-- You may overload this method to customize your minimap
function _M:setupMinimapInfo(mo, map)
    mo:minimap(0xC0, 0x00, 0xAF)
end

function _M:canUseObject()
    return engine.interface.ObjectActivable.canUseObject(self)
end

function _M:use(who, typ, inven, item)
    inven = who:getInven(inven)
    if self:wornInven() and not self.slot == "INVEN" and not self.wielded and not self.use_no_wear then
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

--- Gets the color in which to display the object in lists
function _M:getDisplayColor()
    if self.pseudo_id == true then
        if self.cursed then return {201, 0, 0}, "#RED#" end

        if self.lore then return {142, 69, 0}, "#UMBER#" end
        --[[    if self.rare then
        return {250, 128, 114}, "#SALMON#"]]
        if self.egoed then
            if self.greater_ego then return {255, 215, 0}, "#GOLD#"
            --More than 1 greater ego
        --[[    if self.greater_ego > 1 then
                return {0x8d, 0x55, 0xff}, "#8d55ff#"
            else]]

        --    end
            else
            return {81, 221, 255}, "#LIGHT_BLUE#"
            end
        else return {255, 255, 255}, "#FFFFFF#"
        end

    else return {210, 180, 140}, "#TAN#" --end
    end
end

---Gets the pseudo ID feeling of the object
function _M:getPseudoIdFeeling()
    if self.cursed then return "cursed"
    elseif self.egoed and self.greater_ego then return "excellent"
    elseif self.egoed then return "magical"
    else return "mundane"
    end
end

function _M:getSchool()
    return self.school
end

function _M:isMagical()
    if self.egoed and not self.cursed then return true end

    return false
end

function _M:resolveSource()
	if self.summoner_gain_exp and self.summoner then
		return self.summoner:resolveSource()
	elseif self.summoner_gain_exp and self.src then
		return self.src:resolveSource()
	else
		return self
	end
end


--- Gets the full name of the object
function _M:getName(t)
    t = t or {}
    local qty = self:getNumber()
    local name = self.name


    if self.identified == false and not t.force_id and self:getUnidentifiedName() then
        name = self:getUnidentifiedName()
    --[[    if self:isFlavored() then
            if self:getFlavorText() then name = ("%s %s"):format(self:getFlavorText(), name)
            else
            name = self:getUnidentifiedName()
            end
        else
        name = self:getUnidentifiedName()
        end]]
    end

    if not t.no_add_pseudo then
        if self.pseudo_id == true and self.identified == false and not t.force_id then --and self:getUnidentifiedName() then
            name = ("%s {%s}"):format(name, self:getPseudoIdFeeling())
        end

        if self.school_id == true and self.identified == false and not t.force_id then
            if self.schools then
                name = ("%s {%s}"):format(name, self:getSchool())
            else
                if self.pseudo_id == true then
                    name = ("%s {%s}"):format(name, self:getPseudoIdFeeling())
                else
                    name = self:getUnidentifiedName()
                end
            end
        end
    end

    --Does this even work?
    name = name:gsub("~", ""):gsub("&", "a"):gsub("#([^#]+)#", function(attr)
        return self:descAttribute(attr)
    end)

    if not t.no_add_name and self.add_name then --and self:isIdentified() then
    name = name .. self.add_name:gsub("#([^#]+)#", function(attr)
            return self:descAttribute(attr)
        end)
    end

    if not t.do_color then
        if qty == 1 or t.no_count then return name
        else return qty.." "..name
        end
    else
        local _, c = self:getDisplayColor()
        if qty == 1 or t.no_count then return c..name.."#LAST#"
        else return c..qty.." "..name.."#LAST#"
        end
    end
end

--[[
    --Describing special materials
    if self.keywords then
    if self.keywords and self.keywords.mithril and self.identified == true then str = str.."\n#GOLD#This armor is made of mithril, reducing the armor check penalty by 3 and spell failure chance by 10% and increasing max Dex bonus to AC by 2." end
    if self.keywords and self.keywords.adamantine and self.identified == true then str = str.."\n#GOLD#This armor is made of adamantine, reducing damage taken by 1 and armor check penalty by 1." end
    if self.keywords and self.keywords.dragonhide and self.identified == true then str = str.."\n#GOLD#This armor is made of dragonhide, giving the wearer fire resistance 20 and reducing the armor check penalty by 1." end
    if self.keywords and self.keywords.darkwood and self.identified == true then str = str.."\n#GOLD#This shield is made of darkwood, reducing armor check penalty by 2" end
  ]]

  --- Gets the short name of the object
  function _M:getShortName(t)
  	if not self.short_name then return self:getName({no_add_pseudo=true}) end

  	t = t or {}
  	local qty = self:getNumber()
  	local name = self.short_name

    if self.identified == false and not t.force_id and self:getUnidentifiedName() then
        name = self:getUnidentifiedName()
    end

    if not t.no_add_name and self.add_name then --and self:isIdentified() then
    name = name .. self.add_name:gsub("#([^#]+)#", function(attr)
            return self:descAttribute(attr)
        end)
    end

    if not t.do_color then
        if qty == 1 or t.no_count then return name
        else return qty.." "..name
        end
    else
        local _, c = self:getDisplayColor()
        if qty == 1 or t.no_count then return c..name.."#LAST#"
        else return c..qty.." "..name.."#LAST#"
        end
    end

end

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

        if self.cost and self.appraised == true then desc:add(("Price: %s"):format(self:formatPrice())) end


    if self:isIdentified() then
           if self.wielder then
        --    desc:add({"color","SANDY_BROWN"}, "\nWhen equipped:", {"color", "LAST"}, true)

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

--Helper to display new prices
--Note it omits any coppers unless the price is given in coppers
function _M:formatPrice()
    local platinum = math.floor(self.cost/2000)
    local gold = math.floor(self.cost/200)
    local silver = math.floor(self.cost/10)

    local plat_change = self.cost - (platinum*2000)
    local gold_change = self.cost - (gold*200)
    local silver_rest = self.cost - (silver*10)

    local plat_rest = math.floor(plat_change/200)
    local gold_rest = math.floor(gold_change/10)

    if self.cost > 2000 then
        if (plat_rest or 0) > 0 then return "#ANTIQUE_WHITE#"..platinum.."#GOLD# "..plat_rest.."#LAST#"
        else return "#ANTIQUE_WHITE#"..platinum.."#LAST#" end
    elseif self.cost > 200 then
        if (gold_rest or 0) > 0 then return "#GOLD#"..gold.."#LAST# "..gold_rest
        else return "#GOLD#"..gold.."#LAST#" end
    elseif self.cost > 10 then
        if (silver_rest or 0) > 0 then return silver.." "..silver_rest
        else return silver end
    else return self.cost
    end
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

function _M:identify(id)
    print("[Identify]", self.name, true)

  self:forAllStack(function(so)
    so.identified = id
    if so:isFlavored() then so:learnFlavor() end
  end)
  self:check("on_identify")
end

function _M:getPrice()
    local base = self.cost or 0
    return base
end

function _M:setNumber(n)
  local qty = self:getNumber()
  if qty < n then
    local o = self:clone()
    -- Don't need to get recursive here...
    o.stacked = nil
    for _ = qty + 1, n do
      self:stack(o:clone())
    end
  elseif qty > n then
    for _ = n + 1, qty do
      self:unstack()
    end
  end
end


function _M:on_prepickup(who, idx)
    --Auto-destroy cursed items
    if who == game.player and self.pseudo_id == false then
        local check = who:skillCheck("intuition", 10)
        if check then
            self.pseudo_id = true
        end
    end
    if self.pseudo_id == true and self.cursed then
        game.log(("You recognize the %s as cursed and destroy it."):format(self:getUnidentifiedName() or self.name))
        game.level.map:removeObject(who.x, who.y, idx) return true
    end

    --Appraise
    if who == game.player and self.appraised == false then
        --more than 5 silver
        if (self.cost or 0) > 500 then
            if self:isMagical() then
                local check_price = who:skillCheck("appraise", 25, true)
                if check then
                    self.appraised = true
                end
            else
            local check_price = who:skillCheck("appraise", 20, true)
            if check then
                self.appraised = true
            end
            end
        else --common item
            local check_price = who:skillCheck("appraise", 12, true)
            if check then
                self.appraised = true
            end
        end
    end

    --Lore
    if who.player and self.lore then
        game.level.map:removeObject(who.x, who.y, idx)
        game.player:learnLore(self.lore)
        return true
    end

    --Item manager settings
--[[    local tt = self.subtype
    if who == game.player and tt.destroy then game.level.map:removeObject(who.x, who.y, idx) return true end
    if who == game.player and tt.no_pickup then return true end]]
end

--Flavor stuff (taken from ToME 2 by Zizzo)
function _M:learnFlavor()
  if self:isFlavored() then
    game.state.flavors_known[self.type][self.subtype][self.name] = true
  end
end

function _M:isFlavored()
  return self.flavors_def[self.type] and self.flavors_def[self.type][self.subtype]
end

function _M:isFlavorKnown()
  return self:isFlavored() and game.state.flavors_known[self.type][self.subtype][self.name]
end

function _M:getFlavorText()
    local used = game.state.flavors_assigned[self.type][self.subtype]
--    return self:isFlavored() and game.state.flavors_assigned[self.type][self.subtype][self.name][1]
    return used[self.name][1]
end

function _M:loadFlavors(file)
  local env = {
    Object = self,
    newFlavorSet = function(t) self:newFlavorSet(t) end,
  }
  local f, err = util.loadfilemods(file, setmetatable(env, {__index = _G}))
  if not f and err then error(err) end
  f()
end

function _M:newFlavorSet(t)
  assert(t.type, 'no flavor set type')
  assert(t.subtype, 'no flavor set subtype')
  assert(t.values or t.pop_flavor, 'flavor set must have values or pop_flavor method')

  t.pop_flavor = t.pop_flavor or function(type, subtype)
    local unused = game.state.flavors_unused[type][subtype]
    if #unused == 0 then return '???' end
    local idx = unused[1]
    table.remove(unused, 1)
    return self.flavors_def[type][subtype].values[idx]
  end

  local typ, sub = t.type, t.subtype
  self.flavors_def[typ] = self.flavors_def[typ] or {}
  if self.flavors_def[typ][sub] then
    print(('[OBJECT] WARNING:  multiple flavor definitions for %s/%s'):format(typ, sub))
  else
    self.flavors_def[typ][sub] = t
  end
end
