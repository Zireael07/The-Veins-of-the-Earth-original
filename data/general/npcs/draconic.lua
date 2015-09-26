--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

local dragon_desc = [[It can see in the dark. It is immune to sleep effects and paralysis effects. It needs to eat, sleep and breathe.]]

--Scent;
newEntity{
        define_as = "BASE_NPC_DRAG_TURTLE",
        type = "dragon",
        image = "tiles/mobiles/dragon_turtle.png",
        display = 'D', color=colors.DARK_GREEN,
        body = { INVEN = 10 },
        desc = [[An immense turtle.]],
        uncommon_desc = [[Dragon turtles are extremely territorial, attacking anything that threatens its home or resembles a potential meal — which is just about anything smaller than themselves. They can capsize smaller vessels simply by surfacing beneath them.]],
        common_desc = [[A dragon turtle is so named both for its draconic appearance and its ability to breathe a cone of superheated steam whilst submerged.]],
        base_desc = [[This massive, well-armored tortoise is a dragon turtle.]],

        ai = "human_level", ai_state = { talent_in=3, },
        stats = { str=27, dex=10, con=21, int=12, wis=13, cha=12, luc=10 },
        combat = { dam= {4,6} },
        name = "dragon turtle",
        level_range = {10, 15}, exp_worth = 2700,
        rarity = 10,
        max_life = resolvers.rngavg(135,140),
        hit_die = 12,
        challenge = 9,
        infravision = 1,
        combat_natural = 15,
        skill_diplomacy = 2,
        skill_hide = 7,
        skill_intimidate = 14,
        skill_listen = 14,
        skill_search = 14,
        skill_sensemotive = 14,
        skill_spot = 14,
        skill_survival = 14,
        skill_swim = 13,
        alignment = "Neutral",
        resolvers.talents{ [Talents.T_FIRE_IMMUNITY]=1,
                [Talents.T_STEAM_BREATH]=1,
        },
        resolvers.wounds()
}

--blindsense 60 ft.; Poison - pri sleep 10 rounds sec sleep 1d3 hours Fort DC 14
newEntity{
        define_as = "BASE_NPC_PSEUDODRAGON",
        type = "dragon",
        image = "tiles/mobiles/pseudodragon.png",
        display = 'D', color=colors.LIGHT_GREEN,
        body = { INVEN = 10 },
        desc = [[A tiny draconic creature in shades of green.]],
        specialist_desc = [[The eggs and young of pseudodragons can fetch a tremendous price.]],
        uncommon_desc = [[ Pseudodragons can communicate telepathically with creatures that speak Common or Sylvan.]],
        common_desc = [[Pseudodragons are playful, mischievous members of the dragon family. Powerful individuals prize them as companions, and sorcerers and wizards covet them as familiars.]],
        base_desc = "This tiny reptilian creature with butterfly-like wings is a pseudodragon."..dragon_desc.."",

        ai = "human_level", ai_state = { talent_in=3, },
        stats = { str=6, dex=15, con=13, int=10, wis=12, cha=10, luc=14 },
        combat = { dam= {1,3} },
        name = "pseudodragon",
        level_range = {1, nil}, exp_worth = 400,
        rarity = 15,
        max_life = resolvers.rngavg(13,17),
        hit_die = 2,
        challenge = 1,
        infravision = 4,
        spell_resistance = 19,
        combat_natural = 6,
        skill_diplomacy = 2,
        skill_hide = 18,
        skill_listen = 8,
        skill_search = 6,
        skill_sensemotive = 6,
        skill_spot = 8,
        resolvers.talents{ [Talents.T_ALERTNESS]=1 },
        alignment = "Neutral Good",
        fly = true,
--        movement_speed_bonus = 1,
        movement_speed = 2,
        combat_attackspeed = 2,
        resolvers.wounds()
}

--Fly 60 ft; scent, improved grab
newEntity{
        define_as = "BASE_NPC_WYVERN",
        type = "dragon",
        display = 'D', color=colors.GRAY,
        body = { INVEN = 10 },
        desc = [[A huge flying lizard with a stinging tail.]],
        uncommon_desc = [[Wyverns are stupid creatures, but they can speak Draconic. Wyverns are often used as steeds for more powerful creatures.]],
        common_desc = [[Wyverns are clumsy fliers. They have stingers on the end of their tails that deal poison damage and are proficient at grabbing prey.]],
        base_desc = "This large reptilian creature resembles a dragon, but it is in fact a wyvern. "..dragon_desc.."",

        ai = "human_level", ai_state = { talent_in=3, },
        stats = { str=19, dex=12, con=15, int=6, wis=12, cha=9, luc=10 },
        combat = { dam= {1,6} },
        name = "wyvern",
        level_range = {10, nil}, exp_worth = 2100,
        rarity = 15,
        max_life = resolvers.rngavg(55,60),
        hit_die = 7,
        challenge = 6,
        infravision = 4,
        combat_natural = 7,
        skill_hide = 6,
        skill_listen = 12,
        skill_movesilently = 10,
        skill_spot = 15,
        poison = "wyvern",
--        movement_speed_bonus = -0.33,
        movement_speed = 0.66,
        resolvers.talents{ [Talents.T_ALERTNESS]=1 },
        alignment = "Neutral",
        fly = true,
        resolvers.wounds()
}

--NOTE: True dragons start here
--water breathing
newEntity{
	define_as = "BASE_NPC_DRAGON_BLACK",
	type = "dragon",
	display = 'D', color=colors.BLACK,
    image = "tiles/mobiles/dragon/dragon_black_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[Black dragons are sometimes known as skull dragons because of their skeletal faces. Adding to the skeletal impression is the gradual deterioration of the hide around the base of the horn and the cheekbones. This deterioration increases with age and does not harm the dragon.
    On hatching, a black dragon's scales are thin, small, and glossy. As the dragon ages, they become larger, thicker, and duller, helping it camouflage itself in swamps and marshes.]],
    specialist_desc = [[Black dragons are particularly fond of coins, going to great lengths to discover the location of hordes of these items, whether they are silver, gold, or platinum.]],
    uncommon_desc = [[Older dragons have a variety of magical powers, such as darkness, insect plague, and corrupt water. Unlike many creatures, black dragons can use these abilities while submerged.]],
    common_desc = [[Black dragons make their lairs in warm marshes and submerged caves. These lairs often carry an acrid smell, a hint at the dragon’s highly acidic breath weapon.]],
    base_desc = "This black, skeletal reptile is a black dragon, sometimes known as a skull dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=11, dex=10, con=13, int=8, wis=11, cha=8, luc=10 },
    combat = { dam= {1,4} },
    name = "black dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 15,
    max_life = resolvers.rngavg(27,32),
    hit_die = 4,
    challenge = 3,
    infravision = 4,
    combat_natural = 3,
    --TODO: skills
    movement_speed = 2,
    alignment = "Chaotic Evil",
    resolvers.talents{ [Talents.T_ACID_BREATH]=1,
            [Talents.T_ACID_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
    resolvers.wounds()
}

--create/destroy water
newEntity{
	define_as = "BASE_NPC_DRAGON_BLUE",
	type = "dragon",
	display = 'D', color=colors.BLUE,
    image = "tiles/mobiles/dragon/dragon_blue_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[A blue dragon's scales vary in color from an iridescent azure to a deep indigo, polished to a glossy finish by blowing desert sands. The size of its scales increases little as the dragon ages, although they do become thicker and harder. Its hide tends to hum and crackle faintly with built-up static electricity. These effects intensify when the dragon is angry or about to attack, giving off an odor of ozone and sand.
    Their vibrant color makes blue dragons easy to spot in barren desert surroundings. However, they often burrow into the sand so only part of their heads are exposed.]],
    specialist_desc = [[Blue dragons are hard to spot when buried beneath the sand, but stand out easily when above ground. When flying, however, they blend in with the desert sky almost perfectly. They use this to their advantage, preferring to attack prey from surprise.]],
    uncommon_desc = [[Blue dragons develop natural illusions as they mature, such as ventriloquism and mirage arcana. They can also perfectly mimic any sound they hear.]],
    common_desc = [[Blue dragons live in hot desert environments, where they often lie in wait beneath the sand. They aggressively defend their territory with a powerful line of lightning breath.]],
    base_desc = "This horned, ozone-scented creature is a blue dragon."..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,4} },
    name = "blue dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 15,
    max_life = resolvers.rngavg(43,48),
    hit_die = 4,
    challenge = 3,
    infravision = 4,
    combat_natural = 5,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Lawful Evil",
    resolvers.talents{ [Talents.T_ELECTRIC_BREATH]=1,
            [Talents.T_ELECTRIC_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

newEntity{
	define_as = "BASE_NPC_DRAGON_GREEN",
	type = "dragon",
	display = 'D', color=colors.GREEN,
    image = "tiles/mobiles/dragon/dragon_green_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[A wyrmling green dragon's scales are thin, very small, and a deep shade of green that appears nearly black.
    As the dragon ages, the scales grow larger and lighter, turning shades of forest, emerald, and olive green, which helps it blend in with its wooded surroundings.]],
    specialist_desc = [[Green dragons show an interest in the society and abilities of those it captures, as well as local events and, of course, the location of treasure. They also enjoy evoking fear in weak creatures.]],
    uncommon_desc = [[Older, more powerful green dragons can control humanoids and plants alike with abilities like suggestion and command plants. They can use these abilities freely while submerged in water.]],
    common_desc = [[Green dragons make their lairs in old forests, particularly those with larger trees. A stinging odor of chlorine lingers in such regions. They possess a single breath weapon, a cone of acidic gas.]],
    base_desc = "This crested, reptilian creature is a green dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,4} },
    name = "green dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 15,
    max_life = resolvers.rngavg(35,40),
    hit_die = 5,
    challenge = 3,
    infravision = 4,
    combat_natural = 5,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Lawful Evil",
    resolvers.talents{ [Talents.T_ACID_BREATH_CONE]=1,
            [Talents.T_ACID_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

newEntity{
	define_as = "BASE_NPC_DRAGON_RED",
	type = "dragon",
	display = 'D', color=colors.RED,
    image = "tiles/mobiles/dragon/dragon_red_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[The small scales of a wyrmling red dragon are a bright glossy scarlet, making the dragon easily spotted by predators and hunters, so it stays underground and does not venture outside until it is more able to take care of itself. Toward the end of young age, the scales turn a deeper red, and the glossy texture is replaced by a smooth, dull finish. As the dragon grows older, the scales become large, thick, and as strong as metal.
    The neck frill and wings are an ash blue or purple-gray toward the edges, becoming darker with age. The pupils of a red dragon fade as it ages; the oldest red dragons have eyes that resemble molten lava orbs.]],
    specialist_desc = [[Although powerful, red dragons are extremely confident in their own abilities and waste no time considering the strength of their opponent. They can sometimes be tricked into making brash decisions in this manner.]],
    uncommon_desc = [[Older red dragons gain several magical abilities, although most of these are subtle such as discern location and find the path.]],
    common_desc = [[A red dragon’s lair is usually an enormous cave beneath the earth, sometimes near a lake of magma or the heart of a volcano. These lairs quickly fill with the dragon’s sulfurous scent, and shimmers with the heat of its intense fiery breath.]],
    base_desc = "This reptilian beast, which smells of smoke, is a red dragon."..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,4} },
    name = "red dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 15,
    max_life = resolvers.rngavg(55,60),
    hit_die = 7,
    challenge = 3,
    infravision = 4,
    combat_natural = 6,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Chaotic Evil",
    resolvers.talents{ [Talents.T_FIRE_BREATH]=1,
            [Talents.T_FIRE_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--Icewalking, vulnerability to fire
newEntity{
	define_as = "BASE_NPC_DRAGON_WHITE",
	type = "dragon",
	display = 'D', color=colors.WHITE,
    image = "tiles/new/dragon/dragon_white_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[The scales of a wyrmling white dragon glisten like mirrors.
    As the dragon ages, the sheen disappears, and by very old age, scales of pale blue and light gray are mixed in with the white.]],
    specialist_desc = [[White dragons like to hoard diamonds within ice-covered caverns so that the gems are reflected all about them. The oldest white dragons often use control weather to fortify these hidden stashes.]],
    uncommon_desc = [[As a white dragon ages, it masters several abilities dealing with bitter wind and cold weather, like freezing fog and wall of ice. From the time they are born, they can climb up any icy surface with ease.]],
    common_desc = [[White dragons lair beneath the snow and ice of their tundra homes, away from the sun. Their sole breath weapon is a cone of cold.]],
    base_desc = "This snow-colored reptile is a white dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,4} },
    name = "white dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 15,
    max_life = resolvers.rngavg(20,25),
    hit_die = 3,
    challenge = 3,
    infravision = 4,
    combat_natural = 2,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Chaotic Evil",
    resolvers.talents{ [Talents.T_COLD_BREATH]=1,
            [Talents.T_COLD_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--Metallic
--vulnerability to cold, speak with animals
newEntity{
	define_as = "BASE_NPC_DRAGON_BRASS",
	type = "dragon",
	display = 'D', color=colors.SANDY_BROWN,
    image = "tiles/new/dragon/dragon_brass_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[At birth, a brass dragon's scales are a dull, mottled brown. As the dragon gets older, the scales become more brassy until they reach a warm, burnished appearance. The grand head-plates of a brass dragon are smooth and metallic, and it sports bladed chin horns that grow sharper with age.
    Wings and frills are mottled green toward the edges, darkening with age. As the dragon grows older, its pupils fade until the eyes resemble molten metal orbs.]],
    specialist_desc = [[Although good-natured, brass dragons have an insatiable thirst for conversation and will sometimes bury sleeping creature in the sand if they refuse to chat with the dragon. They do not enjoy combat and prefer to avoid it if possible.]],
    uncommon_desc = [[Mature brass dragons have several abilities ranging from suggestion to control weather. The eldest brass dragons can summon djinni to their aid.]],
    common_desc = [[Brass dragons live in deserts and enjoy bathing in the sun and conversing with passers-by. They often come into conflict with blue dragons. Brass dragons have two types of breath weapons, a line of fire and a cone of sleep.]],
    base_desc = "This reptilian creature with a massive head plate is a brass dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=11, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,4} },
    name = "brass dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 25,
    max_life = resolvers.rngavg(28,33),
    hit_die = 4,
    challenge = 3,
    infravision = 4,
    combat_natural = 3,
 	--TODO: skills
	movement_speed = 2,
	alignment = "Chaotic Good",
    resolvers.talents{ [Talents.T_FIRE_BREATH_LINE]=1,
            [Talents.T_FIRE_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--water breathing, speak with animals
newEntity{
	define_as = "BASE_NPC_DRAGON_BRONZE",
	type = "dragon",
	display = 'D', color=colors.TAN,
    image = "tiles/mobiles/dragon/dragon_bronze_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[A bronze wyrmling's scales are yellow tinged with green, showing only a hint of bronze. As the dragon approaches adulthood, its color deepens slowly to a darker, rich bronze tone. Very old dragons develop a blue-black tint to the edges of their scales.
    Powerful swimmers, they have webbed feet and smooth, flat scales. The pupils of its eyes fade as a dragon ages, until in the oldest the eyes resemble glowing green orbs.]],
    specialist_desc = [[Bronze dragons dislike killing, usually attempting to bribe or force away any threat rather than fight. If attacked by vessels, they usually try to disable rather than destroy the ship.]],
    uncommon_desc = [[Bronze dragons are masters of the sea, which manifests itself in abilities like control water and fog cloud. Great wyrms can also use control weather.]],
    common_desc = [[Although they lair near deep bodies of fresh or salt water, a bronze dragon’s lair is always dry. They possess two types of breath weapons, a line of lightning and a cone of repulsion gas.]],
    base_desc = "This crested dragon, which smells of the ocean wind, is a bronze dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,4} },
    name = "bronze dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 25,
    max_life = resolvers.rngavg(43,48),
    hit_die = 6,
    challenge = 3,
    infravision = 4,
    combat_natural = 5,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Chaotic Good",
    resolvers.talents{ [Talents.T_ELECTRIC_BREATH]=1,
            [Talents.T_ELECTRIC_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--spider climb
newEntity{
	define_as = "BASE_NPC_DRAGON_COPPER",
	type = "dragon",
	display = 'D', color=colors.DARK_TAN,
    image = "tiles/new/dragon/dragon_copper_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[At birth, a copper dragon's scales have a ruddy brown color with a metallic tint. As the dragon gets older, the scales become finer and more coppery, assuming a soft, warm gloss by young adult age. Very old dragons' scales pick up a green tint.
    A copper dragon's pupils fade with age, and the eyes of great wyrms resemble glowing turquoise orbs.]],
    specialist_desc = [[Copper dragons enjoy pranks, jokes, and riddles. They rarely attack creatures that can tell them an amusing story or joke that it hasn’t heard before.]],
    uncommon_desc = [[In combat, copper dragons attempt to even the odds with abilities like stone shape, transmute rock to mud, and wall of stone.]],
    common_desc = [[Copper dragons nest in warm hills, which often brings them into conflict with the larger red dragons. They can use two breath weapons, a line of acid and a cone of slow gas.]],
    base_desc = "This reddish, metallic reptile is a copper dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,4} },
    name = "copper dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 25,
    max_life = resolvers.rngavg(42,48),
    hit_die = 6,
    challenge = 3,
    infravision = 4,
    combat_natural = 5,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Chaotic Good",
    resolvers.talents{ [Talents.T_ACID_BREATH]=1,
            [Talents.T_ACID_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--vulnerability to cold, water breathing
newEntity{
	define_as = "BASE_NPC_DRAGON_GOLD",
	type = "dragon",
	display = 'D', color=colors.GOLD,
    image = "tiles/mobiles/dragon/dragon_gold_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[On hatching, a gold dragon's scales are dark yellow with golden metallic flecks. The flecks get larger as the dragon matures until, at the adult stage, the scales are completely golden.
    Gold dragons' faces are bewhiskered and sagacious; as they age, their pupils fade until the eyes resemble pools of molten gold.]],
    specialist_desc = [[Gold dragons have an intolerance of evil rivaling that of a paladin. They often appoint themselves with the task of spreading good, often going on crusades against all manner of vile creatures.]],
    uncommon_desc = [[As they age, gold dragons gain several abilities, such as sunburst, detect gems, and bless. The oldest dragons can use foresight to see into the future.]],
    common_desc = [[Unlike most true dragons, gold dragons have no preferred habitat, as long as it’s made out of stone. They can breathe either a cone of fire or a cone of weakening gas.]],
    base_desc = "This glistening, sailed creature is a gold dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,4} },
    name = "gold dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 35,
    max_life = resolvers.rngavg(65,70),
    hit_die = 8,
    challenge = 3,
    infravision = 4,
    combat_natural = 7,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Lawful Good",
    resolvers.talents{ [Talents.T_FIRE_BREATH]=1,
            [Talents.T_FIRE_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}

--cloud walking, vulnerability to fire
newEntity{
	define_as = "BASE_NPC_DRAGON_SILVER",
	type = "dragon",
	display = 'D', color=colors.ANTIQUE_WHITE,
    image = "tiles/mobiles/dragon/dragon_silver_wyrmling.png",
	body = { INVEN = 10 },
	desc = [[A silver wyrmling's scales are blue-gray with silver highlights. As the dragon approaches adulthood, its color gradually brightens until the individual scales are scarcely visible.]],
    specialist_desc = [[Most silver dragons take up human guise in favor of their own forms, and they have a taste for human cooking. They often form alliances and even long-lasting friendships with the lesser-lived races.]],
    uncommon_desc = [[Silver dragons possess two types of breath weapons, a cone of cold and a cone of paralyzing gas. Older specimens can also use abilities like reverse gravity and control weather to even the playing field.]],
    common_desc = [[Silver dragons prefer lairs on secluded mountains, or even in the clouds; in the latter case, they use magically created earth for storing treasure and their young. They often come into conflict with red dragons, winning with the help of their allies.]],
    base_desc = "This frilled, sleek reptile is a silver dragon. "..dragon_desc.."",

    ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,4} },
    name = "silver dragon",
    level_range = {3, nil}, exp_worth = 900,
    rarity = 35,
    max_life = resolvers.rngavg(48,55),
    hit_die = 7,
    challenge = 3,
    infravision = 4,
    combat_natural = 6,
 	--TODO: skills
	movement_speed = 1.33,
	alignment = "Lawful Good",
    resolvers.talents{ [Talents.T_COLD_BREATH]=1,
            [Talents.T_ACID_IMMUNITY]=1,
            [Talents.T_COLD_IMMUNITY]=1,
    },
    resolvers.dragon_agecategory(),
	resolvers.wounds()
}
