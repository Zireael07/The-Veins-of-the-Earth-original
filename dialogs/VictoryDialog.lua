require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local Button = require "engine.ui.Button"
local Savefile = require "engine.Savefile"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Victory!", game.w * 0.6, game.h * 0.6)

    self.text=[[
    You have escaped the #SANDY_BROWN#Veins of the Earth#LAST# and won the game!
]]

    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}

    self:loadUI{
             {left=0, top=0, ui=self.c_desc},

    }
    self:setupUI(false, true)

    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function()
            game:unregisterDialog(self)
            --close the game
            local save = Savefile.new(game.save_name)
    		save:delete()
    		save:close()
    		util.showMainMenu()
        end,
    }
end
