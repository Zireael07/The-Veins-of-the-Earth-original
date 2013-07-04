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
	Dialog.init(self, "Feats", 500, 600)
	self:generateList()
	
	self.c_points = Textzone.new{width=self.iw, height = 50, text = "Available feat points: "..self.player.feat_point}	
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
	if self.player.feat_point > 0 then
		local learned = self.player:learnTalent(item.talent.id) --returns false if not learned due to requirements
		if learned then self.player.feat_point = self.player.feat_point - 1 end
	end
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
        	if player:knowTalent(t) then color = {255,255,255} i = 1
     		elseif player:canLearnTalent(t) then color = {0,187,187} i = 2
     		else color = {100, 100, 100} i = 3
     		end
     		local d = "#GOLD#"..t.name.."#LAST#\n"
     		s = player:getTalentReqDesc(t.id):toString()
     		d = d..s.."\n#WHITE#"
     		d = d..t.info(player,t)
            list[#list+1] = {name=t.name, color = color, desc=d, talent=t, i = i}
        end
    end
    self.list = list
    --Sort it by whetever we have/can/cannot learn it, then alphabetically
    table.sort(self.list, function (a,b) 
    	if a.i == b.i then 
    		return a.name < b.name
    	else 
    		return a.i < b.i
    	end
    end)

end