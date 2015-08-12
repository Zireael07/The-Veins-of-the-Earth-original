-- Veins of the Earth
-- Zireael 2013-2015
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

module(..., package.seeall, class.make)

local pf_levelup = {core.display.loadImage("/data/gfx/ui/levelup.png"):glTexture()}

function _M:init(x, y, w, h, bgcolor, font, size)
    self.display_x = x
    self.display_y = y
    self.w, self.h = w, h
    self.bgcolor = bgcolor
    self.font = core.display.newFont(font, size)
    self:resize(x, y, w, h)
end

--- Resize the display area
function _M:resize(x, y, w, h)
    self.display_x, self.display_y = x, y
    self.w, self.h = w, h
    self.font_h = self.font:lineSkip()
    self.font_w = self.font:size(" ")
    self.bars_x = self.font_w * 6
    self.bars_w = self.w - self.bars_x - 5
    self.surface = core.display.newSurface(w, h)
    self.surface_line = core.display.newSurface(w, self.font_h)
    self.texture = self.surface:glTexture()

    self.items = {}
end

function _M:makeTexture(text, x, y, r, g, b, max_w)
    local s = self.surface_line
    s:erase(0, 0, 0, 0)
    s:drawColorStringBlended(self.font, text, 0, 0, r, g, b, true, max_w)

    local item = { s:glTexture() }
    item.x = x
    item.y = y
    item.w = self.w
    item.h = self.font_h
    self.items[#self.items+1] = item

    return item.w, item.h, item.x, item.y
end

function _M:makeTextureBar(text, nfmt, val, max, reg, x, y, r, g, b, bar_col, bar_bgcol)
    local s = self.surface_line
    s:erase(0, 0, 0, 0)
    s:erase(bar_bgcol.r, bar_bgcol.g, bar_bgcol.b, 255, self.bars_x, h, self.bars_w, self.font_h)
    s:erase(bar_col.r, bar_col.g, bar_col.b, 255, self.bars_x, h, self.bars_w * val / max, self.font_h)

    s:drawColorStringBlended(self.font, text, 0, 0, r, g, b, true)
    local text_w = self.font:size(text)
    s:drawColorStringBlended(self.font, (nfmt or "%d/%d"):format(val, max), self.bars_x + text_w*0.75, 0, r, g, b)
    if reg and reg ~= 0 then
        local reg_txt = (" (%s%.2f)"):format((reg > 0 and "+") or "",reg)
        local reg_txt_w = self.font:size(reg_txt)
        s:drawColorStringBlended(self.font, reg_txt, self.bars_x + self.bars_w - reg_txt_w - 3, 0, r, g, b)
    end
    local item = { s:glTexture() }
    item.x = x
    item.y = y
    item.w = self.w
    item.h = self.font_h
    self.items[#self.items+1] = item

    return item.w, item.h, item.x, item.y
end

-- Displays the stats
function _M:display()
    local player = game.player
    if not player or not player.changed or not game.level then return end

    self.items = {}

    local h = 6
    local x = 2

    self.font:setStyle("bold")
    self:makeTexture(("%s#{normal}#"):format(player.name), 0, h, colors.GOLD.r, colors.GOLD.g, colors.GOLD.b, self.w) h = h + self.font_h
    self.font:setStyle("normal")

    h = h + self.font_h

    self:makeTexture(("Lvl: #GOLD#%2d"):format(player.level), x, h, 255, 255, 255) h = h + self.font_h
    local cur_exp, max_exp = player.exp, player:getExpChart(player.level+1)
    local exp = cur_exp / max_exp * 100

    h = h + self.font_h

    if (player.class_points or 0) > 0 or (player.feat_point or 0) > 0 or (player.stat_point or 0) > 0 then
        self:makeTexture("#LIGHT_GREEN#Level up!", x, h, 255, 255, 255)
    --    local glow = (1+math.sin(core.game.getTime() / 500)) / 2 * 100 + 120
    --    pf_levelup[1]:toScreenFull(50, 800, pf_levelup[6], pf_levelup[7], pf_levelup[2], pf_levelup[3], 1, 1, 1, glow / 255)
    --    pf_levelup[1]:toScreenFull(70, 800, pf_levelup[6], pf_levelup[7], pf_levelup[2], pf_levelup[3])

    else end

    h = h + self.font_h

    self:makeTextureBar("Exp:", "%d%%", exp, 100, nil, x, h, 255, 255, 255, { r=0, g=100, b=0 }, { r=0, g=50, b=0 }) h = h + self.font_h

    h = h + self.font_h

    if player.life < player.max_life*0.3 then self:makeTextureBar("#FIREBRICK#Life:", nil, player.life, player.max_life, nil, x, h, 255, 255, 255, colors.FIREBRICK, colors.VERY_DARK_RED) h = h + self.font_h
    elseif player.life < player.max_life*0.5 then self:makeTextureBar("#DARK_RED#Life:", nil, player.life, player.max_life, nil, x, h, 255, 255, 255, colors.DARK_RED, colors.VERY_DARK_RED) h = h + self.font_h
    else self:makeTextureBar("#CRIMSON#Life:", nil, player.life, player.max_life, nil, x, h, 255, 255, 255, colors.CRIMSON, colors.VERY_DARK_RED) h = h + self.font_h end

    h = h + self.font_h

    self:makeTextureBar("#CRIMSON#Wounds:", nil, player.wounds, player.max_wounds, nil, x, h, 255, 255, 255, colors.LIGHT_RED, colors.DARK_RED) h = h + self.font_h

    h = h + self.font_h

    --Display spell points if any
    if player:knowTalent(player.T_SPELL_POINTS_POOL) then
        self:makeTextureBar("#LIGHT_BLUE#Spell:", nil, player:getMana(), player.max_mana, nil, x, h, 255, 255, 255, colors.LIGHT_BLUE, colors.DARK_BLUE) h = h + self.font_h
    end



    --Display hunger
    --   1   -> 2    -->     3   ->     4     ->   5    -->  6      -->  7    --> 8      -->9
    --Bloated -> Satiated -> Content -> Peckish -> Hungry -> Famished -> Weak -> Fainting -> Starved
    if player.nutrition < 500 then self:makeTexture("#VERY_DARK_RED#Starved!#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 1000 then self:makeTexture("#DARK_RED#Fainting#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 1500 then self:makeTexture("#DARK_RED#Weak#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 2000 then self:makeTexture("#LIGHT_RED#Famished#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 3000 then self:makeTexture("#YELLOW#Hungry#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 3500 then self:makeTexture("#PINK#Peckish#LAST#", x, h, 255, 255, 255)
    --Don't display anything if content
    elseif player.nutrition < 5000 then
    elseif player.nutrition < 7000 and player.nutrition > 5000 then self:makeTexture("#LIGHT_GREEN#Satiated#LAST#", x, h, 255, 255, 255)
    elseif player.nutrition < 8000 and player.nutrition > 7000 then self:makeTexture("#DARK_GREEN#Bloated#LAST#", x, h, 255, 255, 255)
    else end

    h = h + self.font_h

    --inform the player it's a worldmap
    if game.zone.worldmap then
        self:makeTexture("World map", x, h, 240, 240, 170)
    else
        if game.zone.max_level > 1 and game.level.level then
            self:makeTexture(("%s, dungeon lvl: %d"):format(game.zone.name, game.level.level), x, h, 240, 240, 170)
        else
            self:makeTexture(("%s"):format(game.zone.name), x, h, 240, 240, 170)
        end
    end


    h = h + self.font_h

    --TO DO: Level feeling note

    if savefile_pipe.saving then
        h = h + self.font_h
        self:makeTextureBar("Saving:", "%d%%", 100 * savefile_pipe.current_nb / savefile_pipe.total_nb, 100, nil, x, h, colors.YELLOW.r, colors.YELLOW.g, colors.YELLOW.b,
        {r=49, g=54,b=42},{r=17, g=19, b=0})

        h = h + self.font_h
    end
end

function _M:toScreen(nb_keyframes)
    self:display()

    core.display.drawQuad(self.display_x, self.display_y, self.w, self.h, 0, 0, 0, 0)

    for i = 1, #self.items do
        local item = self.items[i]
        if type(item) == "table" then
            if item.glow then
                local glow = (1+math.sin(core.game.getTime() / 500)) / 2 * 100 + 120
                item[1]:toScreenFull(self.display_x + item.x, self.display_y + item.y, item.w, item.h, item[2], item[3], 1, 1, 1, glow / 255)
            else
                item[1]:toScreenFull(self.display_x + item.x, self.display_y + item.y, item.w, item.h, item[2], item[3])
            end
        else
            item(self.display_x, self.display_y)
        end
    end

end
