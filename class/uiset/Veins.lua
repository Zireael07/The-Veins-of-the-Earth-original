-- Veins of the Earth
-- Copyright (C) 2014-2015 Zireael
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

--Based on ToME Classic UISet

require "engine.class"
local UISet = require "mod.class.uiset.UISet"
local DebugConsole = require "engine.DebugConsole"
local PlayerDisplay = require "mod.class.PlayerDisplay"
local HotkeysDisplay = require "engine.HotkeysDisplay"
--local HotkeysIconsDisplay = require "engine.HotkeysIconsDisplay"
local HotkeysIconsDisplay = require "mod.class.HotkeysIconsDisplay"
--local ActorsSeenDisplayMin = require "mod.class.patch.ActorsSeenDisplayMin"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
--local FlyingText = require "engine.FlyingText"
local FlyingText = require "mod.class.patch.FlyingText"
--local Tooltip = require "mod.class.Tooltip"
local Tooltip = require "mod.class.patch.Tooltip"

module(..., package.seeall, class.inherit(UISet))

function _M:init()
    UISet.init(self)
end

function _M:activate()
    local size, size_mono, font, font_mono, font_mono_h, font_h

    font = veins.fonts.hud.style
    size = veins.fonts.hud.size
    font_mono = veins.fonts.tooltip.style
    size_mono = veins.fonts.tooltip.size

    local f = core.display.newFont(font, size)
    font_h = f:lineSkip()
    f = core.display.newFont(font_mono, size_mono)
    font_mono_h = f:lineSkip()
    self.init_font = font
    self.init_size_font = size
    self.init_font_h = font_h
    self.init_font_mono = font_mono
    self.init_size_mono = size_mono
    self.init_font_mono_h = font_mono_h

--    local text_display_h = font_mono_h * 4.2
--    local text_display_h = font_h*5
    local text_display_h = 52

    self.hotkeys_display_text = HotkeysDisplay.new(nil, 216, game.h - text_display_h, game.w - 216, 52, "/data/gfx/ui/talents-list.png", font_mono, size_mono)
    self.hotkeys_display_text:enableShadow(0.6)
    self.hotkeys_display_text:setColumns(3)
    self:resizeIconsHotkeysToolbar()

    self.player_display = PlayerDisplay.new(0, 200, 200, game.h - 200, {30,30,0}, font_mono, size_mono)
    self.logdisplay = LogDisplay.new(216, self.map_h_stop - font_h * 5 -16, (game.w - 216) / 2, font_h * 5, nil, font, size, nil, nil)
    self.logdisplay.resizeToLines = function() self.logdisplay:resize(216, self.map_h_stop - font_h * 5 -16, (game.w - 216) / 2, font_h * 5) end
    self.logdisplay:enableShadow(1)
--    self.logdisplay:enableFading(config.settings.tome.log_fade or 3)
    self.logdisplay:enableFading(4)

    profile.chat:resize(216 + (game.w - 216) / 2, self.map_h_stop - font_h * 5 -16, (game.w - 216) / 2, font_h * 5, font, size, nil, nil)
    profile.chat.resizeToLines = function() profile.chat:resize(216 + (game.w - 216) / 2, self.map_h_stop - font_h * 5 -16, (game.w - 216) / 2, font_h * 5) end
    profile.chat:enableShadow(1)
    profile.chat:enableFading(4)
--    profile.chat:enableFading(config.settings.tome.log_fade or 3)
    profile.chat:enableDisplayChans(false)


--    self.npcs_display = ActorsSeenDisplay.new(nil, 216, game.h - text_display_h, game.w - 216, text_display_h, "/data/gfx/ui/talents-list.png", font_mono, size_mono)
    self.npcs_display = ActorsSeenDisplay.new(nil, 216, game.h - text_display_h, game.w - 216, text_display_h, "/data/gfx/ui/talents-list.png", font_mono, size_mono)
    self.npcs_display:setColumns(3)

--[[    self.npcs_display = ActorsSeenDisplayMin.new(nil, 216, game.h - font_mono_h * 5, game.w - 216, font_mono_h*5, "/data/gfx/ui/talents-list.png", font_mono, size_mono)
   self.npcs_display = ActorsSeenDisplayMin.new(nil, 216 + (game.w - 216) / 2, self.map_h_stop - font_h * 8 -16, (game.w - 216) / 2, font_mono_h*5, nil, font_mono, size_mono)
   self.npcs_display.resizeToLines = function () self.npcs_display:resize(216, self.map_h_stop - font_h * 5 -16, (game.w - 216) / 2, font_h * 5) end]]

    self.minimap_bg, self.minimap_bg_w, self.minimap_bg_h = core.display.loadImage("/data/gfx/ui/minimap.png"):glTexture()
    self:createSeparators()

    game.log = function(style, ...) if type(style) == "number" then game.uiset.logdisplay(...) else game.uiset.logdisplay(style, ...) end end
    game.logChat = function(style, ...)
        if true or not config.settings.tome.chat_log then return end
        if type(style) == "number" then
        local old = game.uiset.logdisplay.changed
        game.uiset.logdisplay(...) else game.uiset.logdisplay(style, ...) end
        if game.uiset.show_userchat then game.uiset.logdisplay.changed = old end
    end
--  game.logSeen = function(e, style, ...) if e and e.player or (not e.dead and e.x and e.y and game.level and game.level.map.seens(e.x, e.y) and game.player:canSee(e)) then game.log(style, ...) end end
    game.logPlayer = function(e, style, ...) if e == game.player or e == game.party then game.log(style, ...) end end
end

function _M:setupMinimap(level)
    level.map._map:setupMiniMapGridSize(4)
end

function _M:resizeIconsHotkeysToolbar()
--    local h = 52
--    if config.settings.tome.hotkey_icons then h = (4 + config.settings.tome.hotkey_icons_size) * config.settings.tome.hotkey_icons_rows end

    local h
    if game.show_npc_list then
        h = self.npcs_display.h
    else
        --default icon size in Veins is 48 +8 margin
        h = 52
    end

    local oldstop = self.map_h_stop or (game.h - h)
    self.map_h_stop = game.h - h
    self.map_h_stop_tooltip = game.h - h

    if self.hotkeys_display_icons then
        self.hotkeys_display_icons:resize(216, game.h - h, game.w - 216, h, 48, 48)
    else
        self.hotkeys_display_icons = HotkeysIconsDisplay.new(nil, 216, game.h - h, game.w - 216, h, "/data/gfx/ui/talents-list.png", self.init_font_mono, self.init_size_mono, 48, 48)
        self.hotkeys_display_icons:enableShadow(0.6)
    end


--    self.hotkeys_display_icons = HotkeysIconsDisplay.new(nil, 216, game.h - h, game.w - 216, h, "/data/gfx/ui/talents-list.png", self.init_font_mono, self.init_size_mono, 48, 48)
--    self.hotkeys_display_icons:enableShadow(0.6)

    if game.inited then
    --    game:resizeMapViewport(game.w - 216, self.map_h_stop - 16, 216, 0)
        self.logdisplay.display_y = self.logdisplay.display_y + self.map_h_stop - oldstop
        profile.chat.display_y = profile.chat.display_y + self.map_h_stop - oldstop
        self.npcs_display_y = self.npcs_display_y + self.map_h_stop - oldstop
        game:setupMouse(true)
    end

    self.hotkeys_display = self.hotkeys_display_icons

--    self.hotkeys_display = config.settings.tome.hotkey_icons and self.hotkeys_display_icons or self.hotkeys_display_text
    self.hotkeys_display.actor = game.player
end


function _M:getMapSize()
    local w, h = core.display.size()
    return 220, 0, w - 220, math.floor(h*0.8)-20
    --changing h leads to map distortion if fbo/shaders are on
--    return 220, 0, w - 220, (h - 100)
end

--------------------------------------------------------------
-- UI stuff
--------------------------------------------------------------

local _sep_horiz = {core.display.loadImage("/data/gfx/ui/separator-hori.png")} _sep_horiz.tex = {_sep_horiz[1]:glTexture()}
local _sep_vert = {core.display.loadImage("/data/gfx/ui/separator-vert.png")} _sep_vert.tex = {_sep_vert[1]:glTexture()}
local _sep_top = {core.display.loadImage("/data/gfx/ui/separator-top.png")} _sep_top.tex = {_sep_top[1]:glTexture()}
local _sep_bottom = {core.display.loadImage("/data/gfx/ui/separator-bottom.png")} _sep_bottom.tex = {_sep_bottom[1]:glTexture()}
local _sep_bottoml = {core.display.loadImage("/data/gfx/ui/separator-bottom_line_end.png")} _sep_bottoml.tex = {_sep_bottoml[1]:glTexture()}
local _sep_left = {core.display.loadImage("/data/gfx/ui/separator-left.png")} _sep_left.tex = {_sep_left[1]:glTexture()}
local _sep_leftl = {core.display.loadImage("/data/gfx/ui/separator-left_line_end.png")} _sep_leftl.tex = {_sep_leftl[1]:glTexture()}
local _sep_rightl = {core.display.loadImage("/data/gfx/ui/separator-right_line_end.png")} _sep_rightl.tex = {_sep_rightl[1]:glTexture()}

local _log_icon, _log_icon_w, _log_icon_h = core.display.loadImage("/data/gfx/ui/log-icon.png"):glTexture()
local _chat_icon, _chat_icon_w, _chat_icon_h = core.display.loadImage("/data/gfx/ui/chat-icon.png"):glTexture()
local _talents_icon, _talents_icon_w, _talents_icon_h = core.display.loadImage("/data/gfx/ui/talents-icon.png"):glTexture()
local _actors_icon, _actors_icon_w, _actors_icon_h = core.display.loadImage("/data/gfx/ui/actors-icon.png"):glTexture()
local _main_menu_icon, _main_menu_icon_w, _main_menu_icon_h = core.display.loadImage("/data/gfx/ui/main-menu-icon.png"):glTexture()
local _inventory_icon, _inventory_icon_w, _inventory_icon_h = core.display.loadImage("/data/gfx/ui/inventory-icon.png"):glTexture()
local _charsheet_icon, _charsheet_icon_w, _charsheet_icon_h = core.display.loadImage("/data/gfx/ui/charsheet-icon.png"):glTexture()
--local _mm_aggressive_icon, _mm_aggressive_icon_w, _mm_aggressive_icon_h = core.display.loadImage("/data/gfx/ui/aggressive-icon.png"):glTexture()
--local _mm_passive_icon, _mm_passive_icon_w, _mm_passive_icon_h = core.display.loadImage("/data/gfx/ui/passive-icon.png"):glTexture()
--local _sel_icon, _sel_icon_w, _sel_icon_h = core.display.loadImage("/data/gfx/ui/icon-select.png"):glTexture()

function _M:displayUI()
    local middle = game.w * 0.5
    local bottom = game.h * 0.8
    local bottom_h = game.h * 0.2
    local icon_x = 0
    local icon_y = game.h - (_inventory_icon_h * 1)
    local glow = (1+math.sin(core.game.getTime() / 500)) / 2 * 100 + 77

    -- Icons
    local x, y = icon_x, icon_y
    if (not game.show_npc_list) then
        _talents_icon:toScreenFull(x, y, _talents_icon_w, _talents_icon_h, _talents_icon_w, _talents_icon_h)
    else
        _actors_icon:toScreenFull(x, y, _actors_icon_w, _actors_icon_h, _actors_icon_w, _actors_icon_h)
    end
    x = x + _talents_icon_w

    -- This is the old version of what's above. Probably should be deleted?
--  _talents_icon:toScreenFull(x, y, _talents_icon_w, _talents_icon_h, _talents_icon_w, _talents_icon_h)
--  if not self.show_npc_list then _sel_icon:toScreenFull(x, y, _sel_icon_w, _sel_icon_h, _sel_icon_w, _sel_icon_h) end
--  x = x + _talents_icon_w
--  _actors_icon:toScreenFull(x, y, _actors_icon_w, _actors_icon_h, _actors_icon_w, _actors_icon_h)
--  if self.show_npc_list then _sel_icon:toScreenFull(x, y, _sel_icon_w, _sel_icon_h, _sel_icon_w, _sel_icon_h) end
--  x = x + _talents_icon_w

--  if self.logdisplay.changed then core.display.drawQuad(x, y, _sel_icon_w, _sel_icon_h, 139, 210, 77, glow) end
--  _log_icon:toScreenFull(x, y, _log_icon_w, _log_icon_h, _log_icon_w, _log_icon_h)
--  if not self.show_userchat then _sel_icon:toScreenFull(x, y, _sel_icon_w, _sel_icon_h, _sel_icon_w, _sel_icon_h) end
--  x = x + _talents_icon_w

--  if profile.chat.changed then core.display.drawQuad(x, y, _sel_icon_w, _sel_icon_h, 139, 210, 77, glow) end
--  _chat_icon:toScreenFull(x, y, _chat_icon_w, _chat_icon_h, _chat_icon_w, _chat_icon_h)
--  if self.show_userchat then _sel_icon:toScreenFull(x, y, _sel_icon_w, _sel_icon_h, _sel_icon_w, _sel_icon_h) end

--  x = 0
--  y = y + _chat_icon_h
--  x = x + _talents_icon_w

    _inventory_icon:toScreenFull(x, y, _inventory_icon_w, _inventory_icon_h, _inventory_icon_w, _inventory_icon_h)
    x = x + _inventory_icon_w
--    x = x + _talents_icon_w
    _charsheet_icon:toScreenFull(x, y, _charsheet_icon_w, _charsheet_icon_h, _charsheet_icon_w, _charsheet_icon_h)
    x = x + _inventory_icon_w
--    x = x + _talents_icon_w
    _main_menu_icon:toScreenFull(x, y, _main_menu_icon_w, _main_menu_icon_h, _main_menu_icon_w, _main_menu_icon_h)
    x = x + _inventory_icon_w
--    x = x + _talents_icon_w
    _log_icon:toScreenFull(x, y, _log_icon_w, _log_icon_h, _log_icon_w, _log_icon_h)
    x = x + _inventory_icon_w
--    x = x + _talents_icon_w

    -- Separators
--  _sep_horiz.tex[1]:toScreenFull(0, 20, game.w, _sep_horiz[3], _sep_horiz.tex[2], _sep_horiz.tex[3])
    _sep_horiz.tex[1]:toScreenFull(216, self.map_h_stop - _sep_horiz[3], game.w - 216, _sep_horiz[3], _sep_horiz.tex[2], _sep_horiz.tex[3])

--  _sep_vert.tex[1]:toScreenFull(mid_min, bottom, _sep_vert[2], bottom_h, _sep_vert.tex[2], _sep_vert.tex[3])
--  _sep_vert.tex[1]:toScreenFull(mid_max, bottom, _sep_vert[2], bottom_h, _sep_vert.tex[2], _sep_vert.tex[3])

    _sep_vert.tex[1]:toScreenFull(200, 0, _sep_vert[2], game.h, _sep_vert.tex[2], _sep_vert.tex[3])

    -- Ornaments
--  _sep_top.tex[1]:toScreenFull(mid_min - (-_sep_vert[2] + _sep_top[2]) / 2, bottom - 14, _sep_top[2], _sep_top[3], _sep_top.tex[2], _sep_top.tex[3])
--  _sep_top.tex[1]:toScreenFull(mid_max - (-_sep_vert[2] + _sep_top[2]) / 2, bottom - 14, _sep_top[2], _sep_top[3], _sep_top.tex[2], _sep_top.tex[3])
--  _sep_bottoml.tex[1]:toScreenFull(mid_min - (-_sep_vert[2] + _sep_bottoml[2]) / 2, game.h - _sep_bottoml[3], _sep_bottoml[2], _sep_bottoml[3], _sep_bottoml.tex[2], _sep_bottoml.tex[3])
--  _sep_bottoml.tex[1]:toScreenFull(mid_max - (-_sep_vert[2] + _sep_bottoml[2]) / 2, game.h - _sep_bottoml[3], _sep_bottoml[2], _sep_bottoml[3], _sep_bottoml.tex[2], _sep_bottoml.tex[3])

--  _sep_leftl.tex[1]:toScreenFull(0, 20 - _sep_leftl[3] / 2 + 7, _sep_leftl[2], _sep_leftl[3], _sep_leftl.tex[2], _sep_leftl.tex[3])
    _sep_left.tex[1]:toScreenFull(200 - 7, self.map_h_stop - 7 - _sep_left[3] / 2, _sep_left[2], _sep_left[3], _sep_left.tex[2], _sep_left.tex[3])

--  _sep_rightl.tex[1]:toScreenFull(game.w - _sep_rightl[2], 20 - _sep_rightl[3] / 2 + 7, _sep_rightl[2], _sep_rightl[3], _sep_rightl.tex[2], _sep_rightl.tex[3])
    _sep_rightl.tex[1]:toScreenFull(game.w - _sep_rightl[2], self.map_h_stop - _sep_left[3] / 2, _sep_rightl[2], _sep_rightl[3], _sep_rightl.tex[2], _sep_rightl.tex[3])

    _sep_top.tex[1]:toScreenFull(200 - (_sep_top[2] - _sep_vert[2]) / 2, - 7, _sep_top[2], _sep_top[3], _sep_top.tex[2], _sep_top.tex[3])
--  _sep_bottom.tex[1]:toScreenFull(200 - (_sep_bottom[2] - _sep_vert[2]) / 2, bottom - 25, _sep_bottom[2], _sep_bottom[3], _sep_bottom.tex[2], _sep_bottom.tex[3])

end

function _M:createSeparators()
    local icon_x = 0
    local icon_y = game.h - (_inventory_icon_h * 1)
    self.icons = {
        display_x = icon_x,
        display_y = icon_y,
        w = 200,
        h = game.h - icon_y,
    }
end

function _M:clickIcon(bx, by)
    if bx < _talents_icon_w then
        game.key:triggerVirtual("TOGGLE_NPC_LIST")
    elseif bx < 2*_inventory_icon_w then
        game.key:triggerVirtual("SHOW_INVENTORY")
    elseif bx < 3*_inventory_icon_w then
        game.key:triggerVirtual("SHOW_CHARACTER_SHEET")
    elseif bx < 4*_inventory_icon_w then
        game.key:triggerVirtual("EXIT")
    elseif bx < 5*_inventory_icon_w then
        game.key:triggerVirtual("SHOW_MESSAGE_LOG")
    end
end

function _M:mouseIcon(bx, by)
    local virtual
    local key

  if bx < _talents_icon_w then
        virtual = "TOGGLE_NPC_LIST"
        key = game.key.binds_remap[virtual] ~= nil and game.key.binds_remap[virtual][1] or game.key:findBoundKeys(virtual)
        key = (key ~= nil and game.key:formatKeyString(key) or "unbound"):capitalize()
        if (not game.show_npc_list) then
            game:tooltipDisplayAtMap(game.w, game.h, "Displaying talents (#{bold}##GOLD#"..key.."#LAST##{normal}#)\nToggle for creature display")
        else
            game:tooltipDisplayAtMap(game.w, game.h, "Displaying creatures (#{bold}##GOLD#"..key.."#LAST##{normal}#)\nToggle for talent display#")
        end
    elseif bx < 2*_inventory_icon_w then
        virtual = "SHOW_INVENTORY"
        key = game.key.binds_remap[virtual] ~= nil and game.key.binds_remap[virtual][1] or game.key:findBoundKeys(virtual)
        key = (key ~= nil and game.key:formatKeyString(key) or "unbound"):capitalize()
        if (key == "I") then
            game:tooltipDisplayAtMap(game.w, game.h, "#{bold}##GOLD#I#LAST##{normal}#nventory")
        else
            game:tooltipDisplayAtMap(game.w, game.h, "Inventory (#{bold}##GOLD#"..key.."#LAST##{normal}#)")
        end
    elseif bx < 3*_inventory_icon_w then
        virtual = "SHOW_CHARACTER_SHEET"
        key = game.key.binds_remap[virtual] ~= nil and game.key.binds_remap[virtual][1] or game.key:findBoundKeys(virtual)
        key = (key ~= nil and game.key:formatKeyString(key) or "unbound"):capitalize()
        if (key == "C") then
            game:tooltipDisplayAtMap(game.w, game.h, "#{bold}##GOLD#C#LAST##{normal}#haracter Sheet")
        else
            game:tooltipDisplayAtMap(game.w, game.h, "Character Sheet (#{bold}##GOLD#"..key.."#LAST##{normal}#)")
        end
    elseif bx < 4*_inventory_icon_w then
        virtual = "EXIT"
        key = game.key.binds_remap[virtual] ~= nil and game.key.binds_remap[virtual][1] or game.key:findBoundKeys(virtual)
        key = (key ~= nil and game.key:formatKeyString(key) or "unbound"):capitalize()
        game:tooltipDisplayAtMap(game.w, game.h, "Main menu (#{bold}##GOLD#"..key.."#LAST##{normal}#)")
    elseif bx < 5*_inventory_icon_w then
        virtual = "SHOW_MESSAGE_LOG"
        key = game.key.binds_remap[virtual] ~= nil and game.key.binds_remap[virtual][1] or game.key:findBoundKeys(virtual)
        key = (key ~= nil and game.key:formatKeyString(key) or "unbound"):capitalize()
        game:tooltipDisplayAtMap(game.w, game.h, "Show message/chat log (#{bold}##GOLD#"..key.."#LAST##{normal}#)")
    end
end

function _M:display(nb_keyframes)
    -- Now the map, if any
    game:displayMap(nb_keyframes)

    -- Display the targetting system if active
--    game.target:display()

    -- Minimap display
    if game.level and game.level.map and not self.no_minimap then
        local map = game.level.map
--[[        game.zone_name_s:toScreenFull(
            map.display_x + map.viewport.width - game.zone_name_w - 15,
            map.display_y + 5,
            game.zone_name_w, game.zone_name_h,
            game.zone_name_tw, game.zone_name_th
        )]]


        local map = game.level.map
--      if self.mm_fbo then
--          self.mm_fbo:use(true)
--          self.minimap_scroll_x, self.minimap_scroll_y = util.bound(self.player.x - 25, 0, map.w - 50), util.bound(self.player.y - 25, 0, map.h - 50)
--          map:minimapDisplay(0, 0, self.minimap_scroll_x, self.minimap_scroll_y, 50, 50, 1)
--          self.mm_fbo:use(false, self.full_fbo)
--          self.minimap_bg:toScreen(0, 0, 200, 200)
--          self.mm_fbo:toScreen(0, 0, 200, 200, self.mm_fbo_shader.shad)
--      else
            self.minimap_bg:toScreen(0, 0, 200, 200)
            if game.player.x then
                game.minimap_scroll_x, game.minimap_scroll_y = util.bound(game.player.x - 25, 0, map.w - 50), util.bound(game.player.y - 25, 0, map.h - 50)
            else
                game.minimap_scroll_x, game.minimap_scroll_y = 0, 0
            end
            map:minimapDisplay(0, 0, game.minimap_scroll_x, game.minimap_scroll_y, 50, 50, 1)
--      end
    end

    -- We display the player's interface
    profile.chat:toScreen()
    self.logdisplay:toScreen()

    self.hotkeys_display_icons:toScreen()

--    self.npcs_display:toScreen()

    self.player_display:toScreen(nb_keyframes)

    if game.show_npc_list then
        self.npcs_display:toScreen()
    else
        self.hotkeys_display:toScreen()
    end

    -- UI
    self:displayUI()
end

function _M:setupMouse(mouse)
    -- Scroll message log
    mouse:registerZone(profile.chat.display_x, profile.chat.display_y, profile.chat.w, profile.chat.h, function(button, mx, my, xrel, yrel, bx, by, event)
        profile.chat.mouse:delegate(button, mx, my, xrel, yrel, bx, by, event)
    end)
    -- Use hotkeys with mouse
    mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, game.w, game.h, function(button, mx, my, xrel, yrel, bx, by, event)
        if game.show_npc_list then return end
        if event == "out" then self.hotkeys_display.cur_sel = nil return end
        if event == "button" and button == "left" and ((game.zone and game.zone.wilderness) or (game.key ~= game.normal_key)) then return end
        self.hotkeys_display:onMouse(button, mx, my, event == "button",
            function(text)
                text = text:toTString()
                text:add(true, "---", true, {"font","italic"}, {"color","GOLD"}, "Left click to use", true, "Right click to configure", true, "Press 'm' to setup", {"color","LAST"}, {"font","normal"})
                game:tooltipDisplayAtMap(game.w, game.h, text)
            end,
            function(i, hk)
                if button == "right" and hk and hk[1] == "talent" then
					local d = require("mod.dialogs.UseTalents").new(game.player)
					d:use({talent=hk[2], name=game.player:getTalentFromId(hk[2]).name}, "right")
					return true
				elseif button == "right" and hk and hk[1] == "inventory" then
					Dialog:yesnoPopup("Unbind "..hk[2], "Remove this object from your hotkeys?", function(ret) if ret then
						for i = 1, 12 * game.player.nb_hotkey_pages do
							if game.player.hotkey[i] and game.player.hotkey[i][1] == "inventory" and game.player.hotkey[i][2] == hk[2] then game.player.hotkey[i] = nil end
						end
					end end)
					return true
				end
            end
        )
    end, nil, "hotkeys", true)
    -- Use icons
    mouse:registerZone(self.icons.display_x, self.icons.display_y, self.icons.w, self.icons.h, function(button, mx, my, xrel, yrel, bx, by, event)
        self:mouseIcon(bx, by)
        if button == "left" and event == "button" then self:clickIcon(bx, by) end
    end)
    -- Tooltip over the player pane
--[[   mouse:registerZone(self.player_display.display_x, self.player_display.display_y, self.player_display.w, self.player_display.h - self.icons.h, function(button, mx, my, xrel, yrel, bx, by, event)
        self.player_display.mouse:delegate(button, mx, my, xrel, yrel, bx, by, event)
    end)]]
    -- Move using the minimap
    mouse:registerZone(0, 0, 200, 200, function(button, mx, my, xrel, yrel, bx, by, event)
        if button == "left" and not xrel and not yrel and event == "button" then
            local tmx, tmy = math.floor(bx / 4), math.floor(by / 4)
            game.player:mouseMove(tmx + game.minimap_scroll_x, tmy + game.minimap_scroll_y)
        elseif button == "right" and self.level then
            local tmx, tmy = math.floor(bx / 4), math.floor(by / 4)
            self.level.map:moveViewSurround(tmx + game.minimap_scroll_x, tmy + game.minimap_scroll_y, 1000, 1000)
        end
    end)
end
