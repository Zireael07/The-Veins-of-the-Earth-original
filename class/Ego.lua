--Veins of the Earth
--Zireael 2014-2015

--based on Zizzo's ToME 2 port

require 'engine.class'
local Entity = require 'engine.Entity'
local Zone = require 'mod.class.Zone'

module(..., package.seeall, class.inherit(Entity))

_M.egos_def = {}

-- - 'good' can be true for only good egos, false for only cursed egos, or
--   nil for both.
-- - 'side' can be 'prefix' or 'suffix' for only the corresponding egos, or
--   nil for both.  If specified, it will ignore whether the object already
--   has prefix/suffix egos.
-- Static
function _M:allowedEgosFor(o, good, side)
  if o.unique then return {} end
  local ret = {}

  local ok = false

    --TO DO: Get the ego list for a base item ala ToME 4

    --Needs to be in the list
--[[   if egos then
        for _, e in ipairs(list) do
            local ok = true

            --check goodness
            ok = ok and (good == nil or good)
            if side then
                --check side
                ok = ok and e[side]
            elseif o.ego_names then
            -- ...or, if we didn't specify a side, the object already has an ego
            -- on this ego's side.
            if o.ego_names.prefix then ok = ok and not e.prefix end
            if o.ego_names.suffix then ok = ok and not e.suffix end
        end
    end]]

	if not o.egos then return {} end
	self.egos_def = self:loadList(o.egos, true)

    for _, e in ipairs(self.egos_def) do
    local ok = true

    -- ... or it doesn't match the requested "goodness" or side...
--    ok = ok and (good == nil or (good and e.cost > 0 or e.cost <= 0))
    if side then
      ok = ok and e[side]
    elseif o.ego_names then
      -- ...or, if we didn't specify a side, the object already has an ego
      -- on this ego's side.
      if o.ego_names.prefix then ok = ok and not e.prefix end
      if o.ego_names.suffix then ok = ok and not e.suffix end
    end

    if ok then table.insert(ret, e) end
  end
  return ret
end

--[[function _M:tryAddEgos(o, good, pass2)
    if o.force_ego then
    -- Slight Hack(TM) to save ourselves some time.
    self:placeForcedEgos(o)
    return
  end

  -- If we've already got prefix and suffix egos, we can't add any more.
  if o.ego_names and o.ego_names.prefix and o.ego_names.suffix then return end

  local cands = self:allowedEgosFor(o, good)

  for _ = 1, 10*#cands do
    local e = rng.table(cands)
    -- Loosely enforce minimum ego depth
 --   local ok = e.level <= level or rng.chance(e.level - level)
    -- Check rarity
   local mr = e.rarity[2]
    mr = mr - game.player:getLuckScale(-math.floor(mr/2), math.floor(mr/2))
    ok = ok and rng.range(1, mr) >= e.rarity[1]


    if ok then
      -- We set the names here; after the parent Object:resolve() is done,
      -- we'll come back behind it and apply the the egos we named here,
      -- which may need to do some of their own resolve()'ing.
      o.ego_names = o.ego_names or {}
      o.ego_names[e.prefix and 'prefix' or 'suffix'] = e.define_as
      break
    end
  end

    -- Small chance of double ego.
  if not pass2 and rng.percent(7 + game.player:getLuck()) then
    self:tryAddEgos(o, good, true)
  end

end]]

function _M:placeForcedEgos(e)
    if not e.force_ego then return end
    if type(e.force_ego) == 'string' then e.force_ego = { e.force_ego } end

    for ie, ego in ipairs(e.force_ego) do
        Zone:applyEgo(e, self.egos_def[ego])
    end
    -- Re-resolve with the (possibly) new resolvers
    e:resolve()
end

-- Static.
function _M:resolveEgos(o, last)
  -- Only copy stuff out of the ego entity on the first pass.
  if not last then
    for _, id in pairs(o.ego_names or {}) do
      local e = self.egos_def[id]
      if not e then
    print('[EGO] no such ego '..id)
      else
    for _, grp in ipairs(e.resolve_data) do
      if rng.percent(grp[1]) then
        table.mergeAddAppendArray(o, grp[2], true)
      end
    end
    table.mergeAddAppendArray(o, e.resolve_data.all or {}, true)
--[[    for k, v in pairs(e.resolve_data.bonus or {}) do
      if v ~= 0 then
        o[k] = (o[k] or 0) + rng.range(1, math.abs(v)) * (v < 0 and -1 or 1)
      end
    end]]

    o.egoed = true

--    if e.rating then o.rating = (o.rating or 0) + e.rating end
      end
    end
  end
  -- Resolve any resolvers we just added.
  o:resolve(nil, last)
end

--New functions (Zireael)
--Get list of all egos, no frills, no separating into prefixes/affixes unlike CreateItem
function _M:generateEgoList(o)
    local list = {}

    game.log("Generating ego list for "..o.name)

    --hackfix for the fact that o has no egos
    --NOTE: relies on zone list therefore will differ by zone
    --NOTE: doesn't work for items whose name doesn't equal base name due to e.g. resolvers
    for i, e in ipairs(game.zone.object_list) do
        if e.name and e.rarity then
            if e.name == o.name then
                o.egos = e.egos
            end
        end
    end

    local object = o

    for id, ego in ipairs(self:allowedEgosFor(object)) do

        list[#list+1] = { name = ego.name, id=id, desc = "", ego=ego }
    end

    list_choices = list
    return list_choices
end

function _M:generateItemCreationEgos(o)
    local list = {}
    local base_list = self:generateEgoList(o)

    for i, ego in ipairs(base_list) do
        local name = ego.name
        local color
        local desc = ""
    --    game.log("Ego: "..ego.name)

        --check that it is craftable (has defined costs)
    --[[    if ego and ego.creation and ego.creation.gold_cost and ego.creation.xp_cost then
            local gold_cost = ego.creation.gold_cost
            local xp_cost = ego.creation.xp_cost

            game.log("Approved egos:"..ego.name)
            --color-code
            if (game.player.money or 0) > gold_cost then color = {255, 255, 255}
            else color = {255, 215, 0} desc = "Not enough gold" end
            if (game.player.exp or 0) > xp_cost then color = {255, 255, 255}
            else color = {81, 221, 255} desc = "Not enough XP" end]]

            --don't show egos we already have
            if not game.zone:getEgoByName(o, name) then
                list[#list+1] = { name = name, color=color, id=id, desc = desc, ego=ego }
            end
    --    end
    end

    list_choices = list
    return list_choices

end
