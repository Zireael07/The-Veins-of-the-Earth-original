--Veins of the Earth
--Zireael 2014

newChat{ id="start",
    text = [[Welcome, adventurer! Would you like to have some company?]],
    answers = {
        {[[Yes, please.]], action = function(npc, player)
--[[    if player:skillCheck("diplomacy", 10) then return "shop"
    else return "sorry"  end]]
    return "company"
    end
    },
        {[[No, I prefer adventuring alone.]]},
    },
}

newChat{ id="company",
    text = [[I'm sorry, but my company will cost you money.]],
    answers = {
        {[[How much does it cost?]], jump="cost"},
        {[[I don't have any money.]], jump="again"},
        {[[I have coin to pay.]], jump="hire"},
    },
}

newChat{ id="cost",
    text = [[It costs 3 gp per day.]],
    answers = {
        {[[Fine. Let's head out.]], jump="hire"},
        {[[That's too costly.]], jump="again"},
    }
}

newChat{ id="again",
    text = [[Come by when you can afford it then.]],
    answers = {
        {[[Bye.]]},
    }
}

newChat{ id="hire",
    text = [[Glad that's settled then. Don't forget to pay.]],
    answers = {
        {[[Let's go!]], action = function(npc, player) 
        --That's where the hireling should join the party
        npc.faction = player.faction 
        --Prevent further talks
        npc.can_talk = nil
        end,

        }, --cond = function(npc, player) player.level > 6 end
        {[[I changed my mind.]], jump="again"},
    }
    
}

--if npc.faction == player.faction then

return "start"

--else end
