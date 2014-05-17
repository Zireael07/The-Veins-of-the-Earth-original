-- Veins of the Earth
-- Copyright (C) 2013-2014 Zireael
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


--Based on ToME 4 code

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local LoreInfo = require "mod.dialogs.LoreInfo"

module(..., package.seeall, class.make)

_M.lore_defs = {}

--- Loads lore
function _M:loadDefinition(file, env)
	local f, err = loadfile(file)
	if not f and err then error(err) end
	setfenv(f, setmetatable(env or {
		newLore = function(t) self:newLore(t) end,
		load = function(f) self:loadDefinition(f, getfenv(2)) end
	}, {__index=_G}))
	f()
end

--- Make a new lore with a name and desc
function _M:newLore(t)
	assert(t.id, "no lore name")
	assert(t.category, "no lore category")
	assert(t.name, "no lore name")
	assert(t.lore, "no lore lore")

	t.order = #self.lore_defs+1

	self.lore_defs[t.id] = t
	self.lore_defs[#self.lore_defs+1] = t
--	print("[LORE] defined", t.order, t.id)
end

function _M:init(t)
	self.additional_lore = self.additional_lore or {}
	self.additional_lore_nb = self.additional_lore_nb or 0
	self.lore_known = self.lore_known or {}
end

function _M:knownLore(lore)
	self.lore_known = self.lore_known or {}
	return self.lore_known[lore] and true or false
end

function _M:getLore(lore, silent)
	self.lore_known = self.lore_known or {}
	self.additional_lore = self.additional_lore or {}
	if not silent then assert(self.lore_defs[lore] or self.additional_lore[lore], "bad lore id "..lore) end
	return self.lore_defs[lore] or self.additional_lore[lore]
end

function _M:additionalLore(id, name, category, lore)
	self.additional_lore = self.additional_lore or {}
	if self.additional_lore[id] then return end
	self.additional_lore_nb = (self.additional_lore_nb or 0) + 1
	self.additional_lore[id] = {id=id, name=name, category=category, lore=lore, order=self.additional_lore_nb + #self.lore_defs}
end

function _M:learnLore(lore, nopopup, silent, nostop)
	local l = self:getLore(lore, silent)
	if not l then return end
	local learnt = false

	self.lore_known = self.lore_known or {}

	

	if not self:knownLore(lore) or l.always_pop then
		game.logPlayer(self, "Lore found: #UMBER#%s", l.name)

		game:registerDialog(require("mod.dialogs.LoreInfo").new(l, self.player))

	--[[	if not nopopup then
	--		LoreInfo.new(l, game.player)

			game.logPlayer(self, "You can read all your collected lore in the game menu, by pressing Escape.")
		end]]
		learnt = true
	end

	self.lore_known[lore] = true
--	if learnt and not self.additional_lore[lore] then game.player:registerLoreFound(lore) end
	print("[LORE] learnt", lore)
	if learnt then if l.on_learn then l.on_learn(self) end end

	if game.player.runStop and not nostop then
		game.player:runStop("learnt lore")
		game.player:restStop("learnt lore")
	end
end
