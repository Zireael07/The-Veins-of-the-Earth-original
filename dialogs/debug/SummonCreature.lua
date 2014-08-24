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


require "engine.class"
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"
local Tab = require 'engine.ui.Tab'

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
	self:generateLists()
	engine.ui.Dialog.init(self, "Summon Creature", 600, 500)


--	self.c_tabs = Tabs.new{width=wide, tabs=types, on_change=function(kind) self:switchTo(kind) end}
	self.c_enemies = List.new{width=400, height=400, nb_items=#self.list_enemies, list=self.list_enemies, fct=function(item) self:use(item) end, scrollbar=true}
	self.c_neutral = List.new{width=400, height=400, nb_items=#self.list_neutral, list=self.list_neutral, fct=function(item) self:use(item) end, scrollbar=true}
	self.c_encounter = List.new{width=400, height=400, nb_items=#self.list_encounter, list=self.list_encounter, fct=function(item) self:use(item) end, scrollbar=true}
--    self.c_desc = TextzoneList.new{width=self.iw-410, height = 400, text="Hello from description"}

	self.t_enemies = Tab.new {
    title = 'Enemies',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('enemies') end end,
  }
    self.t_neutral = Tab.new {
    title = 'Neutral',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('neutral') end end,
  }
  	self.t_encounter = Tab.new {
    title = 'Encounters',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('encounters') end end,
  }

	self.t_enemies:select()


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

function _M:switchTo(tab)
    self.t_enemies.selected = tab == 'enemies'
    self.t_neutral.selected = tab == 'neutral'
    self.t_encounter.selected = tab == 'encounters'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)

    if tab == "enemies" then

    self:loadUI{
       	{left=0, top=0, ui=self.t_enemies},
		{left=self.t_enemies.w + 5, top=0, ui=self.t_neutral},
		{left=self.t_neutral, top=0, ui=self.t_encounter},
		{left=0, top=self.t_enemies.h + 5, ui=self.c_enemies},
    }
    
    self:setupUI()
--	self:setupUI(true, true)

    end

    if tab == "neutral" then

    self:loadUI{
        {left=0, top=0, ui=self.t_enemies},
		{left=self.t_enemies, top=0, ui=self.t_neutral},
		{left=self.t_neutral, top=0, ui=self.t_encounter},
		{left=0, top=self.t_enemies.h + 5, ui=self.c_neutral},
    }
    
    self:setupUI()
 --	self:setupUI(true, true)
    end
    
    if tab == "encounters" then

    self:loadUI{
        {left=0, top=0, ui=self.t_enemies},
		{left=self.t_enemies, top=0, ui=self.t_neutral},
		{left=self.t_neutral, top=0, ui=self.t_encounter},
        {left=0, top=self.t_enemies.h + 5, ui=self.c_encounter},
    }
    
    self:setupUI()
--    self:setupUI(true, true)
    end


end


function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	local n = game.zone:finishEntity(game.level, "actor", item.e)
	local x, y = util.findFreeGrid(game.player.x, game.player.y, 20, true, {[engine.Map.ACTOR]=true})
	if not x then return end
	game.zone:addEntity(game.level, n, "actor", x, y)
end

function _M:generateLists()
	self:generateListEnemies()
	self:generateListNeutral()
	self:generateListEncounter()
end


function _M:generateListEnemies()
	local list = {}

	for i, e in ipairs(game.zone.npc_list) do
		if e.name ~= "unknown actor" and e.type ~= "encounter" then
			local color
			if e.type == "encounter" then color = {255, 215, 0}
			elseif e.faction == "neutral" then color = {81, 221, 255}
			else color = {255, 255, 255} end

		list[#list+1] = {name=e.name, type=e.type, color=color, challenge=e.challenge, unique=e.unique, faction=e.faction, e=e}
		else end
	end
	
	table.sort(list, function(a,b)
        --Sort by challenge
        if a.challenge == b.challenge then 
            return a.name < b.name
        else 
            return a.challenge < b.challenge
        end
		
        --[[	if a.unique and not b.unique then return true
		elseif not a.unique and b.unique then return false end]]
	--	return a.name < b.name
	end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list_enemies = list
end

function _M:generateListNeutral()
	local list = {}

	for i, e in ipairs(game.zone.npc_list) do
		if e.name ~= "unknown actor" and e.faction == "neutral" then
			local color
			if e.type == "encounter" then color = {255, 215, 0}
			elseif e.faction == "neutral" then color = {81, 221, 255}
			else color = {255, 255, 255} end

		list[#list+1] = {name=e.name, type=e.type, color=color, challenge=e.challenge, unique=e.unique, faction=e.faction, e=e}
		else end
	end
	
	table.sort(list, function(a,b)
		 --Sort by challenge
        if a.challenge == b.challenge then 
            return a.name < b.name
        else 
            return a.challenge < b.challenge
        end
        
        --[[    if a.unique and not b.unique then return true
        elseif not a.unique and b.unique then return false end]]
    --  return a.name < b.name
	end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list_neutral = list
end

function _M:generateListEncounter()
	local list = {}

	for i, e in ipairs(game.zone.npc_list) do
		if e.name ~= "unknown actor" and e.type == "encounter" then
			local color
			if e.type == "encounter" then color = {255, 215, 0}
			elseif e.faction == "neutral" then color = {81, 221, 255}
			else color = {255, 255, 255} end

		list[#list+1] = {name=e.name, type=e.type, color=color, challenge=e.challenge, unique=e.unique, faction=e.faction, e=e}
		else end
	end
	
	table.sort(list, function(a,b)
		 --Sort by challenge
        if a.challenge == b.challenge then 
            return a.name < b.name
        else 
            return a.challenge < b.challenge
        end
        
        --[[    if a.unique and not b.unique then return true
        elseif not a.unique and b.unique then return false end]]
    --  return a.name < b.name
	end)

	local chars = {}
	for i, v in ipairs(list) do
		v.name = v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list_encounter = list
end