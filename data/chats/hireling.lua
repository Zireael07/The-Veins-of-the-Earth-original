--Veins of the Earth
--Zireael 2014

local cost

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
        {[[That's too costly.]], jump="again"},
        {[[Fine. Let's head out.]], action = function(npc, player)
        if player:skillCheck("diplomacy", 15) then return "hire" end
        --   cost = 3
        return "sorry" end,
        },
        
    },
}

newChat{ id="again",
    text = [[Come by when you can afford it then.]],
    answers = {
        {[[Bye.]]},
    }
}

newChat{ id="sorry",
    text = [[Sorry, I'm not interested. Maybe if you paid me more?]],
    answers = {
        {[[What if I paid you double?]], jump="double"},
        {[[That's too bad. I'll manage on my own.]]},
    }
    
}

newChat{ id="double",
    text = [[That's a whole different matter. 6 gp per day it is.]],
    answers = {
    {[[Great, let's go!]], action = function(npc, player)
        if player:skillCheck("diplomacy", 10) then 
        --    cost = 6
            return "hire2" end
     return "sorry"  end,
    },
    {[[I changed my mind.]], jump="again"},
}
}

newChat{ id="hire",
    text = [[Glad that's settled then. Don't forget to pay.]],
    answers = {
        {[[Let's go!]], action = function(npc, player) 
        --That's where the hireling should join the party
        npc.faction = player.faction 
        --Deduce the gold
        player.money = player.money - 3
        --Prevent further talks
        npc.can_talk = nil
        end,

        }, --cond = function(npc, player) player.level > 6 end
        {[[I changed my mind.]], jump="again"},
    }
    
}

newChat{ id="hire2",
    text = [[Glad that's settled then. Don't forget to pay.]],
    answers = {
        {[[Let's go!]], action = function(npc, player) 
        --That's where the hireling should join the party
        npc.faction = player.faction 
        --Deduce the gold
        player.money = player.money - 6
        --Prevent further talks
        npc.can_talk = nil
        end,

        }, --cond = function(npc, player) player.level > 6 end
        {[[I changed my mind.]], jump="again"},
    }
    
}



return "start"


