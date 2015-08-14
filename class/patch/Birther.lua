--Veins of the Earth
--Zireael 2015

require 'engine.class'
local Birther = require 'engine.Birther'

module(..., package.seeall, class.inherit(Birther))

function _M:newBirthDescriptor(t)
	assert(t.name, "no birth name")
	assert(t.type, "no birth type")
	t.short_name = t.short_name or t.name
	t.short_name = t.short_name:upper():gsub("[ ]", "_")
	t.display_name = t.display_name or t.name
	assert(t.desc, "no birth description")

    --here's the patch
    -- Can pass a string, make it into a function
	if type(t.desc) == "string" then
		local infostr = t.desc
		t.desc = function() return infostr end
	end
    -- Remove line stat with tabs to be cleaner ..
	local desc = t.desc
	t.desc = function(self, t) return desc(self, t):gsub("\n\t+", "\n") end

	--stuff which should be in a separate class but can't for some reason
	t.learn_talent_types = function(actor, t)
		for k,v in pairs(t) do
			actor:learnTalentType(v)
		end
	end
	t.learn_all_spells_of_level = function(actor, kind, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, kind) and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
	end
    --end patch

--	if type(t.desc) == "table" then t.desc = table.concat(t.desc, "\n") end
--	t.desc = t.desc:gsub("\n\t+", "\n")
	t.descriptor_choices = t.descriptor_choices or {}

	table.insert(self.birth_descriptor_def, t)
	t.id = #self.birth_descriptor_def
	self.birth_descriptor_def[t.type] = self.birth_descriptor_def[t.type] or {}
	self.birth_descriptor_def[t.type][t.name] = t
	table.insert(self.birth_descriptor_def[t.type], t)
end
