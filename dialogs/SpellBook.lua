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
local Tabs = require "engine.ui.Tabs"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Spellbook: "..self.actor.name, math.max(game.w * 0.5, 70), 500, nil, nil, font)

    local types = {}
    if self.actor:knowTalentType("arcane/arcane") then
        types[#types+1]= {title="Arcane", kind="arcane/arcane"}
    end
    if self.actor:knowTalentType("divine/divine") then
        types[#types+1] = {title="Divine", kind="divine/divine"}
    end

    self:generateList(types[1].kind)

    self.c_tabs = Tabs.new{width=self.iw - 5, tabs=types, on_change=function(kind) self:switchTo(kind) end}

    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}
    self.c_decline = Button.new{text="Decline",fct=function() self:onEnd("decline") end}
    self.c_reset = Button.new{text="Reset", fct=function() self:onReset() end}
    
    self.spells = {}
    for i=1, 9 do
        self.spells[i] =  ImageList.new{width=self.w, height=64, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.list[i],
            fct=function(item, button) self:onSpell(item, button) end,
        }
    end

    self.c_desc = SurfaceZone.new{width=300, height=500,alpha=1.0}
    self.c_charges = SurfaceZone.new{width=300, height=500,alpha=1.0}

    self:loadUI{
        {left=0, top=0, ui=self.c_tabs},
        {left=0, bottom=0, ui=self.c_accept},
        {left=self.c_accept, bottom=0, ui=self.c_decline},
        {right=0, bottom=0, ui=self.c_reset},
        {top=self.c_tabs.h + 10, ui=self.c_desc},
        {top=self.c_desc,ui=self.spells[1]},
        {top=self.spells[1],ui=self.spells[2]},
        {top=self.spells[2],ui=self.spells[3]},
        {top=self.spells[3],ui=self.spells[4]},
        {top=self.spells[4],ui=self.spells[5]},
        {top=self.spells[5],ui=self.spells[6]},
        {top=self.spells[6],ui=self.spells[7]},
        {top=self.spells[7],ui=self.spells[8]},
        {top=self.spells[8],ui=self.spells[9]},
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

    local x = self.spells[1].x
    local y = self.spells[1].y
    --s:drawFrame(300, 300, 1,1,1,1)

    if self.spell_frame and false then
        local i_frame = UI:makeFrame("ui/icon-frame/frame",64,64)
        local x = self.spell_frame[1] or 50
        local y = self.spell_frame[2] or 50
        s:drawFrame(i_frame, x, y, 1,1,1, 1)
    end
    

    local max_charges = game.player:getMaxMaxCharges()

    local w = 0
    local h = 0

    local font = core.display.newFont("/data/font/DroidSans-Bold.ttf", 12)

    for i, v in ipairs(self.list) do
        local charges_used = game.player:getAllocatedCharges(self.spell_list, i) --TODO: Fix this function (getAllocatedCharges)
        local str = "Level-"..i.." Spells "..(charges_used or 0).."/"..(max_charges[i] or 0)
        s:drawString(self.font, str, w, h, 255, 255, 255, true)

        local ww = w
        local hh = h
        for _, t in ipairs(self.list[i]) do
            local p = game.player
            local num = p:getCharges(t) or 0
            local max = p:getMaxCharges(t) or 0
            local str = "#STEEL_BLUE#"..num.."#LIGHT_STEEL_BLUE#".."/".."#STEEL_BLUE#"..max
            c:drawColorString(font, str, ww, hh, 255, 255, 255, true) 
            ww = ww + self.spells[1].tile_w + self.spells[1].padding
        end
        h = h + 90
    end

    self.c_desc:generate()
    self.c_charges:generate()
    for i=1,9 do
        self.spells[i]:generate()
    end


    self.changed = false
end

function _M:switchTo(kind)
    self.spell_list = kind
    self:generateList(kind)
end

function _M:onSpell(item, button)
    local v = 1
    if button == "right" then
        v = -1
    end
    local p = game.player
    if item then 
        p:incMaxCharges(item.data, v) 
    end
    self:drawDialog()

end

function _M:onReset()
    local p = game.player
    p:allocatedChargesReset()
    self:drawDialog()
end

function _M:generateList(spellist)

	local player = game.player
    local list = {}
    for i=1,9 do
        list[i] = {}
    end

    for tid, _ in pairs(player.talents) do
		local t = player:getTalentFromId(tid)
        if t.type[1] == spellist and player:knowTalent(t) then
            local slist = list[t.level]
            list[t.level][#slist+1] = t
        end
    end

    self.list = list

    if self.spells then
        self.spells[1].list = self.list[1]
        self:drawDialog()
    end
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end
