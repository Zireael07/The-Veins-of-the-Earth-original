--Veins of the Earth
--Zireael 2013-2016

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Credits", game.w * 0.5, game.h * 0.5)

    self.text=[[
Credit and thanks, in no particular order and not limited to, are due to:
#{bold}#Key thanks#{normal}#
· #SANDY_BROWN#Nicolas "DarkGod" Casalini#LAST#, without whom this would never have happened

#{bold}#Third-Party Resources:#{normal}#
· #LIGHT_GREEN#Hotkey icons#LAST# for various spells and talents come from #SANDY_BROWN#Game-icons.net#LAST# <#LIGHT_BLUE#http://game-icons.net/#LAST#> and are used under the Creative Commons CC-BY-3.0 license.
· #LIGHT_GREEN#Tiles used#LAST# come from #SANDY_BROWN#Daniel E. Gervais#LAST#, who released them under Creative Commons BY-3.0. For further info, read license.txt in data/gfx/tiles.
· #LIGHT_GREEN#Player tiles#LAST# come from DCSS and were released under CC0.
· #LIGHT_GREEN#Text scrambling#LAST# is done via rot13. The exact function was taken from <#LIGHT_BLUE#lua-users.org/#LAST#>.


#{bold}#Contributors:#{normal}#
· Zireael
· Sebsebeleb
· DarkGod
· Castler
· desophos
· u/Ozymandias79

#{bold}#Testers:#{normal}#
· Leissi
· AuraOfTheDawn
· lukep
· Castler
· u/Ozymandias79
]]

    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}


    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
    }
    self:setupUI(false, true)

    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end
