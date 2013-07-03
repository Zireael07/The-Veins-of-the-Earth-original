local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local TextzoneList = require "engine.ui.TextzoneList"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"
local List = require "engine.ui.List"


module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	Dialog.init(self, "Feats", 500, 600)
	self:generateList()
	
	self.c_list = List.new{width=self.iw/2, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end}
	self.c_desc = TextzoneList.new{width=self.iw/2-20, height = self.ih, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
		{right=0, top=0, ui=self.c_desc}
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
end

function _M:use(item)
	game.log("HI!")
end

function _M:on_select(item,sel)
	--if item.info then self.c_desc.text = item.info end
	--if item.name and self.c_desc then self.c_desc.text = item.name end
	if self.c_desc then self.c_desc:switchItem(item, item.desc) end	
end

function _M:generateList()
	local player = game.player
    local list = {}
    for tid, _ in pairs(player.talents_def) do
		local t = player:getTalentFromId(tid)
        if t.is_feat then
        	local color
        	if player:knowTalent(t) then colour = {255,0,255}
     		--else if player:canLearn(t)
     		else colour = {0, 255, 0} end
     		local d = "#GOLD#"..t.name.."#LAST#\n\n"..t.info(player,t)
            list[#list+1] = {name=t.name, color = color, desc=d}
        end
    end
    self.list = list

end