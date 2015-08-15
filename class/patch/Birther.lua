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
--	if t.type == "class" then
		t.getDesc_class = function(self, t, desc, bab, special)
			local d
			if not special then special = "" end
			local skills = t.getSkillPoints(self, t)
			local skills_first = skills*4
			local bab = t.getBAB(self, t, bab)
			local skills_list = t.getClassSkills(self, t)
			local save_display_first = t.getSavesDisplay(self, t, 1)
			local save_display = t.getSavesDisplay(self, t, nil)
			local hp = t.getHitPoints(self, t)

			d = desc.."\n\n #LIGHT_BLUE#Class skills: "..skills_list.."#WHITE#\n\n"
			d = d..special.." "..hp.." hit points per level, BAB +"..bab..", "..save_display_first.." at first class level. "
			d = d..skills_first.." skill points at 1st character level.\n\n"
			d = d.."BAB +"..bab..", "..save_display.." "..skills.." skill points per level.\n\n"
			d = d.."#GOLD#STR 13#LAST# to multiclass to this class."

			return d
		end
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
	t.getBAB = function(self, t, progression)
		local Player = require "mod.class.Player"
		bab = Player.bab_to_number[progression]
		return bab
	end
	t.getSaveValues = function(self, t, level, progression)
		local Player = require "mod.class.Player"
		save = Player.save_to_number["other"][progression]
		if (level and level == 1) then save = Player.save_to_number["first"][progression] end
		return save
	end
	t.isGoodSave = function(self, t, save)
		local saves = t.getSaves(self, t)
		if saves[save] == "yes" then return true end
		return false
	end
	t.getSavesDisplay = function(self, t, level)
		local good_save = t.getSaveValues(self, t, nil, "good")
		local bad_save = t.getSaveValues(self, t, nil, "bad")
		local good_save_first = t.getSaveValues(self, t, 1, "good")

		local str = ""
		local saves = t.getSaves(self, t)

		if saves then
			for k, e in pairs(saves) do
			--	print("SAVES"..k.." "..e)
				if (level and level == 1) and t.isGoodSave(self, t, k) then
					str = str.." "..k.." +"..good_save_first
				end
				if not level then
					if t.isGoodSave(self, t, k) then
						str = str.." "..k.." +"..good_save
					else
						str = str.." "..k.." +"..bad_save
					end
				end
			end
		end

		return str
	end
--	end
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
