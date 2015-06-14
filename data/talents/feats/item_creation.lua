--Veins of the Earth
--Zireael 2014-2015

newTalentType{ type="arcane/itemcreation", name = "Item Creation", description = "Item Creation" }

local Ego = require 'mod.class.Ego'

newFeat{
	name = "Craft Arms and Armor",
	type = {"arcane/itemcreation", 1},
	is_feat = true,
	points = 1,
	mode = "activated",
	cooldown = 20,
	range = 0,
	--Not used yet because not sure if creating can be done
--[[	get_effect = function(self, t)
		game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the action",{
                {name="Improve existing item", desc=""},
                {name="Create new item", desc=""},
                },
                function(result)
            	game.log("Result: "..result)
            	if result == "Improve existing item" then end

            	if result == "Create new item" then end
            	end))
	end,]]
	action = function(self, t)
		local player = game.player
		--Half the base price of the ego - 250 for base price of 500
		local gold_cost
		--1/25 = 0,04 of the base price; 20 for base price of 500
		--20/250 = 0,08
		local xp_cost
		local inven = game.player:getInven("INVEN")

		local d d = self:showInventory("Improve which item?", inven, function(o) return o.type == "weapon" or o.type == "armor" end, function(o, item)

		--	local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired bonus",
			game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the desired bonus",
			Ego:generateItemCreationEgos(o),

                function(result, item)
			--[[		self:talentDialogReturn(result)
					game:unregisterDialog(self:talentDialogGet())
				end))]]

--            		game.log("Result: "..result)

					game.zone:applyEgo(o, item.ego, "object")


            	--[[	if result == "+1 bonus" then
            		local gold_cost
            		local xp_cost
            		gold_cost = 500
            		xp_cost = gold_cost * 0.08

            	--	game.log("Costs = XP:"..xp_cost.." Gold:"..gold_cost)
            	--	game.log("Object:"..o.name)
            		local player = game.player
                    --Check player gold and XP
            		if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
            		elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP") --end
            		--Check current enhancement
                    elseif o.type == "weapon" and (o.magic_bonus or 0) > 1 then game.log("You can't enchant an item which already has an equal or higher bonus")
            	    elseif o.type == "armor" and (o.combat_magic_armor or 0) > 1 then game.log("You can't enchant an item which already has an equal or higher bonus")
                    else
                    --Deduct the costs
                    player.money = player.money - gold_cost
                    player.exp = player.exp - xp_cost
                    --Apply bonus and update display
            		o.unided_name = o.unided_name.." +1"
                    o.magic_bonus = (o.magic_bonus or 0) + 1
            		o.name = o.name.." +1"
                    end
                    end

            		if result == "+2 bonus" then
            		local gold_cost
            		local xp_cost
            		gold_cost = 4000
            		xp_cost = gold_cost * 0.08
                    local player = game.player
            		--Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP") --end
                    --Check current enhancement
                    elseif o.type == "weapon" and (o.magic_bonus or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus") --end
                    elseif o.type == "armor" and (o.combat_magic_armor or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus")
                    else
                    --Deduct the costs
                    player.money = player.money - gold_cost
                    player.exp = player.exp - xp_cost
                    --Apply bonus and update display
                    o.unided_name = o.unided_name.." +2"
            		o.magic_bonus = (o.magic_bonus or 0) + 2
            		o.name = o.name.." +2"
            		end
                    end

            		if result == "+3 bonus" then
            		gold_cost = 9000
            		xp_cost = gold_cost * 0.08
                    local player = game.player
            		--Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP") --end
                    --Check current enhancement
                    elseif o.type == "weapon" and (o.magic_bonus or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus") --end
                    elseif o.type == "armor" and (o.combat_magic_armor or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost
                        --Apply bonus and update display
                        o.unided_name = o.unided_name.." +3"
            			o.magic_bonus = (o.magic_bonus or 0) + 3
            			o.name = o.name.." +3"
            		 end
            		end

            		if result == "+4 bonus" then
            		gold_cost = 16000
            		xp_cost = gold_cost * 0.08
                    local player = game.player
            		--Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP") --end
                    --Check current enhancement
                    elseif o.type == "weapon" and (o.magic_bonus or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus") --end
                    elseif o.type == "armor" and (o.combat_magic_armor or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost
                        --Apply bonus and update display
                        o.unided_name = o.unided_name.." +4"
            			o.magic_bonus = (o.magic_bonus or 0) + 4
            			o.name = o.name.." +4"
            		 end
            		end

            		if result == "+5 bonus" then
            		gold_cost = 25000
            		xp_cost = gold_cost * 0.08
                    local player = game.player
            		--Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP") --end
                    --Check current enhancement
                    elseif o.type == "weapon" and (o.magic_bonus or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus") --end
                    elseif o.type == "armor" and (o.combat_magic_armor or 0) > 2 then game.log("You can't enchant an item which already has an equal or higher bonus")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost
                        --Apply bonus and update display
                        o.unided_name = o.unided_name.." +5"
            			o.magic_bonus = (o.magic_bonus or 0) + 5
            			o.name = o.name.." +5"
            		end
				end]]

            	end))

			end)

			return true
	end,
	info = function(self, t)
		return "Craft magic armor or weapons."
	end,
}

--NOTE: These craft new items
newFeat{
	name = "Brew Potion",
	type = {"arcane/itemcreation", 1},
	is_feat = true,
	points = 1,
	mode = "activated",
	cooldown = 20,
	range = 0,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")

		--Create a base item
		local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
		if o then
		game.zone:addEntity(game.level, o, "object")
		game.player:addObject(game.player:getInven("INVEN"), o)
		o.pseudo_id = true
		end
		
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the desired effect",
		Ego:generateItemCreationEgos(o),

                function(result, item)
                --  game.log("Result: "..result)

				game.zone:applyEgo(o, item.ego, "object")

            --[[        if result == "cure light wounds" then
                    local gold_cost
                    local xp_cost
                    gold_cost = 50
                    --used a different formula
                    xp_cost = gold_cost * 0.04

                    local player = game.player
                    --Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(1,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "potion of cure light wounds"

                    end
                    end

                        if result == "cure moderate wounds" then
                        local gold_cost
                        local xp_cost
                        gold_cost = 375
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "potion of cure moderate wounds"

                    end
                    end

                    if result == "heal serious wounds" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "potion of heal light wounds"

                    end
                    end

                if result == "bear endurance" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "potion of bear endurance"

                    end
                    end

                if result == "bull strength" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="potion", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "potion of bull strength"

                    end
                    end]]

                end))

            return true
	end,
	info = function(self, t)
		return "Craft magic potions."
	end,
}

newFeat{
	name = "Craft Wand",
	type = {"arcane/itemcreation", 1},
	is_feat = true,
	points = 1,
	mode = "activated",
	cooldown = 20,
	range = 0,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")
		--Create a base item
		local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
		if o then
		game.zone:addEntity(game.level, o, "object")
		game.player:addObject(game.player:getInven("INVEN"), o)
		o.pseudo_id = true
		end

             game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the desired effect",
			Ego:generateItemCreationEgos(o),
                function(result, item)
                  game.log("Result: "..result)


				game.zone:applyEgo(o, item.ego, "object")


                --[[    if result == "cure light wounds" then
                    local gold_cost
                    local xp_cost
                    gold_cost = 50
                    --used a different formula
                    xp_cost = gold_cost * 0.04

                    local player = game.player
                    --Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(1,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "wand of cure light wounds"

                    end
                    end

                        if result == "cure moderate wounds" then
                        local gold_cost
                        local xp_cost
                        gold_cost = 375
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "wand of cure moderate wounds"

                    end
                    end

                    if result == "heal serious wounds" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "wand of heal light wounds"

                    end
                    end

                if result == "bear endurance" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "wand of bear endurance"

                    end
                    end

                if result == "bull strength" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="wand", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "wand of bull strength"

                    end
                    end]]

                end))

            return true
	end,
	info = function(self, t)
		return "Craft magic wands."
	end,
}

newFeat{
	name = "Scribe Scroll",
	type = {"arcane/itemcreation", 1},
	is_feat = true,
	points = 1,
	mode = "activated",
	cooldown = 20,
	range = 0,
	action = function(self, t)
		local inven = game.player:getInven("INVEN")
		--Create a base item
		local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
		if o then
		game.zone:addEntity(game.level, o, "object")
		game.player:addObject(game.player:getInven("INVEN"), o)
		o.pseudo_id = true
		end

             game:registerDialog(require('mod.dialogs.GetChoice').new("Choose the desired effect",
			Ego:generateItemCreationEgos(o),

                function(result, item)
                --  game.log("Result: "..result)
				game.zone:applyEgo(o, item.ego, "object")

                --[[   if result == "cure light wounds" then
                    local gold_cost
                    local xp_cost
                    gold_cost = 50
                    --used a different formula
                    xp_cost = gold_cost * 0.04

                    local player = game.player
                    --Check player gold and XP
                    if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                    elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                    else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "cure light wounds",
                        use = function(self,who)
                        who:heal(rng.dice(1,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "scroll of cure light wounds"

                    end
                    end

                        if result == "cure moderate wounds" then
                        local gold_cost
                        local xp_cost
                        gold_cost = 375
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "cure moderate wounds",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "scroll of cure moderate wounds"

                    end
                    end

                    if result == "heal serious wounds" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "heal light wounds",
                        use = function(self,who)
                        who:heal(rng.dice(2,8) + 5)
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "scroll of heal light wounds"

                    end
                    end

                if result == "bear endurance" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "read",
                        use = function(self,who)
                        who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "scroll of bear endurance"

                    end
                    end

                if result == "bull strength" then

                        local gold_cost
                        local xp_cost
                        gold_cost = 50
                        --used a different formula
                        xp_cost = gold_cost * 0.04

                        local player = game.player
                        --Check player gold and XP
                        if (player.money or 0) < gold_cost then game.log("You don't have enough gold") --end
                        elseif (player.exp or 0) < xp_cost then game.log("You don't have enough XP")
                        else
                        --Deduct the costs
                        player.money = player.money - gold_cost
                        player.exp = player.exp - xp_cost

                        --Create a base item
                        local o = game.zone:makeEntity(game.level, "object", {name="scroll", ego_chance=-1000}, 1, true)
                        if o then
                        game.zone:addEntity(game.level, o, "object")
                        game.player:addObject(game.player:getInven("INVEN"), o)
                        o.pseudo_id = true
                        end

                        o.use_simple = { name = "quaff",
                        use = function(self,who)
                        who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
                        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
                        return {used = true, destroy = true}
                        end
                        }
                        o.unided_name = "scroll of bull strength"

                    end
                    end]]

                end))

            return true
	end,
	info = function(self, t)
		return "Craft magic scrolls."
	end,
}

--[[newFeat{
    name = "Craft Staff",
    type = {"arcane/itemcreation", 1},
    is_feat = true,
    points = 1,
    mode = "activated",
    cooldown = 20,
    range = 0,
    action = function(self, t)
        local inven = game.player:getInven("INVEN")
    end,
    info = function(self, t)
        return "Craft magic staves."
    end,
}]]

newFeat{
	name = "Craft Wondrous Item",
	type = {"arcane/itemcreation", 1},
    is_feat = true,
    points = 1,
    mode = "activated",
    cooldown = 20,
    range = 0,
    action = function(self, t)
	end,
	info = function(self, t)
        return "Craft magic items such as cloaks or belts."
    end,
}
