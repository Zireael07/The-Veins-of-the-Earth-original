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
local KeyBind = require "engine.KeyBind"
local Base = require "engine.ui.Base"
local Particles = require "engine.Particles"

--- A generic UI button
module(..., package.seeall, class.inherit(Base))

--- Requests a simple waiter dialog
function _M:simpleWaiter(title, text, width, count, max)
	local d = new(title, 1, 1)
	width = width or 400
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	local w, h = self.font:size(text.."WWWW")
	w = util.bound(w, title_w + 2 * 5, game.w * 0.9)
	local wait = require("engine.ui.Waiter").new{size=width, known_max=max}
	d:loadUI{
		{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=h+5, text=text}},
		{left = 3, bottom = 3, ui=wait},
	}
	d:setupUI(true, true)

	d.done = function(self) game:unregisterDialog(self) end
	d.timeout = function(self, secs, cb) wait:setTimeout(secs, function() cb() local done = self.done self.done = function()end done(self) end) end
	d.manual = function(self, ...) wait:manual(...) end
	d.manualStep = function(self, ...) wait:manualStep(...) end

	game:registerDialog(d)

	core.wait.enable(count, wait:getWaitDisplay(d))

	return d
end


--- Requests a simple, press any key, dialog
function _M:listPopup(title, text, list, w, h, fct)
	local d = new(title, 1, 1)
	if string.sub(title, 1, 9) == "Landmarks" then
		w = w * 1.5
	end
	w = w * veins.dialog_scale
	h = h * veins.dialog_scale
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	w = util.bound(w, title_w + 2 * 5, game.w * 0.9)
	h = util.bound(h, h, game.h * 0.7)
	
	local desc = require("engine.ui.Textzone").new{width=w, auto_height=true, text=text, scrollbar=true}
	local l = require("engine.ui.List").new{width=w, height=h-16 - desc.h, list=list, fct=function() d.key:triggerVirtual("ACCEPT") end}
	d:loadUI{
		{left = 3, top = 3, ui=desc},
		{left = 3, top = 3 + desc.h + 3, ui=require("engine.ui.Separator").new{dir="vertical", size=w - 12}},
		{left = 3, bottom = 3, ui=l},
	}
	d.key:addBind("EXIT", function() game:unregisterDialog(d) if fct then fct() end end)
	d.key:addBind("ACCEPT", function() game:unregisterDialog(d) if list[l.sel].fct then list[l.sel].fct(list[l.sel]) return end if fct then fct(list[l.sel]) end end)
	d:setFocus(l)
	d:setupUI(true, true)
	game:registerDialog(d)
	return d
end

--- Requests a simple, press any key, dialog
function _M:simplePopup(title, text, fct, no_leave, any_leave)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	local w, h = self.font:size(text.."WWWW")
	w = util.bound(w + 2 * 5, title_w + 2 * 5, game.w * 0.9)
	h = util.bound(h, h, game.h * 0.7)
	d:loadUI{{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=h * 2, text=text}}}
	if not no_leave then
		d.key:addBind("EXIT", function() game:unregisterDialog(d) if fct then fct() end end)
		if any_leave then d.key:addCommand("__DEFAULT", function() game:unregisterDialog(d) if fct then fct() end end) end
		local close = require("engine.ui.Button").new{text="Close", fct=function() d.key:triggerVirtual("EXIT") end}
		d:loadUI{no_reset=true, {hcenter = 0, bottom = 3, ui=close}}
		d:setFocus(close)
	end
	d:setupUI(true, true)
	game:registerDialog(d)
	return d
end

--- Requests a simple, press any key, dialog
function _M:simpleLongPopup(title, text, w, fct, no_leave, force_height)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, title_h = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	w = util.bound(w, title_w + 2 * 5, game.w * 0.9)
	local list = text:splitLines(w, self.font)
	local h = math.min(force_height and (force_height * game.h) or 999999999, self.font_h * #list + title_h )
	d:loadUI{{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=h + title_h, scrollbar=(h < self.font_h * #list) and true or false, text=text}}}
	if not no_leave then
		d.key:addBind("EXIT", function() game:unregisterDialog(d) if fct then fct() end end)
		local close = require("engine.ui.Button").new{text="Close", fct=function() d.key:triggerVirtual("EXIT") end}
		d:loadUI{no_reset=true, {hcenter = 0, bottom = 3, ui=close}}
		d:setFocus(close)
	end
	d:setupUI(true, true)
	game:registerDialog(d)
	return d
end

--- Requests a simple yes-no dialog
function _M:yesnoPopup(title, text, fct, yes_text, no_text, no_leave, escape)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	local w, h = self.font:size(text.."WWWW")
	w = util.bound(w + 2 * 5, title_w + 2 * 5, game.w * 0.9)
	h = util.bound(h, h, game.h * 0.7)

--	d.key:addBind("EXIT", function() game:unregisterDialog(d) fct(false) end)
	local ok = require("engine.ui.Button").new{text=yes_text or "Yes", fct=function() game:unregisterDialog(d) fct(true) end}
	local cancel = require("engine.ui.Button").new{text=no_text or "No", fct=function() game:unregisterDialog(d) fct(false) end}
	if not no_leave then d.key:addBind("EXIT", function() game:unregisterDialog(d) game:unregisterDialog(d) fct(escape) end) end
	d:loadUI{
		{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=h * 2, text=text}},
		{left = 3, bottom = 3, ui=ok},
		{right = 3, bottom = 3, ui=cancel},
	}
	d:setFocus(ok)
	d:setupUI(true, true)

	game:registerDialog(d)
	return d
end

--- Requests a long yes-no dialog
function _M:yesnoLongPopup(title, text, w, fct, yes_text, no_text, no_leave, escape)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, th = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	local bufferw, _ = self.font:size("WWWW")
	w = util.bound(w, title_w + 2 * 5, game.w * 0.9)
	local list = text:splitLines(w - bufferw, self.font)

--	d.key:addBind("EXIT", function() game:unregisterDialog(d) fct(false) end)
	local ok = require("engine.ui.Button").new{text=yes_text or "Yes", fct=function() game:unregisterDialog(d) fct(true) end}
	local cancel = require("engine.ui.Button").new{text=no_text or "No", fct=function() game:unregisterDialog(d) fct(false) end}
	if not no_leave then d.key:addBind("EXIT", function() game:unregisterDialog(d) game:unregisterDialog(d) fct(escape) end) end
	d:loadUI{
		{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=self.font_h * #list, text=text}},
		{left = 3, bottom = 3, ui=ok},
		{right = 3, bottom = 3, ui=cancel},
	}
	d:setFocus(ok)
	d:setupUI(true, true)

	game:registerDialog(d)
	return d
end

--- Requests a simple yes-no dialog
function _M:yesnocancelPopup(title, text, fct, yes_text, no_text, cancel_text, no_leave, escape)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	local w, h = self.font:size(text.."WWWW")
	w = util.bound(w + 2 * 5, title_w + 2 * 5, game.w * 0.9)

--	d.key:addBind("EXIT", function() game:unregisterDialog(d) fct(false) end)
	local ok = require("engine.ui.Button").new{text=yes_text or "Yes", fct=function() game:unregisterDialog(d) fct(true, false) end}
	local no = require("engine.ui.Button").new{text=no_text or "No", fct=function() game:unregisterDialog(d) fct(false, false) end}
	local cancel = require("engine.ui.Button").new{text=cancel_text or "Cancel", fct=function() game:unregisterDialog(d) fct(false, true) end}
	if not no_leave then d.key:addBind("EXIT", function() game:unregisterDialog(d) game:unregisterDialog(d) fct(false, not escape) end) end
	d:loadUI{
		{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=h * 2, text=text}},
		{left = 3, bottom = 3, ui=ok},
		{left = 3 + ok.w, bottom = 3, ui=no},
		{right = 3, bottom = 3, ui=cancel},
	}
	d:setFocus(ok)
	d:setupUI(true, true)

	game:registerDialog(d)
	return d
end

--- Requests a simple yes-no dialog
function _M:yesnocancelLongPopup(title, text, w, fct, yes_text, no_text, cancel_text, no_leave, escape)
	local d = new(title, 1, 1)
  -- Some titles are wider than the content
  -- Using "WWWW" to determine horizontal whitespace buffer for any font size - Marson
  self.font_bold:setStyle("bold")
	local title_w, _ = self.font_bold:size(title.."WWWW")
  self.font:setStyle("normal")
	w = util.bound(w, title_w + 2 * 5, game.w * 0.9)
	local list = text:splitLines(w, font)

--	d.key:addBind("EXIT", function() game:unregisterDialog(d) fct(false) end)
	local ok = require("engine.ui.Button").new{text=yes_text or "Yes", fct=function() game:unregisterDialog(d) fct(true, false) end}
	local no = require("engine.ui.Button").new{text=no_text or "No", fct=function() game:unregisterDialog(d) fct(false, false) end}
	local cancel = require("engine.ui.Button").new{text=cancel_text or "Cancel", fct=function() game:unregisterDialog(d) fct(false, true) end}
	if not no_leave then d.key:addBind("EXIT", function() game:unregisterDialog(d) game:unregisterDialog(d) fct(false, not escape) end) end
	d:loadUI{
		{left = 3, top = 3, ui=require("engine.ui.Textzone").new{width=w, height=self.font_h * #list, text=text}},
		{left = 3, bottom = 3, ui=ok},
		{left = 3 + ok.w, bottom = 3, ui=no},
		{right = 3, bottom = 3, ui=cancel},
	}
	d:setFocus(ok)
	d:setupUI(true, true)

	game:registerDialog(d)
	return d
end

function _M:webPopup(url)
	local d = new(url, game.w * 0.9, game.h * 0.9)
	local w = require("engine.ui.WebView").new{width=d.iw, height=d.ih, url=url, allow_downloads={addons=true, modules=true}}
	if w.unusable then return nil end
	w.on_title = function(title) d:updateTitle(title) end
	d:loadUI{{left=0, top=0, ui=w}}
	d:setupUI()
	d.key:addBind("EXIT", function() game:unregisterDialog(d) end)
	game:registerDialog(d)
	return d
end


title_shadow = true

function _M:init(title, w, h, x, y, alpha, font, showup, skin)
	if title and string.sub(title, 1, 9) == "Prodigies" then
		w = w * 1.25
	end
	local min_w = w
	if title then
    self.font_bold:setStyle("bold")
		local title_w, _ = self.font_bold:size(title.."WWWW")
		min_w = math.max(w, title_w + 2 * 5)
	end
  self.font:setStyle("normal")
  
	w = util.bound(w * veins.dialog_scale, min_w, game.w * 0.9)
	h = util.bound(h * veins.dialog_scale, h, game.h * 0.85)
	if title and string.sub(title, 1, 18) == "Character Creation" then
		y = 50 * veins.dialog_scale
		h = game.h * 0.7
	end
	self.title = title
	self.alpha = self.alpha or 255
	if showup ~= nil then
		self.__showup = showup
	else
		self.__showup = 2
	end
	self.color = self.color or {r=255, g=255, b=255}
	if skin then self.ui = skin end
	if not self.ui_conf[self.ui] then self.ui = "metal" end

	local conf = self.ui_conf[self.ui]
	self.frame = self.frame or {
		b7 = "ui/dialogframe_7.png",
		b8 = "ui/dialogframe_8.png",
		b9 = "ui/dialogframe_9.png",
		b1 = "ui/dialogframe_1.png",
		b2 = "ui/dialogframe_2.png",
		b3 = "ui/dialogframe_3.png",
		b4 = "ui/dialogframe_4.png",
		b6 = "ui/dialogframe_6.png",
		b5 = "ui/dialogframe_5.png",
		shadow = conf.frame_shadow,
		a = conf.frame_alpha or 1,
		darkness = conf.frame_darkness or 1,
		particles = table.clone(conf.particles, true),
	}
	self.frame.ox1 = self.frame.ox1 or conf.frame_ox1
	self.frame.ox2 = self.frame.ox2 or conf.frame_ox2
	self.frame.oy1 = self.frame.oy1 or conf.frame_oy1
	self.frame.oy2 = self.frame.oy2 or conf.frame_oy2

	self.particles = {}

	self.frame.title_x = 0
	self.frame.title_y = 0
	if conf.title_bar then
		self.frame.title_x = conf.title_bar.x
		self.frame.title_y = conf.title_bar.y
		self.frame.title_w = conf.title_bar.w
		self.frame.title_h = conf.title_bar.h
		self.frame.b7 = self.frame.b7:gsub("dialogframe", "title_dialogframe")
		self.frame.b8 = self.frame.b8:gsub("dialogframe", "title_dialogframe")
		self.frame.b9 = self.frame.b9:gsub("dialogframe", "title_dialogframe")
		if self.ui == "steam" then
			Base.ui_conf.steam.title_bar.h = 32
			self.frame.b7 = self.frame.b7:gsub("dialogframe", "dialogframeM")
			self.frame.b8 = self.frame.b8:gsub("dialogframe", "dialogframeM")
			self.frame.b9 = self.frame.b9:gsub("dialogframe", "dialogframeM")
		end
	end

	self.uis = {}
	self.ui_by_ui = {}
	self.focus_ui = nil
	self.focus_ui_id = 0

	self.force_x = x
	self.force_y = y

	self.first_display = true

	Base.init(self, {}, true)

	self:resize(w, h, true)
end

function _M:resize(w, h, nogen)
	local gamew, gameh = core.display.size()
	self.w, self.h = math.floor(w), math.floor(h)
	self.display_x = math.floor(self.force_x or (gamew - self.w) / 2)
	self.display_y = math.floor(self.force_y or (gameh - self.h) / 2)
	if self.title then
		self.ix, self.iy = 5, 8 + 3 + self.font_bold_h
		self.iw, self.ih = w - 2 * 5, h - 8 - 8 - 3 - self.font_bold_h
	else
		self.ix, self.iy = 5, 8
		self.iw, self.ih = w - 2 * 5, h - 8 - 8
	end

--	self.display_x = util.bound(self.display_x, 0, game.w - (self.w+self.frame.ox2))
--	self.display_y = util.bound(self.display_y, 0, game.h - (self.h+self.frame.oy2))

	if not nogen then self:generate() end
end

function _M:generate()
	local gamew, gameh = core.display.size()

	self.frame.w = self.w - self.frame.ox1 + self.frame.ox2
	self.frame.h = self.h - self.frame.oy1 + self.frame.oy2

	self.b7 = self:getUITexture(self.frame.b7)
	self.b9 = self:getUITexture(self.frame.b9)
	self.b1 = self:getUITexture(self.frame.b1)
	self.b3 = self:getUITexture(self.frame.b3)
	self.b8 = self:getUITexture(self.frame.b8)
	self.b4 = self:getUITexture(self.frame.b4)
	self.b2 = self:getUITexture(self.frame.b2)
	self.b6 = self:getUITexture(self.frame.b6)
	self.b5 = self:getUITexture(self.frame.b5)

	self.overs = {}
	for i, o in ipairs(self.frame.overlays or {}) do
		local ov = self:getUITexture(o.image)
		if o.gen then
			o.gen(ov, self)
		else
			ov.x = o.x
			ov.y = o.y
			ov.a = o.a
		end
		self.overs[#self.overs+1] = ov
	end

	self:updateTitle(self.title)

	self.mouse:allowDownEvent(true)
	if self.absolute then
		self.mouse:registerZone(0, 0, gamew, gameh, function(button, x, y, xrel, yrel, bx, by, event) self:mouseEvent(button, x, y, xrel, yrel, bx - self.display_x, by - self.display_y, event) end)
	else
		self.mouse:registerZone(0, 0, gamew, gameh, function(button, x, y, xrel, yrel, bx, by, event) if button == "left" and event == "button" then  self.key:triggerVirtual("EXIT") end end)
		self.mouse:registerZone(self.display_x, self.display_y, self.w, self.h, function(...) self:mouseEvent(...) end)
	end
	self.key.receiveKey = function(_, ...) self:keyEvent(...) end
	self.key:addCommands{
		_TAB = function() self:moveFocus(1) end,
		_UP = function() self:moveFocus(-1) end,
		_DOWN = function() self:moveFocus(1) end,
		_LEFT = function() self:moveFocus(-1) end,
		_RIGHT = function() self:moveFocus(1) end,
	}
	self.key:addBind("SCREENSHOT", function() if type(game) == "table" and game.key then game.key:triggerVirtual("SCREENSHOT") end end)
end

function _M:updateTitle(title)
	if not title then return end
  self.font_bold:setStyle("bold")
	local title = title
	if type(title)=="function" then title = title() end
	local tw, th = self.font_bold:size(title)
	local s = core.display.newSurface(tw, th)
	s:erase(0, 0, 0, 0)
	s:drawColorStringBlended(self.font_bold, title, 0, 0, self.color.r, self.color.g, self.color.b, true)
	self.title_tex = {s:glTexture()}
	self.title_tex.w = tw
	self.title_tex.h = th
  self.font:setStyle("normal")
end

function _M:loadUI(t)
	if not t.no_reset then
		self.uis = {}
		self.ui_by_ui = {}
		self.focus_ui = nil
		self.focus_ui_id = 0
	end
	for i, ui in ipairs(t) do
		self.uis[#self.uis+1] = ui
		self.ui_by_ui[ui.ui] = ui

		if not self.focus_ui and ui.ui.can_focus then
			self:setFocus(i)
		elseif ui.ui.can_focus then
			ui.ui:setFocus(false)
		end
	end
end

function _M:setupUI(resizex, resizey, on_resize, addmw, addmh)
	local mw, mh = nil, nil

--	resizex, resizey = true, true
	if resizex or resizey then
		mw, mh = 0, 0
		local addw, addh = 0, 0

		for i, ui in ipairs(self.uis) do
			if not ui.absolute then
				if ui.top then mh = math.max(mh, ui.top + ui.ui.h + (ui.padding_h or 0))
				elseif ui.bottom then addh = math.max(addh, ui.bottom + ui.ui.h + (ui.padding_h or 0))
				end
			end

--		print("ui", ui.left, ui.right, ui.ui.w)
			if not ui.absolute then
				if ui.left then mw = math.max(mw, ui.left + ui.ui.w + (ui.padding_w or 0))
				elseif ui.right then addw = math.max(addw, ui.right + ui.ui.w + (ui.padding_w or 0))
				end
			end
		end
--		print("===", mw, addw)
		mw = mw + addw + 5 * 2 + (addmw or 0)

--		print("===", mw, addw)
		local tw, th = 0, 0
		if self.title then
      self.font_bold:setStyle("bold")
      tw, th = self.font_bold:size(self.title.."WWWW")
    end
    self.font:setStyle("normal")
		mw = math.max(tw + 6, mw)

		mh = mh + addh + 5 + 22 + 3 + (addmh or 0) + th

		if on_resize then on_resize(resizex and mw or self.w, resizey and mh or self.h) end
		self:resize(resizex and mw or self.w, resizey and mh or self.h)
	else
		if on_resize then on_resize(self.w, self.h) end
		self:resize(self.w, self.h)
	end

	for i, ui in ipairs(self.uis) do
		local ux, uy

		if not ui.absolute then
			ux, uy = self.ix, self.iy

			if ui.top then
				if type(ui.top) == "table" then ui.top = self.ui_by_ui[ui.top].y end
				uy = uy + ui.top
			elseif ui.bottom then
				if type(ui.bottom) == "table" then ui.bottom = self.ui_by_ui[ui.bottom].y end
				uy = uy + self.ih - ui.bottom - ui.ui.h
			elseif ui.vcenter then
				if type(ui.vcenter) == "table" then ui.vcenter = self.ui_by_ui[ui.vcenter].y + ui.vcenter.h end
				uy = uy + math.floor(self.ih / 2) + ui.vcenter - ui.ui.h / 2
			end

			if ui.left then
				if type(ui.left) == "table" then ui.left = self.ui_by_ui[ui.left].x + ui.left.w end
				ux = ux + ui.left
			elseif ui.right then
				if type(ui.right) == "table" then ui.right = self.ui_by_ui[ui.right].x end
				ux = ux + self.iw - ui.right - ui.ui.w
			elseif ui.hcenter then
				if type(ui.hcenter) == "table" then ui.hcenter = self.ui_by_ui[ui.hcenter].x + ui.hcenter.w end
				ux = ux + math.floor(self.iw / 2) + ui.hcenter - ui.ui.w / 2
			elseif ui.hcenter_left then
				if type(ui.hcenter_left) == "table" then 
					ui.hcenter_left = self.ui_by_ui[ui.hcenter_left].x + ui.hcenter_left.w
					ux = ux + ui.hcenter_left - self.ix
				else
					ux = ux + math.floor(self.iw / 2) + ui.hcenter_left
				end
			end
		else
			ux, uy = 0, 0

			if ui.top then uy = uy + ui.top
			elseif ui.bottom then uy = uy + game.h - ui.bottom - ui.ui.h
			elseif ui.vcenter then uy = uy + math.floor(game.h / 2) + ui.vcenter - ui.ui.h / 2 end

			if ui.left then ux = ux + ui.left
			elseif ui.right then ux = ux + game.w - ui.right - ui.ui.w
			elseif ui.hcenter then ux = ux + math.floor(game.w / 2) + ui.hcenter - ui.ui.w / 2 end

			ux = ux - self.display_x
			uy = uy - self.display_y
		end

		ui.x = ux
		ui.y = uy
		ui.ui.mouse.delegate_offset_x = ux
		ui.ui.mouse.delegate_offset_y = uy
		ui.ui:positioned(ux, uy, self.display_x + ux, self.display_y + uy)
	end

	self.setuped = true
end

function _M:setFocus(id, how)
	if type(id) == "table" then
		for i = 1, #self.uis do
			if self.uis[i].ui == id then id = i break end
		end
		if type(id) == "table" then self:no_focus() return end
	end

	local ui = self.uis[id]
	if self.focus_ui == ui then return end
	if self.focus_ui and (self.focus_ui.ui.can_focus or (self.focus_ui.ui.can_focus_mouse and how=="mouse")) then self.focus_ui.ui:setFocus(false) end
	if not ui.ui.can_focus then self:no_focus() return end
	self.focus_ui = ui
	self.focus_ui_id = id
	ui.ui:setFocus(true)
	self:on_focus(id, ui)
end

function _M:moveUIElement(id, left, right, top, bottom)
	if type(id) == "table" then
		for i = 1, #self.uis do
			if self.uis[i].ui == id then id = i break end
		end
		if type(id) == "table" then return end
	end

	self.uis[id].left = left or self.uis[id].left
	self.uis[id].right = right or self.uis[id].right
	self.uis[id].top = top or self.uis[id].top
	self.uis[id].bottom = bottom or self.uis[id].bottom
end

function _M:getUIElement(id)
	if type(id) == "table" then
		for i = 1, #self.uis do
			if self.uis[i].ui == id then id = i break end
		end
		if type(id) == "table" then return end
	end

	return self.uis[id]
end

function _M:toggleDisplay(ui, show)
	if not self.ui_by_ui[ui] then return end
	self.ui_by_ui[ui].hidden = not show
end

function _M:moveFocus(v)
	local id = self.focus_ui_id
	local start = id or 1
	local cnt = 0
	id = util.boundWrap((id or 1) + v, 1, #self.uis)
	while start ~= id and cnt <= #self.uis do
		if self.uis[id] and self.uis[id].ui and self.uis[id].ui.can_focus and not self.uis[id].ui.no_keyboard_focus then
			self:setFocus(id)
			break
		end
		id = util.boundWrap(id + v, 1, #self.uis)
		cnt = cnt + 1
	end
end

function _M:on_focus(id, ui)
end
function _M:no_focus()
end

function _M:mouseEvent(button, x, y, xrel, yrel, bx, by, event)
	-- Look for focus
	for i = 1, #self.uis do
		local ui = self.uis[i]
		if (ui.ui.can_focus or ui.ui.can_focus_mouse) and bx >= ui.x and bx <= ui.x + ui.ui.w and by >= ui.y and by <= ui.y + ui.ui.h then
			self:setFocus(i, "mouse")

			-- Pass the event
			ui.ui.mouse:delegate(button, bx, by, xrel, yrel, bx, by, event)
			return
		end
	end
	self:no_focus()
end

function _M:keyEvent(...)
	if not self.focus_ui or not self.focus_ui.ui.key:receiveKey(...) then
		KeyBind.receiveKey(self.key, ...)
	end
end
function _M:display() end

--- This does nothing and can be changed by other classes
function _M:unload()
end

--- This provides required cleanups, do not touch
function _M:cleanup()
	for p, _ in pairs(self.particles) do p:dieDisplay() end

	for i = 1, #self.uis do
		if self.uis[i].ui and self.uis[i].ui.on_dialog_cleanup then self.uis[i].ui:on_dialog_cleanup() end
	end
end

function _M:drawFrame(x, y, r, g, b, a)
	x = x + self.frame.ox1
	y = y + self.frame.oy1

	-- Sides
	self.b8.t:toScreenFull(x + self.b7.w, y, self.frame.w - self.b7.w - self.b9.w, self.b8.h, self.b8.tw, self.b8.th, r, g, b, a)
	self.b2.t:toScreenFull(x + self.b7.w, y + self.frame.h - self.b3.h, self.frame.w - self.b7.w - self.b9.w, self.b2.h, self.b2.tw, self.b2.th, r, g, b, a)
	self.b4.t:toScreenFull(x, y + self.b7.h, self.b4.w, self.frame.h - self.b7.h - self.b1.h, self.b4.tw, self.b4.th, r, g, b, a)
	self.b6.t:toScreenFull(x + self.frame.w - self.b9.w, y + self.b7.h, self.b6.w, self.frame.h - self.b7.h - self.b1.h, self.b6.tw, self.b6.th, r, g, b, a)

	-- Corners
	self.b1.t:toScreenFull(x, y + self.frame.h - self.b1.h, self.b1.w, self.b1.h, self.b1.tw, self.b1.th, r, g, b, a)
	self.b7.t:toScreenFull(x, y, self.b7.w, self.b7.h, self.b7.tw, self.b7.th, r, g, b, a)
	self.b9.t:toScreenFull(x + self.frame.w - self.b9.w, y, self.b9.w, self.b9.h, self.b9.tw, self.b9.th, r, g, b, a)
	self.b3.t:toScreenFull(x + self.frame.w - self.b3.w, y + self.frame.h - self.b3.h, self.b3.w, self.b3.h, self.b3.tw, self.b3.th, r, g, b, a)

	-- Body
	self.b5.t:toScreenFull(x + self.b7.w, y + self.b7.h, self.frame.w - self.b7.w - self.b3.w , self.frame.h - self.b7.h - self.b3.h, self.b5.tw, self.b5.th, r, g, b, a)

	-- Overlays
	for i = 1, #self.overs do
		local ov = self.overs[i]
		ov.t:toScreenFull(x + ov.x, y + ov.y, ov.w , ov.h, ov.tw, ov.th, r, g, b, a * ov.a)
	end

	if self.frame.particles then
		for i, pdef in ipairs(self.frame.particles) do
			if rng.chance(pdef.chance) then
				local p = Particles.new(pdef.name, 1, pdef.args)
				local pos = {x=0, y=0}
				if pdef.position.base == 7 then
					pos.x = pdef.position.ox
					pos.y = pdef.position.oy
				elseif pdef.position.base == 9 then
					pos.x = self.w + pdef.position.ox + self.b9.w
					pos.y = pdef.position.oy
				elseif pdef.position.base == 1 then
					pos.x = pdef.position.ox
					pos.y = self.h + pdef.position.oy + self.b1.h
				elseif pdef.position.base == 3 then
					pos.x = self.w + pdef.position.ox + self.b3.w
					pos.y = self.h + pdef.position.oy + self.b3.h
				end
				self.particles[p] = pos
			end
		end
	end

	if next(self.particles) then
		for p, pos in pairs(self.particles) do
			if p.ps:isAlive() then
				p.ps:toScreen(x + pos.x, y + pos.y, true, 1)
			else
				self.particles[p] = nil
			end
		end
	end
end

function _M:innerDisplayBack(x, y, nb_keyframes)
end
function _M:innerDisplay(x, y, nb_keyframes)
end

function _M:firstDisplay()
end

function _M:setTitleShadowShader(shader, power)
	self.shadow_shader = shader
	self.shadow_power = power
end

function _M:toScreen(x, y, nb_keyframes)
	if self.__hidden then return end

	local shader = self.shadow_shader

	local zoom = 1
	if self.__showup then
		local eff = self.__showup_effect or "pop"
		if eff == "overpop" then
			zoom = self.__showup / 7
			if self.__showup >= 9 then
				zoom = (9 - (self.__showup - 9)) / 7 - 1
				zoom = 1 + zoom * 0.5
			end
			self.__showup = self.__showup + nb_keyframes
			if self.__showup >= 11 then self.__showup = nil end
		else
			zoom = self.__showup / 7
			self.__showup = self.__showup + nb_keyframes
			if self.__showup >= 7 then self.__showup = nil end
		end
	end

	-- We translate and scale opengl matrix to make the popup effect easily
	local ox, oy = x, y
	local hw, hh = math.floor(self.w / 2), math.floor(self.h / 2)
	local tx, ty = x + hw, y + hh
	x, y = -hw, -hh
	core.display.glTranslate(tx, ty, 0)
	if zoom < 1 then core.display.glScale(zoom, zoom, zoom) end

	-- Draw the frame and shadow
	if self.frame.shadow then self:drawFrame(x + self.frame.shadow.x, y + self.frame.shadow.y, 0, 0, 0, self.frame.shadow.a) end
	self:drawFrame(x, y, self.frame.darkness, self.frame.darkness, self.frame.darkness, self.frame.a)

	-- Title
	if self.title then
		if self.title_shadow then
			if shader then
				shader:use(true)
				shader:uniOutlineSize(self.shadow_power, self.shadow_power)
				shader:uniTextSize(self.title_tex[2], self.title_tex[3])
			else
				self.title_tex[1]:toScreenFull(x + (self.w - self.title_tex.w) / 2 + 3 + self.frame.title_x, y + 3 + self.frame.title_y, self.title_tex.w, self.title_tex.h, self.title_tex[2], self.title_tex[3], 0, 0, 0, 0.5)
			end
		end
		self.title_tex[1]:toScreenFull(x + (self.w - self.title_tex.w) / 2 + self.frame.title_x, y + self.frame.title_y, self.title_tex.w, self.title_tex.h, self.title_tex[2], self.title_tex[3])
		if self.title_shadow and shader then shader:use(false) end
	end

	self:innerDisplayBack(x, y, nb_keyframes, tx, ty)

	-- UI elements
	for i = 1, #self.uis do
		local ui = self.uis[i]
		if not ui.hidden then ui.ui:display(x + ui.x, y + ui.y, nb_keyframes, ox + ui.x, oy + ui.y) end
	end

	self:innerDisplay(x, y, nb_keyframes, tx, ty)

	if self.first_display then self:firstDisplay() self.first_display = false end

	-- Restore normal opengl matrix
	if zoom < 1 then core.display.glScale() end
	core.display.glTranslate(-tx, -ty, 0)
end
