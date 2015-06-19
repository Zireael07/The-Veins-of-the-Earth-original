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
local ActorInventory = require ("engine.interface.ActorInventory")

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

--Let's show special reqs
function _M:getRequirementDesc(who)
    local base_getRequirementDesc = engine.Object.getRequirementDesc

    local desc = base_getRequirementDesc(self, who)

    local req = rawget(self, "require")
    if type(req) == "function" then req = req(who) end
	if not req then return nil end
    --From ActorTalents
    if req.special then
		local c = (req.special.fct(who, offset)) and {"color", 0x00,0xff,0x00} or {"color", 0xff,0x00,0x00}
		desc:add(c, ("- %s #WHITE#"):format(req.special.desc), true)
	end


    return desc
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
function _M:getTextualDesc(compare_with, use_actor)
    use_actor = use_actor or game.player
	compare_with = compare_with or {}

    local desc = tstring{}

--    desc:add(true)

    --General stuff to be shown always
    if self.desc then desc:add(self.desc) end

    --Weapons
    if self.slot_forbid == "OFFHAND" then desc:add("You must wield this weapon with two hands.", true) end
    if self.light then desc:add("This is a light weapon", true) end
    if self.martial then desc:add("This is a martial weapon", true) end
    if self.simple then desc:add("This is a simple weapon", true) end
    if self.reach then desc:add("This is a reach weapon", true) end
    if self.exotic then desc:add("This is an exotic weapon", true) end


    local combat_desc = function(desc, c, compare_with, field)
        self:compare_fields(desc, c, compare_with, field, "critical", "%+d", "Critical: ")
        self:compare_fields(desc, c, compare_with, field, "range", "%+d", "Range: ")
    end

    if self.combat and self.combat.dam and type(self.combat.dam) == "table" then
        desc:add(("Damage: %dd%d"):format(self.combat.dam[1], self.combat.dam[2]), true)

    --    self:compare_fields(desc, self, compare_with, "combat", "threat", self:combatThreat(), "Threatens a critical on a roll of: " )
        desc:add(("Threatens a critical on a roll of: %s"):format(self:formatThreat()), true)
    end

    if self.combat then combat_desc(desc, self, compare_with, "combat") end

    local desc_worn = function(desc, w, compare_with, field)
        w = w or {}
        w = w[field] or {}

        --Armors
        self:compare_fields(desc, w, compare_with, field, "combat_armor_ac", "%+d", "AC: ")
        self:compare_fields(desc, w, compare_with, field, "max_dex_bonus", "%+d", "Max Dex bonus to AC: ")
        self:compare_fields(desc, w, compare_with, field, "spell_fail", "%+d", "Spell failure chance: ", 1, true, true)
        self:compare_fields(desc, w, compare_with, field, "armor_penalty", "%+d", "Armor check penalty: ", 1, true, true)

        --Weapons
        self:compare_fields(desc, w, compare_with, field, "combat_parry", "%+d", "Parry bonus to AC: ")

    end

    if self.wielder then
        desc_worn(desc, self, compare_with, "wielder")
    end

    if self.cost and self.appraised == true then desc:add(("Price: %s"):format(self:formatPrice())) end

    desc:add(self:foundInfo())

    if self:isIdentified() then
        if self.wielder then
        --    desc:add({"color","SANDY_BROWN"}, "\nWhen equipped:", {"color", "LAST"}, true)

        local desc_wielder = function(desc, w, compare_with, field)
            w = w or {}
    		w = w[field] or {}

            self:compare_fields(desc, w, compare_with, field, "skill_bonus_hide", "%+d", "Hide skill bonus:")
            self:compare_fields(desc, w, compare_with, field, "skill_bonus_movesilently", "%+d", "Move Silently skill bonus:")
            self:compare_fields(desc, w, compare_with, field, "skill_bonus_escapeartist", "%+d", "Escape Artist skill bonus:")
            self:compare_fields(desc, w, compare_with, field, "spell_resistance", "%+d", "Spell resistance:")
            self:compare_fields(desc, w, compare_with, field, "combat_magic_armor", "%+d", "Armor magic bonus to AC:")
            self:compare_fields(desc, w, compare_with, field, "combat_magic_shield", "%+d", "Shield magic bonus to AC:")
            self:compare_fields(desc, w, compare_with, field, "combat_natural", "%+d", "Natural armor bonus to AC:")
            self:compare_fields(desc, w, compare_with, field, "combat_protection", "%+d", "Protection bonus to AC:")


            -- Display learned talents
    		local any_learn_talent = 0
    		local learn_talents = {}
    		for i, v in ipairs(compare_with or {}) do
    			if v[field] and v[field].learn_talent then
    				for tid, tl in pairs(v[field].learn_talent) do if tl > 0 then
    					learn_talents[tid] = learn_talents[tid] or {}
    					learn_talents[tid][1] = tl
    					any_learn_talent = any_learn_talent + 1
    				end end
    			end
    		end
    		for tid, tl in pairs(w.learn_talent or {}) do if tl > 0 then
    			learn_talents[tid] = learn_talents[tid] or {}
    			learn_talents[tid][2] = tl
    			any_learn_talent = any_learn_talent + 1
    		end end
    		if any_learn_talent > 0 then
    			desc:add(("Talent%s granted: "):format(any_learn_talent > 1 and "s" or ""))
    			for tid, tl in pairs(learn_talents) do
    				local diff = (tl[2] or 0) - (tl[1] or 0)
    				local name = Talents.talents_def[tid].name
    				if diff ~= 0 then
    					if tl[1] then
    						desc:add(("+%d"):format(tl[2] or 0), diff < 0 and {"color","RED"} or {"color","LIGHT_GREEN"}, ("(+%d) "):format(diff), {"color","LAST"}, ("%s "):format(name))
    					else
    						desc:add({"color","LIGHT_GREEN"}, ("+%d"):format(tl[2] or 0),  {"color","LAST"}, (" %s "):format(name))
    					end
    				else
    					desc:add({"color","WHITE"}, ("%+.2f(-) %s "):format(tl[2] or tl[1], name), {"color","LAST"})
    				end
    			end
    			desc:add(true)
    		end

        end

        desc_wielder(desc, self, compare_with, "wielder")
        end



        --wands
        if self.multicharge then desc:add(("%d charges remaining."):format(self.multicharge or 0), true) end
    else
        desc:add("\nUnidentified.")
    end

    return desc
end

--- Gets the full desc of the object
function _M:getDesc(name_param, compare_with, never_compare, use_actor)
    use_actor = use_actor or game.player
    game.compare = {}

    local slot_name = nil
    local idx_desc = ''

    if not never_compare and core.key.modState('ctrl') then
      -- Ignore what the caller sent us and grab the currently selected
      -- candidate out of the candidate list (rebuilding it if necessary).
      if not (game.compare and game.compare.cands) then self:buildCandidateList() end
      local cc = game.compare
      if cc.idx > 0 then
        compare_with = { cc.cands[cc.idx] }
        slot_name = ActorInventory.inven_def[cc.slots[cc.idx]].name

        if #cc.cands > 1 then
  	idx_desc = ', '..cc.idx..' of '..#cc.cands
        end
      else
        compare_with = {}
      end
    end


    local desc = tstring{}
    name_param = name_param or {}
    name_param.do_color = true

    desc:merge(self:getName(name_param):toTString())
    desc:add({"color", "WHITE"}, true)
	local reqs = self:getRequirementDesc(use_actor)
	if reqs then
		desc:merge(reqs)
	end

--[[    local could_compare = false
    if not name_param.force_compare and not core.key.modState("ctrl") then
        if compare_with[1] then could_compare = true end
        compare_with = {}
    end]]

    desc:add(true, true)
    desc:merge(self:getTextualDesc(compare_with, use_actor))

--    if could_compare and not never_compare then desc:add(true, {"font","italic"}, {"color","GOLD"}, "Press <control> to compare", {"color","LAST"}, {"font","normal"}) end

if not never_compare and compare_with and compare_with[1] and (name_param.force_compare or core.key.modState('ctrl')) then
  -- If we're comparing to something, add a note at the top specifying
  -- what we're comparing with.
  name_param.do_color = true
  local pfx = tstring{{'color','GOLD'}, {'font','italic'}, '[vs. ', compare_with[1]:getName(name_param), ' (', (slot_name or '???'), idx_desc, ')]', {'font','normal'}, {'color','LAST'}, true, true}
  pfx:merge(desc)
  desc = pfx
  if #game.compare.cands > 1 then
    desc:add(true, {'font','italic'}, {'color','GOLD'}, 'Tap <shift> to cycle through comparison choices', {'color','LAST'}, {'font','normal'})
  end
end

    return desc
end

--From enhanced object compare by Zizzo
function _M:buildCandidateList()
  local gp = game.player

  local main_inv = self:wornInven()
  local offslot = gp:getObjectOffslot(self)
  local off_inv = offslot and ActorInventory['INVEN_'..offslot]

--[[  local cand_invs = {
    [Inv.INVEN_MAINHAND] = {
      Inv.INVEN_MAINHAND, Inv.INVEN_PSIONIC_FOCUS,
      Inv.INVEN_QS_MAINHAND, Inv.INVEN_QS_PSIONIC_FOCUS,
    },
    [Inv.INVEN_OFFHAND] = { Inv.INVEN_OFFHAND, Inv.INVEN_QS_OFFHAND },
    [Inv.INVEN_QUIVER] = { Inv.INVEN_QUIVER, Inv.INVEN_QS_QUIVER },
  }]]

  -- Vaguely Convoluted Hack(TM):  Accumulate all the inventory IDs we need
  -- to loop over and sort them in defined order.
  local acc1 = {}
  if main_inv then acc1[main_inv] = true end
  if off_inv then acc1[off_inv] = true end
 -- for _, cand in ipairs(main_inv and cand_invs[main_inv] or {}) do acc1[cand] = true end
 -- for _, cand in ipairs(off_inv and cand_invs[off_inv] or {}) do acc1[cand] = true end
  local acc2 = {}
  for k, v in pairs(acc1) do if v then acc2[#acc2+1] = k end end
  table.sort(acc2)

  -- Now build a candidate list by merging together all the candidate
  -- inventories.
  local cands = {}
  local slots = {}
  for _, inv in ipairs(acc2) do
    local inven = gp:getInven(inv) or {}
    table.mergeAppendArray(cands, inven)
    for i = 1, #inven do
      slots[#slots+1] = inv
    end
  end

  game.compare = { cands=cands, slots=slots, idx=math.min(#cands, 1) }
end


--From ToME 4
function _M:compare_fields(desc, item1, items, infield, field, outformat, text, mod, isinversed, isdiffinversed, add_table)
		add_table = add_table or {}
		mod = mod or 1
		isinversed = isinversed or false
		isdiffinversed = isdiffinversed or false
		local ret = tstring{}
		local added = 0
		local add = false
		ret:add(text)
		local outformatres
		local resvalue = ((item1[field] or 0) + (add_table[field] or 0)) * mod
		local item1value = resvalue
		if type(outformat) == "function" then
			outformatres = outformat(resvalue, nil)
		else outformatres = outformat:format(resvalue) end
		if isinversed then
			ret:add(((item1[field] or 0) + (add_table[field] or 0)) > 0 and {"color","RED"} or {"color","LIGHT_GREEN"}, outformatres, {"color", "LAST"})
		else
			ret:add(((item1[field] or 0) + (add_table[field] or 0)) < 0 and {"color","RED"} or {"color","LIGHT_GREEN"}, outformatres, {"color", "LAST"})
		end
		if item1[field] then
			add = true
		end
		for i=1, #items do
			if items[i][infield] and items[i][infield][field] then
				if added == 0 then
					ret:add(" (")
				elseif added > 1 then
					ret:add(" / ")
				end
				added = added + 1
				add = true
				if items[i][infield][field] ~= (item1[field] or 0) then
					local outformatres
					local resvalue = (items[i][infield][field] + (add_table[field] or 0)) * mod
					if type(outformat) == "function" then
						outformatres = outformat(item1value, resvalue)
					else outformatres = outformat:format(item1value - resvalue) end
					if isdiffinversed then
						ret:add(items[i][infield][field] < (item1[field] or 0) and {"color","RED"} or {"color","LIGHT_GREEN"}, outformatres, {"color", "LAST"})
					else
						ret:add(items[i][infield][field] > (item1[field] or 0) and {"color","RED"} or {"color","LIGHT_GREEN"}, outformatres, {"color", "LAST"})
					end
				else
					ret:add("-")
				end
			end
		end
		if added > 0 then
			ret:add(")")
		end
		if add then
			desc:merge(ret)
			desc:add(true)
		end
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
        if (plat_rest or 0) > 0 then return "#ANTIQUE_WHITE#"..platinum.." pp #GOLD# "..plat_rest.." gp #LAST#"
        else return "#ANTIQUE_WHITE#"..platinum.." pp #LAST#" end
    elseif self.cost > 200 then
        if (gold_rest or 0) > 0 then return "#GOLD#"..gold.." gp #LAST# "..gold_rest.." sp"
        else return "#GOLD#"..gold.." gp #LAST#" end
    elseif self.cost > 10 then
        if (silver_rest or 0) > 0 then return silver.." sp "..silver_rest.." cp"
        else return silver.." sp" end
    else return self.cost
    end
end

function _M:formatThreat()
    local threat = "20"
    if self.combat.threat then threat = (20-self.combat.threat).."-20" end

    return threat
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

--Taken from ToME 2 port, describe where it was found
local function found_level_name(ff)
  if ff.town_zone then
    return ('the town of %s'):format(ff.zone_name)
  end
  if ff.level_name then
    return ('%s in %s'):format(ff.level_name, ff.zone_name)
  end
  return ('level %d of %s'):format(ff.level, ff.zone_name)
end

function _M:foundInfo()
    if self.found then
      local ff = self.found
      local str = ''
      local it = self:getNumber() == 1 and 'it' or 'them'
      local on = (ff.level_name or ff.town_zone) and 'in' or 'on'
      if ff.type == 'birth' then
        str = ('You began the game with %s.'):format(it)
      elseif ff.type == 'floor' then
        local floor_on = ff.town_zone and 'ground in' or 'floor '..on
        str = ('You found %s on the %s %s.'):format(it, floor_on, found_level_name(ff))
      elseif ff.type == 'mon_drop' then
        str = ('You found %s in the remains of %s %s %s.'):format(it, ff.mon_name, on, found_level_name(ff))
      elseif ff.type == 'vault' then
        str = ('You found %s in a vault %s %s.'):format(it, on, found_level_name(ff))
      elseif ff.type == 'rubble' then
        str = ('You found %s buried under rubble %s %s.'):format(it, on, found_level_name(ff))
      elseif ff.type == 'store_buy' then
        str = ('You bought %s from the %s %s %s.'):format(it, ff.store_name, on, found_level_name(ff))
      elseif ff.type == 'debug_dialog' then
        str = ('You created %s from the debug dialog.'):format(it)
      elseif ff.type == 'custom_with_level' then
        str = (ff.custom .. ' %s %s.'):format(it, on, found_level_name(ff))
      elseif ff.type == 'custom' then
        str = ff.custom:format(it)
      else
        str = ("??? You found %s somewhere strange (type='%s')"):format(it, tostring(ff.type or '???'))
      end
      desc = '\n\n#{italic}##YELLOW#' .. str .. '#LAST##{normal}#'
      return desc
    end
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
