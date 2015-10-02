--Veins of the Earth
--Zireael 2014

local def = {
[[#########!!#########]],       
[[#######......#######]],
[[####...~~~~~~...####]],  
[[##...~~~~~~~~~~...##]], 
[[#...~~~~~~~~~~~....#]],
[[!..~~~~~~~~~~~~....#]],
[[#..~~~~~~~~~~~~~~..!]],
[[##.~~~~~~~~~~~~~~..#]],
[[##..~~~~~~~~~~~~..##]], 
[[####...~~~~~~...####]], 
[[#######......#######]],    
[[#########!!#########]],      
}


return function(gen, id)
    local room = gen:roomParse(def)
    return { name="lake_test"..room.w.."x"..room.h, w=room.w, h=room.h, generator = function(self, x, y, is_lit)
        gen:roomFrom(id, x, y, is_lit, room)

        -- Everything is special: cant have the player spawn here
        util.squareApply(x, y, room.w, room.h-2, function(i, j) 

        gen.map.room_map[i][j].special = true 

        gen.map.attrs(i, j, "room_id", "lake")

        gen.map.attrs(i, j, "lake", true)

        end)

        --[[for _, spot in ipairs(room.spots[2]) do
            local e = gen.zone:makeEntity(gen.level, "actor", {type="giant", subtype="ogre"}, nil, true)
            if e then
                gen:roomMapAddEntity(x + spot.x, y + spot.y, "actor", e)
                e.on_added_to_level = nil
            end
        end]]
    end}
end