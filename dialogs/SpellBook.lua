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

    self.c_spells = ImageList.new{width=self.w, height=64, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.list,
            fct=function(item) self:onSpell(item) end,
        }

    self.c_desc = SurfaceZone.new{width=300, height=50,alpha=1.0}
    self.c_charges = SurfaceZone.new{width=300, height=50,alpha=1.0}

    self:redraw()
    
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

    local x = self.c_spells.x
    local y = self.c_spells.y
    --s:drawFrame(300, 300, 1,1,1,1)

    if self.spell_frame and false then
        local i_frame = UI:makeFrame("ui/icon-frame/frame",64,64)
        local x = self.spell_frame[1] or 50
        local y = self.spell_frame[2] or 50
        s:drawFrame(i_frame, x, y, 1,1,1, 1)
    end
    
    local charges_used = game.player:getAllocatedCharges()[1]
    local max_charges = game.player:getMaxMaxCharges()[1]

    local str = "Level-1 Spells "..(charges_used or 0).."/"..(max_charges or 0)
    s:drawString(self.font, str, 0, 0, 255, 255, 255, true)

    local w = 0
    local h = 0
    local font = core.display.newFont("/data/font/DroidSans-Bold.ttf", 12)
    for _, t in ipairs(self.list) do
        local p = game.player
        local num = p:getCharges(t) or 0
        local max = p:getMaxCharges(t) or 0
        local str = "#STEEL_BLUE#"..num.."#LIGHT_STEEL_BLUE#".."/".."#STEEL_BLUE#"..max
        c:drawColorString(font, str, w, h, 255, 255, 255, true) 
        w = w + self.c_spells.tile_w + self.c_spells.padding
    end

    self.c_desc:generate()
    self.c_charges:generate()
    self.c_spells:generate()


    self.changed = false
end

function _M:switchTo(kind)
    self:generateList(kind)
end

function _M:onSpell(item)
    local p = game.player
    if item then 
        p:incMaxCharges(item.data, 1) 
    end
    self:drawDialog()

end

function _M:onReset()
    local p = game.player
    for tid, _ in pairs(p.talents) do
        p:setMaxCharges(tid, 0)
        p:setCharges(tid, 0)
    end
    self:drawDialog()
end

function _M:generateList(spellist)

	local player = game.player
    local list = {}

    for tid, _ in pairs(player.talents) do
		local t = player:getTalentFromId(tid)
        if t.type[1] == spellist and player:knowTalent(t) then
            list[#list+1] = t
        end
    end

    self.list = list

    if self.c_spells then
        self.c_spells.list = self.list
        self:drawDialog()
    end
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end
