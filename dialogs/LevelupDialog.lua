require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    self.actor = game.player

    self:generateList()
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Level Up: "..self.actor.name, math.max(game.w * 0.7, 950), 500, nil, nil, font)
    
    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}

    self.c_classes = Button.new{text="Classes",fct=function() self:onClass() end}

    self.c_feats = Button.new{text="Feats", fct=function() self:onFeat() end}

    self.c_skills = Button.new{text="Skill", fct=function() self:onSkill() end}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_accept},
        {left=self.c_accept, bottom=0, ui=self.c_classes},
        {left=self.c_classes, bottom=0, ui=self.c_feats},
        {left=self.c_feats, bottom=0, ui=self.c_skills},

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
    
   --Display 7 stats
    s:drawStringBlended(self.font, "STR : "..(player:getStr()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX : "..(player:getDex()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON : "..(player:getCon()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT : "..(player:getInt()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS : "..(player:getWis()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA : "..(player:getCha()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC : "..(player:getLuc()), w, h, 255, 255, 255, true) h = h + self.font_h

    h = 0
    w = self.w * 0.25 
    -- start on second column

    self.c_desc:generate()
    self.changed = false
end

function _M:generateList()
    local player = game.player
    local list = {}
    for tid, _ in pairs(player.talents) do
        local t = player:getTalentFromId(tid)
        if t.is_feat then 
            list[#list+1] = t
        end
    end
    self.list = list
end

function _M:onFeat()
    game:registerDialog(require("mod.dialogs.FeatDialog").new(game.player))
end
function _M:onSkill()
    game:registerDialog(require("mod.dialogs.SkillDialog").new(game.player))
end

function _M:onClass()
    game:registerDialog(require("mod.dialogs.ClassLevelupDialog").new(game.player))
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end