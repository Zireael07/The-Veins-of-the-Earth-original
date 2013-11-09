-- Veins of the Earth
-- Zireael
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

newEntity{
	define_as = "BASE_MONEY",
	type = "money", subtype="money",
	display = "$", color=colors.YELLOW,
	encumber = 0,
	rarity = 5,
	identified = true,
	desc = [[All that glitters is not gold; all that is gold does not glitter.]],
	on_prepickup = function(self, who, id)
		who:incMoney(self.money_value)
		game.logPlayer(who, "You pickup %d gold pieces.", self.money_value)
		-- Remove from the map
		game.level.map:removeObject(who.x, who.y, id)
		return true
	end,
	auto_pickup = true,
}

newEntity{
    base = "BASE_MONEY",
    name = "copper coins",
    image = "tiles/copper_coins.png",
 	color = colors.SANDY_BROWN,
    level_range = {1,20},
    desc = [[A pile of copper coins.]],
    money_value = rng.range(2, 50),
}

newEntity{
    base = "BASE_MONEY",
    name = "silver coins",
    image = "tiles/silver_coins.png",
 	color = colors.SILVER,
    level_range = {7,nil},
    desc = [[A pile of silver coins.]],
    money_value = rng.range(52, 150),
}

newEntity{
    base = "BASE_MONEY",
    name = "gold coins",
    image = "tiles/gold_coins.png",
 	color = colors.GOLD,
    level_range = {10,nil},
    desc = [[A pile of gold coins.]],
    money_value = rng.range(152, 500),
}