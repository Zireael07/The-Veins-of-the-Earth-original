-- $Id: TweakedTreeList.lua 64 2012-09-16 18:20:17Z dsb $
-- ToME - Tales of Middle-Earth
-- Copyright (C) 2012 Scott Bigham
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
-- Scott Bigham "Zizzo"
-- dsb-tome@killerbbunnies.org

require 'engine.class'
local TreeList = require 'engine.ui.TreeList'
local Slider = require "engine.ui.Slider"

-- A slightly modified version of TreeList, adding column headers similar
-- to ListColumns and aligning tree item text differently.
module(..., package.seeall, class.inherit(TreeList))

function _M:init(t)
  TreeList.init(self,t)
  self.simple_list = t.simple_list

  -- Tweak:  The parent module allocates selector-style frames for the
  -- column headers; replace them with heading-style frames.
  for _, col in ipairs(self.columns) do
    col.frame_col = self:makeFrame("ui/heading", col.width, self.fh)
    col.frame_col_sel = self:makeFrame("ui/heading-sel", col.width, self.fh)
  end
end

-- Duplicated with small modifications from TreeList.drawItem()
function _M:drawItem(item, nb_keyframes)
  nb_keyframes = (nb_keyframes or 0) / 2
  item.cols = {}
  for i, col in ipairs(self.columns) do
    if not col.direct_draw then
      local fw = col.width
      local level = item.level or 0
      local color = util.getval(item.color, item) or {255,255,255}
      local text
      if type(col.display_prop) == "function" then
	text = col.display_prop(item):toTString()
      else
	text = item[col.display_prop or col.sort]
	if type(text) ~= "table" or not text.is_tstring then
	  text = util.getval(text, item)
	  if type(text) ~= "table" then text = tstring.from(tostring(text)) end
	end
      end
      local s = col.surface

      local offset = 0
      if i == 1 then
	-- Tweak:  Without this, child leaf nodes could end up aligned to
	-- the left of their parent node if self.level_offset < self.plus.w.
	-- In simple_list mode, though, we don't need this adjustment.
	offset = level * self.level_offset
	if not self.simple_list then offset = offset + self.plus.w end
      end
      local startx = col.frame_sel.b4.w + offset

      item.cols[i] = {}

      s:erase(0, 0, 0, 0)
      local test_text = text:toString()
      local font_w, _ = self.font:size(test_text)
      font_w = font_w + startx

      if font_w > fw then
	item.displayx_offset = item.displayx_offset or {}
	item.displayx_offset[i] = item.displayx_offset[i] or 0
	item.dir = item.dir or {}
	item.dir[i] = item.dir[i] or 0

	if item.dir[i] == 0 then
	  item.displayx_offset[i] = item.displayx_offset[i] - nb_keyframes
	  if -item.displayx_offset[i] >= font_w - fw + 15 then
	    item.dir[i] = 1
	  end
	elseif item.dir[i] == 1 then
	  item.displayx_offset[i] = item.displayx_offset[i] + nb_keyframes
	  if item.displayx_offset[i] >= 0 then
	    item.dir[i] = 0
	  end
	end

	-- We use 1000 and do not cut lines to make sure it draws as much as possible
	text:drawOnSurface(s, 10000, nil, self.font, startx + item.displayx_offset[i], (self.fh - self.font_h) / 2, color[1], color[2], color[3])
	item.autoscroll = true
      else
	text:drawOnSurface(s, 10000, nil, self.font, startx, (self.fh - self.font_h) / 2, color[1], color[2], color[3])
      end

      --text:drawOnSurface(s, col.width - startx - col.frame_sel.b6.w, 1, self.font, startx, (self.fh - self.font_h) / 2, color[1], color[2], color[3])
      item.cols[i]._tex, item.cols[i]._tex_w, item.cols[i]._tex_h = s:glTexture()
    end
  end
  if self.on_drawitem then self.on_drawitem(item) end
end

-- Duplicated with small modifications from TreeList.generate()
function _M:generate(t)
  self.mouse:reset()
  self.key:reset()

  local fw, fh = self.w, self.fh
  self.fw, self.fh = fw, fh

  if not self.h then self.h = self.nb_items * fh end

  -- Tweak:  Leave room for the column headers
  self.max_display = math.floor(self.h / fh) - 1

  -- Draw the scrollbar
  if self.scrollbar then
    self.scrollbar = Slider.new{size=self.h - fh, max=1}
  end

  -- Tweak:  Draw the column headers
  local colx = 0
  for j, col in ipairs(self.columns) do
    local fw = col.width
    col.fw = fw
    local text = col.name
    local s = col.surface

    self.font:setStyle('bold')
    s:erase(0, 0, 0, 0)
    s:drawColorStringBlended(self.font, text, col.frame_sel.b4.w, (fh - self.font_h)/2, 255, 255, 255, true, fw - col.frame_sel.b4.w - col.frame_sel.b6.w)
    self.font:setStyle('normal')

    col._tex, col._tex_w, col._tex_h = s:glTexture()
    colx = colx + col.width
  end

  -- Draw the tree items
  self:drawTree()

  -- Add UI controls
  -- Tweak:  Don't include headers in the mouse zone
  self.mouse:registerZone(0, fh, self.w, self.h, function(button, x, y, xrel, yrel, bx, by, event)
    if button == "wheelup" and event == "button" then self.scroll = util.bound(self.scroll - 1, 1, self.max - self.max_display + 1)
    elseif button == "wheeldown" and event == "button" then self.scroll = util.bound(self.scroll + 1, 1, self.max - self.max_display + 1) end

    if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
    self.sel = util.bound(self.scroll + math.floor(by / self.fh), 1, self.max)
    if self.sel_by_col then
      for i = 1, #self.sel_by_col do if bx > (self.sel_by_col[i-1] or 0) and bx <= self.sel_by_col[i] then
	self.cur_col = i
	break
      end end
    end
    self:onSelect()
    if self.list[self.sel] and self.list[self.sel].nodes and bx <= self.plus.w and button ~= "wheelup" and button ~= "wheeldown" and event == "button" then
      self:treeExpand(nil)
    else
      if (self.all_clicks or button == "left") and button ~= "wheelup" and button ~= "wheeldown" and event == "button" then self:onUse(button) end
    end
    if event == "motion" and button == "left" and self.on_drag then self.on_drag(self.list[self.sel], self.sel) end
  end)
  self.key:addBinds{
    ACCEPT = function() self:onUse("left") end,
    MOVE_UP = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = util.boundWrap(self.sel - 1, 1, self.max) self.scroll = util.scroll(self.sel, self.scroll, self.max_display) self:onSelect()
    end,
    MOVE_DOWN = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = util.boundWrap(self.sel + 1, 1, self.max) self.scroll = util.scroll(self.sel, self.scroll, self.max_display) self:onSelect()
    end,
  }
  if self.sel_by_col then
    self.key:addBinds{
      MOVE_LEFT = function() self.cur_col = util.boundWrap(self.cur_col - 1, 1, #self.sel_by_col) self:onSelect() end,
      MOVE_RIGHT = function() self.cur_col = util.boundWrap(self.cur_col + 1, 1, #self.sel_by_col) self:onSelect() end,
    }
  end
  self.key:addCommands{
    [{"_UP","ctrl"}] = function() self.key:triggerVirtual("MOVE_UP") end,
    [{"_DOWN","ctrl"}] = function() self.key:triggerVirtual("MOVE_DOWN") end,
    _HOME = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = 1
      self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
      self:onSelect()
    end,
    _END = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = self.max
      self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
      self:onSelect()
    end,
    _PAGEUP = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = util.bound(self.sel - self.max_display, 1, self.max)
      self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
      self:onSelect()
    end,
    _PAGEDOWN = function()
      if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
      self.sel = util.bound(self.sel + self.max_display, 1, self.max)
      self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
      self:onSelect()
    end,
  }

  self:outputList()
  self:onSelect()
end

-- Duplicated with small modifications from TreeList.display()
function _M:display(x, y, nb_keyframes)
  local bx, by = x, y
  if self.sel then
    local item = self.list[self.sel]
    if self.previtem and self.previtem~=item then
      self.previtem.displayx_offset = {}
      self:drawItem(self.previtem)
      self.previtem = nil
    end
    if item and item.autoscroll then
      self:drawItem(item, nb_keyframes)
      self.previtem = item
    end
  end

  -- Tweak:  Draw column headers
  local hdr_x = x
  for j, col in ipairs(self.columns) do
    local frame = j == 1 and col.frame_col or col.frame_col_sel
    self:drawFrame(frame, hdr_x, y)
    col._tex:toScreenFull(hdr_x, y, col.fw, self.fh, col._tex_w, col._tex_h)
    hdr_x = hdr_x + col.width
  end
  y = y + self.fh

  local max = math.min(self.scroll + self.max_display - 1, self.max)
  for i = self.scroll, max do
    local x = x
    for j = 1, #self.columns do
      local col = self.columns[j]
      local item = self.list[i]
      if not item then break end
      if self.sel == i and (not self.sel_by_col or self.cur_col == j) then
	if self.focused then
	  self:drawFrame(col.frame_sel, x, y)
	else
	  self:drawFrame(col.frame_usel, x, y)
	end
      elseif (not self.sel_by_col or self.cur_col == j) then
	self:drawFrame(col.frame, x, y)
	if item.focus_decay then
	  if self.focused then
	    self:drawFrame(col.frame_sel, x, y, 1, 1, 1, item.focus_decay / self.focus_decay_max_d)
	  else
	    self:drawFrame(col.frame_usel, x, y, 1, 1, 1, item.focus_decay / self.focus_decay_max_d)
	  end
	  item.focus_decay = item.focus_decay - nb_keyframes
	  if item.focus_decay <= 0 then item.focus_decay = nil end
	end
      end

      if col.direct_draw then
	col.direct_draw(item, x, y, col.width, self.fh)
      else
	if self.text_shadow then
	  item.cols[j]._tex:toScreenFull(x+1, y+1, col.width, self.fh, item.cols[j]._tex_w, item.cols[j]._tex_h, 0, 0, 0, self.text_shadow)
	end
	item.cols[j]._tex:toScreenFull(x, y, col.width, self.fh, item.cols[j]._tex_w, item.cols[j]._tex_h)
      end

      if item.nodes and j == 1 then
	local s = item.shown and self.minus or self.plus
	-- Tweak:  Shift the plus/minus nodes right by the depth offset.
	s.t:toScreenFull(x + item.level*self.level_offset, y + (self.fh - s.h) / 2, s.w, s.h, s.th, s.th)
      end

      x = x + col.width
    end
    y = y + self.fh
  end

  if self.focused and self.scrollbar then
    self.scrollbar.pos = self.sel
    self.scrollbar.max = self.max
    self.scrollbar:display(bx + self.w - self.scrollbar.w, by, by + self.fh)
  end
end
