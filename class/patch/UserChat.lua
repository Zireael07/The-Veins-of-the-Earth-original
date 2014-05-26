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

require "engine.UserChat"

module(..., package.seeall, class.inherit(
    engine.UserChat
))


--- Request a line to send
function _M:talkBox(on_end)
	if not profile.auth then return end
--	local Talkbox = require "mod.class.patch.Talkbox"
--	local d = Talkbox.new(self, on_end)
--	game:registerDialog(d)

	game:registerDialog(require("mod.class.patch.Talkbox").new(self, self.player, on_end))

	self:updateChanList()
end