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
