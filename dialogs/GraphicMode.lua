-- Veins of the Earth
-- Copyright (C) 2013-14 Zireael
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
local List = require "engine.ui.List"
local Button = require "engine.ui.Button"
local Checkbox = require "engine.ui.Checkbox"
local Textzone = require "engine.ui.Textzone"
local Textbox = require "engine.ui.Textbox"
local GetQuantity = require "engine.dialogs.GetQuantity"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Dialog))


function _M:init()
	self:generateList()
	self.changed = false

	Dialog.init(self, "Change graphic mode", 300, 20)

	self.c_list = List.new{width=self.iw, nb_items=7, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBinds{
		EXIT = function()
			if self.changed then game:setupDisplayMode(true) end
			game:unregisterDialog(self)
		end,
	}
end


function _M:use(item)
	if not item then return end
	config.settings.veins.tiles = item.val
	self.changed = true
	
	Map:resetTiles()
	game:unregisterDialog(self)

	game:setupDisplayMode(true)
end

function _M:generateList()
	local list = { {name="tiles", val="tiles"}, {name="ASCII", val="ascii"}, }
	self.list = list
end
