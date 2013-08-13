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
	Dialog.init(self, "Skills", 500, 600)
	self:generateList()
	
	self.c_points = Textzone.new{width=self.iw, height = 50, text = "Available skill points: "..self.player.skill_point}	
	self.c_list = List.new{width=self.iw/2, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end}
	self.c_desc = TextzoneList.new{width=self.iw/2-20, height = 400, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
		{left=0, top=50, ui=self.c_list},
		{right=0, top=0, ui=self.c_desc}
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
	self:on_select(self.list[1])
end

function _M:use(item)
	if (self.player.skill_point or 0) > 0 then

		--increase the skill by one
		self.player:attr("skill_"..item.name, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
	end
end

function _M:on_select(item,sel)
	--if item.info then self.c_desc.text = item.info end
	--if item.name and self.c_desc then self.c_desc.text = item.name end
	if self.c_desc then self.c_desc:switchItem(item, item.desc) end
	self.selection = sel	
end

function _M:update()
	local sel = self.selection
	self:generateList() -- Slow! Should just update the one changed and sort again
	self.c_points.text = "Available skill points: "..self.player.skill_point
	self.c_points:generate()
	self.c_list.list = self.list
	self.c_list:generate()
	if sel then self.c_list:select(sel) end
end

function _M:generateList()
	local player = game.player
	local skills = {
		"balance",
		"bluff",
		"climb",
		"concentration",
		"diplomacy",
		"disabledevice",
		"escapeartist",
		"handleanimal",
		"heal",
		"hide",
		"intimidate",
		"intuition",
		"jump",
		"knowledge",
		"listen",
		"movesilently",
		"openlock",
		"search",
		"sensemotive",
		"pickpocket",
		"spellcraft",
		"survival",
		"tumble",
		"usemagic",
	}
    local list = {}
    for _, skill in pairs(skills) do
    	local value = player:getSkill(skill)
 		local color = {255, 255, 255}
 		local d = "#GOLD#"..skill:capitalize().."#LAST#\n\n"
 		s = "Description goes here"
 		d = d..s.."\n#WHITE#"
        list[#list+1] = {name="#SLATE#(#LAST##AQUAMARINE#"..(value or 0).."#LAST##SLATE#) #LAST#"..skill:capitalize(), color = color, desc=d}
    end
    self.list = list
end