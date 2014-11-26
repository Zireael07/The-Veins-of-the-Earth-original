--Veins of the Earth
--Zireael 2014

--Let's get this on, shall we?
newChat{id="start",
    text=[[Hello pretty! Are you interested?]],
    answers = {
        {[[Oh yeah!]], action = function(npc, player)
        --Deduce the gold
        player.money = player.money - 10
        --rest
        if rng.dice(1,20) + player:getConMod() > 18 then
            player.kid = true
            player.kid_date = game.calendar:getDayOfYear(self.turn)
        end
    end,
    cond=function(npc, player)
            if player.money < 10 then return end
            return true
        end
    },
        {[[No, I have no need of your services.]]},
    },
}

--Wrong sex!
newChat{id="welcome",
    text = [[Oh boy, I think you might be more interested in one of the girls...]],
    answers = {
        {[[I suppose so.]]},
    },
}

return (game.player.descriptor.sex == "Female") and "start" or "welcome"