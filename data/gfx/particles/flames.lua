base_size = 32


return {
	base = 1000,

	angle = { 0, 360 }, anglev = { 2000, 4000 }, anglea = { 200, 600 },

	life = { 5, 10 },
	size = { 3, 6 }, sizev = {0, 0}, sizea = {0, 0},
	r = {200, 255}, rv = {0, 0}, ra = {0, 0},
	g = {120, 170}, gv = {0, 0}, ga = {0, 0},
	b = {0, 0}, bv = {0, 0}, ba = {0, 0},
	a = {255, 255}, av = {0, 0}, aa = {0, 0},
}, function(self)
--	self.nb = (self.nb or 0) + 1
--	if self.nb < 4 then
		self.ps:emit(100)

--	end
end,
40