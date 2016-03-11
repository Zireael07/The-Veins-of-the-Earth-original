--Veins of the Earth

--From ToME git
function util.squareApply(x, y, w, h, fct)
    for i = x, x + w do for j = y, y + h do
        fct(i, j)
    end end
end

--From Qi Daozei
--- Rounds a number, rounding .5 away from 0.  See http://lua-users.org/wiki/SimpleRound
function math.round_simple(num)
    if num >= 0 then return math.floor(num+.5)
    else return math.ceil(num-.5) end
end

--From ToME2 port
-- Reverse of T-Engine's string.capitalize().
function string.uncapitalize(s)
    if #s > 1 then
        return s:sub(1, 1):lower() .. s:sub(2)
    elseif #s == 1 then
        return s:lower()
    else
        return s
    end
end

--From StackOverflow via StarKeep
function util.remove_duplicates(t)
	local hash = {}
	local res = {}
	for _,v in ipairs(t) do
		if (not hash[v]) then
			res[#res+1] = v
			hash[v] = true
		end
	end

    game.log("Called the filter")
	return res
end

--From Reddit
function table.filter_duplicates(list, what)
    assert(what~=nil, "filter key cannot be nil")

    local dupes = {}
    local result = {}
    for i=1,#list do
        local item = list[i]
    --    game.log(item)
        if not item[what] then game.log("No what in item") end
        if not dupes[item[what]] then
            dupes[item[what]] = true
            result[#result+1] = item
        end
    end
    return result
end


function table.filter_list(list, what)
    for i, t in ipairs(list) do
        local dupes = {}
        local result = {}
        for i, what in ipairs(t) do

        game.log(t.what)
        if not t.what then game.log("No what in item") return end
        local item = t
        local v = t.what

        if not dupes[v] then
            dupes[v] = true
            result[#result+1] = t
        end


    --    if not dupes[item[what]] then
    --        dupes[item[what]] = true
    --[[        result[#result+1] = item
        end]]
        end
        if not dupes.t then
            result[#result+1] = t
        end

    end
    return result
end

function table.remove_duplicates(list, what)
    if _G.type(what) ~= "string" then game.log("What is not a string") end

    for i, t in ipairs(list) do

    local hash = {}
	local res = {}
    for _, what in ipairs(t) do
	    if not hash[what] then
		    res[#res+1] = what
		    hash[what] = true
            list[#list+1] = res
        end
	end

    end

    local out = list

    return out
--	return res

end
