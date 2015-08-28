-- Veins of the Earth
-- Copyright (C) 2013 Zireael
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
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init(mx, my, tmx, tmy)
    self.tmx, self.tmy = util.bound(tmx, 0, game.level.map.w - 1), util.bound(tmy, 0, game.level.map.h - 1)
    if tmx == game.player.x and tmy == game.player.y then self.on_player = true end

    self:generateList()
    self.__showup = false

    local name = "Actions"
    local w = self.font_bold:size(name)
    engine.ui.Dialog.init(self, name, 1, 100, mx, my)

    local list = List.new{width=math.max(w, self.max) + 10, nb_items=math.min(15, #self.list), scrollbar=#self.list>15, list=self.list, fct=function(item) self:use(item) end, select=function(item) self:select(item) end}

    self:loadUI{
        {left=0, top=0, ui=list},
    }

    self:setupUI(true, true, function(w, h)
        self.force_x = mx - w / 2
        self.force_y = my - self.h + (self.ih + list.fh / 3)
        if self.force_y + h > game.h then self.force_y = game.h - h end
    end)

    self.mouse:reset()
    self.mouse:registerZone(0, 0, game.w, game.h, function(button, x, y, xrel, yrel, bx, by, event) if (button == "left" or button == "right") and event == "button" then self.key:triggerVirtual("EXIT") end end)
    self.mouse:registerZone(self.display_x, self.display_y, self.w, self.h, function(button, x, y, xrel, yrel, bx, by, event) if button == "right" and event == "button" then self.key:triggerVirtual("EXIT") else self:mouseEvent(button, x, y, xrel, yrel, bx, by, event) end end)
    self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:unload()
    engine.ui.Dialog.unload(self)
    game:targetMode(false, false)
    self.exited = true
end

function _M:use(item)
    if not item then return end
    game:unregisterDialog(self)
    game:targetMode(false, false)

    local act = item.action

    if act == "move_to" then game.player:mouseMove(self.tmx, self.tmy, true)
    elseif act == "target-player" then item.actor:setTarget(game.player)
    elseif act == "order" then game.party:giveOrders(item.actor)
    elseif act == "change_level" then game.key:triggerVirtual("CHANGE_LEVEL")
    elseif act == "pickup" then game.key:triggerVirtual("PICKUP_FLOOR")
    elseif act == "character_sheet" then game:registerDialog(require("mod.dialogs.CharacterSheet").new(item.actor))
    elseif act == "monster_info" then game:registerDialog(require("mod.dialogs.MonsterInfo").new(item.actor))
    elseif act == "inventory" then game.key:triggerVirtual("SHOW_INVENTORY")
    elseif act == "rest" then game.key:triggerVirtual("REST")
    end
end

local olditem = nil
function _M:select(item)
    if self.exited then return end
    if not item then return end
    if olditem and olditem == item then return end
    if not item.set_target then game:targetMode(false, false) return end

    game:targetMode(true, nil, nil, item.set_target)
    game.target:setSpot(self.tmx, self.tmy, "forced")
end

function _M:generateList()
    local list = {}
    local player = game.player

    local g = game.level.map(self.tmx, self.tmy, Map.TERRAIN)
    local t = game.level.map(self.tmx, self.tmy, Map.TRAP)
    local o = game.level.map(self.tmx, self.tmy, Map.OBJECT)
    local a = game.level.map(self.tmx, self.tmy, Map.ACTOR)

    -- Generic actions
    if g and g.change_level and self.on_player then list[#list+1] = {name="Change level", action="change_level", color=colors.simple(colors.VIOLET)} end
    if o and self.on_player then list[#list+1] = {name="Pick up item", action="pickup", color=colors.simple(colors.ANTIQUE_WHITE)} end
    if g and not self.on_player then list[#list+1] = {name="Move to", action="move_to", color=colors.simple(colors.ANTIQUE_WHITE)} end
    if a and not self.on_player and game.party:canOrder(a, false) then list[#list+1] = {name="Give order", action="order", color=colors.simple(colors.TEAL), actor=a} end
    if a and not self.on_player and config.settings.cheat then list[#list+1] = {name="Target player", action="target-player", color=colors.simple(colors.RED), actor=a} end
--    if a and config.settings.cheat then list[#list+1] = {name="Lua inspect", action="debug-inspect", color=colors.simple(colors.LIGHT_BLUE), actor=a} end
    if self.on_player then list[#list+1] = {name="Rest a while", action="rest", color=colors.simple(colors.ANTIQUE_WHITE)} end
    if self.on_player then list[#list+1] = {name="Inventory", action="inventory", color=colors.simple(colors.ANTIQUE_WHITE)} end
    if a then list[#list+1] = {name="Inspect Creature", action="character_sheet", color=colors.simple(colors.ANTIQUE_WHITE), actor=a} end
    if a and player:canReallySee(a) then list[#list+1] = {name="Monster Info", action="monster_info", color=colors.simple(colors.ANTIQUE_WHITE), actor=a} end

    self.max = 0
    self.maxh = 0
    for i, v in ipairs(list) do
        local w, h = self.font:size(v.name)
        self.max = math.max(self.max, w)
        self.maxh = self.maxh + h
    end

    self.list = list
end
