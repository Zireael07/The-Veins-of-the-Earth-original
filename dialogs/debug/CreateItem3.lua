-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael
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
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.g

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    self:generateList()
--    self:generateEgoLists()

    Dialog.init(self, "Create Object", 600, 400)

    self.c_list_items = List.new{width=300, height=400, list=self.list_items, fct=function(item) self:use(item) end}
    self.c_list_egos = List.new{width=400, height=400, list=self.list_egos or {}, fct=function(item) self:use(item) end}

    self:loadUI{
        {left=0, top=0, ui=self.c_list_items},
        {right=0, top=0, ui=self.c_list_egos},
    }
    self:setupUI()

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

    if item.unique then
        local n = game.zone:finishEntity(game.level, "object", item.e)
        n:identify(true)
        game.zone:addEntity(game.level, n, "object", game.player.x, game.player.y)
    else
        if not item.egos then 
        game.log("No egos found")
        return end

        self:generateEgoLists(item)

--[[        game:registerDialog(GetQuantity.new("Number of items to make", "1-100", 20, 100, function(qty)
            Dialog:yesnoPopup("Ego", "Make an ego item if possible?", function(ret)
                if not ret then
                    for i = 1, qty do
                        local n = game.zone:finishEntity(game.level, "object", item.e, {ego_chance=-1000})
                        n:identify(true)
                        game.zone:addEntity(game.level, n, "object", game.player.x, game.player.y)
                    end
                else
                    Dialog:yesnoPopup("Greater Ego", "Make an ego item if possible?", function(ret)
                        local f
                        if not ret then
                            f = {ego_chance=1000}
                        else
                            f = {ego_chance=1000, properties={"greater_ego"}}
                        end

                        for i = 1, qty do
                            local n = game.zone:finishEntity(game.level, "object", item.e, f)
                            n:identify(true)
                            game.zone:addEntity(game.level, n, "object", game.player.x, game.player.y)
                        end
                    end)
                end
            end)
        end), 1)]]
    end
end

function _M:generateList()
    local list = {}

    for i, e in ipairs(game.zone.object_list) do
        if e.name and e.rarity then
            local color
            if e.unique then color = {255, 215, 0}
            else color = {255, 255, 255} end

            list[#list+1] = {name=e.name, unique=e.unique, color=color, egos=e.egos, e=e}
        end
    end
    table.sort(list, function(a,b)
        if a.unique and not b.unique then return true
        elseif not a.unique and b.unique then return false end
        return a.name < b.name
    end)

    local chars = {}
    for i, v in ipairs(list) do
        v.name = v.name
        chars[self:makeKeyChar(i)] = i
    end
    list.chars = chars

    self.list_items = list
end

function _M:generateEgoLists(item)
    self.c_list_egos.list = {}
    self.list_egos = {}


    local list = {}

    if item and item.egos then
    
    local legos = {}
        game.zone:getEntities(game.level, "object") -- make sure ego definitions are loaded
        table.insert(legos, game.level:getEntitiesList("object/"..item.egos..":prefix") or {})
        table.insert(legos, game.level:getEntitiesList("object/"..item.egos..":suffix") or {})
        table.insert(legos, game.level:getEntitiesList("object/"..item.egos..":") or {})

        print(" * loaded ", #legos, "ego definitions from ", item.egos)

        for i, e in ipairs(legos) do
        --    game.log("Legos reached")
            list[#list+1] = {e=e}

        
        --[[   if e.name then
                game.log(e.name)
            --    local affix = e.suffix and suffix or e.prefix and prefix
                list[#list+1] = {name=e.name, e=e}
            end]]
        end

    end


    --[[    --Do it the randart way!
        local base = game.zone:makeEntity(game.level, "object", {name = item.name, ego_chance=-1000}, nil, true)
        local o = base:cloneFull()

        if not base then print ("No base") end
        if not o then print ("Clone failed") end

        local legos = {}
        game.zone:getEntities(game.level, "object") -- make sure ego definitions are loaded
        table.insert(legos, game.level:getEntitiesList("object/"..o.egos..":prefix") or {})
        table.insert(legos, game.level:getEntitiesList("object/"..o.egos..":suffix") or {})
        table.insert(legos, game.level:getEntitiesList("object/"..o.egos..":") or {})

        print(" * loaded ", #legos, "ego definitions from ", o.egos)

        for i, e in ipairs(legos) do
            if e.name then
            --    local affix = e.suffix and suffix or e.prefix and prefix
                list[#list+1] = {name=e.name, e=e}
            end
        end

    end]]

--    self.c_list_egos.list = list
    self.list_egos = list
end