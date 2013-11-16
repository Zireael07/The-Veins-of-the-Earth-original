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


local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_ABOLETH",
	type = "aberration", subtype = "aboleth",
	image = "tiles/aboleth2.png",
	display = "X", color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A horrid thing with tentacles!]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=8, dex=10, con=7, int=14, wis=12, cha=12, luc=12 },
	combat = { dam= {1,6} },
}

-- Mind blast
newEntity{ base = "BASE_NPC_ABOLETH",
	name = "weak aboleth", color=colors.WHITE,
	image = "tiles/aboleth.png",
	level_range = {6, 14}, exp_worth = 450,
	rarity = 20,
	max_life = resolvers.rngavg(10,15),
	hit_die = 4,
	challenge = 6,
	skill_swim = 8,
	skill_knowledge = 8,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}        

--Psionic abilities (hypnotic pattern, illusory wall, mirage arcana, persistent image, programmed image, project image, veil)
--enslave (dominate person range 6 3/day)
newEntity{ base = "BASE_NPC_ABOLETH",
	name = "aboleth", color=colors.WHITE,
	level_range = {10, 14}, exp_worth = 525,
	rarity = 25,
	max_life = resolvers.rngavg(70,75),
	hit_die = 8,
	challenge = 7,
	combat_natural = 7,
	skill_concentration = 11,
	skill_knowledge = 11,
	skill_swim = 8,
	stats = { str=26, dex=12, con=20, int=15, wis=17, cha=17, luc=12 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}        

--TO DO: Aboleth mage (slap 10 levels of wizard on top of a normal aboleth)

newEntity{
	define_as = "BASE_NPC_ATHACH",
	type = "aberration", subtype = "athach",
	image = "tiles/athach.png",
	display = "X", color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A hulking deformed creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=26, dex=13, con=21, int=7, wis=12, cha=6, luc=8 },
	combat = { dam= {2,8} },
}

newEntity{ base = "BASE_NPC_ATHACH",
	name = "athach", color=colors.BLACK,
	level_range = {10, 20}, exp_worth = 2400,
	rarity = 20,
	max_life = resolvers.rngavg(130,135),
	hit_die = 14,
	challenge = 8,
	combat_natural = 6,
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, 
--		[Talents.T_POWER_ATTACK] = 1,			},
	resolvers.equip{
                full_id=true,
                { name = "leather armor" },
                { name = "morningstar" },
        },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}        

newEntity{
	define_as = "BASE_NPC_CHOKER",
	type = "aberration", subtype = "choker",
	display = "X", color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A small creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=16, dex=14, con=13, int=4, wis=13, cha=7, luc=8 },
	combat = { dam= {1,3} },
}

newEntity{ base = "BASE_NPC_CHOKER",
	name = "choker", color=colors.BROWN,
	level_range = {2, 14}, exp_worth = 225,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 3,
	challenge = 3,
	combat_natural = 4,
	infravision = 3,
	skill_climb = 8,
	skill_hide = 8,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}        

newEntity{
	define_as = "BASE_NPC_CHUUL",
	type = "aberration", subtype = "chuul",
	display = "X", color=colors.BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A large serpent-like squid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=20, dex=16, con=18, int=10, wis=14, cha=5, luc=8 },
	combat = { dam= {2,6} },
}

newEntity{ base = "BASE_NPC_CHUUL",
	name = "chuul", color=colors.BLUE,
	level_range = {2, 14}, exp_worth = 525,
	rarity = 25,
	max_life = resolvers.rngavg(90,95),
	hit_die = 11,
	challenge = 7,
	combat_natural = 9,
	infravision = 3,
	skill_swim = 8,
	skill_hide = 10,
	skill_listen = 9,
	skill_spot = 9,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}       

newEntity{
	define_as = "BASE_NPC_CLOAKER",
	type = "aberration", subtype = "cloaker",
	image = "tiles/newtiles/cloaker.png",
	display = "X", color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[It looks like a cloak.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=17, con=17, int=14, wis=15, cha=15, luc=8 },
	combat = { dam= {1,6} },
}

newEntity{ base = "BASE_NPC_CLOAKER",
	name = "cloaker", color=colors.BLACK,
	level_range = {5, 14}, exp_worth = 300,
	rarity = 25,
	max_life = resolvers.rngavg(40,45),
	hit_die = 6,
	challenge = 5,
	combat_natural = 6,
	infravision = 3,
	skill_hide = 4,
	skill_movesilently = 9,
	skill_listen = 11,
	skill_spot = 11,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}       

--Drow spell-likes, spell resistance, poison
newEntity{
	define_as = "BASE_NPC_DRIDER",
	type = "aberration", subtype = "drider",
	display = "X", color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A mix between a drow and a spider.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=15, con=16, int=15, wis=16, cha=16, luc=8 },
	combat = { dam= {1,4} },
}

newEntity{ base = "BASE_NPC_DRIDER",
	name = "drider", color=colors.BLACK,
	level_range = {8, 14}, exp_worth = 525,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 6,
	challenge = 7,
	combat_natural = 5,
	infravision = 5,
	skill_climb = 8,
	skill_hide = 8,
	skill_movesilently = 10,
	skill_listen = 6,
	skill_spot = 6,
	resolvers.equip{
                full_id=true,
                { name = "shortbow" },
                { name = "arrows (20)" },
        },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}       

newEntity{
	define_as = "BASE_NPC_ETTERCAP",
	type = "aberration", subtype = "ettercap",
	image = "tiles/ettercap.png",
	display = "X", color=colors.DARK_GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
        desc = [[A small twisted creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=17, con=13, int=6, wis=15, cha=8, luc=8 },
	combat = { dam= {1,8}, },
	name = "ettercap",
	level_range = {2, 14}, exp_worth = 225,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 5,
	challenge = 3,
	combat_natural = 1,
	infravision = 1,
	skill_climb = 8,
	skill_hide = 4,
	skill_listen = 2,
	skill_spot = 4,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}
 
--Disease, improved grab, scent
newEntity{
	define_as = "BASE_NPC_OTYUGH",
	type = "aberration", subtype = "otyugh",
	image = "tiles/newtiles/otyugh.png",
	display = "X", color=colors.UMBER,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A small dirty twisted creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=10, con=13, int=5, wis=12, cha=6, luc=8 },
	combat = { dam= {1,6}, },
	name = "otyugh",
	level_range = {5, 14}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(35,40),
	hit_die = 5,
	challenge = 4,
	combat_natural = 8,
	infravision = 4,
	skill_listen = 5,
	skill_spot = 5,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Burrow 10 ft.; Immunity to acid, tremorsense 4 squares, stone shape
newEntity{
	define_as = "BASE_NPC_DELVER",
	type = "aberration",
	display = "X", color=colors.GRAY,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A huge slimy burrowing creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=27, dex=13, con=21, int=14, wis=14, cha=12, luc=8 },
	combat = { dam= {1,6}, },
	name = "delver",
	level_range = {5, 14}, exp_worth = 2700,
	rarity = 15,
	max_life = resolvers.rngavg(140,145),
	hit_die = 15,
	challenge = 9,
	combat_natural = 13,
	infravision = 4,
	skill_knowledge = 12,
	skill_listen = 18,
	skill_movesilently = 16,
	skill_spot = 18,
	skill_survival = 12,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1, 
		[Talents.T_TOUGHNESS] = 1,	
		},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Blindsight 6 squares; immune to gaze attacks, visual effects, illusions, +4 to saves against sonic effects
--Disruptive harmonics: 4d6 Reflex DC 15
--neutral evil alignment
newEntity{
	define_as = "BASE_NPC_DESTRACHAN",
	type = "aberration",
	display = "X", color=colors.ORANGE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A huge slimy burrowing creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=18, dex=12, con=16, int=12, wis=18, cha=12, luc=8 },
	combat = { dam= {1,6}, },
	name = "destrachan",
	level_range = {10, nil}, exp_worth = 2400,
	rarity = 15,
	max_life = resolvers.rngavg(60,63),
	hit_die = 8,
	challenge = 8,
	combat_natural = 7,
	infravision = 4,
	skill_hide = 6,
	skill_listen = 21,
	skill_movesilently = 6,
	skill_spot = 18,
	skill_survival = 5,
	resolvers.talents{ [Talents.T_DODGE]=1, 	
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Detect magic, ethereal jaunt
--Neutral alignment
newEntity{
	define_as = "BASE_NPC_ETHEREAL_FILCHER",
	type = "aberration",
	display = "X", color=colors.LIGHT_BLUE,
	body = { INVEN = 10 },
    desc = [[A bizarre looking creature with long fingers.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=18, con=11, int=7, wis=12, cha=10, luc=12 },
	combat = { dam= {1,4}, },
	name = "ethereal filcher",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 5,
	challenge = 3,
	infravision = 4,
	skill_listen = 8,
	skill_pickpocket = 8,
	skill_spot = 8,
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_DODGE]=1 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Ethereal jaunt; neutral alignment
newEntity{
	define_as = "BASE_NPC_ETHEREAL_MARAUDER",
	type = "aberration",
	display = "X", color=colors.DARK_BLUE,
	body = { INVEN = 10 },
    desc = [[A small bizarre looking creature with a bluish tint.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=12, con=11, int=7, wis=12, cha=10, luc=12 },
	combat = { dam= {1,6}, },
	name = "ethereal marauder",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 2,
	challenge = 3,
	infravision = 4,
	combat_natural = 3,
	skill_listen = 4,
	skill_movesilently = 4,
	skill_spot = 4,
	movement_speed_bonus = 0.33, 	
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Swim 20 ft.; gibbering 4 squares spread DC 13 Will or confusion for 1d2 rounds; improved grab, swallow whole; AL N
--Immune to critical hits & flanking
newEntity{
	define_as = "BASE_NPC_GIBBERING_MOUTHER",
	type = "aberration",
	display = "X", color=colors.DARK_RED,
	body = { INVEN = 10 },
    desc = [[A small bizarre looking creature with multiple mouths.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=13, con=22, int=4, wis=13, cha=13, luc=10 },
	combat = { dam= {1,1}, },
	name = "gibbering mouther",
	level_range = {5, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 2,
	challenge = 5,
	infravision = 4,
	combat_natural = 8,
	skill_listen = 3,
	skill_swim = 15,
	skill_spot = 4,
	combat_dr = 5,
	movement_speed_bonus = -0.66, 	
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Climb 20 ft., scent
newEntity{
	define_as = "BASE_NPC_GRICK",
	type = "aberration",
	display = "X", color=colors.BLUE,
	body = { INVEN = 10 },
    desc = [[A small tentacled creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=14, con=11, int=3, wis=14, cha=5, luc=10 },
	combat = { dam= {1,4}, },
	name = "grick",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 3,
	infravision = 4,
	combat_natural = 4,
	skill_climb = 8,
	skill_hide = 9,
	skill_listen = 4,
	skill_spot = 4,
	combat_dr = 10,
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    