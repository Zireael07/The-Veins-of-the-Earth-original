-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2015 Nicolas Casalini
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


return {
	frag = "objectsoutline",
	vert = nil,
	args = {
		tex = { texture = 0 },
		textSize = textSize or {1, 1},
		intensity = intensity or 0.3,
		outlineSize = outlineSize or {2, 2},
	--	outlineColor = outlineColor or {0, 1, 0.5, 0.4}, --greenish-blue (ToME default)
		outlineColor = outlineColor or {1, 0, 0.5, 0.4}, --red
	--	outlineColor = outlineColor or {0, 0.5, 1, 0.4}, --blue
	--	outlineColor = outlineColor or {1, 1, 0.5, 0.4}, --yellow

	},
	clone = false,
	permanent = true,
}
