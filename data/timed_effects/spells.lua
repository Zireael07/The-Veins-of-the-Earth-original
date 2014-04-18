--Veins of the Earth
--Zireael 2013-2014

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Various spell effects

newEffect{
	name = "SLEEP",
	desc = "Sleeping",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# falls asleep!", "+Sleep" end,
	on_lose = function(self, err) return "#Target# wakes up.", "-Sleep" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("sleep", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("sleep", eff.tmpid)
	end,
}

newEffect{
	name = "CHARM",
	desc = "Charmed",
	type = "mental",
	status = "beneficial", --?
	on_gain = function(self, err) return "#Target# is charmed!", "+Charm" end,
	on_lose = function(self, err) return "#Target# regains free will.", "-Charm" end,
	activate = function(self, eff)
		--From Qi Daozei
		 -- Reset NPCs' targets.  Otherwise, they follow the player around
        -- like a puppy dog.
        for uid, e in pairs(game.level.entities) do
            print(e.name)
            if e.setTarget and e ~= game.player then
                e:setTarget(nil)
            end
        end
    end,
	deactivate = function(self, eff)
	end,
}

newEffect{
	name = "GHOUL_TOUCH",
	desc = "Ghouled",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is rotting!", "+Ghoul" end,
	on_lose = function(self, err) return "#Target# is no longer rotting.", "-Ghoul" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move", 1)
		--TO DO: Sicken in 2 sq radius
    end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end,
}

newEffect{
	name = "HOLD",
	desc = "Paralyzed",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is paralyzed!", "+Hold" end,
	on_lose = function(self, err) return "#Target# is no longer paralyzed.", "-Hold" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("never_move", 1)
    end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("never_move", eff.tmpid)
	end,
}


newEffect{
	name = "INVISIBLE",
	desc = "Invisible",
	type = "physical",
	status = "beneficial",
	parameters = { power=1 },
	on_gain = function(self, err) return "#Target# fades from sight!", "+Invisible" end,
	on_lose = function(self, err) return "#Target# reappears!", "-Invisible" end,
	activate = function(self, eff)
		eff.invis = self:addTemporaryValue("stealth", eff.power)
	--[[	if not self.shader then
			eff.set_shader = true
			self.shader = "invis_edge"
			self:removeAllMOs()
			game.level.map:updateMap(self.x, self.y)
		end]]
	end,
	deactivate = function(self, eff)
	--[[	if eff.set_shader then
			self.shader = nil
			self:removeAllMOs()
			game.level.map:updateMap(self.x, self.y)
		end]]
		self:removeTemporaryValue("stealth", eff.invis)
	end,
}

--Dummies so that concealment works
newEffect{
	name = "BLIND",
	desc = "Blinded",
	long_desc = [[The character cannot see. He takes a -2 penalty to Armor Class and loses his Dexterity bonus to AC (if any). 
		All opponents are considered to have total concealment (50% miss chance) to the blinded character.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# loses sight!", "+Blind" end,
	on_lose = function(self, err) return "#Target# regains sight.", "-Blind" end,

}

newEffect{
	name = "DARKNESS",
	desc = "In magical darkness",
	long_desc = [[The character cannot see. All opponents have partial concealment (20% miss chance).]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# loses sight!", "+Blind" end,
	on_lose = function(self, err) return "#Target# regains sight.", "-Blind" end,
}

newEffect{
	name = "FAERIE",
	desc = "Outlined",
	long_desc = [[The character is outlined by a magical ring of fire. All concealment except darkness spell is cancelled.]],
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is outlined!", "+Outline" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-Outline" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("faerie", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}

--Buff spells, Zireael
newEffect{
	name = "BEAR_ENDURANCE",
	desc = "Boost Con!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_CON]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_con", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_con", eff.increase)
	end,
}

newEffect{
	name = "BULL_STRENGTH",
	desc = "Boost Str!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_STR]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_str", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_str", eff.increase)
	end,
}

newEffect{
	name = "EAGLE_SPLENDOR",
	desc = "Boost Cha!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_CHA]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_cha", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_cha", eff.increase)
	end,
}

newEffect{
	name = "OWL_WISDOM",
	desc = "Boost Wis!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_WIS]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_wis", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_wis", eff.increase)
	end,
}

newEffect{
	name = "CAT_GRACE",
	desc = "Boost Dex!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_DEX]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_dex", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_dex", eff.increase)
	end
}

newEffect{
	name = "FOX_CUNNING",
	desc = "Boost Int!",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		local inc = { [Stats.STAT_INT]=4, }
		self:effectTemporaryValue(eff, "inc_stats", inc)
		eff.increase = self:addTemporaryValue("stat_increase_int", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stat_increase_int", eff.increase)
	end,
}

--Buff spell, Seb
newEffect{
	name = "MAGE_ARMOR",
	desc = "Mage Armor",
	type = "magical",
	status = "beneficial",
	on_gain = function(self, err) return "A field seems to surround #Target#", "+Mage Armor" end,
	on_lose = function(self, err) return "The field around #Target# seems to dissipate", "-Mage Armor" end,
	activate = function(self, eff)
		self:effectTemporaryValue(eff, "combat_armor_ac", 4)
	end,
}



--Modified ToME 4 code
newEffect{
	name = "FEAR",
	desc = "Panicked",
	type = "mental",
	subtype = { fear=true },
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# becomes panicked!", "+Panicked" end,
	on_lose = function(self, err) return "#Target# is no longer panicked", "-Panicked" end,
	activate = function(self, eff)
	end,
	deactivate = function(self, eff)
	end,
	do_act = function(self, eff)
		if not self:enoughEnergy() then return nil end
		if eff.source.dead then return true end

		-- apply periodic timer instead of random chance
		if not eff.timer then
			eff.timer = rng.float(0, 100)
		end
		if self:willSave(15) then
			eff.timer = eff.timer 
			game.logSeen(self, "%s struggles against the panic.", self.name:capitalize())
		else
			eff.timer = eff.timer + rng.float(0, 100)
		end
		if eff.timer > 100 then
			eff.timer = eff.timer - 100

			local distance = core.fov.distance(self.x, self.y, eff.source.x, eff.source.y)
			if distance <= eff.range then
				-- in range
				if not self:attr("never_move") then
					local sourceX, sourceY = eff.source.x, eff.source.y

					local bestX, bestY
					local bestDistance = 0
					local start = rng.range(0, 8)
					for i = start, start + 8 do
						local x = self.x + (i % 3) - 1
						local y = self.y + math.floor((i % 9) / 3) - 1

						if x ~= self.x or y ~= self.y then
							local distance = core.fov.distance(x, y, sourceX, sourceY)
							if distance > bestDistance
									and game.level.map:isBound(x, y)
									and not game.level.map:checkAllEntities(x, y, "block_move", self)
									and not game.level.map(x, y, Map.ACTOR) then
								bestDistance = distance
								bestX = x
								bestY = y
							end
						end
					end

					if bestX then
						self:move(bestX, bestY, false)
						game.logPlayer(self, "#F53CBE#You panic and flee from %s.", eff.source.name)
					else
						game.logSeen(self, "#F53CBE#%s panics and tries to flee from %s.", self.name:capitalize(), eff.source.name)
						self:useEnergy(game.energy_to_act * self:combatMovementSpeed(bestX, bestY))
					end
				end
			end
		end
	end,
}
