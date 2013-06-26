require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"


module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	print("[TESTY]")
	print(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Spellbook: "..self.actor.name, math.max(game.w * 0.5, 70), 500, nil, nil, font)

    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}
    self.c_decline = Button.new{text="Decline",fct=function() self:onEnd("decline") end}

    self.c_spells = ImageList.new{width=self.w, height=64, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.generateList(),
            fct=function(item) self:onSpell(item) end,
            on_select=function(item, how) self:selectTab(item, how) end
        }

    self:loadUI{
        {left=0, bottom=0, ui=self.c_accept},
        {left=self.c_accept, bottom=0, ui=self.c_decline},
        {top=0, ui=self.c_spells},

    }
    
    self:setupUI()
    
    self.key:addBinds{
        EXIT = function() self:onEnd("decile") end,
    }
end

function _M:drawDialog()
    self.changed = true
    if self.bg_texture then self.bg_texture:toScreenFull(self.display_x, self.display_y, self.w, self.h, self.bg_texture_w, self.bg_texture_h) end
    local frame = UI:makeFrame("ui/icon-frame/frame", 48, 48)
    UI:drawFrame(frame, 50, 50, 0.5,0.5,0.5, 1)
end

function _M:selectTab(item, how)
    
end

function _M:onSpell(item)

end

function _M:generateList()
	print("[LISTY]")
	local player = game.player
    local list = {}
    for tid, _ in pairs(player.talents) do
		local t = player:getTalentFromId(tid)
        --if t.is_spell then
            list[#list+1] = t.image
        --end
    end
    return list
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end
