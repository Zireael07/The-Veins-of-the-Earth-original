The Veins of the Earth
=========

A short guide to modding

Important note:
As opposed to ToME 4, the main hand slot has an *underscore* in the name! It's MAIN_HAND not MAINHAND to better differentiate from OFF_HAND!

Classes
If you add a prestige class, it must be added to the section in base descriptor which disallows them at birth. Also, it needs to have prestige = true.

"Good" saves come out as a +2 bonus at 1st level and a +0.5 bonus every level.
"Poor" saves come out as no bonus at 1st level and a +0.33 bonus every level.
This is identical to a variant known as "fractional saves".

Skills
Skills are added in the data/skills.lua file. You need to define name, description, skill and penalty.

If you add a skill, it must be listed in the class skills listing in Actor.lua.

Effects (spells, poisons, class abilities, etc.)
DO NOT ever use numbers in effect names, EVER!!
The stat_increase_x temporary value is there for the character sheet to track stat changes. The x has to match the stat's name.
Same goes for stat_decrease_x.

General entities (NPCs, objects)
rarity -> how often do we want this to appear. the bigger the number, the rarer it is. Never set to 0.
display -> what ASCII character is used. Look at Legend.lua for the list of symbols used
color -> the color of the above character
image -> the tile that is used.
name -> what it says on the tin
desc -> the description which will be displayed in the tooltips
egos -> any magic item properties the item might have
egos_chance -> what it says on the tin. Be careful not to misspell it.
resolvers -> these govern the equipment, classes or templates the NPC might have

Items
unided_name -> the name that is displayed before the item is identified
cost -> the internal value is counted in copper pieces, while resolvers handle higher coinage (most equipment uses resolver.value{silver=x}, where x is the price in silver pieces)

Prices
1 pp = 10 gp = 200 sp = 2000 cp
1 gp = 20 sp = 200 cp
1 sp = 10 cp

Egos
Keywords are necessary for the tooltips to work.

Weapons
slot = MAIN_HAND, offslot = OFF_HAND -> one-handed weapon
slot = MAIN_HAND, slot_forbid = OFF_HAND -> two-handed weapon
slot = MAIN_HAND, offslot = SHOULDER -> ranged weapon

require -> any feats required to use the item
encumber -> weight in lbs.
dam -> the first number is the number of dice rolled, the second one is the number of die sides.
For example, dam = {1,6} means 1d6
threat -> by how much do we increase the threat range (when do we crit for those unfamilliar with d20)
No threat? We crit on a 20. threat 1 - crit on 19-20. threat 2 - crit on 18-20. threat 3 - crit on 17-20.
critical -> by how much do we multiply the damage on a critical hit. If not present, it's x2
range -> for bows, crossbows etc. how far can we shoot. Works the same way as spell range or darkvision range.

Flags, like martial = true, simple = true or reach = true, define whether some feat/talent effects apply to this weapon. The exotic = true flag, while redundant, makes it possible for tooltips to work correctly.

Armor
slot = BODY -> armor
slot = OFF_HAND -> shield

combat_shield -> the AC bonus granted by the shield
spell_fail -> the spell failure chance
combat_armor_ac -> the AC bonus granted by the armor
max_dex_bonus -> if the armor limits max Dex bonus to AC, this is the max bonus
armor_penalty -> this number is deduced from the skill checks for some skills

Other items
combat_natural -> the AC bonus granted by amulets of natural armor
combat_protection -> the AC bonus granted by rings of protection

NPCs
ai -> one of three: either "animal_level" for dumb critters with Int <3, "human_level" for most critters with Int 3+ or "humanoid_level" for critters with Int 3+ which are capable of picking up stuff
type -> what it says on the tin; used to track some immunities
subtype -> enter the name of the monster. It is used to track favored enemies and some immunities
body -> this line defines which slots the creature will have
stats -> what it says on the tin

max_life -> the amount of life the monster will have, the average of the two values entered
hit_die -> the HD of the monster. Necessary for some spells to work.
challenge -> the CR of the monster (in other words, how hard it is to defeat)

Exp_worth is a leftover from the system where it was individually defined for every monster. It has no use currently.

The equipment resolver does what it says - gives the NPC equipment. Make sure the NPC has the correct slots defined in body.
infravision -> the darkvision the NPC has
Darkvision 1 - 20 ft. or less or low-light vision
Darkvision 3 - 30 ft.
Darkvision 6 - 60 ft.

Basic speed is 30 ft., any additions/substractions is handled via movement_speed.
5 ft. = 0.22
10 ft. = 0.33
20 ft. = 0.66
30 ft  = 1
40 ft. = 1.33
50 ft. = 1.66
60 ft. = 2
70 ft. = 2.33
80 ft. = 2.66
90 ft. = 3

skill_... -> any bonuses the monster receives (not counting the bonuses from stats and/or feats)
combat_natural -> the natural armor bonus minus the size bonus (the latter doesn't exist in VotE)
poison -> the name of the poison's entry in Combat.lua

specialist_desc -> the top-level knowledge about the monster a character can have
uncommon_desc -> uncommon knowledge about the monster a character can have
common_desc -> common "
base_desc -> base "
Note that there's no need to repeat information from lower levels in higher levels.


Spells
Icon names for spells must match the spell's name exactly, otherwise they won't be displayed.

Some spells are color-coded:
Cyan/white - fly spells
Brown/yellow - "animal buff" spells (e.g. Bull's Strength)
Blue/yellow - cleric only spells
Green - druid spells
Gray/red - summon spells (gray/green for summon nature's ally)
Pink/brown - polymorph spells


It is imperative that the self.project line look like this:
self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = self:getSpellDC(t)})
This ensures the proper DCs are used.

DamageType -> what it says on the tin. Special conditions, such as grease, are also coded as DamageType.

target {type="bolt"} -> passes through the target and can hit another one
target {type="hit"} -> hit one target
target {type="cone"} -> a cone
target {type="ball"} -> a circle around the target. Requires radius.

range 3 - close range (25')
range 5 - medium range (100')
range 20 - long range (400')

duration 10 - 1 minute
duration 100 - 10 minutes
duration 600 - 1 hour

Feats
Certain (activable or sustained) feats are color-coded, too.

Purple - metamagic feats
Purple/gold - item creation feats
Blue/yellow - clerical feats (turn undead, lay on hands)
