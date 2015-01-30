-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
require "mod.class.NPC"
require "mod.class.interface.PartyDeath"

module(..., package.seeall, class.inherit(mod.class.NPC, mod.class.interface.PartyDeath))

function _M:init(t, no_default)
	mod.class.NPC.init(self, t, no_default)

	-- Set correct AI
	if self.ai ~= "party_member" and not self.no_party_ai then
		self.ai_state.ai_party = self.ai
		self.ai = "party_member"
	end
end

function _M:tooltip(x, y, seen_by)
	local str = mod.class.NPC.tooltip(self, x, y, seen_by)
	if not str then return end

	str:add(
		true,
		{"color", "TEAL"},
	--	("Behavior: %s"):format(self.ai_tactic.type or "default"), true,
		("Action radius: %d"):format(self.ai_state.tactic_leash),
		{"color", "WHITE"}
	)
	return str
end

function _M:die(src, death_note)
	return self:onPartyDeath(src, death_note)
end
