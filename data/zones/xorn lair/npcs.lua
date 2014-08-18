-- Veins of the Earth
-- Zireael 2014
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


load("/data/general/npcs/humanoid.lua")
load("/data/general/npcs/monstrous_humanoid.lua")

load("/data/general/npcs/vermin.lua")

load("/data/general/npcs/aberration.lua")
load("/data/general/npcs/construct.lua")

load("/data/general/npcs/elementals.lua")

load("/data/general/npcs/ooze.lua")

load("/data/general/npcs/outsider_evil.lua")
load("/data/general/npcs/outsider_good.lua")

load("/data/general/npcs/outsider_air.lua")
load("/data/general/npcs/outsider_fire.lua")
load("/data/general/npcs/outsider_earth.lua")

--This part is copied from default xorns
newEntity{
    define_as = "BASE_NPC_XORN_TUNNELER",
    type = "outsider", subtype = "earth",
    image = "tiles/elemental.png",
    display = 'O', color=colors.LIGHT_BROWN,
    body = { INVEN = 10 },
    desc = [[An earthen creature.]],
    uncommon_desc = [[Xorns are immune to cold and fire, and they are resistant to electricity. There are several different shapes and sizes of xorns. Some grow to tremendous size and are known as elder xorns. Xorns ignore most creatures (since they cannot digest meat), unless they carry substantial amounts of metal or stone on them.]],
    common_desc = [[Xorns have all-around vision and can glide through earth and stone as if they were swimming -- they do not leave behind any trace of their passage. Xorns can sense the presence of creatures by the small tremors they produce on the ground.]],
    base_desc = [[This bizarre creature is a xorn, a native of the Elemental Plane of Earth. It can see in the dark and cannot be brought back to life by usual means. It can burrow through rock and earth.]],

--    ai = "dumb_talented_simple", ai_state = { talent_in=3, },
    stats = { str=15, dex=10, con=15, int=10, wis=11, cha=10, luc=10 },
    combat = { dam= {2,8} },
--    rarity = 15,
    infravision = 4,
    combat_dr = 5,
    skill_hide = 10,
    alignment = "neutral",
    resists = { [DamageType.ELECTRIC] = 10, },
}

--First part copied, now let's get the ball rolling!
newEntity{ define_as = "XORN_TUNNELER",
    base = "BASE_NPC_XORN_TUNNELER",
    name = "xorn tunneler",
    level_range = {5, nil}, exp_worth = 0,
--    rarity = 15,
    --for testing purposes
    max_life = 1000,
    hit_die = 3,
    challenge = 3,
    combat_natural = 13,
    skill_intimidate = 3,
    skill_knowledge = 6,
    skill_listen = 6,
    skill_movesilently = 3,
    skill_search = 6,
    skill_survival = 6,
    skill_spot = 8,  

    ai = "xorn_tunneler", ai_state = {},
    never_anger = true,
    invulnerable = 1,
    faction = "neutral",
}