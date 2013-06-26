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

    self:generateList()
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Spellbook: "..self.actor.name, math.max(game.w * 0.5, 70), 500, nil, nil, font)

    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}
    self.c_decline = Button.new{text="Decline",fct=function() self:onEnd("decline") end}

    self.c_spells = ImageList.new{width=self.w, height=64, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.list,
            fct=function(item) self:onSpell(item) end,
            on_select=function(item, how) self:drawDialog() self:selectTab(item, how) end
        }

    self.c_desc = SurfaceZone.new{width=300, height=50,alpha=1.0}
    self.c_charges = SurfaceZone.new{width=300, height=50,alpha=1.0}

    self:loadUI{
        {left=0, bottom=0, ui=self.c_accept},
        {left=self.c_accept, bottom=0, ui=self.c_decline},
        {top=0, ui=self.c_desc},
        {top=self.c_desc,ui=self.c_spells},
        {top=self.c_desc,ui=self.c_charges},

    }
    
    self:setupUI()
    self:drawDialog()
    
    self.key:addBinds{
        EXIT = function() self:onEnd("decline") end,
    }
end

function _M:drawDialog(s)
    local s = self.c_desc.s
    local c = self.c_charges.s
    s:erase(0,0,0,0)
    c:erase(0,0,0,0)
    --local frame = UI:makeFrame("ui/icon-frame/frame", 48, 48)

    x = self.c_spells.x
    y = self.c_spells.y
    --s:drawFrame(300, 300, 1,1,1,1)

    if self.spell_frame and false then
        local i_frame = UI:makeFrame("ui/icon-frame/frame",64,64)
        local x = self.spell_frame[1] or 50
        local y = self.spell_frame[2] or 50
        s:drawFrame(i_frame, x, y, 1,1,1, 1)
    end
    
    s:drawString(self.font, "Level-1 Spells", 0, 0, 255, 255, 255, true)
    local w = 0
    local h = 0
    for tid, _ in pairs(game.player.talents) do
        local t = game.player:getTalentFromId(tid)
        if t.is_spell then
            local num = t.charges
            local max = t.max_charges
            local str = t.charges.."/"..t.max_charges
            c:drawString(self.font, str, w, h, 255, 255, 255, true) 
            w = w + self.c_spells.tile_w + self.c_spells.padding
        end
    end

    self.c_desc:generate()
    self.c_charges:generate()

    self.changed = false
end

function _M:selectTab(item, how)
    if item then
        --self.spell_frame = {item.x, item.y}
    else
        --self.spell_frame = nil
    end
end

function _M:onSpell(item)
    if item then 
        item.data.max_charges = item.data.max_charges + 1 
    else

    end
    self:drawDialog()

end

function _M:generateList()
	local player = game.player
    local list = {}
    for tid, _ in pairs(player.talents) do
		local t = player:getTalentFromId(tid)
        if t.is_spell and t.charges then
            list[#list+1] = t
        end
    end
    self.list = list
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end
