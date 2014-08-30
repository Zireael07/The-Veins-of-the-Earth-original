-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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


require "engine.class"
local UI = require "engine.ui.Base"
local UISet = require "mod.class.uiset.UISet"
local DebugConsole = require "engine.DebugConsole"
local PlayerDisplay = require "mod.class.PlayerDisplay"
local HotkeysDisplay = require "engine.HotkeysDisplay"
local HotkeysIconsDisplay = require "engine.HotkeysIconsDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local FlyingText = require "engine.FlyingText"
local Shader = require "engine.Shader"
--local Tooltip = require "mod.class.Tooltip"
local Tooltip = require "mod.class.patch.Tooltip"
local TooltipsData = require "mod.class.interface.TooltipsData"
local Dialog = require "engine.ui.Dialog"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(UISet, TooltipsData))

local move_handle = {core.display.loadImage("/data/gfx/ui/move_handle.png"):glTexture()}

function _M:init()
    UISet.init(self)

    self.mhandle = {}
    self.res = {}
    self.party = {}
    self.tbuff = {}
    self.pbuff = {}

    self.locked = true

    self.mhandle_pos = {
    --    player = {x=296, y=73, name="Player Infos"},
        minimap = {x=208, y=176, name="Minimap"},
        gamelog = {x=function(self) return self.logdisplay.w - move_handle[6] end, y=function(self) return self.logdisplay.h - move_handle[6] end, name="Game Log"},
        hotkeys = {x=function(self) return self.places.hotkeys.w - move_handle[6] end, y=function(self) return self.places.hotkeys.h - move_handle[6] end, name="Hotkeys"},
    }

    self:resetPlaces()
    table.merge(self.places, config.settings.tome.uiset_minimalist and config.settings.tome.uiset_minimalist.places or {}, true)

    local w, h = core.display.size()

    -- Adjsut to account for resolution change
    if config.settings.tome.uiset_minimalist and config.settings.tome.uiset_minimalist.save_size then
        local ow, oh = config.settings.tome.uiset_minimalist.save_size.w, config.settings.tome.uiset_minimalist.save_size.h

        -- Adjust UI
        local w2, h2 = math.floor(ow / 2), math.floor(oh / 2)
        for what, d in pairs(self.places) do
            if d.x > w2 then d.x = d.x + w - ow end
            if d.y > h2 then d.y = d.y + h - oh end
        end
    end

    self.sizes = {}
end

function _M:isLocked()
    return self.locked
end

function _M:switchLocked()
    self.locked = not self.locked
    if self.locked then
  --      game.bignews:say(60, "#CRIMSON#Interface locked, mouse enabled on the map")
    else
  --      game.bignews:say(60, "#CRIMSON#Interface unlocked, mouse disabled on the map")
    end
end

function _M:getMainMenuItems()
    return {
        {"Reset interface positions", function() Dialog:yesnoPopup("Reset UI", "Reset all the interface?", function(ret) if ret then
            self:resetPlaces() self:saveSettings() 
        end end) end},
    }
end

function _M:resetPlaces()
    local w, h = core.display.size()

    local th = 48

    local hup = h - th

    self.places = {
    --    player = {x=0, y=0, scale=1, a=1},
        minimap = {x=w - 239, y=0, scale=1, a=1},
        gamelog = {x=0, y=hup - 210, w=math.floor(w/2), h=200, scale=1, a=1},
        hotkeys = {x=10, y=h - th, w=w-60, h=th, scale=1, a=1},
    }
end

function _M:boundPlaces(w, h)
    w = w or game.w
    h = h or game.h

    for what, d in pairs(self.places) do
        if d.x then
            d.x = math.floor(d.x)
            d.y = math.floor(d.y)
            if d.w and d.h then
                d.scale = 1

                d.x = util.bound(d.x, 0, w - d.w)
                d.y = util.bound(d.y, 0, h - d.h)
            elseif d.scale then
                d.scale = util.bound(d.scale, 0.5, 2)

                local mx, my = util.getval(self.mhandle_pos[what].x, self), util.getval(self.mhandle_pos[what].y, self)

                d.x = util.bound(d.x, -mx * d.scale, w - mx * d.scale - move_handle[6] * d.scale)
                d.y = util.bound(d.y, -my * d.scale, self.map_h_stop - my * d.scale - move_handle[7] * d.scale)
            end
        end
    end
end

function _M:saveSettings()
    self:boundPlaces()

    local lines = {}
    lines[#lines+1] = ("tome.uiset_minimalist = {}"):format()
    lines[#lines+1] = ("tome.uiset_minimalist.save_size = {w=%d, h=%d}"):format(game.w, game.h)
    lines[#lines+1] = ("tome.uiset_minimalist.places = {}"):format(w)
    for _, w in ipairs{"player", "minimap", "gamelog", "hotkeys"} do
        lines[#lines+1] = ("tome.uiset_minimalist.places.%s = {}"):format(w)
        if self.places[w] then for k, v in pairs(self.places[w]) do
            lines[#lines+1] = ("tome.uiset_minimalist.places.%s.%s = %f"):format(w, k, v)
        end end
    end

--    self:triggerHook{"UISet:Minimalist:saveSettings", lines=lines}

    game:saveSettings("tome.uiset_minimalist", table.concat(lines, "\n"))
end

function _M:activate()
--[[    local size, size_mono, font, font_mono, font_mono_h, font_h

    size = ({normal=16, small=14, big=18})[config.settings.tome.fonts.size]
    size_mono = ({normal=14, small=10, big=16})[config.settings.tome.fonts.size]
    font = "/data/font/DroidSans.ttf"
    font_mono = "/data/font/DroidSansMono.ttf"

    local f = core.display.newFont(font, size)
    font_h = f:lineSkip()
    f = core.display.newFont(font_mono, size_mono)
    font_mono_h = f:lineSkip()
    self.init_font = font
    self.init_size_font = size
    self.init_font_h = font_h
    self.init_font_mono = font_mono
    self.init_size_mono = size_mono
    self.init_font_mono_h = font_mono_h]]

    self:resizeIconsHotkeysToolbar()

--    self.logdisplay = LogDisplay.new(0, 0, self.places.gamelog.w, self.places.gamelog.h, nil, font, size, nil, nil)
    self.logdisplay = LogDisplay.new(0, 0, self.places.gamelog.w, self.places.gamelog.h, 5, nil, 14, nil, nil)
    self.logdisplay:enableFading(7)

    game.log = function(style, ...) if type(style) == "number" then game.uiset.logdisplay(...) else game.uiset.logdisplay(style, ...) end end
    game.logPlayer = function(e, style, ...) if e == game.player then game.log(style, ...) end end

    self:boundPlaces()
end

function _M:setupMinimap(level)
    level.map._map:setupMiniMapGridSize(4)
end

function _M:resizeIconsHotkeysToolbar()
    local h = 52
    if config.settings.tome.hotkey_icons then h = (4 + config.settings.tome.hotkey_icons_size) * config.settings.tome.hotkey_icons_rows end

    local oldstop = self.map_h_stop or (game.h - h)
    self.map_h_stop = game.h - h
    self.map_h_stop_tooltip = game.h - h

--    self.hotkeys_display_icons = HotkeysIconsDisplay.new(nil, 216, game.h - h, game.w - 216, h, "/data/gfx/ui/talents-list.png", self.init_font_mono, self.init_size_mono, config.settings.tome.hotkey_icons_size, config.settings.tome.hotkey_icons_size)
    self.hotkeys_display_icons = HotkeysIconsDisplay.new(nil, 216, game.h - h, game.w - 216, h, {30,30,0}, nil, nil, 48, 48)

    self.hotkeys_display_icons:enableShadow(0.6)

    if game.inited then
        game:resizeMapViewport(game.w - 216, self.map_h_stop - 16)
        self.logdisplay.display_y = self.logdisplay.display_y + self.map_h_stop - oldstop
    --    profile.chat.display_y = profile.chat.display_y + self.map_h_stop - oldstop
        game:setupMouse()
    end

    self.hotkeys_display = self.hotkeys_display_icons
    self.hotkeys_display.actor = game.player
end

function _M:handleResolutionChange(w, h, ow, oh)
    print("minimalist:handleResolutionChange: adjusting UI")
    -- what was the point of this recursive call?
--  local w, h = core.display.size()
--  game:setResolution(w.."x"..h, true)

    -- Adjust UI
    local w2, h2 = math.floor(ow / 2), math.floor(oh / 2)
    for what, d in pairs(self.places) do
        if d.x > w2 then d.x = d.x + w - ow end
        if d.y > h2 then d.y = d.y + h - oh end
    end

    print("minimalist:handleResolutionChange: toggling UI to refresh")
    -- Toggle the UI to refresh the changes
    self:toggleUI()
    self:toggleUI()

    self:boundPlaces()
    self:saveSettings()
    print("minimalist:handleResolutionChange: saved settings")

    return true
end

function _M:getMapSize()
    local w, h = core.display.size()
    return 0, 0, w, (self.map_h_stop or 80) - 16
end

function _M:uiMoveResize(what, button, mx, my, xrel, yrel, bx, by, event, mode, on_change, add_text)
    if self.locked then return end

    mode = mode or "rescale"

    game.tooltip_x, game.tooltip_y = 1, 1; game:tooltipDisplayAtMap(game.w, game.h, self.mhandle_pos[what].name.."\n---\nLeft mouse drag&drop to move the frame\nRight mouse drag&drop to scale up/down\nMiddle click to reset to default scale"..(add_text or ""))
    if event == "button" and button == "middle" then self.places[what].scale = 1 self:saveSettings()
    elseif event == "motion" and button == "left" then
        self.ui_moving = what
        game.mouse:startDrag(mx, my, s, {kind="ui:move", id=what, dx=bx*self.places[what].scale, dy=by*self.places[what].scale},
            function(drag, used) self:saveSettings() self.ui_moving = nil if on_change then on_change("move") end end,
            function(drag, _, x, y) if self.places[drag.payload.id] then self.places[drag.payload.id].x = x-drag.payload.dx self.places[drag.payload.id].y = y-drag.payload.dy self:boundPlaces() if on_change then on_change("move") end end end,
            true
        )
    elseif event == "motion" and button == "right" then
        if mode == "rescale" then
            game.mouse:startDrag(mx, my, s, {kind="ui:rescale", id=what, bx=bx, by=by},
                function(drag, used) self:saveSettings() if on_change then on_change(mode) end end,
                function(drag, _, x, y) if self.places[drag.payload.id] then
                    self.places[drag.payload.id].scale = util.bound(math.max((x-self.places[drag.payload.id].x)/drag.payload.bx), 0.5, 2)
                    self:boundPlaces()
                    if on_change then on_change(mode) end
                end end,
                true
            )
        elseif mode == "resize" and self.places[what] then
            game.mouse:startDrag(mx, my, s, {kind="ui:resize", id=what, ox=mx - (self.places[what].x + util.getval(self.mhandle_pos[what].x, self)), oy=my - (self.places[what].y + util.getval(self.mhandle_pos[what].y, self))},
                function(drag, used) self:saveSettings() if on_change then on_change(mode) end end,
                function(drag, _, x, y) if self.places[drag.payload.id] then
                    self.places[drag.payload.id].w = math.max(20, x - self.places[drag.payload.id].x + drag.payload.ox)
                    self.places[drag.payload.id].h = math.max(20, y - self.places[drag.payload.id].y + drag.payload.oy)
                    if on_change then on_change(mode) end
                end end,
                true
            )
        end
    end
end

function _M:computePadding(what, x1, y1, x2, y2)
    self.sizes[what] = {}
    local size = self.sizes[what]
    if x2 < x1 then x1, x2 = x2, x1 end
    if y2 < y1 then y1, y2 = y2, y1 end
    size.x1 = x1
    size.x2 = x2
    size.y1 = y1
    size.y2 = y2
    -- This is Marson's code to make you not get stuck under UI elements
    -- I have tested and love it but I don't understand it very well, may be oversights
        if x2 <= Map.viewport.width / 4 then
            Map.viewport_padding_4 = math.max(Map.viewport_padding_4, math.ceil(x2 / Map.tile_w))
        end
        if x1 >= (Map.viewport.width / 4) * 3 then
            Map.viewport_padding_6 = math.max(Map.viewport_padding_6, math.ceil((Map.viewport.width - x1) / Map.tile_w))
        end
        if y2 <= Map.viewport.height / 4 then
            Map.viewport_padding_8 = math.max(Map.viewport_padding_8, math.ceil(y2 / Map.tile_h))
        end
        if y1 >= (Map.viewport.height / 4) * 3 then
            Map.viewport_padding_2 = math.max(Map.viewport_padding_2, math.ceil((Map.viewport.height - y1) / Map.tile_h))
        end

    if x1 <= 0 then
            size.orient = "right"
        end
        if x2 >= Map.viewport.width then
            size.orient = "left"
        end
        if y1 <= 0 then
            size.orient = "down"
        end
        if y2 >= Map.viewport.height then
            size.orient = "up"
        end
end

function _M:displayMinimap(scale, bx, by)
    if self.no_minimap then game.mouse:unregisterZone("minimap") return end

    local map = game.level.map

    mm_shadow[1]:toScreenFull(0, 2, mm_shadow[6], mm_shadow[7], mm_shadow[2], mm_shadow[3])
    mm_bg[1]:toScreenFull(mm_bg_x, mm_bg_y, mm_bg[6], mm_bg[7], mm_bg[2], mm_bg[3])
    if game.player.x then game.minimap_scroll_x, game.minimap_scroll_y = util.bound(game.player.x - 25, 0, map.w - 50), util.bound(game.player.y - 25, 0, map.h - 50)
    else game.minimap_scroll_x, game.minimap_scroll_y = 0, 0 end

    map:minimapDisplay(50 - mm_bg_x, 30 - mm_bg_y, game.minimap_scroll_x, game.minimap_scroll_y, 50, 50, 0.85)
    mm_transp[1]:toScreenFull(50 - mm_bg_x, 30 - mm_bg_y, mm_transp[6], mm_transp[7], mm_transp[2], mm_transp[3])

    mm_comp[1]:toScreenFull(169, 178, mm_comp[6], mm_comp[7], mm_comp[2], mm_comp[3])

    if not self.locked then
        move_handle[1]:toScreenFull(self.mhandle_pos.minimap.x, self.mhandle_pos.minimap.y, move_handle[6], move_handle[7], move_handle[2], move_handle[3])
    end

    if not game.mouse:updateZone("minimap", bx, by, mm_bg[6], mm_bg[7], nil, scale) then
        game.mouse:unregisterZone("minimap")

        local desc_fct = function(button, mx, my, xrel, yrel, bx, by, event)
            if event == "out" then self.mhandle.minimap = nil return
            else self.mhandle.minimap = true end
            if self.no_minimap then return end

            game.tooltip_x, game.tooltip_y = 1, 1; game:tooltipDisplayAtMap(game.w, game.h, "Left mouse to move\nRight mouse to scroll\nMiddle mouse to show full map")

            -- Move handle
            if not self.locked and bx >= self.mhandle_pos.minimap.x and bx <= self.mhandle_pos.minimap.x + move_handle[6] and by >= self.mhandle_pos.minimap.y and by <= self.mhandle_pos.minimap.y + move_handle[7] then
                self:uiMoveResize("minimap", button, mx, my, xrel, yrel, bx, by, event)
                return
            end

            if bx >= 50 and bx <= 50 + 150 and by >= 30 and by <= 30 + 150 then
                if button == "left" and not xrel and not yrel and event == "button" then
                    local tmx, tmy = math.floor((bx-50) / 3), math.floor((by-30) / 3)
                    game.player:mouseMove(tmx + game.minimap_scroll_x, tmy + game.minimap_scroll_y)
                elseif button == "right" then
                    local tmx, tmy = math.floor((bx-50) / 3), math.floor((by-30) / 3)
                    game.level.map:moveViewSurround(tmx + game.minimap_scroll_x, tmy + game.minimap_scroll_y, 1000, 1000)
                elseif event == "button" and button == "middle" then
                    game.key:triggerVirtual("SHOW_MAP")
                end
            end
        end
        game.mouse:registerZone(bx, by, mm_bg[6], mm_bg[7], desc_fct, nil, "minimap", true, scale)
    end

    game.zone_name_s:toScreenFull(
        (mm_bg[6] - game.zone_name_w) / 2,
        0,
        game.zone_name_w, game.zone_name_h,
        game.zone_name_tw, game.zone_name_th
    )

    -- Compute how much space to reserve on the side
    self:computePadding("minimap", bx, by, bx + mm_bg[6] * scale, by + (mm_bg[7] + game.zone_name_h) * scale)
end

function _M:displayGameLog(scale, bx, by)
    local log = self.logdisplay

    if not self.locked then
        core.display.drawQuad(0, 0, log.w, log.h, 0, 0, 0, 60)
    end

    local ox, oy = log.display_x, log.display_y
    log.display_x, log.display_y = 0, 0
    log:toScreen()
    log.display_x, log.display_y = ox, oy

    if not self.locked then
        move_handle[1]:toScreenFull(util.getval(self.mhandle_pos.gamelog.x, self), util.getval(self.mhandle_pos.gamelog.y, self), move_handle[6], move_handle[7], move_handle[2], move_handle[3])
    end

    if not game.mouse:updateZone("gamelog", bx, by, log.w, log.h, nil, scale) then
        game.mouse:unregisterZone("gamelog")

        local desc_fct = function(button, mx, my, xrel, yrel, bx, by, event)
            if event == "out" then self.mhandle.gamelog = nil return
            else self.mhandle.gamelog = true end

            -- Move handle
            local mhx, mhy = util.getval(self.mhandle_pos.gamelog.x, self), util.getval(self.mhandle_pos.gamelog.y, self)
            if not self.locked and bx >= mhx and bx <= mhx + move_handle[6] and by >= mhy and by <= mhy + move_handle[7] then
                self:uiMoveResize("gamelog", button, mx, my, xrel, yrel, bx, by, event, "resize", function(mode)
                    log:resize(self.places.gamelog.x, self.places.gamelog.x, self.places.gamelog.w, self.places.gamelog.h)
                    log:display()
                    log:resetFade()
                end)
                return
            end

            log:mouseEvent(button, mx, my, xrel, yrel, bx, by, event)
        end
        game.mouse:registerZone(bx, by, log.w, log.h, desc_fct, nil, "gamelog", true, scale)
    end
end

function _M:displayHotkeys(scale, bx, by)
    local hkeys = self.hotkeys_display
    local ox, oy = hkeys.display_x, hkeys.display_y

    hk5[1]:toScreenFull(0, 0, self.places.hotkeys.w, self.places.hotkeys.h, hk5[2], hk5[3])

    hk8[1]:toScreenFull(0, -hk8[7], self.places.hotkeys.w, hk8[7], hk8[2], hk8[3])
    hk2[1]:toScreenFull(0, self.places.hotkeys.h, self.places.hotkeys.w, hk2[7], hk2[2], hk2[3])
    hk4[1]:toScreenFull(-hk4[6], 0, hk4[6], self.places.hotkeys.h, hk4[2], hk4[3])
    hk6[1]:toScreenFull(self.places.hotkeys.w, 0, hk6[6], self.places.hotkeys.h, hk6[2], hk6[3])

    hk7[1]:toScreenFull(-hk7[6], -hk7[6], hk7[6], hk7[7], hk7[2], hk7[3])
    hk9[1]:toScreenFull(self.places.hotkeys.w, -hk9[6], hk9[6], hk9[7], hk9[2], hk9[3])
    hk1[1]:toScreenFull(-hk7[6], self.places.hotkeys.h, hk1[6], hk1[7], hk1[2], hk1[3])
    hk3[1]:toScreenFull(self.places.hotkeys.w, self.places.hotkeys.h, hk3[6], hk3[7], hk3[2], hk3[3])

    hkeys.orient = self.sizes.hotkeys and self.sizes.hotkeys.orient or "down"
    hkeys.display_x, hkeys.display_y = 0, 0
    hkeys:toScreen()
    hkeys.display_x, hkeys.display_y = ox, oy

    if not self.locked then
        move_handle[1]:toScreenFull(util.getval(self.mhandle_pos.hotkeys.x, self), util.getval(self.mhandle_pos.hotkeys.y, self), move_handle[6], move_handle[7], move_handle[2], move_handle[3])
    end

    if not game.mouse:updateZone("hotkeys", bx, by, self.places.hotkeys.w, self.places.hotkeys.h, nil, scale) then
        game.mouse:unregisterZone("hotkeys")

        local desc_fct = function(button, mx, my, xrel, yrel, bx, by, event)
            if event == "out" then self.mhandle.hotkeys = nil self.hotkeys_display.cur_sel = nil return
            else self.mhandle.hotkeys = true end

            -- Move handle
            local mhx, mhy = util.getval(self.mhandle_pos.hotkeys.x, self), util.getval(self.mhandle_pos.hotkeys.y, self)
            if not self.locked and bx >= mhx and bx <= mhx + move_handle[6] and by >= mhy and by <= mhy + move_handle[7] then
                self:uiMoveResize("hotkeys", button, mx, my, xrel, yrel, bx, by, event, "resize", function(mode)
                    hkeys:resize(self.places.hotkeys.x, self.places.hotkeys.y, self.places.hotkeys.w, self.places.hotkeys.h)
                end)
                return
            end

            if event == "button" and button == "left" and ((game.zone and game.zone.wilderness and not game.player.allow_talents_worldmap) or (game.key ~= game.normal_key)) then return end
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
                    end
                end
            )
        end
        game.mouse:registerZone(bx, by, self.places.hotkeys.w, self.places.hotkeys.h, desc_fct, nil, "hotkeys", true, scale)
    end

    -- Compute how much space to reserve on the side
    self:computePadding("hotkeys", bx, by, bx + hkeys.w * scale, by + hkeys.h * scale)
end

function _M:display(nb_keyframes)
    local d = core.display
    self.now = core.game.getTime()

    -- Now the map, if any
    game:displayMap(nb_keyframes)

    if self.no_ui then return end

    Map.viewport_padding_4 = 0
    Map.viewport_padding_6 = 0
    Map.viewport_padding_8 = 0
    Map.viewport_padding_2 = 0

    -- Game log
    d.glTranslate(self.places.gamelog.x, self.places.gamelog.y, 0)
    self:displayGameLog(1, self.places.gamelog.x, self.places.gamelog.y)
    d.glTranslate(-self.places.gamelog.x, -self.places.gamelog.y, -0)

    -- Minimap display
    if game.level and game.level.map then
        d.glTranslate(self.places.minimap.x, self.places.minimap.y, 0)
        d.glScale(self.places.minimap.scale, self.places.minimap.scale, self.places.minimap.scale)
        self:displayMinimap(self.places.minimap.scale, self.places.minimap.x, self.places.minimap.y)
        d.glScale()
        d.glTranslate(-self.places.minimap.x, -self.places.minimap.y, -0)
    end

    -- Player
--[[   d.glTranslate(self.places.player.x, self.places.player.y, 0)
    d.glScale(self.places.player.scale, self.places.player.scale, self.places.player.scale)
    self:displayPlayer(self.places.player.scale, self.places.player.x, self.places.player.y)
    d.glScale()
    d.glTranslate(-self.places.player.x, -self.places.player.y, -0)]] 


    -- Hotkeys
    d.glTranslate(self.places.hotkeys.x, self.places.hotkeys.y, 0)
    self:displayHotkeys(1, self.places.hotkeys.x, self.places.hotkeys.y)
    d.glTranslate(-self.places.hotkeys.x, -self.places.hotkeys.y, -0)



    -- Display border indicators when possible
    if self.ui_moving and self.sizes[self.ui_moving] then
        local size = self.sizes[self.ui_moving]
        d.glTranslate(Map.display_x, Map.display_y, 0)
        if size.left then d.drawQuad(0, 0, 10, Map.viewport.height, 0, 200, 0, 50) end
        if size.right then d.drawQuad(Map.viewport.width - 10, 0, 10, Map.viewport.height, 0, 200, 0, 50) end
        if size.top then d.drawQuad(0, 0, Map.viewport.width, 10, 0, 200, 0, 50) end
        if size.bottom then d.drawQuad(0, Map.viewport.height - 10, Map.viewport.width, 10, 0, 200, 0, 50) end
        d.glTranslate(-Map.display_x, -Map.display_y, -0)
    end
end