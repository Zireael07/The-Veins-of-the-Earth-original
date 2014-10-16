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
local Dialog = require "engine.ui.Dialog"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.make)

function _M:onPartyDeath(src, death_note)
	if self.dead then return true end

	-- Remove from the party if needed
	if self.remove_from_party_on_death then
		game.party:removeMember(self, true)
	-- Overwise note the death turn
	else
		game.party:setDeathTurn(self, game.turn)
	end

	-- Die
	death_note = death_note or {}
	mod.class.Actor.die(self, src, death_note)

	-- Was not the current player, just die
	if game.player ~= self then return end

	-- Check for any survivor that can be controlled
	local game_ender = not game.party:findSuitablePlayer()

	-- No more player found! Switch back to main and die
	if game_ender then
		game.party:setPlayer(game.party:findMember{main=true}, true)
		game.paused = true
		game.player.energy.value = game.energy_to_act
		src = src or {name="unknown"}
		game.player.killedBy = src
		game.player.died_times[#game.player.died_times+1] = {name=src.name, level=game.player.level, turn=game.turn}
		game.player:registerDeath(game.player.killedBy)
		local dialog = require("mod.dialogs."..(game.player.death_dialog or "DeathDialog")).new(game.player)
		if not dialog.dont_show then
			game:registerDialog(dialog)
		end
		game.player:saveUUID()

		local death_mean = nil
		if death_note and death_note.damtype then
			local dt = DamageType:get(death_note.damtype)
			if dt and dt.death_message then death_mean = rng.table(dt.death_message) end
		end

		local top_killer = nil
--[[		if profile.mod.deaths then
			local l = {}
			for _, names in pairs(profile.mod.deaths.sources or {}) do
				for name, nb in pairs(names) do l[name] = (l[name] or 0) + nb end
			end
			l = table.listify(l)
			if #l > 0 then
				table.sort(l, function(a,b) return a[2] > b[2] end)
				top_killer = l[1][1]
			end
		end]]

		local msg
		if not death_note.special_death_msg then
			msg = "%s the level %d %s %s was %s to death by %s%s%s on level %s of %s."
			local srcname = src.unique and src.name or src.name:a_an()
			local killermsg = (src.killer_message and " "..src.killer_message or ""):gsub("#sex#", game.player.female and "her" or "him")
			if src.name == game.player.name then
				srcname = game.player.female and "herself" or "himself"
				killermsg = rng.table{
					" (the fool)",
					" in an act of extreme incompetence",
					" out of supreme humility",
					", by accident of course,",
					" in some sort of fetish experiment gone wrong",
					", providing a free meal to the wildlife",
					" (how embarrassing)",
				}
			end
			msg = msg:format(
				game.player.name, game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.class:lower(),
				death_mean or "battered",
				srcname,
				src.name == top_killer and " (yet again)" or "",
				killermsg,
				game.level.level, game.zone.name
			)
		else
			msg = "%s the level %d %s %s %s on level %s of %s."
			msg = msg:format(
				game.player.name, game.player.level, game.player.descriptor.race:lower(), game.player.descriptor.class:lower(),
				death_note.special_death_msg,
				game.level.level, game.zone.name
			)
		end

		game:playSound("actions/death")
		game.delayed_death_message = "#{bold}#"..msg.."#{normal}#"
	end
end
