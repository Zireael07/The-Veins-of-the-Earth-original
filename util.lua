--Veins of the Earth

--From ToME git
function util.squareApply(x, y, w, h, fct)
    for i = x, x + w do for j = y, y + h do
        fct(i, j)
    end end
end