-- Miscellaneous config

hl.config({
	dwindle = { preserve_split = true },
	misc = { force_default_wallpaper = 0 },
})

hl.window_rule({
	name = "Calculator floats at cursor",
	match = { class = "^org\\.gnome\\.Calculator$" },
	float = true,
	move = "(cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.5))",
})
