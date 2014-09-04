-- Veins of the Earth
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
require "engine.ui.Dialog"
local List = require "engine.ui.List"
local GetQuantity = require "engine.dialogs.GetQuantity"

local Map = require "engine.Map"
local Dialog = require "engine.ui.Dialog"
local DebugConsole = require "engine.DebugConsole"

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
	self:generateList()
	engine.ui.Dialog.init(self, "Debug / Wizard Mode Menu!", 1, 1)

	local list = List.new{width=400, height=500, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=list},
	}
	self:setupUI(true, true)

	self.key:addCommands{ __TEXTINPUT = function(c) if self.list and self.list.chars[c] then self:use(self.list[self.list.chars[c]]) end end}
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end, }
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:use(item)
	if not item then return end
	game:unregisterDialog(self)

	if item.dialog then
		local d = require("mod.dialogs.debug."..item.dialog).new()
		game:registerDialog(d)
		return
	end

	local act = item.action


	if act == "magic_map" then
		game.level.map:liteAll(0, 0, game.level.map.w, game.level.map.h)
		game.level.map:rememberAll(0, 0, game.level.map.w, game.level.map.h)
		for i = 0, game.level.map.w - 1 do
			for j = 0, game.level.map.h - 1 do
				local trap = game.level.map(i, j, game.level.map.TRAP)
				if trap then
					trap:setKnown(game.player, true)
					game.level.map:updateMap(i, j)
				end
			end
		end
	elseif act == "change_level" then
		game:registerDialog(GetQuantity.new("Zone: "..game.zone.name, "Level 1-"..game.zone.max_level, game.level.level, game.zone.max_level, function(qty)
			game:changeLevel(qty)
		end), 1)
	elseif act == "gain-xp" then
		game:registerDialog(GetQuantity.new("XP to gain", "1-100000", 1000, 100000, function(qty)
			game.player:gainExp(qty)
		end), 1)
	elseif act == "gain-gold" then
		game:registerDialog(GetQuantity.new("Gold to gain", "1-100000", 1000, 100000, function(qty)
			game.player:incMoney(qty)
		end), 1)
	elseif act == "identify-items" then
		local inven = game.player:getInven("INVEN")
		for k, o in ipairs(inven) do
			if o.pseudo_id == false then o.pseudo_id = true end
			if  o.identified == false then
				o.identified = true
			end
		end
	elseif act == "remove-all" then
		local l = {}
		for uid, e in pairs(game.level.entities) do
			if not game.party:hasMember(e) then l[#l+1] = e end
		end
		for i, e in ipairs(l) do
			game.level:removeEntity(e)
		end
	elseif act == "kill-clones" then
		for loc, tile in ipairs(game.level.map.map) do
				local actor = tile[Map.ACTOR]
				if actor and loc ~= actor.x + actor.y * game.level.map.w then
					local x = loc % game.level.map.w
					local y = math.floor(loc / game.level.map.w)
					--skip dialog
				--[[	local text = ("A clone of '%s' (UID: %d) was found at tile ##%d (%d, %d). The original is located at tile ##%d (%d, %d). Would you like to remove this clone from the level?"):format(actor.name, actor.uid, loc, x, y, actor.x + actor.y * game.level.map.w, actor.x, actor.y)
					Dialog:yesnoLongPopup("Clone Killer", text, game.w * 0.25,function(kill)
						if kill then]]
							game.log("#LIGHT_RED#[DEBUG] Removed clone of %d '%s' from tile %d (%d, %d)", actor.uid, actor.name, loc, x, y)
							print("[DEBUG] Removed clone of "..actor.uid.." '"..actor.name.."' from tile "..loc.." ("..x..", "..y..")")
							game.level.map:remove(x, y, Map.ACTOR)
					--	end
					--end)
				end
		end
	elseif act == "lua-console" then
		game:registerDialog(DebugConsole.new())
	else
		self:triggerHook{"DebugMain:use", act=act}
	end
end

function _M:generateList()
	local list = {}
	list[#list+1] = {name="Entities list", dialog="EntityTracker"}
	list[#list+1] = {name="Kill off clones", action="kill-clones"} 
	list[#list+1] = {name="Change Zone", dialog="ChangeZone"}
	list[#list+1] = {name="Change Level", action="change_level"}
	list[#list+1] = {name="Gain XP", action="gain-xp"}
	list[#list+1] = {name="Gain gold", action="gain-gold"}
	list[#list+1] = {name="Identify items in inventory", action="identify-items"}
	list[#list+1] = {name="Reveal all map", action="magic_map"}
--	list[#list+1] = {name="Grant/Alter Quests", dialog="GrantQuest"}
	list[#list+1] = {name="Summon Creature", dialog="SummonCreature"}
	list[#list+1] = {name="Create Item", dialog="CreateItem2"}
--	list[#list+1] = {name="Create Item", dialog="CreateItem"}
--	list[#list+1] = {name="Alter Faction", dialog="AlterFaction"}
--	list[#list+1] = {name="Create Trap", dialog="CreateTrap"}
	list[#list+1] = {name="Remove all creatures", action="remove-all"}
	list[#list+1] = {name="Lua Console", action="lua-console"}

	self:triggerHook{"DebugMain:generate", menu=list}

	local chars = {}
	for i, v in ipairs(list) do
		v.name = self:makeKeyChar(i)..") "..v.name
		chars[self:makeKeyChar(i)] = i
	end
	list.chars = chars

	self.list = list
end