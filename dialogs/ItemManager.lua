--Veins of the Earth
--Zireael 2014

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local TextzoneList = require "engine.ui.TextzoneList"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"
local List = require "engine.ui.List"


module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.player = actor
	Dialog.init(self, "Item pickup manager", game.w*0.5, math.max(game.h*0.6, 800))
	self:generateList()
	
	self.c_list = List.new{width=250, height = self.ih*0.8, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
--	self.c_arms = List.new{width=self.iw/2, nb_items=#self.list_arms, list=self.list_arms, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
--		{left=300, top=0, ui=self.c_arms}
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
	self:on_select(self.list[1])
end

function _M:use(item)
	
	--If no pickup then set to destroy
	if item.no_pickup then 
		item.destroy = true
		self:update()
	--If destroy then blank both settings
	elseif item.destroy then
		item.destroy = false
		item.no_pickup = false
	--If no settings set then no pickup
	else item.no_pickup = true
	end

end

function _M:on_select(item,sel)
--	if self.c_desc then self.c_desc:switchItem(item, item.desc) end
	self.selection = sel	
end

function _M:update()
	local sel = self.selection
	self:generateList() -- Slow! Should just update the one changed and sort again
	self.c_list.list = self.list
	self.c_list:generate()
	if sel then self.c_list:select(sel) end
end

function _M:generateLists()
	self:generateVariousList()
	self:generateArmsList()
end

function _M:generateList()
	local player = game.player
    local list = {}

    for i, e in ipairs(game.zone.object_list) do
	--	if e.type ~= "armor" and e.type ~= "weapon" and 
			if e.subtype and e.rarity and e.name then
			--Remove duplicates
			local add = true
            for _, a in pairs(list) do
                if e.subtype == a.subtype then
                    add = false
                        break
                    end
                end
                if add then
			local color
			local tt = e.subtype
			if e and e.destroy then color = {201, 0, 0}
			elseif e and e.no_pickup then color = {0, 255, 0}
			else color = {255,255,255}
			end

			list[#list+1] = {name=e.subtype, color = color, subtype=e.subtype, unique=e.unique, e=e}
			end
		end
	end

	self.list = list

	table.sort(list, function(a,b)
	--[[	if a.unique and not b.unique then return true
		elseif not a.unique and b.unique then return false end]]
		return a.name < b.name
	end)

end

function _M:generateArmsList()
	local player = game.player
    local list = {}

    for i, e in ipairs(game.zone.object_list) do
		if e.type == "armor" or e.type == "weapon" and e.subtype and e.rarity and e.name then
			--Remove duplicates
			local add = true
            for _, a in pairs(list) do
                if e.subtype == a.subtype then
                    add = false
                        break
                    end
                end
                if add then
			local color
			local tt = e.subtype
			if e and e.destroy then color = {201, 0, 0}
			elseif e and e.no_pickup then color = {0, 255, 0}
			else color = {255,255,255}
			end

			list[#list+1] = {name=e.subtype, color = color, subtype=e.subtype, unique=e.unique, e=e}
			end
		end
	end

	self.list = list

	table.sort(list, function(a,b)
	--[[	if a.unique and not b.unique then return true
		elseif not a.unique and b.unique then return false end]]
		return a.name < b.name
	end)

end