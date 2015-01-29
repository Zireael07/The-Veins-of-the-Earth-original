-- ToME - Tales of Maj'Eyal
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
require "engine.ui.Dialog"
local List = require "engine.ui.List"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

local orders = {
	escort_rest = {-100, function(actor) return "Wait a few turns" end},
	escort_portal = {-99, function(actor) return "Where is the portal?" end},
	target = {1, function(actor) return ("Set the target [current: %s]"):format(actor.ai_target.actor and actor.ai_target.actor.name or "none") end},
	behavior = {2, function(actor) return ("Set behavior [current: %s]"):format(actor.ai_tactic.type or "default") end},
	anchor = {3, function(actor) return ("Set the leash anchor [current: %s]"):format(actor.ai_state.tactic_leash_anchor and actor.ai_state.tactic_leash_anchor.name or "none") end},
	leash = {4, function(actor) return ("Set the leash distance [current: %d]"):format(actor.ai_state.tactic_leash) end},
	talents = {5, function(actor) return ("Define tactical talents usage") end},
}

function _M:init(actor, def)
	self.actor = actor
	self.def = def
	self:generateList()
	engine.ui.Dialog.init(self, "Order: "..actor.name, 1, 1)

	local list = List.new{width=400, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=list},
	}
	self:setupUI(true, true)

	self.key:addCommands{ __TEXTINPUT = function(c) if self.list and self.list.chars[c] then self:use(self.list[self.list.chars[c]]) end end}
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	game.party:giveOrder(self.actor, item.order)
end

function _M:generateList()
	local list = {}

	for o, _ in pairs(self.def.orders) do
		if orders[o] then
			list[#list+1] = {name=orders[o][2](self.actor), order=o, sort=orders[o][1]}
		end
	end
	table.sort(list, function(a,b) return a.sort < b.sort end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = self:makeKeyChar(i)..") "..v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end
