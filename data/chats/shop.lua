--Veins of the Earth
--Zireael 2013-2015

newChat{ id="start",
    text = [[Welcome, adventurer! Would you like to see my wares?]],
    answers = {
        {[[Yes, please.]], action = function(npc, player)
--[[    if player:skillCheck("diplomacy", 10) then return "shop"
    else return "sorry"  end]]
    return "shop"
    end
	},
        {[[I don't have money.]], skill = "bluff", action = function(npc, player)
    if player:skillCheck("bluff", 10) then return "shop"
    else return "sorry" end
    end,
    cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Me no have money.]], skill = "bluff", action = function(npc, player)
    if player:skillCheck("bluff", 10) then return "shop"
    else return "sorry" end
    end,
    cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end
    },
        {[[Show them or I will kill you!]], skill = "intimidate", action = function(npc, player)
    if player:skillCheck("intimidate", 10) then return "shop"
    else return "sorry" end
    end,
    cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[You give stuff or me kill you!]], skill = "intimidate", action = function(npc, player)
    if player:skillCheck("intimidate", 10) then return "shop"
    else return "sorry" end
    end,
    cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end
    },
        {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
    },
}

newChat{ id="shop",
    text = [[I will show you my wares.]],
    answers = {
        {[[Thank you]], action = function(npc, player)
    npc.store:loadup(game.level, game.zone)
    npc.store:interact(game.player, "General shop wares")
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
