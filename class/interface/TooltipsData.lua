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


require "engine.class"

module(..., package.seeall, class.make)

-------------------------------------------------------------
-- Resources
-------------------------------------------------------------
TOOLTIP_LEVEL = [[ This is your character level. ]]
TOOLTIP_LIFE = [[ This is your life meter. If it falls to #LIGHT_RED#0#LAST# or lower, you're dead. ]]
TOOLTIP_EXP = [[ This is the number of current #ORANGE#Experience Points#LAST# and the number required for the next level. ]]
TOOLTIP_AC = [[ AC is short for #ORANGE#Armor Class#LAST#. It determines how hard you are to hit.
	#GOLD#10 + armor bonus + shield bonus + magic bonus + natural bonus + Dex modifier (may be limited by armor)#LAST# ]]

TOOLTIP_FEAT = [[ You gain a feat point upon birth and one point every three character levels. 
Feats in #GOLD#gold#LAST# are class feats, gained automatically when you gained a level in the class. ]]
TOOLTIP_ENC = [[ If your #ORANGE#encumbrance#LAST# exceeds #GOLD#33%#LAST# of your #ORANGE#max encumbrance#LAST#, you suffer penalties from #SANDY_BROWN#light load#LAST#. 
	If it exceeds #GOLD#66%#LAST#, you suffer penalties from #SANDY_BROWN#heavy load#LAST#, instead.]]


TOOLTIP_SAVES = [[ When making a saving throw, a #SANDY_BROWN#d20 #LAST#is rolled, the bonus is added and the result is compared with the spell or trap's #ORANGE#Difficulty Class#LAST#. ]]
TOOLTIP_FORTITUDE = [[ Fortitude allows you to resist poisons or diseases.
	#GOLD#Base Fortitude bonus + stat bonus (best of Str, Con modifiers).#LAST# ]]
TOOLTIP_REFLEX = [[ Reflex represents protects you from a grease spell or other dangers avoided by moving.
	#GOLD#Base Reflex bonus + stat bonus (best of Dex, Int modifiers).#LAST# ]]
TOOLTIP_WILL = [[ Will helps you resist charm spells or a vampire's gaze, for example.
	#GOLD#Base Will bonus + stat bonus (best of Wis, Cha modifiers).#LAST# ]]

TOOLTIP_STATS = [[ The number on the right is the #ORANGE#modifier#LAST# used by the skills or saves. ]]
TOOLTIP_STR = [[ STR is short for #ORANGE#Strength#LAST#. It affects the damage your character deals in combat, as well as his melee attacks. ]]
TOOLTIP_DEX = [[ DEX is short for #ORANGE#Dexterity#LAST#. It represents how well your character can dodge blows in combat, as well as his ranged attacks. ]]
TOOLTIP_CON = [[ CON is short for #ORANGE#Constitution#LAST#. It affects your character's fortitude. ]]
TOOLTIP_INT = [[ INT is short for #ORANGE#Intelligence#LAST#. If you are a mage, it determines how hard it is to withstand your spells. ]]
TOOLTIP_WIS = [[ WIS is short for #ORANGE#Wisdom#LAST#. It affects your character's willpower and clerical powers. ]]
TOOLTIP_CHA = [[ CHA is short for #ORANGE#Charisma#LAST#. It affects your character's interactions with others. ]]
TOOLTIP_LUC = [[ LUC is short for #ORANGE#Luck#LAST#. It has no effects presently. In the future, it will influence most statistics, as well as loot drops and enemies appearing. ]]

TOOLTIP_SKILL = [[ #GOLD#Skill ranks + stat modifier + any bonuses - armor check penalty (for some skills)#LAST#
	When using a skill, a #SANDY_BROWN#d20 roll#LAST# is made and the stat modifier is added along with your ranks.
    The max number of ranks you can have in a skill is limited to #SANDY_BROWN#4 + 1 per level#LAST#. ]]

TOOLTIP_ATTACK_MELEE = [[ BAB is short for #ORANGE#Base Attack Bonus#LAST#. This number is added to your #GOLD#Strength bonus#LAST# and a #SANDY_BROWN#d20 roll#LAST# when you make an attack. The total is compared to the opponent's AC to determine whether you hit.]]
TOOLTIP_ATTACK_RANGE = [[ BAB is short for #ORANGE#Base Attack Bonus#LAST#. This number is added to your #GOLD#Dexterity bonus#LAST# and a #SANDY_BROWN#d20 roll#LAST# when you make an attack. The total is compared to the opponent's AC to determine whether you hit.]]

