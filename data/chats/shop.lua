--Veins of the Earth
--Zireael

newChat{ id="start",
    text = [[Welcome, adventurer! Would you like to see my wares?]],
    answers = {
        {[[Yes, please.]], action = function(npc, player)
--[[    if player:skillCheck("diplomacy", 10) then return "shop"
    else return "sorry"  end]]
    return "shop"
    end
	},
        {[[I don't have money.]], action = function(npc, player)
    if player:skillCheck("bluff", 10) then return "shop" 
    else return "sorry" end
    end,
    cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Me no have money.]], action = function(npc, player)
    if player:skillCheck("bluff", 10) then return "shop" 
    else return "sorry" end
    end,
    cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Show them or I will kill you!]], action = function(npc, player)
    if player:skillCheck("intimidate", 10) then return "shop" 
    else return "sorry" end
    end,
    cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[You give stuff or me kill you!]], action = function(npc, player)
    if player:skillCheck("intimidate", 10) then return "shop" 
    else return "sorry" end
    end,
    cond=function(npc, player) 
        if player:getInt() > 10 then return end
        return true
    end
    },
        {[[Back away.]]},
    },
}

newChat{ id="shop",
    text = [[I will show you my wares.]],
    answers = {
        {[[Thank you]], action = function(npc, player)
 --   local shop = game:getStore("GENERAL")
    npc.store:loadup(game.level, game.zone)
    npc.store:interact(game.player, "General shop wares")
--    shop = nil
    end
    },
    },
}

newChat{ id="sorry",
    text = [[I will not help you, you ruffian!]],
    answers = {
        {[[*Get angry and kill him*]], action = function(npc, player) 
			npc.faction = "enemies"
		end
        },
        {[[Leave.]]},
    },
}


return "start"