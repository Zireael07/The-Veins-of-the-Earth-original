The Veins of the Earth
=========

A short guide to modding

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
level_range -> what level must the player be for the monster to be generated
ai -> do NOT change this line!
type -> what it says on the tin
subtype -> enter the name of the monster. It is used to track favored enemies
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
CR 1 - 300 XP
CR 2 - 600 XP
CR 3 - 900 XP
CR 6 - 450 XP ?
CR 7 - 550 XP ? 

The inventory resolver is there to make sure the monsters drop corpses.
The equipment resolver does what it says - gives the NPC equipment. Make sure the NPC has the correct slots defined in body.
infravision -> the darkvision the NPC has
Darkvision 1 - 20 ft. or less or low-light vision
Darkvision 3 - 30 ft.
Darkvision 6 - 60 ft.

skill_... -> any bonuses the monster receives (not counting the bonuses from stats and/or feats)
combat_natural -> the natural armor bonus minus the size bonus (the latter doesn't exist in VotE)

Spells
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