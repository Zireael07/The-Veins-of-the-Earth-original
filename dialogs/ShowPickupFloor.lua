--Veins of the Earth
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

require 'engine.class'
local ShowPickupFloor = require 'engine.dialogs.ShowPickupFloor'

module(..., package.seeall, class.inherit(ShowPickupFloor))

function _M:init(title, x, y, filter, action, takeall, actor)
  ShowPickupFloor.init(self, title, x, y, filter, action, takeall, actor)

  -- Widen the 'char' column a bit to stop the @#$%ing annoying wiggling.
  self.c_list:setColumns {
    {name="", width={26,"fixed"}, display_prop="char"},
    {name="", width={24,"fixed"}, display_prop="object", sort="sortname", direct_draw=function(item, x, y) item.object:toScreen(nil, x+4, y, 16, 16) end},
    {name="Item", width=72, display_prop="sortname"},
    {name="Category", width=25, display_prop="cat"},
    {name="Enc.", width=8, display_prop="encumberance"},
  }
end
