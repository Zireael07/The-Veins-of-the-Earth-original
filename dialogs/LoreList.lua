-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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

--Based on ToME 4

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local ListColumns = require "engine.ui.ListColumns"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local Image = require "engine.ui.Image"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, actor)
	self.actor = actor
--	print("Lore")
	local total = #actor.lore_defs + actor.additional_lore_nb
	local nb = 0
	for id, data in pairs(actor.lore_known) do nb = nb + 1 end

	Dialog.init(self, (title or "Lore").." ("..nb.."/"..total..")", game.w * 0.8, game.h * 0.8)

	self.c_desc = TextzoneList.new{width=math.floor(self.iw / 2 - 10), scrollbar=true, height=self.ih}

	self:generateList()

	self.c_list = ListColumns.new{width=math.floor(self.iw / 2 - 10), height=self.ih - 10, scrollbar=true, sortable=true, columns={
		{name="", width={40,"fixed"}, display_prop="order", sort="order"},
		{name="Lore", width=60, display_prop="name", sort="name"},
		{name="Category", width=40, display_prop="cat", sort="cat"},
	}, list=self.list, fct=function(item) end, select=function(item, sel) self:select(item) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
		{right=0, top=0, ui=self.c_desc},
		{hcenter=0, top=5, ui=Separator.new{dir="horizontal", size=self.ih - 10}},
	}
	self:setFocus(self.c_list)
	self:setupUI()
	self:select(self.list[1])

	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:generateList()
	-- Makes up the list
	local list = {}
	local i = 0
	for id, _ in pairs(self.actor.lore_known) do
		local l = self.actor:getLore(id)
		list[#list+1] = { name=l.name, desc=util.getval(l.lore), cat=l.category, order=l.order, image=l.image }
		i = i + 1
	end
	-- Add known artifacts
	table.sort(list, function(a, b) return a.order < b.order end)
	self.list = list
end

function _M:select(item)
	if item then
		self.c_desc:switchItem(item, ("#GOLD#Category:#AQUAMARINE# %s\n#GOLD#Found as:#0080FF# %s\n#GOLD#Text:#ANTIQUE_WHITE# %s"):format(item.cat, item.name, item.desc))
	end
end