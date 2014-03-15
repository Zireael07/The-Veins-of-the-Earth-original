--Veins of the Earth
--Zireael 2014

require "engine.class"

local Dialog = require "engine.ui.Dialog"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Monster Info: "..actor.name, game.w * 0.3, game.h*0.3, nil, nil, font)

    --Display in-character info
    local player = game.player
    local actor = self.actor
    
    local x = rng.dice(1,20) + (player:getSkill("knowledge") or 0)

 if x > 25+actor.challenge then 
    if actor.specialist_desc then self.text = "#LIGHT_BLUE#You know specialist stuff about the monster#LAST# \n"..actor.specialist_desc.." \n"..actor.uncommon_desc.." \n"..actor.common_desc.." \n"..actor.base_desc
    elseif actor.uncommon_desc then self.text = "#LIGHT_BLUE#You know specialist stuff about the monster#LAST# \n"..actor.uncommon_desc.." \n"..actor.common_desc.." \n"..actor.base_desc
    elseif actor.common_desc then self.text = "#LIGHT_BLUE#You know specialist stuff about the monster#LAST# \n"..actor.common_desc.." \n"..actor.base_desc
    else self.text = "#LIGHT_BLUE#You know specialist stuff about the monster"
    end
 elseif x > 20+actor.challenge then 
    if actor.uncommon_desc then self.text = "#LIGHT_BLUE#You know uncommon stuff about the monster#LAST# \n"..actor.uncommon_desc.." \n"..actor.common_desc.." \n"..actor.base_desc
    elseif actor.common_desc and actor.base_desc then self.text = "#LIGHT_BLUE#You know uncommon stuff about the monster#LAST# \n"..actor.common_desc.." \n"..actor.base_desc
    else self.text = "#LIGHT_BLUE#You know uncommon stuff about the monster"
    end
 elseif x > 15+actor.challenge then
    if actor.common_desc and actor.base_desc then self.text = "#LIGHT_BLUE#You know obvious stuff about the monster#LAST# \n"..actor.common_desc.." \n"..actor.base_desc
    else self.text = "#LIGHT_BLUE#You know obvious stuff about the monster"
    end
 else 
    if actor.base_desc then self.text = "#LIGHT_BLUE#You know basic stuff about the monster #LAST# \n"..actor.base_desc 
    else self.text = "#LIGHT_BLUE#You know basic stuff about the monster" end
end


    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih/4,alpha=0}
    self.c_text = Textzone.new{width=self.iw, height=self.ih/2, scrollbar=true, text = self.text}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
        {left=0, top=50, ui=self.c_text},
        
    }
    
    self:setupUI()

    self:drawDialog()
    
    self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
end

function _M:drawDialog()
    local player = game.player
    local actor = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0
    
 --Display kills and seens
 s:drawColorStringBlended(self.font, "Number killed: #ORANGE# : "..(player.all_kills[actor.name] or 0), w, h, 255, 255, 255, true) h = h + self.font_h
 s:drawColorStringBlended(self.font, "Number seen: #GOLD# : "..(player.all_seen[actor.name] or 0), w, h, 255, 255, 255, true) h = h + self.font_h


 h = h + self.font_h -- Adds an empty row

 	self.c_desc:generate()
    self.changed = false
end