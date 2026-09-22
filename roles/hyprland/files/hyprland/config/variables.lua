-- Default apps, mod keys, monitors, workspace count.
-- Consumed by binds.lua and custom.lua (globals, no `local`, so require() order matters:
-- this file must load before anything that reads them).

TERMINAL = "kitty"
FILE_MANAGER = "thunar"
MENU = "hyprlauncher"
CALCULATOR = "gnome-calculator"
POWERMENU = os.getenv("HOME") .. "/.config/hypr/scripts/powermenu.sh"

-- Optional text editor quick-launch (SUPER + T in binds.lua is commented out until this is set).
-- EDITOR = "your-editor-here"

-- Monitor output names, e.g. "DP-1" / "HDMI-A-1" (run `hyprctl monitors` to list yours).
-- Left blank here since these are per-machine; override in custom.lua once you know your
-- hardware's output names. Used by binds.lua's per-monitor focus/move keybinds.
MONITOR1 = ""
MONITOR2 = ""

MAINMOD = "ALT"
SUBMOD = "SUPER"

-- Number of workspaces per monitor (max 10)
NUM_WPM = 10
