--Veins of the Earth
--Zireael 2013-2016


local Talents = require "engine.interface.ActorTalents"
local DamageType = require "engine.DamageType"

--Special stuff
function resolvers.specialnpc()
 	return {__resolver="specialnpc", __resolve_last=true}
end

function resolvers.calc.specialnpc(t, e)
	local choice
	local cr_boost = 0

	--pick special template
	if rng.chance(2) then
		choice = "bandit"
		cr_boost = 2
	elseif rng.chance(6) then
		choice = "outlaw"
		cr_boost = 1
	elseif rng.chance(10) then
		choice = "brigand"
		cr_boost = 1
	elseif rng.chance(8) then
		choice = "chieftain"
		cr_boost = 2
	elseif rng.chance(6) then
		choice = "shaman"
		cr_boost = 2
	elseif rng.chance(4) then
		choice = "skilled"
		cr_boost = 1
	elseif rng.chance(10) then
		choice = "experienced"
		cr_boost = 2
	elseif rng.chance(15) then
		choice = "veteran"
		cr_boost = 4
	elseif rng.chance(20) then
		choice = "elite"
		cr_boost = 5
	elseif rng.chance(25) then
		choice = "master"
		cr_boost = 7
	elseif rng.chance(30) then
		choice = "paragon"
		cr_boost = 9
	elseif rng.chance(40) then
		choice = "legendary"
		cr_boost = 12
	end

	--safety check
	if game.zone.max_cr then
		if e.challenge + cr_boost > game.zone.max_cr + game:getDunDepth() then
			choice = nil
		end
	end

	--apply the templates now
	--BANDIT: +2 Str, -2 Cha; HD +1 armor proficiencies, martial weapon proficiency. Power Attack;
	if choice == "bandit" then
--		e:learnTalent(e.POWER_ATTACK, true)
--		e:learnTalent(e.MARTIAL_WEAPON_PROFICIENCY, true)
		e.challenge = e.challenge +2
		e.hit_die = e.hit_die +1
		e.special = "bandit"
	--OUTLAW: +2 Dex -2 Cha; HD +1, armor proficiencies; Dodge, Expertise, Deft Opportunist
	elseif choice == "outlaw" then
--	e:learnTalent(e.DODGE, true)
		e.challenge = e.challenge +1
		e.hit_die = e.hit_die +1
		e.special = "outlaw"
	--BRIGAND: +2 Dex -2 Cha +2 HD; armor proficiencies; Power Attack, Endurance
	elseif choice == "brigand" then
		e.challenge = e.challenge +1
		e.hit_die = e.hit_die +2
		e.special = "brigand"
	--CHIEFTAIN: +4 Str  +4 Con, +2 attack, Power Attack, Cleave, *2 HD
	--magic armor and weapons
	elseif choice == "chieftain" then
--		e:learnTalent(e.POWER_ATTACK, true)
--		e:learnTalent(e.CLEAVE, true)
		e.hit_die = e.hit_die*2
		e.combat_attack = e.combat_attack +2
		e.challenge = e.challenge +2
		e.special = "chieftain"
	--SHAMAN: +4 Wis +2 HD +2 CR; Combat Casting
	-- potions, wands
	elseif choice == "shaman" then
		--e:learnTalent(e.COMBAT_CASTING, true)
		e.hit_die = e.hit_die +2
		e.challenge = e.challenge +2
		e.special = "shaman"
	--SKILLED: +1 to all attributes, +1 HD, +1 attack, +1 CR
	elseif choice == "skilled" then
		e.hit_die = e.hit_die +1
		e.combat_attack = e.combat_attack +1
		e.challenge = e.challenge +1
		e.special = "skilled"
	--EXPERIENCED: +2 to all attributes, +2 attack +2 HD
	elseif choice == "experienced" then
		e.combat_attack = e.combat_attack +2
		e.challenge = e.challenge +2
		e.hit_die = e.hit_die +2
		e.special = "experienced"
	--VETERAN: +2 Str +3 other attributes, +4 attack +4 HD
	elseif choice == "veteran" then
		e.challenge = e.challenge +4
		e.combat_attack = e.combat_attack +4
		e.hit_die = e.hit_die +4
		e.special = "veteran"
	--ELITE: +2 Str +4 other attributes; +6 attack +8 HD
	elseif choice == "elite" then
		e.challenge = e.challenge +5
		e.combat_attack = e.combat_attack +6
		e.hit_die = e.hit_die +8
		e.special = "elite"
	--MASTER: +2 Str +4 other attributes; +8 attack +12 HD
	elseif choice == "master" then
		e.challenge = e.challenge +7
		e.combat_attack = e.combat_attack +8
		e.hit_die = e.hit_die +12
		e.special = "master"
	--PARAGON: +2 Str +4 other attributes; +10 attack +15 HD
	elseif choice == "paragon" then
		e.challenge = e.challenge +9
		e.combat_attack = e.combat_attack +10
		e.hit_die = e.hit_die +15
		e.special = "paragon"
	--LEGENDARY: +2 Str +4 other attributes; +14 attack +20 HD
	elseif choice == "legendary" then
		e.challenge = e.challenge +12
		e.combat_attack = e.combat_attack +14
		e.hit_die = e.hit_die +20
		e.special = "legendary"
	end

end

--Based on Incursion
function resolvers.dragon_agecategory()
	return {__resolver="dragon_agecategory", __resolve_last=true}
end

function resolvers.calc.dragon_agecategory(t, e)
	local choice
	local cr_boost = 0

	if rng.chance(2) then
		choice = "very young"
		cr_boost = 2
	elseif rng.chance(4) then
		choice = "young"
		cr_boost = 3
	elseif rng.chance(6) then
		choice = "juvenile"
		cr_boost = 4
	elseif rng.chance(8) then
		choice = "young adult"
		cr_boost = 6
	elseif rng.chance(10) then
		choice = "adult"
		cr_boost = 8
	--logical consequence of Inc's templates
	elseif rng.chance(14) then
		choice = "mature adult"
		cr_boost = 10
	elseif rng.chance(16) then
		choice = "old"
		cr_boost = 12
	elseif rng.chance(20) then
		choice = "very old"
		cr_boost = 14
	elseif rng.chance(24) then
		choice = "ancient"
		cr_boost = 16
	elseif rng.chance(30) then
		choice = "wyrm"
		cr_boost = 20
	elseif rng.chance(35) then
		choice = "great wyrm"
		cr_boost = 22
	--we do nothing
	else
		choice = "hatchling"
		cr_boost = 0
	end

	--safety check
	if game.zone.max_cr then
		if e.challenge + cr_boost > game.zone.max_cr + game:getDunDepth() then
			choice = "hatchling"
		end
	end

	if choice == "hatchling" then
	--do nothing
	elseif choice == "very young" then
		e.challenge = e.challenge + 2
		e.hit_die = e.hit_die + 3
		e.combat.dam = {1, 6}
		--Power Attack
	elseif choice == "young" then
		e.challenge = e.challenge + 3
		e.hit_die = e.hit_die + 6
		e.combat.dam = {1, 8}
		--Power Attack
	elseif choice == "juvenile" then
		e.challenge = e.challenge + 4
		e.hit_die = e.hit_die + 9
		e.combat.dam = {1, 8}
		--Power Attack, Rend
	elseif choice == "young adult" then
	--	e.image =  adult
		e.challenge = e.challenge + 6
		e.hit_die = e.hit_die + 12
		e.combat.dam = {2, 6}
		--Power Attack, Rend
		--frightful presence DC 21
	elseif choice == "adult" then
		--	e.image =  adult
		e.challenge = e.challenge + 8
		e.hit_die = e.hit_die + 15
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 24
	elseif choice == "mature adult" then
		--	e.image =  adult
		e.challenge = e.challenge + 10
		e.hit_die = e.hit_die + 18
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 26
	elseif choice == "old" then
		--	e.image =  adult
		e.challenge = e.challenge + 12
		e.hit_die = e.hit_die + 21
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 29
	elseif choice == "very old" then
		--	e.image =  adult
		e.challenge = e.challenge + 14
		e.hit_die = e.hit_die + 24
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 31
	elseif choice == "ancient" then
		--	e.image =  adult
		e.challenge = e.challenge + 16
		e.hit_die = e.hit_die + 27
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 34
	elseif choice == "wyrm" then
		--	e.image =  adult
		e.challenge = e.challenge + 18
		e.hit_die = e.hit_die + 30
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 35
	elseif choice == "great wyrm" then
		--	e.image =  adult
		e.challenge = e.challenge + 20
		e.hit_die = e.hit_die + 33
		e.combat.dam = {2, 8}
		--Power Attack, Rend
		--frightful presence DC 38
	end

	--append the age to the dragon name
	e.name = choice.." "..e.name
	--set the age category
	e.age_cat = choice
end


--[[	--CURATE: +4 CR; +2 Str +2 Con +4 Int +3 Wis +6; AC +2 attack +3 HD +4; armor proficiencies, Combat Casting, Power Attack, turn undead (Clr5)
	elseif rng.chance(15) then
		--feats go here
		e.challenge = e.challenge + 4
		e.hit_die = e.hit_die +4
		e.combat_attack = e.combat_attack + 3
		e.combat_untyped = e.combat_untyped +2
		e.special = "curate"]]
