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
