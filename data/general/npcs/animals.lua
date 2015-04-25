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

local Talents = require("engine.interface.ActorTalents")

local animal_desc = [[It has low Intelligence and is always neutral. It needs to eat, sleep and breathe.]]

newEntity{
	define_as = "BASE_NPC_ANIMAL",
	type = "animal",
	body = { INVEN = 10 },
	ai = "animal_level", ai_state = { talent_in=3, },
	alignment = "Neutral",
	resolvers.wounds()
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_RAT",
	image = "tiles/rat.png",
	display = 'r', color=colors.WHITE,
	desc = [[A small rat.]],
	common_desc = [[A dire rat spreads filth fever, a dangerous disease, with its sharp bite.]],
	base_desc = "This child-sized rodent is a dire rat. Dire rats are scavengers, but fearlessly defend their territory. "..animal_desc.."",

	stats = { str=10, dex=17, con=12, int=1, wis=12, cha=4, luc=2 },
	combat = { dam= {1,4} },
	skill_climb = 10,
	skill_movesilently = 8,
}

newEntity{
	base = "BASE_NPC_RAT",
	name = "dire rat", color=colors.WHITE,
	image = "tiles/dire_rat.png",
	level_range = {1, 4}, exp_worth = 135,
	rarity = 4,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/3,
}

newEntity{
	base = "BASE_NPC_RAT",
	name = "rat", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 50,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/8,
	skill_hide = 14,
	skill_swim = 14,
	stats = { str=2, dex=15, con=10, int=2, wis=12, cha=2, luc=2 },
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_SNAKE",
	image = "tiles/snake.png",
	display = 'z', color=colors.GREEN,
	desc = [[A small snake.]],

	stats = { str=4, dex=17, con=11, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,2} },
	skill_balance = 8,
	skill_climb = 8,
	skill_hide = 8,
	skill_listen = 5,
	skill_spot = 5,
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "tiny snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "small snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 135,
	rarity = 3,
	max_life = resolvers.rngavg(2,5),
	hit_die = 1,
	challenge = 1/3,
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "medium snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(7,10),
	hit_die = 2,
	challenge = 1,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_LIZARD",
	image = "tiles/lizard.png",
	display = 'R', color=colors.GREEN,
	desc = [[A small lizard.]],

	stats = { str=3, dex=15, con=10, int=1, wis=12, cha=2, luc=2 },
	combat = { dam= {1,4} },
	skill_climb = 10,
	skill_balance = 8,
	skill_hide = 10,
	skill_spot = 2,
	faction = "Neutral",
}

newEntity{
	base = "BASE_NPC_LIZARD",
	name = "medium lizard", color=colors.GREEN,
	level_range = {1, 20}, exp_worth = 65,
	rarity = 5,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/6,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_MONLIZARD",
	image = "tiles/lizard.png",
	display = 'R', color=colors.DARK_GREEN,
	desc = [[A large lizard.]],

	stats = { str=17, dex=15, con=17, int=1, wis=12, cha=2, luc=2 },
	combat = { dam= {1,8} },
	skill_climb = 4,
	skill_balance = 8,
	skill_hide = 4,
	skill_spot = 2,
	skill_swim = 8,
	skill_listen = 2,
}

newEntity{
	base = "BASE_NPC_LIZARD",
	name = "monitor lizard", color=colors.GREEN,
	level_range = {1, 20}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 2,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_BAT",
	image = "tiles/bat.png",
	display = 'b', color=colors.BLACK,
	desc = [[A large bat.]],
	common_desc = [[Dire bats use echolocation to sense their surroundings. If deafened, they must rely on their weak vision instead.]],
	base_desc = "This leathery creature is a dire bat. Dire bats are easily excited, and usually attack any creatures they encounter. "..animal_desc.."",

	stats = { str=1, dex=15, con=10, int=2, wis=14, cha=4, luc=10 },
	combat = { dam= {1,2} },
	skill_movesilently = 4,
	skill_hide = 12,
	skill_spot = 6,
	skill_listen = 6,
	fly = true,
	faction = "Neutral",
}

newEntity{
	base = "BASE_NPC_BAT",
	name = "bat", color=colors.BLACK,
	level_range = {1, 20}, exp_worth = 30,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/10,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_RAVEN",
	image = "tiles/newtiles/raven.png",
	display = 'b', color=colors.GREY,
	desc = [[A large raven.]],
	common_desc = [[Dire ravens are attracted to shiny baubles, and if attacked, instinctually try to peck out their opponents’ eyes.]],
	base_desc = "This ebon bird is a dire raven. It is a scavenger that attacks only to defend its carrion meals. "..animal_desc.."",

	stats = { str=1, dex=15, con=10, int=2, wis=14, cha=6, luc=10 },
	combat = { dam= {1,2} },
	skill_spot = 4,
	skill_listen = 3,
	fly = true,
	faction = "Neutral",
}

newEntity{
	base = "BASE_NPC_RAVEN",
	name = "raven", color=colors.SLATE,
	level_range = {1, 20}, exp_worth = 65,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/6,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_WOLF",
	image = "tiles/UT/wolf.png",
	display = 'd', color=colors.BLACK,
	desc = [[A large wolf.]],

	stats = { str=13, dex=15, con=15, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 5,
}

newEntity{
	base = "BASE_NPC_WOLF",
	name = "wolf", color=colors.BLACK,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 8,
	max_life = resolvers.rngavg(12,14),
	hit_die = 1,
	challenge = 1,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_TORTOISE",
	subtype = "aquatic",
	image = "tiles/tortoise.png",
	display = 'B', color=colors.DARK_GREEN,
	desc = [[A large tortoise.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=10, con=21, int=2, wis=15, cha=7, luc=2 },
	combat = { dam= {1,10} },
	skill_spot = 2,
	skill_swim = 8,
	skill_listen = 2,
	faction = "Neutral",
}

newEntity{
	base = "BASE_NPC_TORTOISE",
	name = "giant tortoise", color=colors.BLACK,
	level_range = {10, 20}, exp_worth = 600,
	rarity = 10,
	max_life = resolvers.rngavg(65,72),
	hit_die = 7,
	challenge = 2,
}

--From Pathfinder
--Trip
newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_HYENA",
	image = "tiles/UT/wolf.png",
	display = 'd', color=colors.TAN,
	desc = [[This hyena is covered in shaggy, tan-colored fur with black and brown stripes.]],

	stats = { str=14, dex=15, con=15, int=2, wis=13, cha=6, luc=10 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 5,
	skill_hide = 5,
}

newEntity{
	base = "BASE_NPC_HYENA",
	name = "hyena", color=colors.TAN,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 10,
	combat_natural = 2,
	max_life = resolvers.rngavg(12,15),
	hit_die = 2,
	challenge = 1,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
}

--Called hyaenodon in PF
--Trip, Weapon Focus (bite)
newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_HYENA_SHORTFACED",
	image = "tiles/UT/wolf.png",
	display = 'd', color=colors.DARK_TAN,
	desc = [[Slightly larger than a normal hyena, this spotted canine has the same shorter forelimbs of that breed but with a blunt face and larger teeth.]],

	stats = { str=26, dex=15, con=19, int=2, wis=13, cha=6, luc=10 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 9,
	skill_hide = 3,
}

newEntity{
	base = "BASE_NPC_HYENA_SHORTFACED",
	name = "short-faced hyena", color=colors.DARK_TAN,
	level_range = {1, 20}, exp_worth = 1200,
	rarity = 15,
	combat_natural = 5,
	max_life = resolvers.rngavg(45,50),
	hit_die = 2,
	challenge = 4,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
}

--From Incursion
--Trip
newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_JACKAL",
	image = "tiles/UT/wolf.png",
	display = 'd', color=colors.UMBER,
	desc = [[Jackals are very vocal creatures. Yipping calls are made when the family gathers and are specific to individual families. Non-members do not recognize or respond to the calls of other families.
    Additionally, when threatened, these jackals make loud screaming vocalizations. When seriously wounded, the vocalizations change from screams to low croaks.]],

	stats = { str=12, dex=15, con=12, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 5,
}

newEntity{
	base = "BASE_NPC_JACKAL",
	name = "jackal", color=colors.UMBER,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 10,
	max_life = resolvers.rngavg(8,12),
	hit_die = 2,
	challenge = 1,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_MASTIFF",
	image = "tiles/UT/wolf.png",
	display = 'd', color=colors.DARK_UMBER,
	desc = [[This vicious hunting dog may once have been the companion of a ranger or druid, but now it seems to have gone feral and recognizes no master other then its own hunger and survival instinct.]],

	stats = { str=15, dex=13, con=14, int=2, wis=11, cha=4, luc=10 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 5,
}

newEntity{
	base = "BASE_NPC_MASTIFF",
	name = "mastiff", color=colors.DARK_UMBER,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 10,
	max_life = resolvers.rngavg(8,12),
	hit_die = 2,
	challenge = 1,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
}

--Scent, pounce, rake; cold resistance
newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_CAVE_LION",
--	image = "tiles/UT/wolf.png",
	display = 'c', color=colors.SANDY_BROWN,
	desc = [[This believed-extinct member of the cat family was a third larger in overall dimensions compared to the modern lion, and weighed perhaps half again as much.
	They also hunted in prides, much like the modern lion.  Cave lions were well-adapted to cold climates, with a warm coat and larger body mass to preserve heat.]],

	stats = { str=24, dex=16, con=17, int=2, wis=12, cha=6, luc=10 },
	combat = { dam= {1,6} },
	skill_movesilently = 4,
	skill_hide = 4,
}

newEntity{
	base = "BASE_NPC_CAVE_LION",
	name = "cave lion", color=colors.SANDY_BROWN,
	level_range = {1, 20}, exp_worth = 1200,
	rarity = 15,
	combat_natural = 4,
	max_life = resolvers.rngavg(55,65),
	hit_die = 7,
	challenge = 6,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, },
}

--Scent; Run feat
newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_HUGE_VIPER",
--	image = "tiles/snake.png",
	display = 'R', color=colors.LIGHT_GREEN,
	desc = [[Generally considered a slow moving, somewhat placid animal, vipers are not considered aggressive unless provoked or hungry. If tampered with, it will generally puff up and give an extremely loud hiss.]],

	stats = { str=16, dex=15, con=13, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,6} },
	skill_balance = 8,
	skill_climb = 8,
	skill_hide = 4,
	skill_listen = 4,
	skill_spot = 4,
	faction = "Neutral",
}

newEntity{
	base = "BASE_NPC_HUGE_VIPER",
	name = "huge viper", color=colors.LIGHT_GREEN,
	level_range = {1, 20}, exp_worth = 1200,
	rarity = 15,
	combat_natural = 4,
	max_life = resolvers.rngavg(50,55),
	hit_die = 6,
	challenge = 4,
	movement_speed = 0.66,
	combat_attackspeed = 0.66,
	--poison = "viper venom"
}
