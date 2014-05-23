The Veins of the Earth
=========

A short guide to modding

Important note:
As opposed to ToME 4, the main hand slot has an *underscore* in the name! It's MAIN_HAND not MAINHAND to better differentiate from OFF_HAND!

Classes
If you add a prestige class, it must be added to the section in base descriptor which disallows them at birth. Also, it needs to have prestige = true.

Effects (spells, poisons, class abilities, etc.)
DO NOT ever use numbers in effect names, EVER!!
The stat_increase_x temporary value is there for the character sheet to track stat changes. The x has to match the stat's name.
Same goes for stat_decrease_x.

General entities (NPCs, objects)
rarity -> how often do we want this to appear. the bigger the number, the rarer it is. Never set to 0.
display -> what ASCII character is used. Look at Legend.lua for the list of symbols used
color -> the color of the above character
name -> what it says on the tin
desc -> the description which will be displayed in the tooltips
egos -> any magic item properties the item or templates the creature might have
egos_chance -> what it says on the tin. Be careful not to misspell it.

Items
unided_name -> the name that is displayed before the item is identified

Egos
Keywords are necessary for the tooltips to work.

Weapons
slot = MAIN_HAND, offslot = OFF_HAND -> one-handed weapon
slot = MAIN_HAND, slot_forbid = OFF_HAND -> two-handed weapon

require -> any feats required to use the item
encumber -> weight in lbs.
cost -> price in gp
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
ai -> do NOT change this line!
type -> what it says on the tin; used to track some immunities
subtype -> enter the name of the monster. It is used to track favored enemies and some immunities
body -> this line defines which slots the creature will have
stats -> what it says on the tin

max_life -> the amount of life the monster will have, the average of the two values entered
hit_die -> the HD of the monster. Necessary for some spells to work.
challenge -> the CR of the monster (in other words, how hard it is to defeat)
exp_worth -> how much XP is the monster worth.
CR 1/10 - 30 XP
CR 1/8 - 40 XP
CR 1/6 - 50 XP
CR 1/4 - 75 XP
CR 1/3 - 100 XP
CR 1/2 - 150 XP
CR 1 - 300 XP
CR 2 - 600 XP
CR 3 - 900 XP
CR 4 - 1200 XP
CR 5 - 1500 XP
CR 6 - 1800 XP
CR 7 - 2100 XP
CR 8 - 2500 XP
CR 9 - 2700 XP
CR 10 - 3000 XP
CR 11 - 3300 XP
CR 12 - 3600 XP
CR 13 - 4000 XP
CR 14 - 4200 XP
CR 15 - 4500 XP
CR 16 - 4800 XP
CR 17 - 5000 XP
CR 20 - 6000 XP

The inventory resolver is there to make sure the monsters drop corpses.
The equipment resolver does what it says - gives the NPC equipment. Make sure the NPC has the correct slots defined in body.
infravision -> the darkvision the NPC has
Darkvision 1 - 20 ft. or less or low-light vision
Darkvision 3 - 30 ft.
Darkvision 6 - 60 ft.

Basic speed is 30 ft., any additions/substractions is handled via movement_speed_bonus.
10 ft. = -0.66
20 ft. = -0.33 
40 ft. = 0.33
50 ft. = 0.66
60 ft. = 1
70 ft. = 1.33
80 ft. = 1.66
90 ft. = 2

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


It is imperative that the self.project line look like:
a) self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = 15}) -> save DC defined
b) self:projectile(tg, x, y, DamageType.ACID, {dam=damage}) -> default save DC

DamageType -> what it says on the tin. Special conditions, such as grease, are also coded as DamageType.

target {type="bolt"} -> passes through the target and can hit another one
target {type="hit"} -> hit one target
target {type="cone"} -> a cone
target {type="ball"} -> a circle around the target. Requires radius.

range 3 - close range
range 5 - medium range

duration 10 - 1 minute
duration 100 - 10 minutes
duration 600 - 1 hour

Feats
Certain (activable or sustained) feats are color-coded, too.

Purple - metamagic feats
Purple/gold - item creation feats
Blue/yellow - clerical feats (turn undead, lay on hands)