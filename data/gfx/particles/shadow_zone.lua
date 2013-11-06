base_size = 32

return { generator = function()
	local ad = rng.range(0, 360)
	local a = math.rad(ad)
	local dir = math.rad(ad + 90)
	local r = rng.range(1, 20)
	local dirv = math.rad(1)
	local col = rng.range(20, 80)/255

	return {
--		trail = 1,
		life = 10,
		size = 4, sizev = -0.1, sizea = 0,

		x = r * math.cos(a), xv = rng.float(-0.4, 0.4), xa = 0,
		y = r * math.sin(a), yv = rng.float(-0.4, 0.4), ya = 0,
		dir = dir, dirv = dirv, dira = dir / 20,
		vel = 1, velv = 0, vela = 0.1,

		r = col,  rv = 0, ra = 0,
		g = col,  gv = 0, ga = 0,
		b = col,  bv = 0, ba = 0,
		a = rng.range(220, 255)/255,  av = 0, aa = 0,
	}
end, },
function(self)
	self.ps:emit(4)
end,
40