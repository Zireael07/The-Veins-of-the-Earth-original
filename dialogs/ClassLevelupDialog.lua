require "engine.class"

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

--Taken from ToME 4
local function restore(dest, backup)
    local bx, by = dest.x, dest.y
    backup.replacedWith = false
    dest:replaceWith(backup)
    dest.replacedWith = nil
    dest.x, dest.y = bx, by
    dest.changed = true
    dest:removeAllMOs()
    if game.level and dest.x then game.level.map:updateMap(dest.x, dest.y) end
end

function _M:init(actor)
    self.actor = actor
    self.actor_dup = actor:clone()
    self:generateList()
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Class select", game.w*0.4, game.h*0.6)

    self.c_points = Textzone.new{width=self.iw/2, height = 50, text = "Available class points: "..self.actor.class_points}
    self.c_list = List.new{width=self.iw/2, height = self.ih*0.9, scrollbar=true, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end}
    self.c_desc = TextzoneList.new{width=self.iw/2-20, height = (self.ih*0.9), scrollbar=true, text="Hello from description"}

    self:loadUI{
        {left=0, top=0, ui = self.c_points},
        {left=0, top=50, ui=self.c_list},
        {right=0, top=50, ui=self.c_desc}
    }
    self:setFocus(self.c_list)
    self:setupUI(false, true)

--    self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
    --Taken from ToME 4
    self.key:addBinds{
        EXIT = function()
            if self.actor.class_points~=self.actor_dup.class_points then
                self:yesnocancelPopup("Finish","Do you accept changes?", function(yes, cancel)
                if cancel then
                    return nil
                else
                    if yes then ok = true else ok = true self:cancel() end
                end
                if ok then
                    game:unregisterDialog(self)
                    self.actor_dup = {}
                    if self.on_finish then self.on_finish() end
                end
                end)
            else
                game:unregisterDialog(self)
                self.actor_dup = {}
                if self.on_finish then self.on_finish() end
            end
        end,
    }

    self:on_select(self.list[1])
end

function _M:cancel()
    restore(self.actor, self.actor_dup)
end

function _M:use(item)
    if self.actor.class_points <= 0 then game.log("You need a class point") return end
    if not item.can_level then game.log("You don't fulfill all the requirements for this class") return end

    self.actor:levelClass(item.real_name)

    self:update()
end

function _M:on_select(item,sel)
    --if item.info then self.c_desc.text = item.info end
    --if item.name and self.c_desc then self.c_desc.text = item.name end
    if self.c_desc then self.c_desc:switchItem(item, item.desc) end
    self.selection = sel
end

function _M:update()
    local sel = self.selection
    self:generateList() -- Slow! Should just update the one changed and sort again
    self.c_points.text = "Available class points: "..self.actor.class_points
    self.c_points:generate()
    self.c_list.list = self.list
    self.c_list:generate()
    if sel then self.c_list:select(sel) end
end

function _M:generateList()
    local Birther = require "engine.Birther"

    local list = {}

    for i, d in ipairs(Birther.birth_descriptor_def.subclass) do
        local level = self.actor.classes[d.name] or 0
        local can_level = d.can_level(self.actor)
        local prestige = false
        local name = ""

        --generate description
        local desc = "#KHAKI#"..d.name.."#LAST#"
        if d.prestige then
            desc = desc.."\n#ORCHID#Prestige class#LAST#"
            prestige = true
        end

        local core_desc = d.desc
        if self:descText(d) then core_desc = self:descText(d) end
        desc = desc.."\n\n"..core_desc

        if can_level then
            name = "#SLATE#(#LAST##AQUAMARINE#"..level.."#LAST##SLATE#) #LAST#"..d.name
        else
            name = "#SLATE#(#LAST##AQUAMARINE#"..level.."#LAST##SLATE#) #DARK_GREY#"..d.name
        end
        table.insert(list, {name = name, desc = desc, level = level, real_name = d.name, can_level = can_level, prestige = prestige})
    end

    self.list = list

    table.sort(self.list, function (a,b)
        --Can I level it?
        if not a.can_level == b.can_level then
            return a.can_level
        end
        --Prestige classes after normal classes
        if not a.prestige and b.prestige then return true
        elseif a.prestige and not b.prestige then return false end
        if a.level == b.level then
            return a.name < b.name
        else
            return a.level > b.level
        end
    end)

end

function _M:descText(t)
	local actor = self.actor
	local d = t.desc(actor,t)
	return d
end
