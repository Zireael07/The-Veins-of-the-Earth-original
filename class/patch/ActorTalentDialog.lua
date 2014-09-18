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

-- talentDialog and supporting functions, backported from ToME 1.2.4

local Actor = require('mod.class.Actor')

local dialog_returns_list = setmetatable({}, {__mode="v"})
local dialog_returns = setmetatable({}, {__mode="k"})

--- Set the result for a talent dialog
Actor.talentDialogReturn = function(self, ...)
	local d = dialog_returns_list[#dialog_returns_list]
	if not d then return end

	dialog_returns[d] = {...}
end

--- Get the dialog
Actor.talentDialogGet = function(self)
	return dialog_returns_list[#dialog_returns_list]
end

--- Show a dialog and wait for it to end in a talent
Actor.talentDialog = function(self, d)
	if not game.dialogs[d] then game:registerDialog(d) end

	dialog_returns_list[#dialog_returns_list+1] = d

	local co = coroutine.running()
	d.unload = function(self) coroutine.resume(co, dialog_returns[d]) end
	local ret = coroutine.yield()

	dialog_returns[d] = nil
	table.removeFromList(dialog_returns_list, d)

	return unpack(ret)
end
