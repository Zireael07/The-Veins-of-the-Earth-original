--Veins of the Earth
--Zireael 2015

require 'engine.class'

--Handle actor skills
module(..., package.seeall, class.make)

--what it says on the tin
function _M:domainSelection(actor)
    --Domain selection
    if actor:hasDescriptor{deity="Aiswin"} then
    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Night", desc=""},
    {name="Planning", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Night" then end
        if result == "Planning" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Asherath"} then
     game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Night", desc=""},
    {name="Planning", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Night" then end
        if result == "Planning" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Ekliazeh"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Craft", desc=""},
    {name="Community", desc=""},
    {name="Earth", desc=""},
    {name="Law", desc=""},
    {name="Strength", desc=""},
    {name="Protection", desc=""},
    },
    function(result)
        if result == "Craft" then end
        if result == "Community" then end
        if result == "Earth" then end
        if result == "Law" then end
        if result == "Strength" then end
        if result == "Protection" then end
    end))

    end

    if actor:hasDescriptor{deity="Erich"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Domination", desc=""},
    {name="Guardian", desc=""},
    {name="Law", desc=""},
    {name="Nobility", desc=""},
    {name="Protection", desc=""},
    {name="War", desc=""},
    },
    function(result)
        if result == "Domination" then end
        if result == "Guardian" then end
        if result == "Law" then end
        if result == "Nobility" then end
        if result == "Protection" then end
        if result == "War" then end
    end))

    end

    if actor:hasDescriptor{deity="Essiah"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Good", desc=""},
    {name="Liberation", desc=""},
    {name="Luck", desc=""},
    {name="Passion", desc=""},
    {name="Travel", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Good" then end
        if result == "Liberation" then end
        if result == "Luck" then end
        if result == "Passion" then end
        if result == "Travel" then end
    end))

    end

    if actor:hasDescriptor{deity="Hesani"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Healing", desc=""},
    {name="Magic", desc=""},
    {name="Succor", desc=""},
    {name="Sun", desc=""},
    {name="Weather", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Healing" then end
        if result == "Magic" then end
        if result == "Succor" then end
        if result == "Sun" then end
        if result == "Weather" then end
    end))
    end

    if actor:hasDescriptor{deity="Immotian"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Community", desc=""},
    {name="Fire", desc=""},
    {name="Knowledge", desc=""},
    {name="Law", desc=""},
    {name="Protection", desc=""},
    {name="Succor", desc=""},
    },
    function(result)
        if result == "Community" then end
        if result == "Fire" then end
        if result == "Knowledge" then end
        if result == "Law" then end
        if result == "Protection" then end
        if result == "Succor" then end
    end))

    end

    if actor:hasDescriptor{deity="Khasrach"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Destruction", desc=""},
    {name="Hatred", desc=""},
    {name="Mysticism", desc=""},
    {name="Strength", desc=""},
    {name="Pain", desc=""},
    {name="War", desc=""},
    },
    function(result)
        if result == "Destruction" then end
        if result == "Hatred" then end
        if result == "Mysticism" then end
        if result == "Strength" then end
        if result == "Pain" then end
        if result == "War" then end
    end))

    end

    if actor:hasDescriptor{deity="Kysul"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Good", desc=""},
    {name="Mysticism", desc=""},
    {name="Planning", desc=""},
    {name="Slime", desc=""},
    {name="Water", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Good" then end
        if result == "Mysticism" then end
        if result == "Planning" then end
        if result == "Slime" then end
        if result == "Water" then end
    end))

    end

    if actor:hasDescriptor{deity="Maeve"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Chaos", desc=""},
    {name="Domination", desc=""},
    {name="Magic", desc=""},
    {name="Moon", desc=""},
    {name="Nobility", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Chaos" then end
        if result == "Domination" then end
        if result == "Magic" then end
        if result == "Moon" then end
        if result == "Nobility" then end
    end))

    end

    if actor:hasDescriptor{deity="Mara"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Death", desc=""},
    {name="Good", desc=""},
    {name="Healing", desc=""},
    {name="Night", desc=""},
    {name="Succor", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Death" then end
        if result == "Good" then end
        if result == "Healing" then end
        if result == "Night" then end
        if result == "Succor" then end
    end))

    end

    if actor:hasDescriptor{deity="Sabin"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Air", desc=""},
    {name="Chaos", desc=""},
    {name="Destruction", desc=""},
    {name="Luck", desc=""},
    {name="Time", desc=""},
    {name="Weather", desc=""},
    },
    function(result)
        if result == "Air" then end
        if result == "Chaos" then end
        if result == "Destruction" then end
        if result == "Luck" then end
        if result == "Time" then end
        if result == "Weather" then end
    end))

    end

    if actor:hasDescriptor{deity="Semirath"} then
    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Chaos", desc=""},
    {name="Good", desc=""},
    {name="Liberation", desc=""},
    {name="Luck", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Chaos" then end
        if result == "Good" then end
        if result == "Liberation" then end
        if result == "Luck" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Multitude"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Blood", desc=""},
    {name="Chaos", desc=""},
    {name="Destruction", desc=""},
    {name="Death", desc=""},
    {name="Evil", desc=""},
    {name="Pain", desc=""},
    },
    function(result)
        if result == "Blood" then end
        if result == "Chaos" then end
        if result == "Destruction" then end
        if result == "Death" then end
        if result == "Evil" then end
        if result == "Pain" then end
    end))

    end

    if actor:hasDescriptor{deity="Xavias"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Craft", desc=""},
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Magic", desc=""},
    {name="Mysticism", desc=""},
    {name="Planning", desc=""},
    },
    function(result)
        if result == "Craft" then end
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Magic" then end
        if result == "Mysticism" then end
        if result == "Planning" then end
    end))

    end

    if actor:hasDescriptor{deity="Xel"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Community", desc=""},
    {name="Death", desc=""},
    {name="Evil", desc=""},
    {name="Pain", desc=""},
    {name="Nature", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Community" then end
        if result == "Death" then end
        if result == "Evil" then end
        if result == "Pain" then end
        if result == "Nature" then end
        if result == "Trickery" then end
    end))
    end

    if actor:hasDescriptor{deity="Zurvash"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Animal", desc=""},
    {name="Domination", desc=""},
    {name="Night", desc=""},
    {name="Passion", desc=""},
    {name="Pain", desc=""},
    {name="Strength", desc=""},
    },
    function(result)
        if result == "Animal" then end
        if result == "Domination" then end
        if result == "Night" then end
        if result == "Passion" then end
        if result == "Pain" then end
        if result == "Strength" then end
    end))

    end
end

--Metamagic stuff, Sebsebeleb
function useMetamagic(self, t)
	local metaMod = {}
	for tid, _ in pairs(self.talents) do
		local t = self:getTalentFromId(tid)
		local tt = self:getTalentTypeFrom(t)
		if tt == "arcane/metamagic" and self:isTalentActive(t.id) then
			for i,v in ipairs(t.getMod(self, t)) do
				metaMod[i] = (metaMod[i] and metaMod[i] + v) or v
			end
		end
	end
	return metaMod
end

--Spells & spellbook stuff, Sebsebeleb & DG & Zireael
--- The max charge worth you can have in a given spell level
function _M:getMaxMaxCharges(spell_list)
	local t = {}

    --Bonus spells tables
    --12-13
    local stat_bonus_one = {[1] = 1, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 }
    --14-15
    local stat_bonus_two = {[1] = 1, [2] = 1, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 }
    --16-17
    local stat_bonus_three = {[1] = 1, [2] = 1, [3] = 1, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 }
    --18-19
    local stat_bonus_four = {[1] = 1, [2] = 1, [3] = 1, [4] = 1, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0 }
    --20-21
    local stat_bonus_five = {[1] = 2, [2] = 1, [3] = 1, [4] = 1, [5] = 1, [6] = 0, [7] = 0, [8] = 0, [9] = 0 }
    --22-23
    local stat_bonus_six = {[1] = 2, [2] = 2, [3] = 1, [4] = 1, [5] = 1, [6] = 1, [7] = 0, [8] = 0, [9] = 0 }
    --24-25
    local stat_bonus_seven = {[1] = 2, [2] = 2, [3] = 2, [4] = 1, [5] = 1, [6] = 1, [7] = 1, [8] = 0, [9] = 0 }
    --26-27
    local stat_bonus_eight = {[1] = 2, [2] = 2, [3] = 2, [4] = 2, [5] = 1, [6] = 1, [7] = 1, [8] = 1, [9] = 0 }
    --28-29
    local stat_bonus_nine = {[1] = 3, [2] = 2, [3] = 2, [4] = 2, [5] = 2, [6] = 1, [7] = 1, [8] = 1, [9] = 1 }
    --30-31
    local stat_bonus_ten = {[1] = 3, [2] = 3, [3] = 2, [4] = 2, [5] = 2, [6] = 2, [7] = 1, [8] = 1, [9] = 1 }

	local l = self.level + 5
	while l > 5 do
        local spells = math.min(8, l)

		t[#t+1] = spells
        local spell_level = #t+1
		--We gain a new spell level every 3 character levels.
		l = l - 2

        --Account for bonus spells here, Zireael
        if (self.classes and self.classes["Wizard"] and self:getInt() >= 12)
        or (self.classes and self.classes["Ranger"] and self:getWis() >= 12)
        or (self.classes and self.classes["Cleric"] and self:getWis() >= 12)
        or (self.classes and self.classes["Bard"] and self:getCha() >= 12)
        then

            if (self.classes and self.classes["Wizard"] and self:getInt() < 14)
            or (self.classes and self.classes["Ranger"] and self:getWis() < 14)
            or (self.classes and self.classes["Cleric"] and self:getWis() < 14)
            or (self.classes and self.classes["Bard"] and self:getCha() < 14)
            then
                spells = spells + stat_bonus_one[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 14 and self:getInt() < 16)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 14 and self:getWis() < 16)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 14 and self:getWis() < 16)
            or (self.classes and self.classes["Bard"] and self:getCha() > 14 and self:getCha() < 16)
            then
                spells = spells + stat_bonus_two[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 16 and self:getInt() < 18)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 16 and self:getWis() < 18)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 16 and self:getWis() < 18)
            or (self.classes and self.classes["Bard"] and self:getCha() > 16 and self:getCha() < 18)
            then
                spells = spells + stat_bonus_three[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 18 and self:getInt() < 20)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 18 and self:getWis() < 20)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 18 and self:getWis() < 20)
            or (self.classes and self.classes["Bard"] and self:getCha() > 18 and self:getCha() < 20)
            then
                spells = spells + stat_bonus_four[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 20 and self:getInt() < 22)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 20 and self:getWis() < 22)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 20 and self:getWis() < 22)
            or (self.classes and self.classes["Bard"] and self:getCha() > 20 and self:getCha() < 22)
            then
                spells = spells + stat_bonus_five[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 22 and self:getInt() < 24)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 22 and self:getWis() < 24)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 22 and self:getWis() < 24)
            or (self.classes and self.classes["Bard"] and self:getCha() > 22 and self:getCha() < 24)
            then
                spells = spells + stat_bonus_six[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 24 and self:getInt() < 26)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 24 and self:getWis() < 26)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 24 and self:getWis() < 26)
            or (self.classes and self.classes["Bard"] and self:getCha() > 24 and self:getCha() < 26)
            then
                spells = spells + stat_bonus_seven[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 26 and self:getInt() < 28)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 26 and self:getWis() < 28)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 26 and self:getWis() < 28)
            or (self.classes and self.classes["Bard"] and self:getCha() > 26 and self:getCha() < 28)
            then
                spells = spells + stat_bonus_eight[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 28 and self:getInt() < 30)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 28 and self:getWis() < 30)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 28 and self:getWis() < 30)
            or (self.classes and self.classes["Bard"] and self:getCha() > 28 and self:getCha() < 30)
            then
                spells = spells + stat_bonus_nine[spell_level]
            end

            if (self.classes and self.classes["Wizard"] and self:getInt() > 30 and self:getInt() < 32)
            or (self.classes and self.classes["Ranger"] and self:getWis() > 30 and self:getWis() < 32)
            or (self.classes and self.classes["Cleric"] and self:getWis() > 30 and self:getWis() < 32)
            or (self.classes and self.classes["Bard"] and self:getCha() > 30 and self:getCha() < 32)
            then
                spells = spells + stat_bonus_ten[spell_level]
            end

        end

        --if class = cleric and spell_list = divine then set 1 additional spell (domain spell)
	end



    return t
end

function _M:getMaxCharges(tid)
	local t = self:getTalentFromId(tid)
	tid = t.id

	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		return self:getMaxMaxCharges()[t.level] or 0
	end
	return self.max_charges[tid] or 0
end

function _M:getCharges(tid)
	local t = self:getTalentFromId(tid)
	tid = t.id

	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		return self.charges[innatekind..t.level] or 0
	end
	return self.charges[tid] or 0
end

function _M:incMaxCharges(tid, v, spell_list)
	local tt
	local t
	if type(tid) == "table" then
		t = tid
		tt = tid.type[1]
		tid = tid.id
	else
		t = self:getTalentFromId(tid)
		tt = self:getTalentFromId(tid).type[1]
	end

	--Does the player have the spell slots for this level?
	if not self:getMaxMaxCharges()[t.level] then return end

    -- Disallow going below 0.
    v = math.max(-(self.max_charges[tid] or 0), v)

	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(spell_list, t.level)
	if a + v > self:getMaxMaxCharges()[t.level] then
		Dialog:simplePopup("Max spells reached", "You can't memorize more spells!")
		return end
	self.max_charges[tid] = (self.max_charges[tid] or 0) + v
	self:incAllocatedCharges(spell_list, t.level, v)
end


--- Set the number of prepared instances of a certain spell
function _M:setMaxCharges(tid, spell_list, v)

	local t
	if type(tid) == "table" then
		t = tid
		tid = tid.id
	else
		t = self:getTalentFromId(tid)
	end

	--Can the player have this many max charges for this type?
	local a = self:getAllocatedCharges(spell_list, tid.level)
	if a + v > self:getMaxMaxCharges()[tid.level] then return end
	self.max_charges[tid] = v
	self:setAllocatedCharges(spell_list, t.level, v)
end

--- Set the number of available instances of a certain spell
function _M:setCharges(tid, v)
	local t = self:getTalentFromId(tid)
	tid = t.id

	--Account for innate casting
	local cl, kind = self:casterLevel(t)
	local innatekind = "innate_casting_"..kind
	if self:attr(innatekind) then
		self.charges[innatekind..t.level] = v
	else
		self.charges[tid] = v
	end
end

--- Increase the number of available instances of a certain spell
function _M:incCharges(tid, v)
	if type(tid) == "table" then tid = tid.id end
	local new = (self:getCharges(tid) or 0) + v
	self:setCharges(tid, new)
end

function _M:getAllocatedCharges(spell_list, level)
	local c = self.allocated_charges[spell_list]
	c = c and c[level]
	return c or 0
end

function _M:setAllocatedCharges(spell_list, level, value)
	if not self.allocated_charges[spell_list] then self.allocated_charges[spell_list] = {} end
	if not self.allocated_charges[spell_list][level] then self.allocated_charges[spell_list][level] = {} end
	self.allocated_charges[spell_list][level] = value
end

function _M:incAllocatedCharges(spell_list, level, value)
	local c = self:getAllocatedCharges(spell_list, level)
	local val = c and (c + value) or value
	self:setAllocatedCharges(spell_list, level, val)
end

function _M:allocatedChargesReset()
	for k, v in pairs(self.max_charges) do
		self.max_charges[k] = 0
	end
	for k, v in pairs(self.charges) do
		self.charges[k] = 0
	end
	for k,v in pairs(self.allocated_charges) do
		for level, value in pairs(self.allocated_charges[k]) do
			self.allocated_charges[k][level] = 0
		end
	end
end

--DarkGod's useful functions
function _M:hasDescriptor(t)
	if not self.descriptor then return false end
	for k, v in pairs(t) do
		if self.descriptor[k] ~= v then return false end
	end
	return true
end

function _M:highestSpellDescriptor(what)
	local list = {}
	for tid, _ in pairs(self.talents) do
		local t = self:getTalentFromId(tid)
		if t.is_spell and t.descriptors and t.descriptors[what] and self:getCharges(t) > 0 then list[#list+1] = t end
	end
	if #list == 0 then return nil end
	table.sort(list, "level")
	return list[#list]
end

function _M:incCasterLevel(kind, v)
	self.caster_levels[kind] = self.caster_levels[kind] or 0
	self.caster_levels[kind] = self.caster_levels[kind] + v
end

function _M:casterLevel(kind)
	if type(kind) == "string" then
		if not self.caster_levels[kind] then return 0, "none" end
		return self.caster_levels[kind], kind
	else
		local t = self:getTalentFromId(kind)
		if not t.spell_kind then return 0, "none" end
		local max, kind = 0, "none"
		for k, _ in pairs(t.spell_kind) do
			max = math.max(max, (self:casterLevel(k)))
			kind = k
		end
		return max, kind
	end
end

function _M:spellIsKind(t, kind)
	if not t then return false end
	if not t.is_spell then return false end
	if not t.spell_kind[kind] then return false end
	return true
end
