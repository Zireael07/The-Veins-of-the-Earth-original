--Veins of the Earth
--Zireael 2013-2015

--Outsiders (except janni) do not drop corpses

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_OUTSIDER",
	type = "outsider",
	body = { INVEN = 10 },
	ai = "human_level", ai_state = { talent_in=3, },
	resolvers.wounds()
}

--Corporeal instability DC 15 Fort
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_CHAOS_BEAST",
	name = "chaos beast",
	image = "tiles/mobiles/chaos_beast.png",
	display = 'O', color=colors.RED,
	desc = [[A shapechanging beast.]],

	stats = { str=14, dex=13, con=13, int=10, wis=10, cha=10, luc=10 },
	combat = { dam= {1,3} },

	level_range = {1, 5}, exp_worth = 2100,
	rarity = 8,
	max_life = resolvers.rngavg(40,45),
	hit_die = 4,
	challenge = 7,
	combat_natural = 5,
	spell_resistance = 15,
	skill_climb = 11,
	skill_escapeartist = 11,
	skill_hide = 12,
	skill_jump = 7,
	skill_listen = 11,
	skill_search = 11,
	skill_spot = 11,
	skill_tumble = 11,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	alignment = "Chaotic Neutral",
	specialist_desc = [[A victim of a chaos beast’s touch does not immediately die from the transformation. A shapechange or stoneskin spell can stop the process temporarily, but a restoration, heal, or greater restoration spell is needed to remove the affliction.]],
	uncommon_desc = [[A chaos beast can cause very little damage. However, its touch is damaging to corporeal creatures, causing them to melt into an amorphous mass, slowing going into shock and eventually becoming a chaos beast themselves. They are completely immune to transmutation.]],
	common_desc = [[Much like their home plane of Limbo, chaos beasts have no set form. Instead, they constantly shift and alter their bodies, and there’s no telling what one might look like.]],
	base_desc = [[ This amorphous, revolting creature is a chaos beast. It can see in the dark and cannot be brought back to life by normal means.]],
}

--Immunity to poison, petrification & cold
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_FORMIAN",
	image = "tiles/mobiles/newtiles/mobiles/formian.png",
	display = 'x', color=colors.BROWN,
	desc = [[It looks like a cross between an ant and a centaur.]],

	stats = { str=13, dex=14, con=13, int=6, wis=10, cha=9, luc=10 },
	combat = { dam= {1,4} },
	skill_climb = 9,
	skill_movesilently = 8,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	resists = {
        [DamageType.FIRE] = 10,
        [DamageType.ELECTRIC] = 10,
        [DamageType.SONIC] = 10,
    },
	alignment = "Neutral",
}

newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian worker",
	desc = [[The lowest caste of the ant-like formians -- the outer-planar personification of lawful existance -- the worker appears as an ant
      creature the size of a doberman. Their mentality is very limited, and they tend to be non-hostile unless attacked or provoked, though
      they can easily panic when seperated from their superiors.]],
	level_range = {1, 10}, exp_worth = 200,
	rarity = 10,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/2,
	combat_natural = 5,
	skill_hide = 4,
	skill_listen = 4,
	skill_search = 4,
	skill_spot = 4,
	resolvers.talents{ [Talents.T_CSW_INNATE]=1, },
}

--Poison 1d6 STR primary & sec DC 14
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian warrior", color=colors.YELLOW,
	desc = [[A humanoid ant-creature the size of a horse, the formian warrior is the absolute enforcement of outer-planar law, and
      serves as the local militia across the planes of law and neutrality.]],
	level_range = {1, 10}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat = { dam= {2,4} },
	stats = { str=17, dex=16, con=14, int=10, wis=12, cha=11, luc=10 },
	combat_natural = 5,
	spell_resistance = 18,
	skill_hide = 7,
	skill_jump = 11,
	skill_listen = 7,
	skill_movesilently = 7,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

--Poison 1d6 STR primary & sec DC 15
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian taskmaster", color=colors.YELLOW,
	desc = [[A humanoid ant-creature the size of a horse, the formian taskmaster assigns orders to the workers and warriors.]],
	level_range = {5, 15}, exp_worth = 2000,
	rarity = 10,
	max_life = resolvers.rngavg(40,45),
	hit_die = 6,
	challenge = 7,
	combat = { dam= {2,4} },
	stats = { str=18, dex=16, con=14, int=11, wis=16, cha=19, luc=10 },
	combat_natural = 6,
	spell_resistance = 21,
	skill_diplomacy = 2,
	skill_hide = 9,
	skill_intimidate = 8,
	skill_listen = 9,
	skill_search = 7,
	skill_spot = 8,
	skill_movesilently = 9,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

--Poison 2d6 DEX primary & sec DC 20, fast healing 2
--Spell-likes: At will—charm monster (DC 17), clairaudience/clairvoyance, detect chaos, detect thoughts (DC 15), magic circle against chaos, greater teleport; 1/day—dictum (DC 20), order’s wrath (DC 17).
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian myrmarch",
	desc = [[Second only to the formian queen, the myrmarchs govern hives in the tens of formians.]],
	level_range = {10, 15}, exp_worth = 3000,
	rarity = 25,
	max_life = resolvers.rngavg(100,105),
	hit_die = 12,
	challenge = 10,
	combat = { dam= {2,4} },
	stats = { str=19, dex=18, con=18, int=16, wis=16, cha=17, luc=10 },
	combat_natural = 14,
	spell_resistance = 25,
	skill_climb = 15,
	skill_concentration = 15,
	skill_diplomacy = 17,
	skill_hide = 11,
	skill_knowledge = 15,
	skill_listen = 15,
	skill_movesilently = 16,
	skill_search = 15,
	skill_sensemotive = 15,
	skill_spot = 15,
	skill_tumble = 9,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1
	 },
}

--Fast healing 2, Toughness
--Cast spells as Sor17
--Spell-likes: At will—calm emotions (DC 17), charm monster (DC 19), clairaudience/clairvoyance, detect chaos, detect thoughts, dictum (DC 22), divination, hold monster (DC 20), magic circle against chaos, order’s wrath (DC 19), shield of law (DC 23), true seeing.
newEntity{
	base = "BASE_NPC_FORMIAN",
	name = "formian queen",
	level_range = {10, 15}, exp_worth = 3000,
	rarity = 50,
	max_life = resolvers.rngavg(190,195),
	hit_die = 20,
	challenge = 17,
	combat = { dam= {1,1} }, --it should be 0
	stats = { str=1, dex=1, con=20, int=20, wis=20, cha=21, luc=14 },
	combat_natural = 14,
	spell_resistance = 30,
	skill_bluff = 23,
	skill_concentration = 23,
	skill_diplomacy = 27,
	skill_intimidate = 25,
	skill_knowledge = 25,
	skill_listen = 25,
	skill_sensemotive = 25,
	skill_spellcraft = 25,
	skill_spot = 25,
	skill_usemagic = 25,
--	movement_speed_bonus = -0.50,
	movement_speed = 0.50,
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_IRON_WILL]=1,
	},
}

--plane shift; spell-likes: 3/day—invisibility (self only), speak with animals. Caster level 12th. 1/day - create food and water (caster level 7th), ethereal jaunt (caster level 12th) for 1 hour.
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_JANNI",
	image = "tiles/mobiles/djinn.png",
	display = 'J', color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A large humanoid clothed in gray and seemingly hovering in air.]],

	stats = { str=16, dex=15, con=12, int=14, wis=15, cha=13, luc=12 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_JANNI",
	name = "janni",
	level_range = {5, 25}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(30,35),
	hit_die = 6,
	challenge = 4,
	infravision = 4,
	combat_natural = 1,
	skill_bluff = 13,
	skill_concentration = 9,
	skill_diplomacy = 2,
	skill_escapeartist = 3,
	skill_listen = 9,
	skill_movesilently = 3,
	skill_sensemotive = 9,
	skill_spot = 9,
	fly = true,
	resists = { [DamageType.FIRE] = 10 },
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_MOBILITY]=1,
	},
	resolvers.equip{
	full_id=true,
		{ name = "chain mail", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
		{ name = "scimitar", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "longbow", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
	},
}

--Change shape, cast spells as Sor7
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_RAKSHASA",
	subtype = "shapechanger",
	name = "rakshasa",
	image = "tiles/mobiles/rakshasa.png",
	display = 'O', color=colors.LIGHT_RED,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A humanoid with inverted hands.]],
	specialist_desc = [[Not only are rakshasas strong, intelligent, and charming, they can transform themselves to assume any humanoid form. True seeing can still reveal the fiend’s true appearance. Rakshasas feed on human flesh.]],
	uncommon_desc = [[A rakshasa can read minds and is a talented innate sorcerous spellcaster. Their king is Ravana, a mountainous demon lord with ten heads. Ravana is more powerful than he is clever.]],
	common_desc = [[akshasas are masters of deceit and illusion. They are also highly resistant to physical harm, though good-aligned piercing weapons can penetrate their supernatural defenses.]],
	base_desc = [[This malevolent tiger-headed humanoid is actually a fiend called a rakshasa.  They may have been extremely wicked humans in previous incarnations.
	It can see in the dark and cannot be brought back to life by normal means.]],

	stats = { str=12, dex=14, con=16, int=13, wis=13, cha=17, luc=12 },
	combat = { dam= {1,4} },

	level_range = {10, nil}, exp_worth = 3000,
	rarity = 10,
	max_life = resolvers.rngavg(50,55),
	hit_die = 7,
	challenge = 10,
	infravision = 4,
	combat_natural = 9,
	spell_resistance = 27,
	combat_dr = 15,
	skill_bluff = 13,
	skill_concentration = 10,
	skill_diplomacy = 3,
	skill_listen = 12,
	skill_sensemotive = 10,
	skill_spellcraft = 10,
	skill_spot = 10,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	alignment = "Lawful Evil",
}

--immunity to fire; 2d10 damage to undead on hit
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_RAVID",
	subtype = "fire",
	name = "ravid",
	image = "tiles/mobiles/ravid.png",
	display = 'O', color=colors.YELLOW,
	desc = [[A bizarre creature of light energy.]],
	stats = { str=13, dex=10, con=13, int=7, wis=12, cha=14, luc=12 },
	combat = { dam= {1,6} },

	level_range = {5, nil}, exp_worth = 1500,
	rarity = 10,
	max_life = resolvers.rngavg(13,17),
	hit_die = 3,
	challenge = 5,
	infravision = 4,
	combat_natural = 15,
	skill_escapeartist = 6,
	skill_hide = 6,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_survival = 6,
	skill_spot = 6,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	alignment = "Neutral",
	fly = true,
}

--Bay (Will DC 13 or panicked for 2d4 rounds, once per creature), trip, shadow blend
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_SHADOW_MASTIFF",
	name = "shadow mastiff",
	image = "tiles/mobiles/wolf.png",
	display = 'd', color=colors.DARK_GRAY,
	desc = [[A big dog made of shadow.]],
	stats = { str=17, dex=13, con=17, int=4, wis=12, cha=13, luc=10 },
	combat = { dam= {1,6} },

	level_range = {5, nil}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(28,32),
	hit_die = 4,
	challenge = 5,
	infravision = 4,
	combat_natural = 3,
	skill_hide = 7,
	skill_listen = 7,
	skill_movesilently = 7,
	skill_survival = 7,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_DODGE]=1 },
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	alignment = "Neutral Evil",
}

--Burrow 20 ft; +2d6 fire on hit; tremorsense 4 squares; immunity to fire, vulnerability to cold
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_THOQQUA",
	subtype = "fire",
	name = "thoqqua",
	image = "tiles/mobiles/elemental_earth.png",
	display = 'K', color=colors.DARK_TAN,
	desc = [[A creature of fire and earth.]],
	common_desc = [[ese creatures are generally summoned from the Elemental Plane of Fire or, more rarely, the Elemental Plane of Earth. A thoqqua is so hot that its mere touch can ignite almost any material.]],
	base_desc = [[This rocky, red-hot worm is a thoqqua. It can see in the dark and cannot be brought back by normal means. It burrows through earth and rock. It resists fire and takes double damage from cold.]],

	stats = { str=15, dex=13, con=13, int=6, wis=12, cha=10, luc=10 },
	combat = { dam= {1,6} },
	level_range = {1, nil}, exp_worth = 600,
	rarity = 10,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 2,
	infravision = 4,
	combat_natural = 7,
	skill_listen = 4,
	skill_movesilently = 2,
	skill_survival = 2,
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	alignment = "Neutral",
}

--wields +3 adamantine warhammer; Change shape
--Awesome Blow, Blind-Fight, Cleave, Improved Bull Rush, Improved Sunder,
--Spell-likes: At will—chain lightning (DC 23), charm monster (DC 21), cure critical wounds (DC 21), fire storm (DC 24), greater dispel magic, hold monster (DC 22), invisibility, invisibility purge, levitate, persistent image (DC 22); 3/day—etherealness, word of chaos (DC 22), summon nature’s ally IX; 1/day—gate, maze, meteor swarm (DC 26).
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_TITAN",
	name = "titan",
	image = "tiles/mobiles/titan.png",
	display = 'H', color=colors.GOLD,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[An immense humanoid-shaped creature.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=43, dex=12, con=39, int=21, wis=28, cha=24, luc=10 },
	combat = { dam= {1,6} },

	level_range = {25, nil}, exp_worth = 6300,
	rarity = 50,
	max_life = resolvers.rngavg(365,370),
	hit_die = 20,
	challenge = 21,
	infravision = 4,
	combat_natural = 17,
	combat_dr = 15,
	spell_resistance = 32,
	skill_balance = 6,
	skill_bluff = 12,
	skill_climb = 8,
	skill_concentration = 13,
	skill_diplomacy = 4,
	skill_heal = 11,
	skill_intimidate = 25,
	skill_jump = 11,
	skill_knowledge = 22,
	skill_listen = 23,
	skill_sensemotive = 23,
	skill_search = 22,
	skill_spellcraft = 11,
	skill_spot = 23,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
	alignment = "Neutral",
}

--Improved grab, paralysis Fort DC 14; Multiattack, Multiweapon Fighting
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_XILL",
	name = "xill",
	image = "tiles/mobiles/xill.png",
	display = 'O', color=colors.BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	desc = [[A four-armed ethereal beast.]],

	stats = { str=15, dex=16, con=15, int=12, wis=12, cha=11, luc=10 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 1800,
	rarity = 18,
	max_life = resolvers.rngavg(30,35),
	hit_die = 4,
	challenge = 6,
	combat_natural = 7,
	spell_resistance = 21,
	skill_balance = 10,
	skill_climb = 8,
	skill_diplomacy = 2,
	skill_escapeartist = 7,
	skill_intimidate = 8,
	skill_listen = 8,
	skill_movesilently = 8,
	skill_sensemotive = 8,
	skill_spot = 8,
	skill_tumble = 8,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	alignment = "Lawful Evil",
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "short sword", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
		{ name = "short sword", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "longbow", veins_drops="monster", veins_level=resolvers.npc_drops_level, },
	},
}


--Fast healing 2 (in certain conditions), summon mephit, breath weapon 3 sq cone cooldown 3
newEntity{ base = "BASE_NPC_OUTSIDER",
	define_as = "BASE_NPC_MEPHIT",
	subtype = "mephit",
	image = "tiles/mobiles/mephit.png",
	display = 'M', color=colors.WHITE,
	desc = [[A small winged creature.]],

	stats = { str=10, dex=17, con=10, int=6, wis=11, cha=15, luc=12 },
	combat = { dam= {1,3} },
	level_range = {5, 25}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 3,
	challenge = 3,
	infravision = 4,
	combat_dr = 5,
	combat_dr_tohit = 1,
	skill_bluff = 6,
	skill_escapeartist = 6,
	skill_hide = 10,
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_spot = 6,
	alignment = "Neutral",
	fly = true,
}

--breath weapon 1d8 Ref DC 12 half; spell-likes: 1/hour - blur; 1/day gust of wind DC 14
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "air mephit", color=colors.LIGHT_BLUE,
	combat_natural = 4,
--	movement_speed_bonus = 1,
	movement_speed = 2,
	combat_attackspeed = 2,
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--breath weapon 1d4 & -4 AC & -2 attack for 3 rounds; spell-likes: 1/hour - blur; 1/day wind wall DC 15
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "dust mephit", color=colors.SLATE,
	combat_natural = 4,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--breath weapon 1d8 Ref DC 13; spell-like: 1/day soften earth and stone; 1/hour enlarge person (self)
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "earth mephit", color=colors.SANDY_BROWN,
	combat_natural = 7,
	max_life = resolvers.rngavg(17,21),
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	stats = { str=17, dex=8, con=13, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--immunity to fire, vulnerability to cold; breath weapon 1d8 fire Ref DC 12
--Spell-likes: 1/hour scorching ray DC 14; 1/day heat metal DC 14
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "fire mephit", color=colors.RED,
	combat_natural = 5,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	stats = { str=10, dex=13, con=10, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--immunity to cold, vulnerability to fire; 1d4 cold on hit
--Breath weapon 1d4 cold Ref DC 12 & -4 AC & -2 attack for 3 rounds
--Spell-likes: 1/hour magic missile; 1/day - chill metal DC 14
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "ice mephit", color=colors.LIGHT_STEEL_BLUE,
	combat_natural = 5,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--immunity to fire, vulnerability to cold; change shape (lava dr 20 speed -0.80)
--Breath weapon: 1d4 fire Ref DC 12 & -4 AC & -2 attack for 3 rounds
--Spell-likes: 1/day pyrotechnics
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "magma mephit", color=colors.DARK_RED,
	combat_natural = 5,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	stats = { str=10, dex=13, con=10, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--swim 30 ft; breath weapon 1d4 acid Ref DC 12 half & -4 AC & -2 attack for 3 rounds
--Spell-likes: 1/hour acid arrow, 1/day stinking cloud
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "ooze mephit", color=colors.DARK_GREEN,
	combat_natural = 6,
	max_life = resolvers.rngavg(17,21),
	skill_swim = 8,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	stats = { str=14, dex=10, con=13, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--breath weapon 1d4 Ref DC 13 half & -4 AC & -2 attack for 3 rounds if failed
--Spell-likes: 1/hour - glitterdust; 1/day 2d8 rad 2 ball Fort DC 14 half
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "salt mephit", color=colors.WHITE,
	combat_natural = 7,
	max_life = resolvers.rngavg(17,21),
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	stats = { str=17, dex=8, con=13, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}

--immunity to fire, vulnerability to cold; breath weapon 1d4 fire Ref DC 12 half & -4 AC & -2 attack for 3 rounds
--Spell-likes: 1/hour - blur; 1/day 2d6 fire Ref DC 14 half in 3 sq radius
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "steam mephit", color=colors.DARK_GREY,
	combat_natural = 5,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	resolvers.talents{ [Talents.T_DODGE]=1 },
}

--swim 30 ft.; breath weapon 1d8 acid Ref DC 13 half; spell-likes: 1/hour - acid arrow; 1/day stinking cloud
newEntity{
	base = "BASE_NPC_MEPHIT",
	name = "water mephit", color=colors.BLUE,
	combat_natural = 6,
	max_life = resolvers.rngavg(17,21),
	skill_swim = 8,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	stats = { str=14, dex=10, con=13, int=6, wis=11, cha=15, luc=12 },
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
}
