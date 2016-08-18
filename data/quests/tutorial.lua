-- Veins of the Earth
-- Copyright (C) 2016 Zireael
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


name = "Tutorial"
desc = function(self, who)
    local desc = {}
    desc[#desc+1] = "You must survive and kill the enemy at the end of the cave."
    return table.concat(desc, "\n")
end

on_status_change = function(self, who, status, sub)
    if self:isCompleted() then
        who:setQuestStatus(self.id, engine.Quest.DONE)
        world:gainAchievement("TUTORIAL_DONE", game.player)
    end
end

on_grant = function(self)
    --[[local d = require("engine.dialogs.ShowText").new("Tutorial: Movement", "tutorial/move")
    game:registerDialog(d)]]
end
