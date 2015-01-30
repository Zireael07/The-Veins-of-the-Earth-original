--Veins of the Earth
--Zireael 2014

-- Check for unidentified stuff
local function can_auto_id(npc, player)
    for inven_id, inven in pairs(player.inven) do
        for item, o in ipairs(inven) do
            if not o:isIdentified() then return true end
        end
    end
end

local id_item = function(npc, player)
    player:showInventory("Identify which item?", player:getInven("INVEN"), function(o) return not o.lore end, function(o)
            local price = 1100
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 1100 silver, you need more money.") return end
                player:incMoney(-price)
                o:identify()
      
                game.logPlayer(player, "%s identifies %s", npc.name:capitalize(), o:getName{do_colour=true, no_count=true})

        end)
--    end)
end


newChat{id="start",
    text=[[Welcome! Maybe you need me to identify an item?]],
    answers = {
        {[[No, I have no need of your services.]], cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Me no need identify.]], cond=function(npc, player) 
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Yes, please.]], action = function(npc, player)
         player:showInventory("Identify which item?", player:getInven("INVEN"), function(o) return not o.lore end, function(o)
            local price = 1100
            if price > player.money then require("engine.ui.Dialog"):simplePopup("Not enough money", "This costs 1100 silver, you need more money.") return end
                player:incMoney(-price)
                o:identify()
      
                game.logPlayer(player, "%s identifies %s", npc.name:capitalize(), o:getName{do_colour=true, no_count=true})

        end)

    --    id_item
    end, cond=function(npc, player)
            if not can_auto_id(npc, player) then return end
            if player.money < 1100 then return end
            return true
        end
    },
        
    },
}

return "start"