--Veins of the Earth
--Zireael 2014

require "engine.class"

local Dialog = require "engine.ui.Dialog"
local SurfaceZone = require "engine.ui.SurfaceZone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Monster Info", game.w * 0.3, game.h*0.3, nil, nil, font)

    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
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

--Display in-character info
 if player:skillCheck("knowledge", 25+actor.challenge) then s:drawColorStringBlended(self.font, "You know arcane stuff about the monster", w, h, 255, 255, 255, true) h = h + self.font_h
 elseif player:skillCheck("knowledge", 20+actor.challenge) then s:drawColorStringBlended(self.font, "You know uncommon stuff about the monster", w, h, 255, 255, 255, true) h = h + self.font_h
 elseif player:skillCheck("knowledge", 15+actor.challenge) then s:drawColorStringBlended(self.font, "You know obvious stuff about the monster", w, h, 255, 255, 255, true) h = h + self.font_h
 else s:drawColorStringBlended(self.font, "You know basic stuff about the monster", w, h, 255, 255, 255, true) h = h + self.font_h end

 	self.c_desc:generate()
    self.changed = false
end