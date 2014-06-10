-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
local Base = require "engine.ui.Base"
local TextzoneList = require "engine.ui.TextzoneList"
local UIContainer = require "engine.ui.UIContainer"
local Map = require "engine.Map"

--- A generic tooltip
module(..., package.seeall, class.inherit(Base))

tooltip_bound_x1 = function() return 0 end
tooltip_bound_x2 = function() return game.w end
tooltip_bound_y1 = function() return 0 end
tooltip_bound_y2 = function() return game.h end

function _M:init(fontname, fontsize, color, bgcolor, max, lockstatus_icon)
	self.ui = "simple"
	
	self.fontsize = fontsize
	self.font = core.display.newFont(fontname or veins.fonts.tooltip.style, fontsize or veins.fonts.tooltip.size)
	
	self.max = max or config.settings.veins.tootip_width or 400

	self.default_ui = { TextzoneList.new{weakstore=true, width=self.max, height=500, variable_height=true, font=self.font, ui=self.ui} }
	self.locked = false
	
	if lockstatus_icon then
		local open, ow, oh = self:getImage(lockstatus_icon.open)
		local locked, lw, lh = self:getImage(lockstatus_icon.locked)
		self.status_icon = {open = {_tex = open:glTexture(), w = ow, h = oh}, locked = {_tex = locked:glTexture(), w = lw, h = lh} }
	end
	
	self.empty = true
	self.inhibit = false
	self.uis = {}
	self.w = self.max
	self.h = 200
	self.uis_h = 0
	self.pingpong = 0
	self.last_display_x = 0
	self.last_display_y = 0
	self.dest_area = { h = self.h }
	self.container = UIContainer.new{width = self.w, height = self.h, dest_area = { h = self.h, fixed = true} }
	Base.init(self, {})
end

function _M:generate()
	self.frame = Base:makeFrame("ui/tooltip/", self.w + 6, self.h + 6)
end

--- Set the tooltip text	
function _M:set(str, ...)
	-- if locked change is forbiden
	if self.locked then return end
	self.pingpong = 0
	str = str or {}
	
	if type(str) == "string" then str = ... and str:format(...):toTString() or str:toTString() end
	if type(str) == "number" then str = tostring(str):toTString() end

	if self.add_map_str then
		if type(self.add_map_str) == "string" then
			table.append(str, {self.add_map_str:toTString()})
		elseif type(self.add_map_str) == "table" then
			local tstr = tstring{}
			tstr:merge(self.add_map_str)
			table.append(str, {tstr})
		else
			table.append(str, self.add_map_str)
		end
	end
	
	local max_w = 0
	local max_str_w = 0
	local uis = {}
	local part
	if not str.is_tstring then
		-- format all texts into tstring and calculate required width 
		for i=1, #str do
			part = str[i]
			if part then
				if type(part) == "string" then
					part = part:toTString()
				end
				if part.is_tstring then
					local width = part:maxWidth(self.font)
					if width > max_str_w then max_str_w = width end
				elseif part.w > max_w then 
					max_w = part.w 
				end
			end
		end
		
		-- clip calculated width to max tooltip width
		if self.max < max_str_w then max_str_w = self.max end
		if max_str_w > max_w then max_w = max_str_w end

		local ts = tstring{}
		local uis_size = #uis
		for i=1, #str do
			-- if the item is tstring then merge it with main ts
			if str[i] then
				if str[i].is_tstring then
					if i > 1 then 
						if str[i - 1] and str[i - 1].is_tstring then 
							ts:add(true) 
						end 
						ts:add("---", true)
					end
					ts:merge(str[i])
				else
					-- if we have more than one item in list then create TextzoneList and output ts that was gathering texts till now
					if i > 1 then
						-- if the item dont have special flag separe them with separator
						if not str[i].suppress_line_break then
							ts:add(true, "---")
						end
						local tz = TextzoneList.new{weakstore=true, width=max_w, height=500, variable_height=true, font=self.font, ui=self.ui}
						tz:switchItem(ts, ts)
						uis_size = uis_size + 1
						uis[uis_size] = tz
					end
					uis_size = uis_size + 1
					uis[uis_size] = str[i]
					
					-- reset ts
					ts = tstring{}
				end
			end
		end
		local tz = TextzoneList.new{weakstore=true, width=max_w, height=500, variable_height=true, font=self.font, ui=self.ui}
		tz:switchItem(ts, ts)
		
		uis_size = uis_size + 1
		uis[uis_size] = tz
		
		if self.uis == self.default_ui then self:erase() end
		self.uis = uis
		self.empty = false
	-- whole element is tstring so just put it into default element which is textzone
	else
		self:erase()
		self.default_ui[1]:switchItem(str, str) 
		max_w = self.max
		self.empty = str:isEmpty()
	end
	
	self.container:changeUI(self.uis)

	local uih = 0
	for i = 1, #self.uis do uih = uih + self.uis[i].h end
	
	self.uis_h = uih
	
	-- change width and height to new values
	self.h = uih + self.frame.b2.h
	self.w = max_w + self.frame.b4.w
	
	local clip_h = self.h
	if game.tooltip:tooltip_bound_y2() < clip_h then clip_h = game.tooltip:tooltip_bound_y2() end
	
	self.container:resize(self.w, clip_h - self.frame.b2.h, self.w, clip_h - self.frame.b2.h)
	self.h = clip_h
	-- resize background frame
	self.frame.h = self.h
	self.frame.w = self.w
end

function _M:erase()
	self.uis_h = 0
	self.uis = self.default_ui
	self.default_ui[1].list = nil
	self.empty = true
end

function _M:display() end

function _M:toScreen(x, y, nb_keyframes)
	self.last_display_x = x
	self.last_display_y = y

	if self.inhibited == true or self.empty == true then return nil end
	nb_keyframes = nb_keyframes or 0
	-- Save current matrix and load coords to default values
	core.display.glPush()
	core.display.glIdentity()
	
	local locked_w = ( (self.locked and self.uis_h > self.container.dest_area.h) and self.container.scrollbar.w or 0)
	
	if not self.locked then
		if self.pingpong == 0 then
			self.container.scrollbar.pos = self.container.scrollbar.pos + nb_keyframes
			if self.container.scrollbar.pos > self.container.scrollbar.max then 
				self.container.scrollbar.pos = self.container.scrollbar.max 
				self.pingpong = 1
			end
		else
			self.container.scrollbar.pos = self.container.scrollbar.pos - nb_keyframes
			if self.container.scrollbar.pos < 0 then 
				self.container.scrollbar.pos = 0
				self.pingpong = 0
			end
		end
	end
	
	-- Draw the frame and shadow
	self:drawFrame(self.frame, x - locked_w, y, 0, 0, 0, 0.3, self.w + locked_w, self.h) -- shadow
	if self.locked then
		self:drawFrame(self.frame, x - locked_w, y, 1, 1, 1, 1, self.w + locked_w, self.h) -- locked frame
	else
		self:drawFrame(self.frame, x, y, 1, 1, 1, config.settings.veins.tooltip_alpha) -- unlocked frame
	end
	
	if self.status_icon then
		local status_off = ( (self.locked and self.uis_h > self.container.dest_area.h) and 0 or self.container.scrollbar.w)
		if self.locked then
			self.status_icon.locked._tex:toScreen(x + status_off - self.status_icon.locked.w, y + (self.h - self.status_icon.locked.h) * 0.5, self.status_icon.locked.w, self.status_icon.locked.h)
		else
			self.status_icon.open._tex:toScreen(x + status_off - self.status_icon.open.w, y + (self.h - self.status_icon.open.h) * 0.5, self.status_icon.open.w, self.status_icon.open.h )
		end
	end

	self.container:display(x + 8 - locked_w, y + 8, nb_keyframes, x + 8 - locked_w, y + 8)
	
	-- Restore saved opengl matrix
	core.display.glPop()
end

--- Displays the tooltip at the given map coordinates
-- @param tmx the map coordinate to get tooltip from
-- @param tmy the map coordinate to get tooltip from
-- @param mx the screen coordinate to display at, if nil it will be computed from tmx
-- @param my the screen coordinate to display at, if nil it will be computed from tmy
-- @param text a text to display, if nil it will interrogate the map under the mouse using the "tooltip" property
-- @param force forces tooltip to refresh
function _M:displayAtMap(tmx, tmy, mx, my, text, force, nb_keyframes)
	if not mx then
		mx, my = game.level.map:getTileToScreen(tmx, tmy)
	end
--local text = "("..mx..","..my..")"
  -- if Split, divide screen in half and put tooltip on opposite side of mouse - Marson
  if config.settings.veins.tooltip_location == "Opposite" then
    if mx == game.w and my == game.h then
      if game.mouse.last_pos.x >= game.w / 2 then mx = Map.display_x end
      if game.mouse.last_pos.y >= game.h / 2 then my = Map.display_y end
    end
  elseif config.settings.veins.tooltip_location == "Mouse" then
    if config.settings.veins.inventory_tooltip == "Original" and game.dialogs[1] and game.dialogs[1].__CLASSNAME == "mod.dialogs.ShowEquipInven" then
      mx = game.dialogs[1].mouse.last_pos.x
      my = game.dialogs[1].mouse.last_pos.y + 32
    elseif my == game.h and (mx == game.w or mx == Map.display_x) then
      mx = game.mouse.last_pos.x
      my = game.mouse.last_pos.y + 32
    end
  elseif config.settings.veins.tooltip_location == "Lower-Left" then
    if mx == game.w and my == game.h then
      mx = Map.display_x
    elseif mx == Map.display_x and my == game.h then
      mx = game.w
    end
  elseif config.settings.veins.tooltip_location == "Upper-Left" then
    if mx == game.w and my == game.h then
      mx = Map.display_x
      my = Map.display_y
    elseif mx == Map.display_x and my == game.h then
      mx = game.w
      my = Map.display_y
    end
  elseif config.settings.veins.tooltip_location == "Upper-Right" then
    if mx == game.w and my == game.h then
      my = Map.display_y
    elseif mx == Map.display_x and my == game.h then
      my = Map.display_y
    end
  end

--text = text.."\n("..mx..","..my..")"
--text = text.."\ngame("..game.mouse.last_pos.x..","..game.mouse.last_pos.y..")"
--if game.dialogs[1] then text = text.."\ndialogs("..game.dialogs[1].mouse.last_pos.x..","..game.dialogs[1].mouse.last_pos.y..")" end
	if not self.locked then
		if text then
			if text ~= self.old_text or force then
				self:set(text)
				self.old_text = text
			end
		else
			if self.old_ttmx ~= tmx or self.old_ttmy ~= tmy or (game.paused and self.old_turn ~= game.turn) or force then
				self.old_text = ""
				self.old_ttmx, self.old_ttmy = tmx, tmy
				self.old_turn = game.turn
				local ts = self:getTooltipAtMap(tmx, tmy, mx, my)
				if ts or self.add_map_str then
					self:set(ts)
				else
					self:erase()
				end
			end
		end
	end

	if not self.empty then
		local x1, x2, y1, y2 = self.tooltip_bound_x1(), self.tooltip_bound_x2(), self.tooltip_bound_y1(), self.tooltip_bound_y2()
		if mx < x1 then mx = x1 end
		if my < y1 then my = y1 end
		if mx > x2 - self.w then mx = x2 - self.w end
		if my > y2 - self.h then my = y2 - self.h end
		self:toScreen(mx, my, nb_keyframes)
	end
end

--- Gets the tooltips at the given map coord
function _M:getTooltipAtMap(tmx, tmy, mx, my)
	if self.locked then return nil end
	local tt = {}
	local seen = game.level.map.seens(tmx, tmy)
	local remember = game.level.map.remembers(tmx, tmy)
	local ctrl_state = core.key.modState("ctrl")
	
	local check = function(check_type)
		local to_add = game.level.map:checkEntity(tmx, tmy, check_type, "tooltip", game.level.map.actor_player)
		if to_add then 
			if type(to_add) == "string" then to_add = to_add:toTString() end
			if to_add.is_tstring then 
				tt[#tt+1] = to_add 
			else 
				table.append(tt, to_add) 
			end
		end
		return to_add
	end
	
	if seen and not ctrl_state then
		check(Map.PROJECTILE)
		check(Map.ACTOR)
	end
	if seen or remember then
		local obj = check(Map.OBJECT)
		if not ctrl_state or not obj then
			check(Map.TRAP)
			check(Map.TERRAIN)
		end
	end
	
	if #tt > 0 then
		return tt
	end
	return nil
end
