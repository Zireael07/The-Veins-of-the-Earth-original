-- $Id: AttackType.lua 37 2012-08-27 04:37:57Z dsb $
-- ToME - Tales of Middle-Earth
-- Copyright (C) 2012 Scott Bigham
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
--
-- Scott Bigham "Zizzo"
-- dsb-tome@killerbbunnies.org

require 'engine.class'
local DamageType = require 'engine.DamageType'

module(..., package.seeall, class.make)

_M.atk_type_def = {}
_M.atk_method_def = {}

function _M:loadDefinition(file)
  local f, err = loadfile(file)
  if not f and err then error(err) end
  setfenv(f, setmetatable({
    AttackType = _M,
    newAttackType = function(t) self:newAttackType(t) end,
    newAttackMethod = function(t) self:newAttackMethod(t) end,
  }, {__index=_G}))
  f()
end

function _M:newAttackType(t)
  assert(t.id, 'no attack type id')
  t.power = t.power or 0
  table.insert(self.atk_type_def, t)
  self[t.id] = #self.atk_type_def
end

function _M:get(id)
  assert(self.atk_type_def[id], 'attack type '..tostring(id)..' used but not defined')
  return self.atk_type_def[id]
end

-- We split this out so that Player can use this for monster-style attacks
-- for Possessors (TODO).
function _M:monAttackTarget(src, target, p)
  local type = p.type or DamageType.PHYSICAL
  local dt = DamageType:get(type)
  local mthd = self:get(p.method)

  if not dt or src:checkHit(target, dt.power) then
    local dam = p.dam and rng.dice(p.dam[1], p.dam[2]) or 0
    dt.projector(src, target.x, target.y, type, dam, {atk_msg = mthd.msg, silent_0dam=not p.dam})
  elseif not mthd.silent_miss then
    game.logSeen(target, '%s misses %s.', src.name, target.name)
  end
end
