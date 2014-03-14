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
    uncommon_desc = [[Aboleths have a array of psionic powers that create illusions to help ensnare their victims. They can also enslave a victim through the domination of their mind.]],
    common_desc = [[An aboleth's attacks can cause a terrible affliction where the victim's skin becomes a clear, slimey membrane that must remain moistened with cool, fresh water. They also surround themselves with a viscous cloud of mucus that can cause victims to temporarily lose the ability to breath air. Aboleths speak their own language, as well as Undercommon and Aquan. The mucus that aboleths exude can be used to great effect in the creation of potions of water breathing.]],
    base_desc = [[This creature is an aboleth, an intelligent, aquatic aberration. This intelligent race make natural arcane casters, and the most powerful of their kind are usually competent wizards. It can see in the dark and needs to eat, sleep and breathe.]],

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
    uncommon_desc = [[Though having no sense of personal hygene, athachs do have a love for the finery of gems, crystals and jewellery - a passion only matched by their love of food and violence. Though fearful of most giantkin, athachs hate hill giants with a passion and will usually attack them on sight.]],
    common_desc = [[As well as being superb melee combatants, athachs can hurl rocks as skillfully as most giants, and have a nasty poisonous bite that can drain the strength of its victims. Athachs speak a crude dialect of giant.]],
    base_desc = [[This huge, portly giant-like creature is in fact an athach, identifiable by its third arm and its unbelievable stench. It can see in the dark and needs to eat, sleep and breathe.]],

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
	resolvers.talents{ [Talents.T_ALERTNESS]=1, 
	[Talents.T_POWER_ATTACK] = 1
	},
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
	image = "tiles/ettercap.png",
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
	uncommon_desc = [[While not overly dexterous, chokers are unnaturally fast, and thus can perform more actions than a normal creature can.]],
	common_desc = [[A choker’s hands are covered with spiny pads that allow it to traverse walls and ceilings, where it likes to lay in hiding. When prey passes by, it grabs the creature by the neck with its tentacle-like arms and proceeds to strangle the victim until it dies.]],
	base_desc = [[This small creature is a choker, a subterranean beast. It can see in the dark.]],
}        

newEntity{
	define_as = "BASE_NPC_CHUUL",
	type = "aberration", subtype = "chuul",
	display = "X", color=colors.BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A large serpent-like squid.]],
    uncommon_desc = [[Although unable to use many items, chuuls enjoy taking trophies from their kills, particularly lizardfolk, so they take victims’ equipment back to their lairs. If a victim should happen to own no interesting items, a chuul will take its skull or other symbol of the kill.]],
    common_desc = [[A chuul fights primarily with its two large, powerful pincers. However, it can also paralyze victims with its tentacles. Despite their amphibious nature, chuuls prefer to stay on land or in shallow water during combat.]],
    base_desc = [[This amphibious creature is a chuul. It can see in the dark.]],

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
    specialist_desc = [[A cloaker can manipulate the shadows, producing several effects that mimic the following spells -- obscure vision, dancing images, and silent image.]],
    uncommon_desc = [[Cloakers can produce a dangerous subsonic moan that causes shakiness, fear, nausea, or stupor in its victims.]],
    common_desc = [[When at rest cloakers closely resemble large black cloaks, which aids their disguise. They can fly, and they can also unfurl and completely engulf a Medium creature.]],
    base_desc = [[This creature is a cloaker, a foul creature that prowls the vast caverns beneath the earth. It can see in the dark and needs to eat, sleep and breathe.]],

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

--Drow spell-likes, poison
newEntity{
	define_as = "BASE_NPC_DRIDER",
	type = "aberration", subtype = "drider",
	image = "tiles/newtiles/drider.png",
	display = "X", color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A mix between a drow and a spider.]],
    uncommon_desc = [[Driders are resistant to magic and possess several innate magical abilities, such as darkness and suggestion. In addition, they can cast spells as clerics, wizards, or sorcerers.]],
    common_desc = [[ Driders have a weak bite attack that can poison creatures, but they also wield manufactured weapons in combat.]],
    base_desc = [[This arachnoid creature is a drider. It can see in the dark and needs to eat, sleep and breathe.
    Driders were once dark elves who failed some test of their goddess Lolth, and were transformed as punishment. Drow and driders hate each other passionately. Driders are outcasts from drow society.]],

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
	spell_resistance = 12,
	skill_climb = 8,
	skill_hide = 8,
	skill_movesilently = 10,
	skill_listen = 6,
	skill_spot = 6,
	resolvers.equip{
                full_id=true,
                { name = "shortbow" },
                { name = "arrows" },
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
    uncommon_desc = [[Intelligent subterranean creatures sometimes coexist with otyughs, using them as living garbage disposals.]],
    common_desc = [[Otyughs live in heaps of refuse, scavenging almost anything for food. They have powerful tentacles to grasp prey. The bite of an otyugh is filled with the filth fever disease.]],
    base_desc = [[This disgusting creature is an otyugh. It can see in the dark.]],

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
--Toughness, Power Attack
newEntity{
	define_as = "BASE_NPC_DELVER",
	type = "aberration",
	image = "tiles/newtiles/otyugh.png",
	display = "X", color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A huge slimy burrowing creature.]],
    uncommon_desc = [[ Most delvers are shy and inoffensive creatures, but like with nearly all species, there are exceptions to this rule. Delvers can also become addicted to metal which acts like an intoxicating drug to them. Such addicted specimens can also act very unlike most of their kin.]],
    common_desc = [[The slime that covers a delver is corrosive to most objects, highly corrosive to metallic objects or creatures, and devastating against stone objects or creatures. A delver can also alter the effect of its slime so that instead of disolving stone, it can soften it instead, much like using the spell stone shape. Most delvers speak Terran and Undercommon.]],
    base_desc = [[This huge creature is a delver, an intelligent subterranean dweller that feeds on the rocks that it disolved with a corrosive slime that covers its body. It can see in the dark.]],

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
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Blindsight 6 squares; immune to gaze attacks, visual effects, illusions, +4 to saves against sonic effects
--Disruptive harmonics: 4d6 Reflex DC 15
newEntity{
	define_as = "BASE_NPC_DESTRACHAN",
	type = "aberration",
	image = "tiles/destrachan.png",
	display = "X", color=colors.ORANGE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A blind aberrant creature.]],
    uncommon_desc = [[Destrachans can unleash a sonic blast that has various effects depending on the harmonics is uses, but can cause both lethal and non-lethal damage to the subjects it targets. They have accute hearing but can protect themselves against sonic attack forms by closing the flaps of skin that surround their sensitive ears.]],
    common_desc = [[Destrachan are sightless creatures, and rely on their acute sense of hearing to interact with their surroundings. They use sonics to interpret their environment and are immune to effects that target the eyes of the victim such as visual illusions and gaze attacks. Destrachan do not usually communicate through language, but most understand Common.]],
    base_desc = [[This creature, though looking like a simple reptilian beast is in fact a destrachan, a malevolent and craftily sadistic subterranean creature.]],

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
	skill_hide = 6,
	skill_listen = 21,
	skill_movesilently = 6,
	skill_spot = 18,
	skill_survival = 5,
	alignment = "neutral evil",
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
    uncommon_desc = [[The natural coloration of gricks makes them difficult to locate in naturally rocky areas. Gricks may gather and attack in a group, but they do not act in concert with each other.]],
    common_desc = [[Gricks resist normal weapons. They infest dungeons, caves, and other underground places, although they sometimes haunt open spaces when food is scarce.]],
    base_desc = [[This wormlike creature is a grick. It can see in the dark.]],

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

--Immunity to acid
newEntity{
	define_as = "BASE_NPC_MIMIC",
	type = "aberration",
	display = "m", color=colors.BROWN,
	body = { INVEN = 10 },
    desc = [[A stash of items.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=12, con=17, int=10, wis=13, cha=10, luc=10 },
	combat = { dam= {1,8}, },
	name = "mimic",
	level_range = {5, nil}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 2,
	challenge = 4,
	infravision = 4,
	combat_natural = 5,
	skill_climb = 5,
	skill_listen = 7,
	skill_spot = 7,
	movement_speed_bonus = -0.90, 	
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}    

--Alternate form, scent, tremorsense 60 ft.; +4 Fort and Ref
--Immune to poison, sleep, paralysis, polymorph, stunning
newEntity{
	define_as = "BASE_NPC_PHASM",
	type = "aberration",
	display = "X", color=colors.DARK_GREEN,
	body = { INVEN = 10 },
    desc = [[An amorphous creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=12, dex=15, con=15, int=16, wis=13, cha=14, luc=12 },
	combat = { dam= {1,3}, },
	name = "phasm",
	level_range = {10, nil}, exp_worth = 2000,
	rarity = 15,
	max_life = resolvers.rngavg(95,100),
	hit_die = 15,
	challenge = 7,
	infravision = 4,
	combat_natural = 5,
	skill_bluff = 18,
	skill_climb = 6,
	skill_diplomacy = 10,
	skill_intimidate = 2,
	skill_knowledge = 15,
	skill_listen = 10,
	skill_spot = 10,
	skill_survival = 6,	
	alignment = "chaotic neutral",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
} 

--Rust [item Ref DC 17]
newEntity{
	define_as = "BASE_NPC_RUST_MONSTER",
	type = "aberration",
	display = "X", color=colors.DARK_UMBER,
	body = { INVEN = 10 },
    desc = [[A small tan brownish creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=17, con=13, int=2, wis=13, cha=8, luc=12 },
	combat = { dam= {1,3}, },
	name = "rust monster",
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(25,30),
	hit_die = 5,
	challenge = 3,
	infravision = 2,
	combat_natural = 5,
	skill_listen = 6,
	skill_spot = 6,
	movement_speed_bonus = 0.33,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
} 

--Swim 40 ft.; rake 1d6
newEntity{
	define_as = "BASE_NPC_SKUM",
	type = "aberration",
	display = "X", color=colors.AQUA,
	body = { INVEN = 10 },
    desc = [[A humanoid with joined fingers and fins.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=13, con=13, int=10, wis=10, cha=6, luc=10 },
	combat = { dam= {2,6}, },
	name = "skum",
	level_range = {5, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 2,
	infravision = 4,
	combat_natural = 2,
	skill_hide = 5,
	skill_listen = 7,
	skill_movesilently = 5,
	skill_spot = 7,
	skill_swim = 8,
	movement_speed_bonus = -0.33,
	alignment = "lawful evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
} 

--Too small to drop corpse; fly 50 ft.; electricity damage; immunity to magic, natural invis
newEntity{
	define_as = "BASE_NPC_WISP",
	type = "aberration",
	display = "X", color=colors.LIGHT_YELLOW,
	body = { INVEN = 10 },
    desc = [[A colorful group of lights, similar to a lantern.]],
    uncommon_desc = [[When startled or frightened, a will-o'-wisp can extinguish its glow, effectively turning it invisible. Although immune to most spells or spell-like effects, they are affected by magic missile and maze.]],
    common_desc = [[Will-o'-wisps can fly with remarkable agility. They are completely immune to most spells or spell-like effects, and they attack by inflicting powerful electrical shocks.]],
    base_desc = [[This floating, glowing orb is actually a creature called a will-o'-wisp. It can see in the dark and fly.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=1, dex=29, con=10, int=15, wis=16, cha=12, luc=12 },
	combat = { dam= {2,6}, },
	name = "will'o'wisp",
	level_range = {5, nil}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(40,45),
	hit_die = 9,
	challenge = 6,
	infravision = 4,
	combat_protection = 10,
	skill_bluff = 12,
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_listen = 14,
	skill_search = 12,
	skill_spot = 14,
	movement_speed_bonus = 0.66,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1 },
} 

newEntity{
	define_as = "BASE_NPC_NAGA",
	type = "aberration", subtype = "naga",
	image = "tiles/naga.png",
	display = "n", color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
    desc = [[A monster with a snakelike body and a human head.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=15, con=14, int=16, wis=15, cha=17, luc=12 },
	combat = { dam= {2,6} },
	infravision = 4,
	movement_speed_bonus = 0.33,
	rarity = 20,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

--Poison, 2d4 min sleep Fort DC 16; cast spells as Sor7
--Immunity to poison, resistance to charm +2
newEntity{ base = "BASE_NPC_NAGA",
	name = "dark naga", color=colors.BLACK,
	level_range = {10, nil}, exp_worth = 2400,
	max_life = resolvers.rngavg(55,60),
	hit_die = 9,
	challenge = 8,
	combat = { dam= {2,4} },
	combat_natural = 2,
	skill_bluff = 6,
	skill_concentration = 10,
	skill_diplomacy = 4,
	skill_intimidate = 2,
	skill_listen = 8,
	skill_sensemotive = 6,
	skill_spellcraft = 9,
	skill_spot = 8,
	alignment = "lawful evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
	specialist_desc = [[Most dark nagas speak Infernal and Common, but they can also read thoughts as easily as a wizard reads a book.]],
	uncommon_desc = [[A dark naga’s fangs and the stinger in its tail both deliver a debilitating venom that can plunge its victim into a nightmare-wracked coma for several minutes.]],
	common_desc = [[A dark naga is a talented innate sorcerous spellcaster. They often form alliances with other foul creatures for their mutual gain.]],
	base_desc = [[This slithering eel-like creature with the vaguely human-like face is a scheming creature called a dark naga. It can see in the dark.]],
}      

--Poison pri & sec 1d10 Con; Fort DC 19; spells as Sor9 + Good & Law domains
newEntity{ base = "BASE_NPC_NAGA",
	name = "guardian naga",
	level_range = {10, nil}, exp_worth = 3000,
	max_life = resolvers.rngavg(90,95),
	hit_die = 9,
	stats = { str=21, dex=14, con=19, int=16, wis=19, cha=18, luc=12 },
	challenge = 10,
	combat_natural = 6,
	skill_bluff = 14,
	skill_concentration = 16,
	skill_diplomacy = 4,
	skill_intimidate = 2,
	skill_sensemotive = 14,
	skill_spellcraft = 14,
	skill_spot = 9,
	alignment = "lawful good",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_DODGE]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
}  

--Charming gaze 3 squares hit charm person Will DC 19; poison pri & sec 1d8 CON Fort DC 18; cast as Sor7
newEntity{ base = "BASE_NPC_NAGA",
	name = "spirit naga", color=colors.GRAY,
	level_range = {10, nil}, exp_worth = 2700,
	max_life = resolvers.rngavg(75,80),
	hit_die = 9,
	stats = { str=18, dex=13, con=18, int=12, wis=17, cha=17, luc=12 },
	challenge = 9,
	combat_natural = 6,
	skill_bluff = 14,
	skill_concentration = 9,
	skill_listen = 11,
	skill_spellcraft = 9,
	skill_spot = 11,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
	specialist_desc = [[Other varieties of naga exist, including the eel-like dark naga.]],
	uncommon_desc = [[A spirit naga can charm people simply by meeting their gaze, and its bite carries a deadly poison.]],
	common_desc = [[Spirit nagas possess significant innate sorcererous ability. Their name comes from their habit of lairing in spiritually unclean areas.]],
	base_desc = [[This large serpent with black-and-crimson bands and a humanlike head is a spirit naga. It can see in the dark. Most spirit nagas speak Abyssal and Common.]],
}      

--Swim 50 ft.; poison pri & sec 1d8 CON Fort DC 17
newEntity{ base = "BASE_NPC_NAGA",
	name = "water naga", color=colors.BLUE,
	level_range = {10, nil}, exp_worth = 2000,
	max_life = resolvers.rngavg(60,65),
	hit_die = 7,
	stats = { str=16, dex=13, con=18, int=10, wis=17, cha=15, luc=12 },
	challenge = 7,
	combat_natural = 4,
	skill_concentration = 11,
	skill_listen = 4,
	skill_spellcraft = 8,
	skill_spot = 4,
	skill_swim = 8,
	alignment = "neutral",
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
}      
