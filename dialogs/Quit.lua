-- Veins of the Earth
-- Copyright (C) 2013 Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'engine.class'
local Dialog = require 'engine.ui.Dialog'
local List = require 'engine.ui.List'
local Savefile = require 'engine.Savefile'

module(..., package.seeall, class.inherit(engine.ui.Dialog))

function _M:init()
  local w, h = 300, 100
  Dialog.init(self, 'Save Character', 300, 100)
  self.c_list = List.new {
    width = w,
    height = h,

list = {
      {
	name = 'Continue playing',
	fct = function(_)
	  game:unregisterDialog(self)
	  game.quit_dialog = false
	end
      },
      {
	name = 'Save and continue playing',
	fct = function(_)
	  game:unregisterDialog(self)
	  game.quit_dialog = false
	  savefile_pipe:push(game.save_name, "game", game)
	end
      },
      {
	name = 'Save and quit',
	fct = function(_)
	  game:unregisterDialog(self)
	  savefile_pipe:push(game.save_name, "game", game)
	  util.showMainMenu()
	end
      },
      {
	name = 'Quit and abandon character',
	fct = function(_)
	  game:unregisterDialog(self)
	  game.quit_dialog = false
	  self:confirmQuit()
	end
      }
    },
   fct = function() self.key:triggerVirtual('ACCEPT') end,
  }
  self:loadUI {
    { left = 3, top = 3, ui = self.c_list }
  }
  self.key:addBind('EXIT', function()
    game:unregisterDialog(self)
    game.quit_dialog = false
  end)
  self.key:addBind('ACCEPT', function()
    local item = self.c_list.list[self.c_list.sel]
    if item and item.fct then item.fct(item) end
  end)
  self:setFocus(self.c_list)
  self:setupUI(true, true)
end

function _M:confirmQuit()
  local text = "#{bold}#WARNING:#{normal}#  This will remove the savefile for this character, and you will be unable to play it further.\n\nProceed anyway?"
  local callback = function(ret)
    if not ret then
      local save = Savefile.new(game.save_name)
      save:delete()
      save:close()
      util.showMainMenu()
    end
  end
  Dialog:yesnoLongPopup('Quit Permanently?', text, 400, callback, "Don't quit", 'Quit')
end