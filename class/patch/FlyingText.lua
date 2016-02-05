--From sensible flying text addon by hyprformance

require "engine.class"

local FlyingText = require "engine.FlyingText"
module(..., package.seeall, class.inherit(FlyingText))

local speed = 3.8

--- Init
-- @string[opt="DroidSans"] fontname
-- @int[opt=12] fontsize
-- @string[opt="DroidSans-Bold"] bigfontname
-- @int[opt=14] bigfontsize
function _M:init(fontname, fontsize, bigfontname, bigfontsize)
    self.font = core.display.newFont(fontname or "/data/font/DroidSans.ttf", fontsize+2 or 12+2)
    self.bigfont = core.display.newFont(bigfontname or "/data/font/DroidSans-Bold.ttf", bigfontsize+2 or 14+2)
    self.font_h = self.font:lineSkip()
    self.flyers = {}

    -- I've been known to dabble in initialization myself
    self.waitingFlyers = {}
    self.framesElapsed = 0
end

--- Add a new flying text
-- @int x x position
-- @int y y position
-- @int[opt=10] duration
-- @param[type=?number] xvel horizontal velocity
-- @param[type=?number] yvel vertical velocity
-- @string str what the text says
-- @param[type=?table] color color of the text, defaults to colors.White
-- @param[type=?boolean] bigfont use the big font?
-- @return `FlyingText`
function _M:add(x, y, duration, xvel, yvel, str, color, bigfont)
    f = self:addOld(x, y, duration, xvel, yvel, str, color, bigfont)

    -- but add the flyer to waitlist instead (and standardize that velocity!!)
    self.flyers[f] = nil
    table.insert(self.waitingFlyers, 1, {x, y, duration, speed * 0.33333, -speed, str, color, bigfont})

    -- return whatever the original function would have returned, which no ToME function seems to care about anyways
    return f
end

function _M:addOld(x, y, duration, xvel, yvel, str, color, bigfont)
    if not x or not y or not str then return end
    color = color or {255,255,255}
    local gen, max_lines, max_w = self.font:draw(str, str:toTString():maxWidth(self.font), color[1], color[2], color[3])
    if not gen or not gen[1] then return end
    local f = {
        item = gen[1],
        x=x,
        y=y,
        w=gen[1].w, h=gen[1].h,
        duration=duration or 10,
        xvel = xvel or 0,
        yvel = yvel or 0,
        t = t,
    }
    f.popout_dur = math.max(3, math.floor(f.duration / 4))
    self.flyers[f] = true
    return f
end

--- Removes all FlyingText
function _M:empty()
    local value = FlyingText:empty()

    -- delete some more variables
    self.waitingFlyers = {}

    -- return whatever the original function would have returned
    return value
end

--- Display loop function
-- @int nb_keyframes
function _M:display(nb_keyframes)
    -- this puts flying text generation on a frame timer, essentially
    self.framesElapsed = self.framesElapsed + (nb_keyframes or 0)

    if self.framesElapsed > 5 and table.getn(self.waitingFlyers) > 0 then -- regardless of graphics FPS, tome appears to run at 30 'nb_keyframes' per second
        self.framesElapsed = 0

        -- find a valid text in the waiting line to finally draw to screen.
        local result = nil

        while result == nil do
            local p = table.remove(self.waitingFlyers)
            result = self:addOld(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
            self.flyers[result] = nil
            --result.popout_dur = 0
            self.flyers[result] = true
        end
    end

    --original function starts here
    if not next(self.flyers) then return end

    local dels = {}

    for fl, _ in pairs(self.flyers) do
        local zoom = nil
        local x, y = -fl.w / 2, -fl.h / 2
        local tx, ty = fl.x, fl.y
        core.display.glTranslate(tx, ty, 0)

        if fl.duration <= fl.popout_dur then
            zoom = (fl.duration / fl.popout_dur)
            core.display.glScale(zoom, zoom, zoom)
        end

        if self.shadow then fl.item._tex:toScreenFull(x+1, y+1, fl.item.w, fl.item.h, fl.item._tex_w, fl.item._tex_h, 0, 0, 0, self.shadow) end
        fl.item._tex:toScreenFull(x, y, fl.item.w, fl.item.h, fl.item._tex_w, fl.item._tex_h)

        -- if self.shadow then fl.t:toScreenFull(x+1, y+1, fl.w, fl.h, fl.tw, fl.th, 0, 0, 0, self.shadow) end
        -- fl.t:toScreenFull(x, y, fl.w, fl.h, fl.tw, fl.th)
        fl.x = fl.x + fl.xvel * nb_keyframes
        fl.y = fl.y + fl.yvel * nb_keyframes
        fl.duration = fl.duration - nb_keyframes

        if zoom then core.display.glScale() end
        core.display.glTranslate(-tx, -ty, 0)

        -- Delete the flyer
        if fl.duration <= 0 then
            dels[#dels+1] = fl
        end
    end

    for i, fl in ipairs(dels) do self.flyers[fl] = nil end
end
