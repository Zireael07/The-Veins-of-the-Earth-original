--Veins of the Earth
--Zireael

local Talents = require("engine.interface.ActorTalents")

local dragon_desc = [[It can see in the dark. It is immune to sleep effects and paralysis effects. It needs to eat, sleep and breathe.]]

--Scent; immunity to fire; breath weapon 12d6 fire Ref DC 21 half
newEntity{
        define_as = "BASE_NPC_DRAG_TURTLE",
        type = "dragon",
        image = "tiles/dragon_turtle.png",
        display = 'D', color=colors.DARK_GREEN,
        body = { INVEN = 10 },
        desc = [[An immense turtle.]],

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
        resolvers.wounds()
}

--blindsense 60 ft.; Poison - pri sleep 10 rounds sec sleep 1d3 hours Fort DC 14
newEntity{
        define_as = "BASE_NPC_PSEUDODRAGON",
        type = "dragon",
        image = "tiles/pseudodragon.png",
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
--Poison (wyvern poison 2d6 CON) Fort DC 17
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
--        movement_speed_bonus = -0.33,
        movement_speed = 0.66,
        resolvers.talents{ [Talents.T_ALERTNESS]=1 },
        alignment = "Neutral",
        fly = true,
        resolvers.wounds()
}

--NOTE: True dragons start here
--Immunity to acid, water breathing
newEntity{
	define_as = "BASE_NPC_DRAGON_BLACK",
	type = "dragon",
	display = 'D', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[Black dragons are sometimes known as skull dragons because of their skeletal faces. Adding to the skeletal impression is the gradual deterioration of the hide around the base of the horn and the cheekbones. This deterioration increases with age and does not harm the dragon. On hatching, a black dragon�s scales are thin, small, and glossy. As the dragon ages, they become larger, thicker, and duller, helping it camouflage itself in swamps and marshes.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=11, dex=10, con=13, int=8, wis=11, cha=8, luc=10 },
    combat = { dam= {1,6} },
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
    resolvers.wounds()
}

--Immunity to electricity, create/destroy water
newEntity{
	define_as = "BASE_NPC_DRAGON_BLUE",
	type = "dragon",
	display = 'D', color=colors.BLUE,
	body = { INVEN = 10 },
	desc = [[A blue dragon's scales vary in color from an iridescent azure to a deep indigo, polished to a glossy finish by blowing desert sands. The size of its scales increases little as the dragon ages, although they do become thicker and harder. Its hide tends to hum and crackle faintly with built-up static electricity. These effects intensify when the dragon is angry or about to attack, giving off an odor of ozone and sand. Their vibrant color makes blue dragons easy to spot in barren desert surroundings. However, they often burrow into the sand so only part of their heads are exposed.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

newEntity{
	define_as = "BASE_NPC_DRAGON_GREEN",
	type = "dragon",
	display = 'D', color=colors.GREEN,
	body = { INVEN = 10 },
	desc = [[A wyrmling green dragon's scales are thin, very small, and a deep shade of green that appears nearly black. As the dragon ages, the scales grow larger and lighter, turning shades of forest, emerald, and olive green, which helps it blend in with its wooded surroundings.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,6} },
    name = "blue dragon",
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
	resolvers.wounds()
}

newEntity{
	define_as = "BASE_NPC_DRAGON_RED",
	type = "dragon",
	display = 'D', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[The small scales of a wyrmling red dragon are a bright glossy scarlet, making the dragon easily spotted by predators and hunters, so it stays underground and does not venture outside until it is more able to take care of itself. Toward the end of young age, the scales turn a deeper red, and the glossy texture is replaced by a smooth, dull finish. As the dragon grows older, the scales become large, thick, and as strong as metal. The neck frill and wings are an ash blue or purple-gray toward the edges, becoming darker with age. The pupils of a red dragon fade as it ages; the oldest red dragons have eyes that resemble molten lava orbs.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

--Icewalking, immunity to cold, vulnerability to fire
newEntity{
	define_as = "BASE_NPC_DRAGON_WHITE",
	type = "dragon",
	display = 'D', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[The scales of a wyrmling white dragon glisten like mirrors. As the dragon ages, the sheen disappears, and by very old age, scales of pale blue and light gray are mixed in with the white.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

--Metallic
--Immunity to fire, vulnerability to cold, speak with animals
newEntity{
	define_as = "BASE_NPC_DRAGON_BRASS",
	type = "dragon",
	display = 'D', color=colors.SANDY_BROWN,
	body = { INVEN = 10 },
	desc = [[At birth, a brass dragon's scales are a dull, mottled brown. As the dragon gets older, the scales become more brassy until they reach a warm, burnished appearance. The grand head-plates of a brass dragon are smooth and metallic, and it sports bladed chin horns that grow sharper with age. Wings and frills are mottled green toward the edges, darkening with age. As the dragon grows older, its pupils fade until the eyes resemble molten metal orbs.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=11, dex=10, con=13, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

--Immunity to acid, spider climb
newEntity{
	define_as = "BASE_NPC_DRAGON_COPPER",
	type = "dragon",
	display = 'D', color=colors.DARK_TAN,
	body = { INVEN = 10 },
	desc = [[A bronze wyrmling�s scales are yellow tinged with green, showing only a hint of bronze. As the dragon approaches adulthood, its color deepens slowly to a darker, rich bronze tone. Very old dragons develop a blue-black tint to the edges of their scales. Powerful swimmers, they have webbed feet and smooth, flat scales. The pupils of its eyes fade as a dragon ages, until in the oldest the eyes resemble glowing green orbs.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

--Immunity to fire, vulnerability to cold, water breathing
newEntity{
	define_as = "BASE_NPC_DRAGON_GOLD",
	type = "dragon",
	display = 'D', color=colors.GOLD,
	body = { INVEN = 10 },
	desc = [[On hatching, a gold dragon�s scales are dark yellow with golden metallic flecks. The flecks get larger as the dragon matures until, at the adult stage, the scales are completely golden. Gold dragons� faces are bewhiskered and sagacious; as they age, their pupils fade until the eyes resemble pools of molten gold.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=17, dex=10, con=15, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}

--Immunity to acid and cold, cloud walking, vulnerability to fire
newEntity{
	define_as = "BASE_NPC_DRAGON_SILVER",
	type = "dragon",
	display = 'D', color=colors.ANTIQUE_WHITE,
	body = { INVEN = 10 },
	desc = [[A silver wyrmling�s scales are blue-gray with silver highlights. As the dragon approaches adulthood, its color gradually brightens until the individual scales are scarcely visible.]],
	ai = "human_level", ai_state = { talent_in=3, },
    stats = { str=13, dex=10, con=13, int=14, wis=15, cha=14, luc=10 },
    combat = { dam= {1,6} },
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
	resolvers.wounds()
}
