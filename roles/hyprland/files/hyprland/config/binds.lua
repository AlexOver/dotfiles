-- Keybindings, structured to mirror dotfilesMothership's binds.lua sections, but every
-- command below points at what's actually installed on this machine (kitty, thunar,
-- hyprlauncher, swaync, copyq, pactl/playerctl/brightnessctl, hyprlock, grim/slurp) rather
-- than dotfilesMothership's CachyOS-specific tools (noctalia, dolphin, hyprpicker, uwsm).

local mainMod = MAINMOD
local mainShift = mainMod .. " + SHIFT"
local subMod = SUBMOD
local subShift = subMod .. " + SHIFT"

-- Set to "uwsm app -- " and uncomment if you adopt UWSM session management.
local launchPrefix = ""

---------------------
---- LAUNCHER ----
---------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(launchPrefix .. MENU))
hl.bind(mainShift .. " + Escape", hl.dsp.exec_cmd(POWERMENU))
hl.bind(subMod .. " + E", hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
-- hl.bind(subMod .. " + T", hl.dsp.exec_cmd(launchPrefix .. EDITOR)) -- TODO: set EDITOR in variables.lua first
hl.bind(subMod .. " + C", hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.bind("XF86Calculator", hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
-- hl.bind(subMod .. " + Z", hl.dsp.exec_cmd("your-settings-app")) -- TODO: no settings panel installed today
hl.bind(subMod .. " + X", hl.dsp.exec_cmd("swaync-client -t -sw")) -- control-center (closest equivalent: swaync)
-- hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("your-emoji-picker")) -- TODO: no emoji picker installed today
hl.bind(subMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
-- hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(TERMINAL .. " -e btop")) -- TODO: needs `btop` package

---------------------
---- UTILITIES ----
---------------------

-- hl.bind(subMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a -n")) -- TODO: needs `hyprpicker` package
hl.bind(
	subShift .. " + S",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Documents/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000'
	)
)
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'grim - | wl-copy && wl-paste > ~/Documents/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of whole screen taken" -t 1000'
	)
)
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("copyq toggle"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("swaync-client -t -sw")) -- notifications (closest equivalent: swaync)

-----------------------------
---- RESIZE SUBMAP ----
-----------------------------

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

---------------------
---- ZOOM ----
---------------------

local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end

hl.bind(mainMod .. " + Minus", function()
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind(mainMod .. " + Plus", function()
	zoomfunction(0.3)
end, { repeating = true })
hl.bind(mainMod .. " + code:82", function() -- keypad minus
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind(mainMod .. " + code:86", function() -- keypad plus
	zoomfunction(0.3)
end, { repeating = true })

-----------------------------
---- HARDWARE CONTROLS ----
-----------------------------

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

---------------------------------------------
---- WINDOW / WORKSPACE / MONITOR MANAGEMENT ----
---------------------------------------------

-- Window manipulation
hl.bind(mainShift .. " + Q", hl.dsp.window.close())
hl.bind(mainShift .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))

-- Alt-Tab cycling (closest equivalent to a window-switcher panel)
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + Tab", hl.dsp.window.bring_to_top())
hl.bind(mainShift .. " + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainShift .. " + Tab", hl.dsp.window.bring_to_top())

-- Focus navigation - arrows
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- Focus navigation - vim style
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window - arrows
hl.bind(mainShift .. " + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainShift .. " + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainShift .. " + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainShift .. " + right", hl.dsp.window.move({ direction = "right" }))

-- Move window - vim style
hl.bind(mainShift .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainShift .. " + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainShift .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainShift .. " + L", hl.dsp.window.move({ direction = "right" }))

-- Move the whole workspace to another monitor, left/right. dotfilesMothership has no
-- equivalent for this, so it's kept as-is (arrows only, no vim duplicate, to leave the
-- CTRL+SHIFT+H/L combo free for the adjacent-workspace-move binds below).
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.workspace.move({ monitor = "r" }))

-- Adjacent workspace focus, relative to current monitor - arrows
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "emptym" }))

-- Adjacent workspace focus - vim style
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ workspace = "emptym" }))

-- Move window to adjacent workspace, relative to current monitor - arrows
hl.bind(mainShift .. " + CTRL + right", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainShift .. " + CTRL + left", hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainShift .. " + CTRL + down", hl.dsp.window.move({ workspace = "emptym" }))

-- Move window to adjacent workspace - vim style
hl.bind(mainShift .. " + CTRL + L", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainShift .. " + CTRL + H", hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mainShift .. " + CTRL + J", hl.dsp.window.move({ workspace = "emptym" }))

-- Focus / move window to a specific monitor. Inert on a single-monitor machine until
-- MONITOR1 / MONITOR2 are overridden in custom.lua with real output names.
hl.bind(subMod .. " + 1", hl.dsp.focus({ monitor = MONITOR1 }))
hl.bind(subMod .. " + 2", hl.dsp.focus({ monitor = MONITOR2 }))
hl.bind(subShift .. " + 1", hl.dsp.window.move({ monitor = MONITOR1 }))
hl.bind(subShift .. " + 2", hl.dsp.window.move({ monitor = MONITOR2 }))

-- Switch to / move to workspace (absolute)
for i = 1, NUM_WPM do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainShift .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch to / move to workspace, relative to current monitor
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = "m~" .. i }))
	hl.bind(mainShift .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = "m~" .. i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainShift .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))

---------------------------
---- MOUSE CONTROLS ----
---------------------------

-- Scroll through workspaces with the mouse wheel, relative to current monitor
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Move window to adjacent workspace with the mouse wheel
hl.bind(mainShift .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainShift .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "m-1" }))

-- Move window to adjacent monitor with the mouse wheel
hl.bind(subShift .. " + mouse_down", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(subShift .. " + mouse_up", hl.dsp.window.move({ monitor = "-1" }))

-- Drag / resize with the mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
