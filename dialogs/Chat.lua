-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2015 Nicolas Casalini
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
local VariableList = require "engine.ui.VariableList"
local Textzone = require "engine.ui.Textzone"
local Separator = require "engine.ui.Separator"
local Image = require "engine.ui.Image"

local ActorFrame = require "mod.class.patch.ActorFrame"
--local ActorFrame = require "engine.ui.ActorFrame"


module(..., package.seeall, class.inherit(Dialog))

--show_portraits = false
show_portraits = true

function _M:init(chat, id)
	self.cur_id = id
	self.chat = chat
	self.npc = chat.npc
	self.player = chat.player
	Dialog.init(self, self.npc.name, 500, 400)

	local xoff = 0
	if self.show_portraits then
		print("[CHAT] Show portraits enabled")
		xoff = 64
	end

	self:generateList()

	self.c_desc = Textzone.new{width=self.iw - 10 - xoff, height=1, auto_height=true, text=self.text.."\n"}
	self.c_list = VariableList.new{width=self.iw - 10 - xoff, max_height=game.h * 0.70 - self.c_desc.h, list=self.list, fct=function(item) self:use(item) end, select=function(item) self:select(item) end}

	local uis = {
		{left=0, top=0, ui=self.c_desc},
		{left=0, bottom=0, ui=self.c_list},
		{left=5, top=self.c_desc.h - 10, ui=Separator.new{dir="vertical", size=self.iw - 10}},
	}
	if self.show_portraits then
	--[[	if self.npc.portrait then
			image = Image.new{file=self.npc.portrait, auto_width=true, auto_height=true}
			uis[#uis+1] = {right=0, top=0, ui=image }
		end]]
		uis[#uis+1] = {right=0, top=0, ui=ActorFrame.new{actor=self.npc.chat_display_entity or self.npc, w=64, h=64}}

		if self.npc.portrait_table then
			local table = self.npc.portrait_table
			for i, t in ipairs(table) do
				image = Image.new{file=t.image, auto_width=true, auto_height=true}
				self.image.w = 64
				self.image.h = 64
				uis[#uis+1] = {right=0, top=0, ui=image}
			end
		end

		uis[#uis+1] = {left=0, bottom=0, ui=ActorFrame.new{actor=self.player.chat_display_entity or self.player, w=64, h=64}}
		uis[2].left = nil uis[2].right = 0
		uis[3].top = math.max(self.c_desc.h, uis[4].ui.h) + 5
	end

	self:loadUI(uis)
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addCommands{
		__TEXTINPUT = function(c)
			if self.list and self.list.chars[c] then
				self:use(self.list[self.list.chars[c]])
			end
		end,
	}
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:select(item)
	local a = self.chat:get(self.cur_id).answers[item.answer]
	if not a then return end

	if a.on_select then
		a.on_select(self.npc, self.player, self)
	end
end

function _M:use(item, a)
	a = a or self.chat:get(self.cur_id).answers[item.answer]
	if not a then return end

	print("[CHAT] selected", a[1], a.action, a.jump)
	if a.switch_npc then self.chat:switchNPC(a.switch_npc) end
	if a.action then
		local id = a.action(self.npc, self.player, self)
		if id then
			self.cur_id = id
			self:regen()
			return
		end
	end
	if a.jump and not self.killed then
		self.cur_id = a.jump
		self:regen()
	else
		game:unregisterDialog(self)
		return
	end
end

function _M:regen()
	local d = new(self.chat, self.cur_id)
	d.__showup = false
	game:replaceDialog(self, d)
	self.next_dialog = d
end
function _M:resolveAuto()
--[[
	if not self.chat:get(self.cur_id).auto then return end
	for i, a in ipairs(self.chat:get(self.cur_id).answers) do
		if not a.cond or a.cond(self.npc, self.player) then
			if not self:use(nil, a) then return
			else return self:resolveAuto()
			end
		end
	end
]]
end

function _M:generateList()
	self:resolveAuto()

	-- Makes up the list
	local list = { chars={} }
	local nb = 1
	for i, a in ipairs(self.chat:get(self.cur_id).answers) do
		if not a.fallback and (not a.cond or a.cond(self.npc, self.player)) then
			list[#list+1] = { name=string.char(string.byte('a')+nb-1)..") "..self.chat:replace(a[1]), answer=i, color=a.color}
			list.chars[string.char(string.byte('a')+nb-1)] = #list
			nb = nb + 1
		end
	end
	if #list == 0 then
		for i, a in ipairs(self.chat:get(self.cur_id).answers) do
			if a.fallback and (not a.cond or a.cond(self.npc, self.player)) then
				list[#list+1] = { name=string.char(string.byte('a')+nb-1)..") "..self.chat:replace(a[1]), answer=i, color=a.color}
				list.chars[string.char(string.byte('a')+nb-1)] = #list
				nb = nb + 1
			end
		end
	end
	self.list = list

	self.text = self.chat:replace(self.chat:get(self.cur_id).text)

	if self.chat:get(self.cur_id).action then
		self.chat:get(self.cur_id).action(self.npc, self.player)
	end

	return true
end
