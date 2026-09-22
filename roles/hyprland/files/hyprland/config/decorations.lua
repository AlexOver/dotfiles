-- Look and feel: general/decoration, using colors.lua globals

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 3,
		border_size = 2,
		col = {
			active_border = { colors = { ACCENT1, ACCENT2 }, angle = 45 },
			inactive_border = INACTIVE_BORDER,
		},
		layout = "dwindle",
		allow_tearing = false,
	},

	decoration = {
		rounding = 5,
		blur = { enabled = true, size = 3, passes = 1 },
		shadow = { enabled = true, range = 4, render_power = 3, color = SHADOW_COLOR },
	},

	animations = { enabled = true },
})
