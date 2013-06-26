-- $Id: UseItemDialog.lua 2 2012-07-08 02:40:16Z dsb $
-- ToME - Tales of Middle-Earth
-- Copyright (C) 2012 Scott Bigham
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
--
-- Scott Bigham "Zizzo"
-- dsb-tome@killerbbunnies.org

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(center_mouse, actor, object, item, inven, on_use)
  self.actor = actor
  self.object = object
  self.inven = inven
  self.item = item
  self.on_use = on_use

  self:generateList()
  local name = object:getName()
  Dialog.init(self, name, 1, 1)

  local w = self.font_bold:size(name)
  local list = List.new {
    width = math.max(w, self.max_w) + 10,
    nb_items = #self.list,
    list = self.list,
    fct = function(item) self:use(item) end,
  }

  local center_cb = function(w, h)
    if center_mouse then
      local mx, my = core.mouse.get()
      self.force_x = mx - w / 2
      self.force_y = my - (self.h - self.ih + list.fh / 3)
    end
  end
  self:loadUI { { left=0, top=0, ui=list } }
  self:setupUI(true, true, center_cb)

  self.key:addBinds {
    EXIT = function() game:unregisterDialog(self) end
  }
end

function _M:use(item)
  if not item then return end
  game:unregisterDialog(self)
  print('[USE ITEM] action='..item.action)

  if item.action == "use" then
        self.actor:playerUseItem(self.object, self.item, self.inven, self.on_use)
        self.on_use(self.inven, self.item, self.object, true)
 --   elseif item.action == 'quaff' then
    -- TODO self.actor:playerQuaffPotion(self.object, self.item, self.inven, self.on_use)
 --   self.on_use(self.inven, self.item, self.object, true)
 -- elseif item.action == 'read' then
    -- TODO self.actor:playerReadScroll(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'aim_wand' then
    -- TODO self.actor:playerAimWand(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'use_staff' then
    -- TODO self.actor:playerUseStaff(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'zap_rod' then
    -- TODO self.actor:playerZapRod(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'activate' then
    -- TODO self.actor:playerActivateItem(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'eat' then
    -- TODO self.actor:playerEatFood(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'fill' then
    -- TODO self.actor:playerFillLantern(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
--  elseif item.action == 'browse' then
    -- TODO self.actor:playerBrowseSpellbook(self.object, self.item, self.inven, self.on_use)
--    self.on_use(self.inven, self.item, self.object, true)
  elseif item.action == 'wear' then
    self.actor:doWear(self.inven, self.item, self.object)
    self.on_use(self.inven, self.item, self.object, true)
  elseif item.action == 'takeoff' then
    self.actor:doTakeoff(self.inven, self.item, self.object)
    self.on_use(self.inven, self.item, self.object, true)
  elseif item.action == 'drop' then
    local on_use_cb = function()
      self.on_use(self.inven, self.item, self.object, false)
    end
    self.actor:doDrop(self.inven, self.item, on_use_cb)
  end
end

function _M:generateList()
  local list = {}

  if self.object.use_simple then
    list[#list+1] = { name='Use', action='use' }
  end
--  if self.object.on_quaff then
--    list[#list+1] = { name='Quaff', action='quaff' }
--  end
--  if self.object.on_read then
--    list[#list+1] = { name='Read', action='read' }
--  end
  -- We'll assume on object will have more than one of the following three
  -- callbacks, so we can reuse the action name.
--  if self.object.on_aim then
--    list[#list+1] = { name='Use', action='aim_wand' }
--  end
  
---  if self.object.on_zap then
--    list[#list+1] = { name='Use', action='zap_rod' }
--  end
--  if self.object.on_activate then
--    list[#list+1] = { name='Activate', action='activate' }
--  end
--  if self.object.foodval then
--    list[#list+1] = { name='Eat', action='eat' }
--  end
--  if self.object.oil then
--    list[#list+1] = { name='Fill lantern', action='fill' }
--  end
--  if self.object.spells then
--    list[#list+1] = { name='Browse spells', action='browse' }
--  end
  if self.inven == self.actor.INVEN_INVEN and self.object.slot then
    list[#list+1] = { name='Wear/wield', action='wear' }
  end
 if self.inven ~= self.actor.INVEN_INVEN then
   list[#list+1] = { name='Take off', action='takeoff' }
  end
  -- TODO Maybe allow drop from equip
  if self.inven == self.actor.INVEN_INVEN then
    list[#list+1] = { name='Drop', action='drop' }
  end

  self.max_w = 0
  self.max_h = 0
  for i, v in ipairs(list) do
    local w, h = self.font:size(v.name)
    self.max_w = math.max(self.max_w, w)
    self.max_h = self.max_h + self.font_h
  end

  self.list = list
end
