--Veins of the Earth
--Zireael 2016

require 'engine.class'

--local Calendar = require "engine.Calendar"

--Handle actor journal
module(..., package.seeall, class.make)

function _M:newJournalEntry(entry)
    --set up
    self.journal = self.journal or {}
    local turn = game.turn
    local id = turn
    local date = self:getDate(turn)
    local journal = { entry = entry, date=date }
 
    self.journal[id] = journal
    game.log("Added a new journal entry, entry - "..entry .." date "..date)
end

function _M:getDate(turn)
    game.log("Getting date for turn "..turn)
    local date 

    local doy, year = game.calendar:getDayOfYear(turn)
    local day = tostring(game.calendar:getDayOfMonth(doy)):ordinal()
    local month = game.calendar:getMonthName(doy)
    local year_str = tostring(year):ordinal()

    date = day.." "..month.." "..year_str

    return date
end