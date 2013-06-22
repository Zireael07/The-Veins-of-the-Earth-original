require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Character Sheet: "..self.actor.name, math.max(game.w * 0.7, 950), 500, nil, nil, font)
    
    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
    }
    
    self:setupUI()

    self:drawDialog()
    
    self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
end

function _M:drawDialog()
    local player = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0
    s:drawStringBlended(self.font, "Name : "..(player.name or "Unnamed"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Class : "..(player.descriptor.class or player.type:capitalize()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Race : "..(player.descriptor.race or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Level : "..(player.level or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "EXP : "..(player.exp or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Gold : "..(player.money or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "AC : "..(player.combat_def or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Attack : "..(player.combat_attack or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
--    s:drawStringBlended(self.font, "SP : "..(player.mana or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Hit Dice : "..(player.hit_die or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Hit Points : "..(player.life or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Max Hit Points : "..(player.max_life or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Darkvision : "..(player.infravision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = 0
    w = self.w * 0.25 
    -- start on second column
        
    s:drawStringBlended(self.font, "STR : "..(player:getStr()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX : "..(player:getDex()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON : "..(player:getCon()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT : "..(player:getInt()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS : "..(player:getWis()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA : "..(player:getCha()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC : "..(player:getLuc()), w, h, 255, 255, 0, true) h = h + self.font_h

    self.c_desc:generate()
    self.changed = false
end