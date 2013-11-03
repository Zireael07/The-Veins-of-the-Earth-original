-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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
local Dialog = require "engine.ui.Dialog"
local Tab = require "engine.ui.Tab"
local Mouse = require "engine.Mouse"
local Slider = require "engine.ui.Slider"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, shadow, log, chat)
	local w = math.floor(game.w * 0.9)
	local h = math.floor(game.h * 0.9)
	Dialog.init(self, title, w, h)
	if shadow then self.shadow = shadow end

	self.log, self.chat = log, chat

	self.event_fct = function(e) self:onTalkEvent(e) end
	chat:registerTalkEvents(self.event_fct)

	local tabs = {}

	local order = {}
	local list = {}
	for name, data in pairs(chat.channels) do list[#list+1] = name end
	table.sort(list, function(a,b) if a == "global" then return 1 elseif b == "global" then return nil else return a < b end end)
	order[#order+1] = {timestamp=log:getLogLast(), tab="__log"}

	tabs[#tabs+1] = {top=0, left=0, ui = Tab.new{title="Game Log", fct=function() end, on_change=function() local i = #tabs self:switchTo(tabs[1]) end, default=true}, tab_channel="__log" }
	for i, name in ipairs(list) do
		local oname = name
		local nb_users = 0
		for _, _ in pairs(chat.channels[name].users) do nb_users = nb_users + 1 end
		name = name:capitalize().." ("..nb_users..")"

		local ii = i
		tabs[#tabs+1] = {top=0, left=(#tabs==0) and 0 or tabs[#tabs].ui, ui = Tab.new{title=name, fct=function() end, on_change=function() local i = ii+1 self:switchTo(tabs[i]) end, default=false}, tab_channel=oname }
		order[#order+1] = {timestamp=chat:getLogLast(oname), tab=oname}
	end

	self.start_y = tabs[1].ui.h + 5

	self:loadUI(tabs)
	self.tabs = tabs
	self:setupUI()

	self.scrollbar = Slider.new{size=self.h - 20, max=1, inverse=true}

	table.sort(order, function(a,b) return a.timestamp > b.timestamp end)
	self:switchTo(self.last_tab or "__log")
end

function _M:unload()
	self.chat:unregisterTalkEvents(self.event_fct)
end

function _M:onTalkEvent(e)
	if not e.channel then return end
	if e.channel ~= self.last_tab then return end
	self:switchTo(self.last_tab)
end

function _M:generate()
	Dialog.generate(self)

	-- Add UI controls
	local tabs = self.tabs
	self.key:addBinds{
		MOVE_UP = function() self:setScroll(self.scroll - 1) end,
		MOVE_DOWN = function() self:setScroll(self.scroll + 1) end,
		ACCEPT = "EXIT",
		EXIT = function() game:unregisterDialog(self) end,
	}
	self.key:addCommands{
		_TAB = function() local sel = 1 for i=1, #tabs do if tabs[i].ui.selected then sel = i break end end self:switchTo(tabs[util.boundWrap(sel+1, 1, #tabs)]) end,
		_HOME = function() self:setScroll(1) end,
		_END = function() self:setScroll(self.max) end,
		_PAGEUP = function() self:setScroll(self.scroll - self.max_display) end,
		_PAGEDOWN = function() self:setScroll(self.scroll + self.max_display) end,
	}

	for i, tab in ipairs(tabs) do
		local tab = tab
		tab.ui.key:addBind("USERCHAT_TALK", function()
			local type, name = profile.chat:getCurrentTarget()
			if type == "channel" and self.last_tab ~= "__log" then profile.chat:setCurrentTarget(true, self.last_tab) end
			profile.chat:talkBox()
		end)
	end
end

function _M:mouseEvent(button, x, y, xrel, yrel, bx, by, event)
	Dialog.mouseEvent(self, button, x, y, xrel, yrel, bx, by, event)

	if button == "wheelup" and event == "button" then self.key:triggerVirtual("MOVE_UP")
	elseif button == "wheeldown" and event == "button" then self.key:triggerVirtual("MOVE_DOWN")
	else
		if not self.dlist then return end
		local citem, gitem = nil, nil
		for i = #self.dlist, 1, -1 do
			local item = self.dlist[i]
			if item.dh and by >= item.dh then citem = self.dlist[i].src gitem = self.dlist[i].d break end
		end

		if event == "motion" then
			local tooltip = nil
			if citem and citem.extra_data and citem.extra_data.mode == "tooltip" then
				tooltip = citem.extra_data.tooltip
				tooltip = tooltip:toTString()
			end

			if gitem then
				local sub_es = {}
				for di = 1, #gitem._dduids do sub_es[#sub_es+1] = gitem._dduids[di].e end
				if sub_es and #sub_es > 0 then
					if not tooltip then tooltip = tstring{} end
					for i, e in ipairs(sub_es) do
						if e.tooltip then
							tooltip:merge(e:tooltip())
							if e:getEntityKind() == "actor" then tooltip:add(true, "Right click to inspect.", true) end
							if i < #sub_es then tooltip:add(true, "---", true)
							else tooltip:add(true) end
						end
					end
				end
			end

			if tooltip then
				game:tooltipDisplayAtMap(game.w, game.h, tooltip)
			else
				game.tooltip_x, game.tooltip_y = nil, nil
			end
		elseif event == "button" then
			if citem and citem.url and button == "left" then
				util.browserOpenUrl(citem.url)
			end

			if gitem and button == "right" then
				local sub_es = {}
				for di = 1, #gitem._dduids do sub_es[#sub_es+1] = gitem._dduids[di].e end
				if sub_es and #sub_es > 0 then
					if not tooltip then tooltip = tstring{} end
					for i, e in ipairs(sub_es) do
						if e:getEntityKind() == "actor" then
							game:registerDialog(require("mod.dialogs.CharacterSheet").new(e))
						end
					end
				end
			end

			if citem and citem.login then
				local data = profile.chat:getUserInfo(citem.login)
				if data then
					local list = {
						{name="Show infos", ui="show"},
						{name="Whisper", ui="whisper"},
						{name="Ignore", ui="ignore"},
						{name="Open profile(in browser)", ui="profile"},
						{name="Report for bad behavior", ui="report"}
					}
					if data.char_link then table.insert(list, 3, {name="Open charsheet(in browser)", ui="charsheet"}) end
					Dialog:listPopup("User: "..citem.login, "Action", list, 300, 200, function(sel)
						if not sel or not sel.ui then return end
						if sel.ui == "show" then
							local UserInfo = require "engine.dialogs.UserInfo"
							game:registerDialog(UserInfo.new(data))
						elseif sel.ui == "profile" then
							util.browserOpenUrl(data.profile)
						elseif sel.ui == "charsheet" then
							util.browserOpenUrl(data.char_link)
						elseif sel.ui == "whisper" then
							profile.chat:setCurrentTarget(false, citem.login)
							profile.chat:talkBox()
						elseif sel.ui == "ignore" then
							Dialog:yesnoPopup("Ignore user", "Really ignore all messages from: "..citem.login, function(ret) if ret then profile.chat:ignoreUser(citem.login) end end)
						elseif sel.ui == "report" then
							game:registerDialog(require('engine.dialogs.GetText').new("Reason to report: "..citem.login, "Reason", 4, 500, function(text)
								profile.chat:reportUser(citem.login, text)
								game.log("#VIOLET#", "Report sent.")
							end))							
						end
					end)
				end
			end
		end
	end
end

function _M:loadLog(log, oldscroll)
	self.lines = {}
	for i = #log, 1, -1 do
		if type(log[i]) == "string" then
			self.lines[#self.lines+1] = {str=log[i]}
		else
			self.lines[#self.lines+1] = log[i]
		end
	end

	self.max_h = self.ih - self.iy
	self.max = #log
	self.max_display = math.floor(self.max_h / self.font_h)

	self.scrollbar.max = self.max - self.max_display + 1
	self.scroll = nil
	self:setScroll(oldscroll or (self.max - self.max_display + 1))
end

function _M:switchTo(ui)
	if type(ui) == "string" then for i, tab in ipairs(self.tabs) do if tab.tab_channel == ui then ui = tab end end end
	if type(ui) == "string" then ui = self.tabs[1] end

	for i, ui in ipairs(self.tabs) do ui.ui.selected = false end
	ui.ui.selected = true
	if ui.tab_channel == "__log" then
		self:loadLog(self.log:getLog(true))
	else
		local s = nil
		if _M.last_tab == ui.tab_channel and self.max and self.max_display and self.scroll < self.max - self.max_display + 1 then
			s = self.scroll
		end
		self:loadLog(self.chat:getLog(ui.tab_channel, true), s)
	end
	-- Set it on the class to persist between invocations
	_M.last_tab = ui.tab_channel
end

function _M:setScroll(i)
	local old = self.scroll
	self.scroll = util.bound(i, 1, math.max(1, self.max - self.max_display + 1))
	if self.scroll == old then return end

	self.dlist = {}
	local nb = 0
	local old_style = self.font:getStyle()
	for z = 1 + self.scroll, #self.lines do
		local stop = false
		local tstr = self.lines[z]
		if not tstr then break end
		local gen = self.font:draw(tstr.str, self.iw - 10, 255, 255, 255, false, true)
		for i = 1, #gen do
			self.dlist[#self.dlist+1] = {d=gen[i], src=self.lines[z].src}
			nb = nb + 1
			if nb >= self.max_display then stop = true break end
		end
		if stop then break end
	end
	self.font:setStyle(old_style)
end

function _M:innerDisplay(x, y, nb_keyframes, tx, ty)
	local h = y + self.iy + self.start_y
	for i = 1, #self.dlist do
		local item = self.dlist[i].d
		if self.shadow then item._tex:toScreenFull(x+2, h+2, item.w, item.h, item._tex_w, item._tex_h, 0,0,0, self.shadow) end
		item._tex:toScreenFull(x, h, item.w, item.h, item._tex_w, item._tex_h)

		for di = 1, #item._dduids do item._dduids[di].e:toScreen(nil, x + item._dduids[di].x, h, item._dduids[di].w, item._dduids[di].w, 1) end

		self.dlist[i].dh = h - y
--		print("<<",i,"::",h + ty)
		h = h + self.font_h
	end

	self.scrollbar.pos = self.scrollbar.max - self.scroll + 1
	self.scrollbar:display(x + self.iw - self.scrollbar.w, y)
end
