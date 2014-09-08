-- $Id: ShowInventory.lua 864 2014-05-18 04:52:13Z dsb $
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
local ShowInventory = require 'engine.dialogs.ShowInventory'

module(..., package.seeall, class.inherit(ShowInventory))

function _M:init(title, inven, filter, action, actor)
  ShowInventory.init(self, title, inven, filter, action, actor)

  -- Widen the 'char' column a bit to stop the @#$%ing annoying wiggling.
  self.c_list:setColumns {
    {name="", width={26,"fixed"}, display_prop="char", sort="id"},
    {name="", width={24,"fixed"}, display_prop="object", sort="sortname", direct_draw=function(item, x, y) item.object:toScreen(nil, x+4, y, 16, 16) end},
    {name="Inventory", width=72, display_prop="name", sort="sortname"},
    {name="Category", width=20, display_prop="cat", sort="cat"},
    {name="Enc.", width=8, display_prop="encumberance", sort="encumberance"},
  }
end
