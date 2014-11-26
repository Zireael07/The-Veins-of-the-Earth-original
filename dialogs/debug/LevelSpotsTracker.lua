-- Based on Marson's AWOL addon for ToME 4
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


require "engine.class"
local Dialog = require "engine.ui.Dialog"
local ListColumns = require "engine.ui.ListColumns"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
--  if not config.settings.cheat then return end
    Dialog.init(self, "Level Spots List     Map Size: W="..game.level.map.w.." H="..game.level.map.h.."", game.w * 0.8, game.h * 0.8)
    self:generateList()

    self.c_list = ListColumns.new{width=math.floor(self.iw - 10), height=self.ih - 10, scrollbar=true, sortable=true, columns={
        {name="Type", width={120,"fixed"}, display_prop="type", sort="type"},
        {name="Subtype", width=100, display_prop="subtype", sort="subtype"},
        {name="X", width={50,"fixed"}, display_prop="x", sort="x"},
        {name="Y", width={50,"fixed"}, display_prop="y", sort="y"},
    }, list=self.list, fct=function(item) end, select=function(item, sel) end}

    self:loadUI{
        {left=0, top=0, ui=self.c_list},
    }
    self:setFocus(self.c_list)
    self:setupUI()
    --self:select(self.list[1])
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end


function _M:generateList()
    -- Makes up the list of spots on level
    local list = {} 

    for i, spot in ipairs(game.level.spots) do
        list[#list+1] = { type=spot.type, subtype=spot.subtype, x=spot.x, y=spot.y }
    end

  if #table > 0 then
    table.sort(list, function(a, b) return a.type < b.type end)
  end
    self.list = list

end