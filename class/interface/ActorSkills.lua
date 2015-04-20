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
	local stat_for_skill = { appraise = "int", balance = "dex", bluff = "cha", climb = "str", concentration = "int", craft = "int", diplomacy = "cha", disabledevice = "int", decipherscript = "int", escapeartist = "dex", handleanimal = "wis", heal = "wis", hide = "dex", intimidate = "cha", intuition = "int", jump = "str", knowledge = "wis", listen = "wis", movesilently = "dex", openlock = "dex", pickpocket = "dex", ride = "dex", search = "int", sensemotive = "wis", swim = "str", spellcraft = "int", spot = "wis", survival = "wis", tumble = "dex", usemagic = "int" }
	if (not skill) then return 0 end
	local penalty_for_skill = { appraise = "no", balance = "yes", bluff = "no", climb = "yes", concentration = "no", craft = "no", diplomacy = "no", disabledevice = "no", decipherscript = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "no", jump = "yes", knowledge = "no", listen = "no", movesilently = "yes", openlock = "no", pickpocket = "yes", ride = "no", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "no" }

	local check = (self:attr("skill_"..skill) or 0) + (self:attr("skill_bonus_"..skill) or 0) + math.floor((self:getStat(stat_for_skill[skill])-10)/2)

	if penalty_for_skill[skill] == "no" then return check end

	if penalty_for_skill[skill] == "yes" then
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
