--Veins of the Earth
--Zireael 2015

newChat{id="start",
    text=[[Welcome! Maybe you need me to heal you?]],
    answers = {
        {[[No, I have no need of your services.]], cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Me no need heal.]], cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Yes, please cast cure light wounds.]], action = function(npc, player)
            local price = 100
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 100 silver, you need more money.") return end

            player:incMoney(-price)
            local d = rng.dice(1,8)
            player:heal(d)
            game.log("%s casts a spell and heals you of %d damage"):format(npc.name:capitalize(), d)
            --end
        end, cond=function(npc, player)
            if player.money < 100 then return end
            return true
        end
        },
        {[[Yes, please cast cure moderate wounds.]], action = function(npc, player)
            local price = 600
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 600 silver, you need more money.") return end

            player:incMoney(-price)
            local d = rng.dice(2,8)
            player:heal(d)
            game.log("%s casts a spell and heals you of %d damage"):format(npc.name:capitalize(), d)
        end, cond=function(npc, player)
            if player.money < 600 then return end
            return true
        end
        },
        {[[Yes, please cast cure critical wounds.]], action = function(npc, player)
            local price = 2800
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 2800 silver, you need more money.") return end

            player:incMoney(-price)
            local d = rng.dice(2,8)
            player:heal(d)
            game.log("%s casts a spell and heals you of %d damage"):format(npc.name:capitalize(), d)
        end, cond=function(npc, player)
            if player.money < 2800 then return end
            return true
        end
        },
        {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
    },
}

return "start"
