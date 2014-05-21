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
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
	self:generateList()
	engine.ui.Dialog.init(self, "Summon Creature", 1, 1)

	local list = List.new{width=400, height=500, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=list},
	}
	self:setupUI(true, true)

	self.key:addCommands{ __TEXTINPUT = function(c)
		for i = list.sel + 1, #self.list do
			local v = self.list[i]
			if v.name:sub(1, 1):lower() == c:lower() then list:select(i) return end
		end
		for i = 1, list.sel do
			local v = self.list[i]
			if v.name:sub(1, 1):lower() == c:lower() then list:select(i) return end
		end
	end}
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	local n = game.zone:finishEntity(game.level, "actor", item.e)
	local x, y = util.findFreeGrid(game.player.x, game.player.y, 20, true, {[engine.Map.ACTOR]=true})
	if not x then return end
	game.zone:addEntity(game.level, n, "actor", x, y)
end

function _M:generateList()
	local list = {}

	for i, e in ipairs(game.zone.npc_list) do
		if e.name ~= "unknown actor" then
			local color
			if e.type == "encounter" then color = {255, 215, 0}
			elseif e.faction == "neutral" then color = {81, 221, 255}
			else color = {255, 255, 255} end

		list[#list+1] = {name=e.name, type=e.type, color=color, unique=e.unique, faction=e.faction, e=e}
		else end
	end
	
	table.sort(list, function(a,b)
		--Show encounters first
		if a.type == "encounter" and not b.type == "encounter" then return true
		elseif not a.type == "encounter" and b.type == "encounter" then return false end
	--[[	if a.unique and not b.unique then return true
		elseif not a.unique and b.unique then return false end]]
		return a.name < b.name
	end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end