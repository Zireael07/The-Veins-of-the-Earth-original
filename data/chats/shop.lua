--Veins of the Earth
--Zireael

newChat{ id="start",
    text = [[Welcome, adventurer! Would you like to see my wares?]],
    answers = {
        {[[Yes, please.]], action = function(npc, player)
    if player:skillCheck("diplomacy", 10) then return "shop"
    else return "sorry"  end
    end
	},
        {[[I don't have money.]], action = function(npc, player)
    if player:skillCheck("bluff", 10) then return "shop" 
    else return "sorry" end
    end
    },
        {[[Show them or I will kill you!]], action = function(npc, player)
    if player:skillCheck("intimidate", 10) then return "shop" 
    else return "sorry" end
    end
    },
        {[[Back away.]]},
    },
}

newChat{ id="shop",
    text = [[I will show you my wares.]],
    answers = {
        {[[Thank you]]},
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