--Veins of the Earth
--Zireael 2015

require 'engine.class'

--Handle actor skills
module(..., package.seeall, class.make)

_M.skill_defs = {}

function _M:loadDefinition(file, env)
	local f, err = loadfile(file)
	if not f and err then error(err) end
	setfenv(f, setmetatable(env or {
		newSkill = function(t) self:newSkill(t) end,
		load = function(f) self:loadDefinition(f, getfenv(2)) end
	}, {__index=_G}))
	f()
end

function _M:newSkill(t)
    assert(t.name, "no skill name")
    t.id = t.id or t.name:gsub("[ ]", "_")
    assert(t.desc, "no skill desc")
    t.stat = t.stat or "str"
    t.penalty = t.penalty or "no"
	t.background = t.background or false

    self.skill_defs[t.name] = t
	self.skill_defs[#self.skill_defs+1] = t

end

function _M:init(t)
    for i, s in ipairs(_M.skill_defs) do
        self["skill_"..s.id] = 0
        self["skill_bonus_"..s.id] = 0
    end
end

--Skill checks, Zireael
function _M:getSkill(skill)
	if (not skill) then return 0 end

	local penalty_for_skill = { appraise = "no", balance = "yes", bluff = "no", climb = "yes", concentration = "no", craft = "no", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "yes", handle_animal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "no", jump = "yes", knowledge = "no", listen = "no", move_silently = "yes", open_lock = "no", pick_pocket = "yes", ride = "no", search = "no", sense_motive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", use_magic = "no" }

	local check = (self:attr("skill_"..skill) or 0) + (self:attr("skill_bonus_"..skill) or 0) + self:getSkillMod(skill)

	if not self:isSkillPenalty(skill) then return check end

	if self:isSkillPenalty(skill) then
		if self:knowTalent(self.T_ARMOR_OPTIMISATION) and self:attr("armor_penalty") then
			return check - (self:attr("armor_penalty")/3 or 0) - (self:attr("load_penalty") or 0) --end
		else
		return check - (self:attr("armor_penalty") or 0) - (self:attr("load_penalty") or 0) end
	end

end

function _M:skillCheck(skill, dc, silent)
	local success = false

	local d = rng.dice(1,20)
	local result = d + (self:getSkill(skill) or 0)

	if d == 20 then success = true
	elseif d == 1 then success = false
	else success = result > dc end

	--Limit logging to the player
	if not silent and self == game.player then
		local who = self:getName()
		local s = ("%s check for %s: dice roll %d + bonus %d = %d vs DC %d -> %s"):format(
			skill:capitalize(), who, d, self:getSkill(skill) or 0, result, dc, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end

	--XP prize
	if success then
		if self:crossClass(skill) then
			self:gainExp(5)
		else
			self:gainExp(10)
		end
	end

	return success
end

function _M:opposedCheck(skill1, target, skill2)
	local success = false

	local my_skill = self:getSkill(skill1)
	local enemy_skill = target:getSkill(skill2)
	local d = rng.dice(1,20)
	local d2 = rng.dice(1,20)
	local enemy_total = d2 + (enemy_skill or 0)
	local my_total = d + (my_skill or 0)

	if d + (my_skill or 0) > enemy_total then success = true end

	if self == game.player then
		local s = ("Opposed check: dice roll %d + bonus %d versus DC %d -> %s"):format(
			d, my_skill or 0, enemy_total, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end
	if target == game.player then
		local player_success = true
		if success then player_success = false end
		local s = ("Opposed check for the monster: %d versus DC %d -> player %s"):format(
			my_total, enemy_total, player_success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end

	return success
end

--Separate function b/c no roll and different logging
function _M:takeTen(skill, dc, silent)
	local success = false

	local result = 10 + (self:getSkill(skill) or 0)

	--Limit logging to the player
	if not silent and self == game.player then
		local who = self:getName()
		local s = ("%s check for %s: 10 + bonus %d = %d vs DC %d -> %s"):format(
			skill:capitalize(), who, self:getSkill(skill) or 0, result, dc, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end

	return success
end


function _M:staggeredCheck(skill, dc1, dc2, dc3)
	local success = false

	local d = rng.dice(1,20)
	local result = d + (self:getSkill(skill) or 0)

	if result > target3 then success = true ---do stuff
	elseif result > target2 then success = true ---do stuff
	elseif result > target1 then success = true ---do stuff
	end

	--Limit logging to the player
	if not silent and self == game.player then
		local who = self:getName()
		local s = ("%s check for %s: dice roll %d + bonus %d = %d vs DC %d -> %s"):format(
			skill:capitalize(), who, d, self:getSkill(skill) or 0, result, dc, success and "#GREEN#success#LAST#" or "#RED#failure#LAST#")
		game.log(s)
	end

	--XP prize
	if success then
		if self:crossClass(skill) then
			self:gainExp(10)
		else
			self:gainExp(20)
		end
	end
end

function _M:getSkillMod(skill)
	local stat_for_skill = {}
	for i, s in ipairs(_M.skill_defs) do
		stat_for_skill[s.id] = s.stat
	end

	if not stat_for_skill[skill] or stat_for_skill[skill] == nil then
		game.log("Invalid skill "..skill.." requested, no stat")
		return 0
	else
		return math.floor((self:getStat(stat_for_skill[skill])-10)/2)
	end
end

function _M:isSkillPenalty(skill)
	local penalty_for_skill = {}
	for i, s in ipairs(_M.skill_defs) do
		penalty_for_skill[s.id] = s.penalty
	end

	return penalty_for_skill[skill] == "yes" and true or false
end

--Cross-class skills, Zireael
function _M:crossClass(skill, class)
	if (not skill) then return nil end

	--List class skills for every class
	local c_barbarian = { appraise = "no", balance = "no", bluff = "no", climb = "yes", concentration = "no", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "yes", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "yes", search = "no", sense_motive = "no", spot = "yes", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", use_magic = "no" }
	local c_bard = { appraise = "yes", balance = "yes", bluff = "yes", climb = "yes", concentration = "yes", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "yes", escape_artist = "yes", handle_animal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", move_silently = "yes", open_lock = "no", pick_pocket = "yes", ride = "no", search = "no", sense_motive = "yes", spot = "no", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "yes", use_magic = "yes" }
	local c_cleric = { appraise = "no", balance = "no", bluff = "no", climb = "no", concentration = "yes", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "no", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "no", search = "no", sense_motive = "no", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", use_magic = "no" }
	local c_druid = { appraise = "no", balance = "no", bluff = "no", climb = "no", concentration = "yes", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "yes", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "yes", search = "no", sense_motive = "no", spot = "yes", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "no", use_magic = "no" }
	local c_fighter = { appraise = "no", balance = "no", bluff = "no", climb = "yes", concentration = "no", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "yes", search = "no", sense_motive = "no", spot = "yes", swim = "yes", spellcraft = "no", survival = "no", tumble = "no", use_magic = "no" }
	local c_monk = { appraise = "no", balance = "yes", bluff = "no", climb = "yes", concentration = "no", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "no", escape_artist = "yes", handle_animal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", move_silently = "yes", open_lock = "no", pick_pocket = "no", ride = "no", search = "no", sense_motive = "yes", spot = "yes", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", use_magic = "no" }
	local c_paladin = { appraise = "no", balance = "no", bluff = "no", climb = "no", concentration = "yes", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "yes", search = "no", sense_motive = "yes", spot = "no", swim = "no", spellcraft = "no", survival = "no", tumble = "no", use_magic = "no" }
	local c_ranger = { appraise = "no", balance = "no", bluff = "no", climb = "yes", concentration = "yes", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "yes", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", move_silently = "yes", open_lock = "no", pick_pocket = "no", ride = "yes", search = "yes", sense_motive = "no", spot = "yes", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", use_magic = "no" }
	local c_rogue = { appraise = "yes", balance = "yes", bluff = "yes", climb = "yes", concentration = "no", craft = "yes", diplomacy = "yes", disable_device = "yes", decipher_script = "yes", escape_artist = "yes", handle_animal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", move_silently = "yes", open_lock = "yes", pick_pocket = "yes", ride = "no", search = "yes", sense_motive = "yes", spot = "yes", swim = "no", spellcraft = "no", survival = "no", tumble = "yes", use_magic = "yes" }
	local c_sorcerer = { appraise = "no", balance = "no", bluff = "yes", climb = "no", concentration = "yes", craft = "yes", diplomacy = "yes", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "no", search = "no", sense_motive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", use_magic = "no" }
	local c_wizard = { appraise = "no", balance = "no", bluff = "no", climb = "no", concentration = "yes", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "no", search = "no", sense_motive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", use_magic = "no" }
	local c_warlock = { appraise = "no", balance = "no", bluff = "no", climb = "no", concentration = "yes", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "no", search = "no", sense_motive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", use_magic = "no" }
	local c_magus = { appraise = "yes", balance = "no", bluff = "no", climb = "yes", concentration = "yes", craft = "yes", diplomacy = "no", disable_device = "no", decipher_script = "no", escape_artist = "no", handle_animal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", move_silently = "no", open_lock = "no", pick_pocket = "no", ride = "yes", search = "no", sense_motive = "no", spot = "yes", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "no", use_magic = "yes" }

	local what
	if class then what = class end
	if self.last_class then what = self.last_class end

	if what == "Barbarian" and c_barbarian[skill] == "no" then return true end
	if what == "Bard" and c_bard[skill] == "no" then return true end
	if what == "Cleric" and c_cleric[skill] == "no" then return true end
	if what == "Druid" and c_druid[skill] == "no" then return true end
	if what == "Fighter" and c_fighter[skill] == "no" then return true end
	if what == "Monk" and c_monk[skill] == "no" then return true end
	if what == "Paladin" and c_paladin[skill] == "no" then return true end
	if what == "Ranger" and c_ranger[skill] == "no" then return true end
	if what == "Rogue" and c_rogue[skill] == "no" then return true end
	if what == "Sorcerer" and c_sorcerer[skill] == "no" then return true end
	if what == "Wizard" and c_wizard[skill] == "no" then return true end
	--Non-standard classes
	if what == "Warlock" and c_warlock[skill] == "no" then return true end
	if what == "Shaman" and c_cleric[skill] == "no" then return true end
	if what == "Magus" and c_magus[skill] == "no" then return true end
	--Prestige classes
	if what == "Shadowdancer" and c_rogue[skill] == "no" then return true end
	if what == "Assassin" and c_rogue[skill] == "no" then return true end
	if what == "Loremaster" and c_wizard[skill] == "no" then return true end
	if what == "Archmage" and c_wizard[skill] == "no" then return true end
	if what == "Blackguard" and c_paladin[skill] == "no" then return true end
	if what == "Arcane archer" and c_ranger[skill] == "no" then return true end

--[[	if self.last_class and self.last_class == "Barbarian" and c_barbarian[skill] == "no" then return true end
	if self.last_class and self.last_class == "Bard" and c_bard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Cleric" and c_cleric[skill] == "no" then return true end
	if self.last_class and self.last_class == "Druid" and c_druid[skill] == "no" then return true end
	if self.last_class and self.last_class == "Fighter" and c_fighter[skill] == "no" then return true end
	if self.last_class and self.last_class == "Monk" and c_monk[skill] == "no" then return true end
	if self.last_class and self.last_class == "Paladin" and c_paladin[skill] == "no" then return true end
	if self.last_class and self.last_class == "Ranger" and c_ranger[skill] == "no" then return true end
	if self.last_class and self.last_class == "Rogue" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Sorcerer" and c_sorcerer[skill] == "no" then return true end
	if self.last_class and self.last_class == "Wizard" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Warlock" and c_warlock[skill] == "no" then return true end
	if self.last_class and self.last_class == "Shaman" and c_cleric[skill] == "no" then return true end
	if self.last_class and self.last_class == "Shadowdancer" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Assassin" and c_rogue[skill] == "no" then return true end
	if self.last_class and self.last_class == "Loremaster" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Archmage" and c_wizard[skill] == "no" then return true end
	if self.last_class and self.last_class == "Blackguard" and c_paladin[skill] == "no" then return true end
	if self.last_class and self.last_class == "Arcane archer" and c_ranger[skill] == "no" then return true end
]]

	return false
end



function _M:isClassSkill(self, class)
	local classed_skills = {}
	for i, s in ipairs(_M.skill_defs) do
		local skill = s.id
		if not self:crossClass(skill, class) then
			classed_skills[skill] = "yes"
		else
			classed_skills[skill] = "no"
		end

		return classed_skills[skill] == "yes" and true or false
	end

end

function _M:getClassSkills(self, class)
	list = {}
	for i, s in ipairs(_M.skill_defs) do
		local skill = s.id
		if not self:crossClass(skill, class) then
	--	if self:isClassSkill(self, class) then
			list[#list+1] = skill
		else end
	end
	return list
end
