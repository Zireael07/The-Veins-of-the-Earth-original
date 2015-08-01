--Veins of the Earth
--Zireael 2013-2015

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"

--Various spell effects

--Most basic spells
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
	name = "SLOW",
	desc = "Slowed",
	type = "physical",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is slowed!", "+Slow" end,
	on_lose = function(self, err) return "#Target# seems to speed up.", "-Slow" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("movement_speed_bonus", -0.50)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed_bonus", eff.tmpid)
	end,
}

--Not directly detrimental to targets
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

        self.faction = "neutral"
    end,
	deactivate = function(self, eff)
		self.faction = "enemies"
	end,
}

--More complex spells
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


--Bard skills
--+1 bonus on charm and fear effects
newEffect{
	name = "INSPIRE_COURAGE_I",
	desc = "Inspired",
	type = "mental",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# is inspired!", "+Inspire" end,
	on_lose = function(self, err) return "#Target# is no longer inspired.", "-Inspire" end,
	activate = function(self, eff)
		eff.attack = self:addTemporaryValue("combat_attack", 1)
		eff.dmg = self:addTemporaryValue("combat_damage", 1)
    end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("combat_attack", eff.attack)
		self:removeTemporaryValue("combat_damage", eff.dmg)
	end,
}

--Dummies so that concealment works
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

newEffect{
	name = "ENTROPIC_SHIELD",
	desc = "Entropic Shield",
	type = "mental",
	status = "beneficial",
}

newEffect{
	name = "DELAY_POISON",
	desc = "Delay poison",
	type = "physical",
	status = "beneficial",
}

--Detect spells
newEffect{
	name = "DETECT_EVIL",
	desc = "Detected evil",
	long_desc = [[The character detects as evil.]],
	type = "mental",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is evil!", "+DetectEvil" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-DetectEvil" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("evil", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "DETECT_GOOD",
	desc = "Detected good",
	long_desc = [[The character detects as good.]],
	type = "mental",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is good!", "+DetectGood" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-DetectGood" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("good", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "DETECT_CHAOS",
	desc = "Detected chaos",
	long_desc = [[The character detects as chaotic.]],
	type = "mental",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is chaotic!", "+DetectChaos" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-DetectChaos" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("chaos", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "DETECT_LAW",
	desc = "Detected law",
	long_desc = [[The character detects as lawful.]],
	type = "mental",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is lawful!", "+DetectLaw" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-DetectLaw" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("law", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "DETECT_POISON",
	desc = "Detected poison",
	long_desc = [[The character is poisoned.]],
	type = "mental",
	status = "detrimental",
	on_gain = function(self, err) return "#Target# is poisoned!", "+DetectPois" end,
	on_lose = function(self, err) return "#Target# is no longer outlined.", "-DetectPois" end,
	activate = function(self, eff)
        eff.particle = self:addParticles(Particles.new("poisoned", 1))
    end,
    deactivate = function(self, eff)
        self:removeParticles(eff.particle)
    end,
}


--Dummies again
newEffect{
	name = "KNOW_ALIGNMENT",
	desc = "knows alignment",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
--		eff.particle = self:addParticles(Particles.new("law", 1))
	end,
	 deactivate = function(self, eff)
--        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "DEATHWATCH",
	desc = "death watch",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
--		eff.particle = self:addParticles(Particles.new("law", 1))
	end,
	 deactivate = function(self, eff)
--        self:removeParticles(eff.particle)
    end,
}

newEffect{
	name = "LONGSTRIDER",
	desc = "Boost speed",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 0.33)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed", eff.speed)
	end,
}

newEffect{
	name = "EXPEDITIOUS_RETREAT",
	desc = "Boost speed",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 1)
		--never attack but move? uh...
	--	eff.tmpid = self:addTemporaryValue("never_move", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed", eff.speed)
	end,
}

newEffect{
	name = "ANT_HAUL",
	desc = "Triple carry capacity",
	type = "mental",
	status = "beneficial",
	activate = function(self, eff)
		eff.capacity = self:addTemporaryValue("ant_haul", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("ant_haul", eff.capacity)
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
	type = "mental",
	status = "beneficial",
	on_gain = function(self, err) return "A field seems to surround #Target#", "+Mage Armor" end,
	on_lose = function(self, err) return "The field around #Target# seems to dissipate", "-Mage Armor" end,
	activate = function(self, eff)
		self:effectTemporaryValue(eff, "combat_armor_ac", 4)
	end,
}

newEffect{
	name = "DIVINE_FAVOR",
	desc = "Divine Favor",
	type = "mental",
	status = "beneficial",
--	on_gain = function(self, err) return "A field seems to surround #Target#", "+Mage Armor" end,
--	on_lose = function(self, err) return "The field around #Target# seems to dissipate", "-Mage Armor" end,
	activate = function(self, eff)
		eff.attack = self:addTemporaryValue(eff, "combat_attack", 1)
		eff.damage = self:addTemporaryValue("combat_damage", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("combat_attack", eff.attack)
		self:removeTemporaryValue("combat_damage", eff.damage)
	end,
}

newEffect{
	name = "SHIELD_OF_FAITH",
	desc = "Shield of Faith",
	type = "mental",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# is protected by a shield!", "+ShieldFaith" end,
	on_lose = function(self, err) return "#Target# is no longer protected.", "-ShieldFaith" end,
	activate = function(self, eff)
		eff.deflection = self:addTemporaryValue(eff, "combat_protection", 2)
    end,
    deactivate = function(self, eff)
		self:removeTemporaryValue("combat_protection", eff.deflection)
    end,
}


--Flying, Zireael
newEffect{
	name = "LEVITATE",
	desc = "Levitating",
	type = "mental",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# starts floating in air", "+Levitate" end,
	on_lose = function(self, err) return "#Target# descends to the ground", "-Levitate" end,
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 0.66)
		self.fly = true
	end,
	deactivate = function(self, eff)
		self.fly = false
		self:removeTemporaryValue("movement_speed", eff.speed)
	end,
}

newEffect{
	name = "FLY",
	desc = "Flying",
	type = "magical",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# starts flying in the air", "+Fly" end,
	on_lose = function(self, err) return "#Target# descends gently to the ground", "-Fly" end,
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 1.33)
		self.fly = true
	end,
	deactivate = function(self, eff)
		self.fly = false
		self:removeTemporaryValue("movement_speed", eff.speed)
	end,
}

newEffect{
	name = "HASTE",
	desc = "Haste",
	type = "magical",
	status = "beneficial",
	on_gain = function(self, err) return "#Target# starts moving quicker", "+Haste" end,
	on_lose = function(self, err) return "#Target# seems to slow down", "-Haste" end,
	activate = function(self, eff)
		eff.speed = self:addTemporaryValue("movement_speed", 2)
		eff.attack = self:addTemporaryValue("combat_attack", 1)
		self:effectTemporaryValue(eff, "combat_dodge", 1)
		self:effectTemporaryValue(eff, "reflex_save", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("movement_speed", eff.speed)
		self:removeTemporaryValue("combat_attack", eff.attack)
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
