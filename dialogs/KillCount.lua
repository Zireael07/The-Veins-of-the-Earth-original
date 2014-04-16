--Veins of the Earth
--Zireael 2014

require "engine.class"

local Dialog = require "engine.ui.Dialog"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"
local List = require "engine.ui.List"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor

    self:generateList()
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Kill list", game.w * 0.5, game.h*0.5, nil, nil, font)

    local player = game.player

    self.c_list = List.new{width=400, height=500, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, scrollbar=true}
    self.c_text = Textzone.new{width=self.iw, height = 50, text = "You have killed the following monsters"}

    self:loadUI{
        {left=0, top=0, ui=self.c_text},
        {left=0, top=50, ui=self.c_list},
    }

    self:setFocus(self.c_list)
    self:setupUI(false, true)

    self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
end

function _M:use(item)
    if not item then return end
end

function _M:generateList()
    local player = game.player
    local list = {}

    for i, e in ipairs(game.zone.npc_list) do
        local name
        --Don't display bugged actors and encounters
        if e.name ~= "unknown actor" and e.type ~= "encounter" then
            local number = player.all_kills[e.name] or 0
            --Comment this line out if you want to see all monsters
            if number > 0 then

            name = "#WHITE#"..e.name.."  #GOLD#"..number
        
        list[#list+1] = {name=name, number=number, e=e}
            end
        end
    end
    table.sort(list, function(a,b) 
        if a.number == b.number then
            return a.name < b.name
        else 
        return a.number > b.number
        end
    end)

    self.list = list
end