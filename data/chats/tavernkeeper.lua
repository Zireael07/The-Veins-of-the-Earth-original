--Veins of the Earth
--Zireael 2015

--same as dungeon rest
local function poor_room(npc, player)
    local price = 0.2
    if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 100 silver, you need more money.") return end

    player:incMoney(-price)
    player:cityRest()

    --normal healing
    --use Wis instead of Con if have Mind over Body feat
    local con = player:getCon()
    local heal = ((player.level +3)*con)/5

    --Heal skill
    if (player.skill_heal or 0) > 0 then
         heal = ((player.level + player.skill_heal +3)*con)/5
    end

    player.life = math.min(player.max_life, player.life + heal)

    --heal one wound
    if player.wounds < player.max_wounds then
        player.wounds = player.wounds + 1
    end
end

--Half again as good
local function standard_room(npc, player)
    local price = 1
    if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 600 silver, you need more money.") return end

    player:incMoney(-price)

    player:cityRest()

    --normal healing
    --use Wis instead of Con if have Mind over Body feat
    local con = player:getCon()
    local norm = ((player.level +3)*con)/5
    local heal = norm*2

    --Heal skill
    if (player.skill_heal or 0) > 0 then
         norm = ((player.level + player.skill_heal +3)*con)/5
         heal = norm*2
    end

    player.life = math.min(player.max_life, player.life + heal)

    --heal two wounds
    if player.wounds < player.max_wounds then
        player.wounds = player.wounds + 2
    end
end

--The best money can buy
local function luxury_room(npc, player)
    local price = 5
    if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 2800 silver, you need more money.") return end

    player:incMoney(-price)

    player:cityRest()

    --restore all vitality
    player.life = player.max_life

    --heal two wounds
    if player.wounds < player.max_wounds then
        player.wounds = player.wounds + 2
    end
end

newChat{id="start",
    text=[[Welcome! Maybe you are in need of resting?]],
    answers = {
        {[[No, I have no need of your services.]], cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Me no need rest.]], cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Yes, I would like the cheapest room.]], action = poor_room,
        cond=function(npc, player)
        if player.money < 1 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like the standard room.]], action = standard_room,
        cond=function(npc, player)
        if player.money < 1 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like the luxury room.]], action = luxury_room,
        cond=function(npc, player)
        if player.money < 5 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
    --The dumb versions
        {[[Me want poor room.]], action = poor_room,
        cond=function(npc, player)
        if player.money < 1 then return end
        if player:getInt() >= 10 then return end
        return true
    end
    },
        {[[Me want normal room.]], action = standard_room,
        cond=function(npc, player)
            if player.money < 1 then return end
            if player:getInt() >= 10 then return end
            return true
        end
    },
        {[[Me want best room.]], action = luxury_room,
        cond=function(npc, player)
        if player.money < 5 then return end
        if player:getInt() >= 10 then return end
        return true
        end
        },
    },
}

return "start"
