newChat{id="start",
    text=[[Welcome! Maybe you need me to train you?]],
    answers = {
        {[[No, I have no need of your services.]], cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Me no need train.]], cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Yes, I'd like to train a class.]], action = function(npc, player)
            local price = 400 --2 gold
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 100 silver, you need more money.") return end

            player:incMoney(-price)
            game:registerDialog(require("mod.dialogs.ClassLevelupDialog").new(player, npc))


        end, cond=function(npc, player)
            if player.money < 400 then return end
            return true
        end
        },
        {[[Yes, I'd like to train a skill.]], action = function(npc, player)
            local price = 50
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 600 silver, you need more money.") return end

            player:incMoney(-price)
            game:registerDialog(require("mod.dialogs.SkillDialog").new(player, npc))


        end, cond=function(npc, player)
            if player.money < 50 then return end
            return true
        end
        },
        {[[Yes, I'd like to train a feat.]], action = function(npc, player)
            local price = 100
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 2800 silver, you need more money.") return end

            player:incMoney(-price)
            game:registerDialog(require("mod.dialogs.FeatDialog").new(player, npc))

        end, cond=function(npc, player)
            if player.money < 100 then return end
            return true
        end
        },
        {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
    },
}

return "start"
