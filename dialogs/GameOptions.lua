-- Veins of the Earth
-- Copyright (C) 2013 - 2014 Zireael
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
local Dialog = require "engine.ui.Dialog"
local TreeList = require "engine.ui.TreeList"
local Textzone = require "engine.ui.Textzone"
local Separator = require "engine.ui.Separator"
local GetQuantity = require "engine.dialogs.GetQuantity"
local Tabs = require "engine.ui.Tabs"
local GraphicMode = require("mod.dialogs.GraphicMode")

module(..., package.seeall, class.inherit(Dialog))

function _M:init(gameplay)
	Dialog.init(self, "Game Options", game.w * 0.8, game.h * 0.8)
	self.needs_reboot = false
	self.c_desc = Textzone.new{width=math.floor(self.iw / 2 - 10), height=self.ih, text=""}

    self.gameplay = gameplay

    local tabs = {
            {title="UI", kind="ui"},
            {title="Fonts", kind="fonts"},
            {title="Gameplay", kind="game"},
    }
        

	self.c_tabs = Tabs.new{width=self.iw - 5, tabs=tabs, on_change=function(kind) self:switchTo(kind) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_tabs},
		{left=0, top=self.c_tabs.h, ui=self.c_list},
		{right=0, top=self.c_tabs.h, ui=self.c_desc},
		{hcenter=0, top=5+self.c_tabs.h, ui=Separator.new{dir="horizontal", size=self.ih - 10}},

	}
	self:setFocus(self.c_list)
	self:setupUI()

	self.key:addBinds{
		EXIT = function()
			if self.needs_reboot then game:setupDisplayMode(true) end
			game:unregisterDialog(self) 
		end,
	}
end

function _M:select(item)
	if item and self.uis[3] then
		self.uis[3].ui = item.zone
	end
end

function _M:switchTo(kind)
	self['generateList'..kind:capitalize()](self)
	self:triggerHook{"GameOptions:generateList", list=self.list, kind=kind}

	self.c_list = TreeList.new{width=math.floor(self.iw / 2 - 10), height=self.ih - 10, scrollbar=true, columns={
		{width=60, display_prop="name"},
		{width=40, display_prop="status"},
	}, tree=self.list, fct=function(item) end, select=function(item, sel) self:select(item) end}
	if self.uis and self.uis[2] then
		self.c_list.mouse.delegate_offset_x = self.uis[2].ui.mouse.delegate_offset_x
		self.c_list.mouse.delegate_offset_y = self.uis[2].ui.mouse.delegate_offset_y
		self.uis[2].ui = self.c_list
	end
end


function _M:generateListUi()
	-- Makes up the list
	local list = {}
	local i = 0

	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the transparency of dialog screens. 100 is fully opaque and 0 is fully transparent.
		
Default ToME transparencies
• Metal: 90
• Simple: 90
• Stone: 100
• Steamtech: 100#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Dialog transparency#WHITE##{normal}#",
		status = function(item)			
			return tostring((config.settings.veins.dialog_alpha or 1) * 100)
		end, fct=function(item)
			game:registerDialog(GetQuantity.new("Transparency amount", "From 0 to 100", (config.settings.veins.dialog_alpha or 1) * 100, 100, function(qty)
				qty = util.bound(qty, 0, 100) / 100
				config.settings.veins.dialog_alpha = qty
				UIBase.ui_conf.simple.frame_alpha = qty
				UIBase.ui_conf.metal.frame_alpha = qty
				UIBase.ui_conf.metal.frame_shadow.a = qty * 0.5
				UIBase.ui_conf.stone.frame_alpha = qty
				UIBase.ui_conf.stone.frame_shadow.a = qty * 0.5
				if UIBase.ui_conf.steam then
					UIBase.ui_conf.steam.frame_alpha = qty
					if UIBase.ui_conf.steam.frame_shadow then
						UIBase.ui_conf.steam.frame_shadow.a = qty * 0.5
					end
				end
				veins.saveMarson()
				self.c_list:drawItem(item)
			end, 0))
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the transparency of the tooltip. 100 is fully opaque and 0 is fully transparent. (Default ToME transparency is 75.)#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Tooltip transparency#WHITE##{normal}#",
		status = function(item)			
			return tostring((config.settings.veins.tooltip_alpha or 1) * 100)
		end, fct=function(item)
			game:registerDialog(GetQuantity.new("Transparency amount", "From 0 to 100", (config.settings.veins.tooltip_alpha or 1) * 100, 100, function(qty)
				qty = util.bound(qty, 0, 100) / 100
				config.settings.veins.tooltip_alpha = qty
				veins.saveMarson()
				self.c_list:drawItem(item)
			end, 0))
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the background transparency for chat, log, and NPC list. 100 is fully opaque and 0 is fully transparent. (Default ToME transparency is 0.)#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Chat/log/list background transparency#WHITE##{normal}#",
		status = function(item)			
			return tostring(config.settings.veins.chat_alpha or 0)
		end, fct=function(item)
			game:registerDialog(GetQuantity.new("Transparency amount", "From 0 to 100", (config.settings.veins.chat_alpha or 0), 100, function(qty)
				qty = util.bound(qty, 0, 100)
				config.settings.veins.chat_alpha = qty
				veins.saveMarson()
				self.c_list:drawItem(item)
			end, 0))
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the hotkey bar background transparency. 100 is fully opaque and 0 is fully transparent. (Default ToME transparency is 100.)#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Hotkey bar background transparency#WHITE##{normal}#",
		status = function(item)			
			return tostring(config.settings.veins.hotkeys_alpha or 1) * 100
		end, fct=function(item)
			game:registerDialog(GetQuantity.new("Transparency amount", "From 0 to 100", (config.settings.veins.hotkeys_alpha or 1) * 100, 100, function(qty)
				qty = util.bound(qty, 0, 100) / 100
				config.settings.veins.hotkeys_alpha = qty
				veins.saveMarson()
				self.c_list:drawItem(item)
			end, 0))
		end,
	}
  
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the tooltip location.
		
• #YELLOW#Lower-right#WHITE#: standard ToME.
• #YELLOW#Opposite#WHITE#: use the opposite corner of the screen from the mouse. #WHITE#
• #YELLOW#Mouse#WHITE#: tooltip follows the mouse cursor]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Tooltip Location#WHITE##{normal}#",
		status = function(item)
			return tostring(config.settings.veins.tooltip_location or "Lower-Right")
		end, fct=function(item)
			local tooltips = {{name="Lower-Right", location="Lower-Right"}, {name="Lower-Left", location="Lower-Left"}, {name="Upper-Right", location="Upper-Right"}, {name="Upper-Left", location="Upper-Left"}, {name="Opposite", location="Opposite"}, {name="Mouse", location="Mouse"}}
			engine.ui.Dialog:listPopup("Tooltip location", "Select location", tooltips, 100, 200, function(sel)
				if not sel or not sel.location then return end
				config.settings.veins.tooltip_location = sel.location
				veins.saveMarson()
				self.c_list:drawItem(item)
			end)
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets the tooltip location specifically for the inventory screen.
		
• #YELLOW#Original#WHITE# is standard ToME.
• #YELLOW#Small Screen#WHITE# moves the tooltip to either side of the screen.
• #YELLOW#Big Screen#WHITE# uses a dedicated location in the center of the screen. #WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Inventory Tooltip#WHITE##{normal}#",
		status = function(item)
			return tostring(config.settings.veins.inventory_tooltip):capitalize()
		end, fct=function(item)
			local tooltips = {{name="Original", style="Original"}, {name="Small Screen", style="Small Screen"}, {name="Big Screen", style="Big Screen"}}
			engine.ui.Dialog:listPopup("Tooltip style", "Select style", tooltips, 100, 200, function(sel)
				if not sel or not sel.style then return end
				config.settings.veins.inventory_tooltip = sel.style
				veins.saveMarson()
				self.c_list:drawItem(item)
			end)
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Sets width of all tooltips. Original size is 300. Previous versions of this addon used 400.]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Tooltip width#WHITE##{normal}#",
		status = function(item)
			return tostring(config.settings.veins.tootip_width or 400)
		end, fct=function(item)
			game:registerDialog(GetQuantity.new("Width", "From 200 to 800", (config.settings.veins.tootip_width or 400), 800, function(qty)
				qty = util.bound(qty, 200, 800)
				config.settings.veins.tootip_width = qty
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end, 200))
		end,
	}

	self.list = list
end


function _M:generateListFonts()
	-- Makes up the list
	local list = {}
	local i = 0
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for the majority of screens in the game (menus, inventory, etc).#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Dialogs font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.dialog.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.dialogstyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{width=self.c_desc.w, height=self.c_desc.h, text=string.toTString"Enter a font size between 8 and 36 for the majority of screens in the game (menus, inventory list, etc)."}
	list[#list+1] = { zone=zone, name=string.toTString"#GOLD##{bold}#Dialog font Size#WHITE##{normal}#", status=function(item)
		return tostring(veins.fonts.dialog.size or 16)
	end, fct=function(item)
		game:registerDialog(GetQuantity.new("Font size", "From 8 to 36", veins.fonts.dialog.size or 16, 36,
		function(qty)
			qty = util.bound(qty, 8, 36)
			config.settings.veins.fonts.dialogsize = qty
			veins.saveMarson()
			self.c_list:drawItem(item)
			self.needs_reboot = true
		end, 8))
	end,}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for the HUD (hotkeys, buffs).#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#HUD font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.hud.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.hudstyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a hotkey font scale. A higher number displays a larger font size.]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Hotkey font scale#WHITE##{normal}#",
		status = function(item)
			return tostring(config.settings.veins.hotkey_scale or 2)
		end, fct=function(item)
			local tooltips = {{name="3", scale="3"}, {name="2", scale="2"}, {name="1", scale="1"}}
			engine.ui.Dialog:listPopup("Font scale", "Select size", tooltips, 100, 200, function(sel)
				if not sel or not sel.scale then return end
				config.settings.veins.hotkey_scale = sel.scale
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for Tooltips.#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Tooltip font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.tooltip.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.tooltipstyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{width=self.c_desc.w, height=self.c_desc.h, text=string.toTString"Enter a font point size between 8 and 36 for the Tooltips."}
	list[#list+1] = { zone=zone, name=string.toTString"#GOLD##{bold}#Tooltip font Size#WHITE##{normal}#", status=function(item)
		return tostring(veins.fonts.tooltip.size or 16)
	end, fct=function(item)
		game:registerDialog(GetQuantity.new("Font size", "From 8 to 36", veins.fonts.tooltip.size or 16, 36,
		function(qty)
			qty = util.bound(qty, 8, 36)
			config.settings.veins.fonts.tooltipsize = qty
			veins.saveMarson()
			self.c_list:drawItem(item)
			self.needs_reboot = true
		end, 8))
	end,}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for the chat displays.#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Chat font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.chat.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.chatstyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{width=self.c_desc.w, height=self.c_desc.h, text=string.toTString"Enter a font point size between 8 and 36 for Chat."}
	list[#list+1] = { zone=zone, name=string.toTString"#GOLD##{bold}#Chat font size#WHITE##{normal}#", status=function(item)
		return tostring(veins.fonts.chat.size or 16)
	end, fct=function(item)
		game:registerDialog(GetQuantity.new("Font size", "From 8 to 36", veins.fonts.chat.size or 16, 36,
		function(qty)
			qty = util.bound(qty, 8, 36)
			config.settings.veins.fonts.chatsize = qty
			veins.saveMarson()
			self.c_list:drawItem(item)
			self.needs_reboot = true
		end, 8))
	end,}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for flying text. (Displays damage, healing, etc, above your character.)#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Flying font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.flying.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.flyingstyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{width=self.c_desc.w, height=self.c_desc.h, text=string.toTString"Enter a font point size between 8 and 36 for flying text."}
	list[#list+1] = { zone=zone, name=string.toTString"#GOLD##{bold}#Flying font size#WHITE##{normal}#", status=function(item)
		return tostring(veins.fonts.flying.size or 16)
	end, fct=function(item)
		game:registerDialog(GetQuantity.new("Font size", "From 8 to 36", veins.fonts.flying.size or 16, 36,
		function(qty)
			qty = util.bound(qty, 8, 36)
			config.settings.veins.fonts.flyingsize = qty
			veins.saveMarson()
			self.c_list:drawItem(item)
			self.needs_reboot = true
		end, 8))
	end,}
	
	local zone = Textzone.new{
		width = self.c_desc.w,
		height = self.c_desc.h,
		text = string.toTString [[Choose a font type for lore displays.#WHITE#]]
	}
	list[#list+1] = {
		zone = zone,
		name = string.toTString"#GOLD##{bold}#Lore font type#WHITE##{normal}#",
		status = function(item)
			return tostring(veins.fonts.available_list[veins.fonts.lore.key].name or "Droid Sans")
		end, fct=function(item)
			engine.ui.Dialog:fontSelect(veins.fonts.available_list, function(sel)
				if not sel or not sel.key then return end
				config.settings.veins.fonts.lorestyle = sel.key
				veins.saveMarson()
				self.c_list:drawItem(item)
				self.needs_reboot = true
			end)
		end,
	}
	local zone = Textzone.new{width=self.c_desc.w, height=self.c_desc.h, text=string.toTString"Enter a font point size between 8 and 36 for lore displays."}
	list[#list+1] = { zone=zone, name=string.toTString"#GOLD##{bold}#Lore font size#WHITE##{normal}#", status=function(item)
		return tostring(veins.fonts.lore.size or 16)
	end, fct=function(item)
		game:registerDialog(GetQuantity.new("Font size", "From 8 to 36", veins.fonts.lore.size or 16, 36,
		function(qty)
			qty = util.bound(qty, 8, 36)
			config.settings.veins.fonts.loresize = qty
			veins.saveMarson()
			self.c_list:drawItem(item)
			self.needs_reboot = true
		end, 8))
	end,}

	self.list = list
end	

function _M:generateListGame()
    -- Makes up the list
    local list = {}
    local i = 0

--[[   local zone = Textzone.new{
        width = self.c_desc.w,
        height = self.c_desc.h,
        text = string.toTString [[Sets the difficulty setting.
        
• #YELLOW#Default#WHITE#: standard d20.]]
--[[    }
    list[#list+1] = {
        zone = zone,
        name = string.toTString"#GOLD##{bold}#Difficulty setting#WHITE##{normal}#",
        status = function(item)
            return tostring(config.settings.veins.difficulty or "Default")
        end, fct=function(item)
            local difficulty = {{name="Default", difficulty="Default"}, {name="Easy", location="Easy"}, {name="Hard", location="Hard"},}
            engine.ui.Dialog:listPopup("Difficulty setting", "Select difficulty", difficulty, 100, 200, function(sel)
                if not sel or not sel.difficulty then return end
                config.settings.veins.difficulty = sel.difficulty
                game:saveSettings("veins.difficulty", ("veins.difficulty= %s\n"):format(tostring(config.settings.veins.difficulty)))
                self.c_list:drawItem(item)
            end)
        end,
    }]]

    local zone = Textzone.new{
        width = self.c_desc.w,
        height = self.c_desc.h,
        text = string.toTString [[Use the defensive roll variant from SRD.
        
• #YELLOW#True#WHITE#: defensive roll (roll d20 instead of base AC of 10).
• #YELLOW#False#WHITE#: base AC of 10]]
    }
    list[#list+1] = {
        zone = zone,
        name = string.toTString"#GOLD##{bold}#Defensive roll variant#WHITE##{normal}#",
        status = function(item)
            return tostring(config.settings.veins.defensive_roll and "enabled" or "disabled")
        end, fct=function(item)
            if self.gameplay then
            config.settings.veins.defensive_roll = not config.settings.veins.defensive_roll
            game:saveSettings("veins.defensive_roll", ("veins.defensive_roll= %s\n"):format(tostring(config.settings.veins.defensive_roll)))
            self.c_list:drawItem(item)
            end
        end,
    }

     local zone = Textzone.new{
        width = self.c_desc.w,
        height = self.c_desc.h,
        text = string.toTString [[Use the piecemeal armor variant from SRD. It splits up armor into torso, arm and leg pieces.
        
• #YELLOW#True#WHITE#: piecemeal armor.
• #YELLOW#False#WHITE#: standard d20 armor]]
    }
    list[#list+1] = {
        zone = zone,
        name = string.toTString"#GOLD##{bold}#Piecemeal armor variant#WHITE##{normal}#",
        status = function(item)
            return tostring(config.settings.veins.piecemeal_armor and "enabled" or "disabled")
        end, fct=function(item)
            if self.gameplay then
            config.settings.veins.piecemeal_armor = not config.settings.veins.piecemeal_armor
            game:saveSettings("veins.piecemeal_armor", ("veins.piecemeal_armor= %s\n"):format(tostring(config.settings.veins.piecemeal_armor)))
            self.c_list:drawItem(item)
            end
        end,
    }

--[[    local zone = Textzone.new{
        width = self.c_desc.w,
        height = self.c_desc.h,
        text = string.toTString [[Use body parts hitpoints instead of catch-all hit points pool.
        
• #YELLOW#True#WHITE#: body parts system used.
• #YELLOW#False#WHITE#: standard d20, abstract hitpoints total]]
--[[    }
    list[#list+1] = {
        zone = zone,
        name = string.toTString"#GOLD##{bold}#Body parts variant#WHITE##{normal}#",
        status = function(item)
            return tostring(config.settings.veins.body_parts and "enabled" or "disabled")
        end, fct=function(item)
           config.settings.veins.body_parts = not config.settings.veins.body_parts
            game:saveSettings("veins.body_parts", ("veins.body_parts= %s\n"):format(tostring(config.settings.veins.body_parts)))
            self.c_list:drawItem(item)
        end,
    }]]

    self.list = list
end