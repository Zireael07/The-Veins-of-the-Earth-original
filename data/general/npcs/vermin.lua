--Veins of the Earth
--Zireael 2013-2016

local vermin_desc = ""

newEntity{
	define_as = "BASE_NPC_VERMIN",
	type = "vermin",
	body = { INVEN = 10 },
	body_parts = { torso=1, arms=1, legs=1, head=1 },
	ai = "animal_level", ai_state = { talent_in=3, },
	faction = "vermin",
	blood_color = colors.GREY,
	emote_anger = "*click*",
	alignment = "Neutral",
	resolvers.wounds()
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SPIDER",
	image = "tiles/mobiles/spider.png",
	display = 'r', color=colors.BROWN,
	desc = [[A small spider.]],
	uncommon_desc = [[Monstrous spiders come in all shapes and sizes, but most can be grouped into one of two types - hunters and web-spinners. Hunters are fast, expert jumpers and have keen eyesight. Web-spinners can launch a web attack to trap their foes and are experts at remaining unnoticed when in their silky lairs.]],
	common_desc = [[Like some of their smaller kin, monstrous spiders have a nasty poisonous bite. They can also spin webs of surprisingly strong and difficult to spot silk. Generally, the larger the spider the nastier the poison and the stronger its webs.]],
	base_desc = "This eight-legged beast is a monstrous spider, an aggressive cousin of the more common, smaller arachnid. "..vermin_desc.."",

	stats = { str=3, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	infravision = 4,
	skill_climb = 8,
	skill_hide = 4,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "tiny spider",
	level_range = {1, 4}, exp_worth = 100,
	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "small spider",
	level_range = {1, 4}, exp_worth = 135,
	rarity = 3,
	max_life = resolvers.rngavg(3,6),
	hit_die = 1,
	challenge = 1/3,
	stats = { str=7, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "medium spider",
	level_range = {1, 4}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(3,6),
	hit_die = 2,
	challenge = 1,
	stats = { str=11, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "large spider",
	level_range = {5, 20}, exp_worth = 3000,
	rarity = 9,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 4,
	stats = { str=15, dex=17, con=12, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	poison = "medium_spider"
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "huge spider",
	level_range = {7, 20}, exp_worth = 3300,
	rarity = 40,
	max_life = resolvers.rngavg(50,55),
	hit_die = 8,
	challenge = 8,
	stats = { str=19, dex=17, con=14, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "medium_spider"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_ANT",
	image = "tiles/mobiles/ant.png",
	display = 'a', color=colors.BLACK,
	desc = [[This ant has a glossy black carapace, a stinger dripping with acid and razor-sharp pincers. It is about the size of a man.]],
	uncommon_desc = [[Despite their size, giant ants can still climb virtually any surface capable of supporting their weight. To permanently eliminate a hive of giant ants, its queen must be slain or removed; all other members of the hive are expendable.]],
	common_desc = [[Like common ants, the giant ants within a hive are born into various castes. Most hive members are either workers or soldiers, who exist solely to serve the hive and its singular queen. Both workers and soldiers can defend themselves with dangerous bites, but soldiers are particularly aggressive. Soldiers attack by clamping onto a victim with their jaws and then repeatedly strike with an acidic stinger in their abdomen.]],
	base_desc = "This giant insect is an overgrown variety of the common ant. "..vermin_desc.."",

	stats = { str=10, dex=10, con=10, int=1, wis=11, cha=9, luc=10 },
	combat = { dam= {1,6} },
	infravision = 4,
	skill_climb = 8,
	combat_natural = 7,
}

newEntity{
	base = "BASE_NPC_ANT",
	name = "giant ant worker", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 400,
	rarity = 4,
	max_life = resolvers.rngavg(8,11),
	hit_die = 2,
	challenge = 1,
}

--Acid sting 1d4
newEntity{
	base = "BASE_NPC_ANT",
	image = "tiles/mobiles/ant_soldier.png",
	name = "giant ant soldier", color=colors.BLUE,
	level_range = {5, 20}, exp_worth = 600,
	rarity = 8,
	max_life = resolvers.rngavg(10,13),
	hit_die = 2,
	challenge = 2,
	stats = { str=14, dex=10, con=13, int=1, wis=13, cha=11, luc=10 },
	combat = { dam= {2,4} },
}

--Bump up CR and stats, reduce damage per PF
--1d2 STR poison
newEntity{
	base = "BASE_NPC_ANT",
	image = "tiles/mobiles/ant_queen.png",
	name = "giant ant queen", color=colors.DARK_RED, --let's make her stand out
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 14,
	max_life = resolvers.rngavg(20,30),
	hit_die = 4,
	challenge = 5,
	combat_natural = 9,
	stats = { str=22, dex=9, con=25, int=1, wis=17, cha=15, luc=10 },
	combat = { dam= {1,8} },
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_CENTIPEDE",
	image = "tiles/mobiles/centipede.png",
	display = 'w', color=colors.BROWN,
	desc = [[A giant centipede.]],
	uncommon_desc = [[Monstrous centipedes can grow to truly enormous sizes. Larger centipedes have more potent venom. Even the largest monstrous centipedes can skitter along walls or ceilings as well as they can across a floor.]],
	common_desc = [[Monstrous centipedes typically attack anything that might be food. The venom they inject with their bite can slowly paralyze their prey, leaving the creature helpless while the centipede feeds.]],
	base_desc = "This skittering creature is a monstrously large centipede. "..vermin_desc.."",

	stats = { str=1, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	infravision = 4,
	skill_climb = 10,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "tiny centipede", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 50,
	rarity = 4,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/8,
	skill_hide = 16,
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "small centipede", color=colors.BROWN,
	level_range = {1, 20}, exp_worth = 100,
	rarity = 6,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
	skill_hide = 14,
	stats = { str=5, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "medium centipede", color=colors.RED,
	level_range = {1, 20}, exp_worth = 200,
	rarity = 8,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1/2,
	skill_hide = 8,
	stats = { str=9, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	desc = [[This centipede is about the size of a hunting dog. It has a shiny maroon carapice.]],
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "large centipede", color=colors.LIGHT_RED,
	level_range = {5, 20}, exp_worth = 400,
	rarity = 10,
	max_life = resolvers.rngavg(12,14),
	hit_die = 3,
	challenge = 1,
	skill_hide = 4,
	stats = { str=13, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	desc = [[This centipede is larger than a human. It attacks by rearing back part of its body and darting forward with its mouth. Surprisingly, it can do this quite rapidly. It has a bright maroon carapace.]],
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "huge centipede", color=colors.BROWN,
	level_range = {8, 20}, exp_worth = 600,
	rarity = 20,
	max_life = resolvers.rngavg(32,35),
	hit_die = 6,
	challenge = 2,
	stats = { str=17, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "gargantuan centipede", color=colors.BROWN,
	level_range = {10, 20}, exp_worth = 1800,
	rarity = 25,
	max_life = resolvers.rngavg(64,68),
	hit_die = 12,
	challenge = 6,
	stats = { str=23, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,8} },
	poison = "small_centipede"
}

newEntity{
	base = "BASE_NPC_CENTIPEDE",
	name = "colossal centipede", color=colors.BROWN,
	level_range = {15, 20}, exp_worth = 2700,
	rarity = 35,
	max_life = resolvers.rngavg(130,135),
	hit_die = 24,
	challenge = 9,
	stats = { str=27, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} },
	poison = "small_centipede"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SCORPION",
	image = "tiles/mobiles/scorpion.png",
	body_parts = { torso=1, arms=1, legs=1, head=1, tail=1 },
	display = 'w', color=colors.TAN,
	desc = [[A giant scorpion.]],
	specialist_desc = [[Monstrous scorpions can reach truly enormous sizes. Larger scorpions have more potent venom.]],
	uncommon_desc = [[A monstrous scorpion attacks by clutching its prey with its pincers, then quickly jabs the creature with the stinger at the end of its arching tail. A scorpion’s venom can be deadly in larger doses.]],
	common_desc = [[Monstrous scorpions feed on creatures smaller than themselves, but they will attack anything that approaches them. They usually charge their prey.]],
	base_desc = "This clawed arachnid is a monstrously oversized scorpion. "..vermin_desc.."",

	stats = { str=3, dex=10, con=14, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,2} },
	infravision = 4,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "tiny scorpion",
	level_range = {1, 20}, exp_worth = 100,
	rarity = 4,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1/4,
	skill_hide = 12,
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "small scorpion",
	level_range = {1, 20}, exp_worth = 200,
	rarity = 6,
	max_life = resolvers.rngavg(5,7),
	hit_die = 1,
	challenge = 1/2,
	skill_hide = 8,
	skill_climb = 3,
	stats = { str=9, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "medium scorpion",
	level_range = {1, 20}, exp_worth = 400,
	rarity = 6,
	max_life = resolvers.rngavg(12,14),
	hit_die = 2,
	challenge = 1,
	skill_hide = 4,
	skill_climb = 4,
	stats = { str=13, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "large scorpion",
	level_range = {5, 20}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(31,34),
	hit_die = 5,
	challenge = 3,
	skill_climb = 4,
	stats = { str=19, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} },
	poison = "large_scorpion"
}

newEntity{
	base = "BASE_NPC_SCORPION",
	name = "huge scorpion",
	level_range = {8, 20}, exp_worth = 2100,
	rarity = 10,
	max_life = resolvers.rngavg(72,77),
	hit_die = 10,
	challenge = 7,
	skill_climb = 4,
	stats = { str=23, dex=15, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} },
	poison = "large_scorpion"
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_FBEETLE",
	image = "tiles/mobiles/beetle.png",
	display = 'x', color=colors.FIREBRICK,
	desc = [[A giant fire beetle.]],
	stats = { str=10, dex=10, con=11, int=1, wis=10, cha=7, luc=12 },
	combat = { dam= {2,4} },
	infravision = 4,
}

newEntity{
	base = "BASE_NPC_FBEETLE",
	name = "giant fire beetle", color=colors.FIREBRICK,
	level_range = {1, 20}, exp_worth = 135,
	rarity = 4,
	max_life = resolvers.rngavg(3,5),
	resist = { [DamageType.FIRE] = 5, },
	hit_die = 1,
	challenge = 1/3,
	combat_natural = 6,
	common_desc = [[A fire beetle has a particularly nasty bite. Due to its bulk, it cannot fly or skitter up walls. Harvested glands retain their luminescence for several days, and are highly prized by miners and others who work underground.]],
	base_desc = "This oversized insect is a giant fire beetle. These scavengers have two luminescent glands just above their eyes which emit a red glow like burning embers, illuminating an area about six paces across. "..vermin_desc.."",
}

newEntity{ base = "BASE_NPC_VERMIN",
	define_as = "BASE_NPC_SBEETLE",
	image = "tiles/mobiles/beetle.png",
	display = 'x', color=colors.DARK_GREEN,
	desc = [[A giant stag beetle.]],
	stats = { str=23, dex=10, con=17, int=1, wis=10, cha=9, luc=12 },
	combat = { dam= {4,6} },
	infravision = 4,
}

newEntity{
	base = "BASE_NPC_SBEETLE",
	name = "giant stag beetle", color=colors.DARK_GREEN,
	level_range = {5, 20}, exp_worth = 1200,
	rarity = 12,
	max_life = resolvers.rngavg(50,54),
	hit_die = 7,
	challenge = 4,
	combat_natural = 10,
	uncommon_desc = [[A giant stag beetle is a lumbering creature that often simply tramples right over threats smaller than itself.]],
	common_desc = [[Giant stag beetles are herbivores with ravenous appetites. Left unchecked, they can devour entire fields of crops. They attack only if they feel threatened. Due to their bulk, they cannot fly or skitter up walls.]],
	base_desc = "This hulking insect is a giant stag beetle, which takes its name from its antlerlike, chitinous horns. "..vermin_desc.."",
}
