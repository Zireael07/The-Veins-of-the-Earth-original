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

local skills = {
	balance = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	bluff = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#',
	climb = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Strength#LAST#',
	concentration = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Constitution#LAST#',
	diplomacy = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#',
	disabledevice = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#',
	escapeartist = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	handleanimal = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	heal = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	hide = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	intimidate = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#',
	intuition = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\nUsed for identifying items',
	jump = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Strength#LAST#',
	knowledge = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	listen = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	movesilently = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	openlock = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	pickpocket = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	search = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#',
	sensemotive = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	spellcraft = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#',
	survival = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#',
	tumble = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#',
	usemagic = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#',
}

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
		self.player:attr("skill_"..item.skill, 1)

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
    local list = {}
    for skill, description in pairs(skills) do
    	local value = player:getSkill(skill)
 		local color = {255, 255, 255}
 		local d = "#GOLD#"..skill:capitalize().."#LAST#\n\n"
 		d = d..description.."\n#WHITE#"
        list[#list+1] = {name="#SLATE#(#LAST##AQUAMARINE#"..(value or 0).."#LAST##SLATE#) #LAST#"..skill:capitalize(), skill = skill,	 color = color, desc=d}
    end
    self.list = list
end	