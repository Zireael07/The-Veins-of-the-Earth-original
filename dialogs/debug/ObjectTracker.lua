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
    Dialog.init(self, "Object List     Map Size: W="..game.level.map.w.." H="..game.level.map.h.."", game.w * 0.8, game.h * 0.8)
    self:generateList()

    self.c_list = ListColumns.new{width=math.floor(self.iw - 10), height=self.ih - 10, scrollbar=true, sortable=true, columns={
 
         {name="Name", width=100, display_prop="name", sort="name"},
    --    {name="Unique", width={120,"fixed"}, display_prop="unique", sort="unique"},
        {name="X", width={50,"fixed"}, display_prop="x", sort="x"},
        {name="Y", width={50,"fixed"}, display_prop="y", sort="y"},
        {name="Tile", width={100,"fixed"}, display_prop="index", sort="index"},
        {name="Type", width={120,"fixed"}, display_prop="type", sort="type"},
        {name="Allowed", width={130,"fixed"}, display_prop="allowed", sort="allowed"},
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
    -- Makes up the list of objects on level
    local list = {}
    local color_error = {colors.LIGHT_RED.r, colors.LIGHT_RED.g, colors.LIGHT_RED.b}

    for i = 0, game.level.map.w - 1 do for j = 0, game.level.map.h - 1 do
        for z = game.level.map:getObjectTotal(i, j), 1, -1 do
            local e = game.level.map:getObject(i, j, z)
            local add_entity = false
            local color_entity = {colors.WHITE.r, colors.WHITE.g, colors.WHITE.b}
            if e then
                add_entity = true
            end

        if add_entity then
            local row_color = color_entity
            local tile
            local index
                if i and j then
                index = i + j * game.level.map.w
                tile = game.level.map.map[index]
            end
            local allowed = "true"
        --    if type(entity.x) ~= "number" or entity.x < 0 or entity.x >= game.level.map.w then
            if type(i) ~= "number" or i < 0 or i >= game.level.map.w then
                row_color = color_error
            end
            if type(j) ~= "number" or j < 0 or j >= game.level.map.h then
         --   if type(entity.y) ~= "number" or entity.y < 0 or entity.y >= game.level.map.h then
                row_color = color_error
            end
            if tile and tile[Map.TERRAIN] then
                if tile[Map.TERRAIN].does_block_move then
                    allowed = "TERRAIN"
                    row_color = color_error
                end
                if not tile[Map.OBJECT] or tile[Map.OBJECT] ~= e then
                    allowed = "NOT ON MAP"
                    row_color = color_error
                end
            else
                allowed = "NO TERRAIN"
                row_color = color_error
            end
            if tile and tile[Map.OBJECT] and tile[Map.OBJECT].does_block_move then
                    allowed = "OBJECT"
                    row_color = color_error
            end
            local name = e.name
            list[#list+1] = { name=name, unique=unique_text, x=i, y=j, oldx=e.old_x, oldy=e.old_y, index=index, type=tile and tile[Map.TERRAIN] and tile[Map.TERRAIN].type or "INVALID", allowed=allowed, color=row_color }
        end
    end
    end
end
  if #table > 0 then
    table.sort(list, function(a, b) return a.index < b.index end)
  end
    self.list = list

end