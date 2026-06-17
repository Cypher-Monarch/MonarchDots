-- -----------------------------------------------------
-- Key bindings
-- -----------------------------------------------------

-- SUPER KEY

local mainMod = "SUPER"
local HYPRSCRIPTS = "~/.config/hypr/scripts"
local SCRIPTS = "~/.config/misc/scripts"
local TERMINAL = "kitty"
local BROWSER = "gtk-launch zen.desktop"
local FILEMANAGER = "dolphin"
local CALCULATOR = "gnome-calculator"

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(BROWSER))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FILEMANAGER))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(CALCULATOR))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/launch-music.sh"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen 'https://web.whatsapp.com'"))
hl.bind(mainMod .. " + CTRL + V", hl.dsp.exec_cmd("~/.vpn/vpn-toggle.sh"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.config/nwg-dock-hyprland/launch.sh"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("eww open --toggle music-widget"))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd("kitty -e btop-root"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/powerprofile.sh"))
hl.bind("ALT + P", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprpicker.sh"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("krunner --replace"))
hl.bind(mainMod .. " + CTRL + o", hl.dsp.exec_cmd("onlyoffice-desktopeditors"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(
	mainMod .. " + PERIOD",
	hl.dsp.exec_cmd('rofimoji --selector rofi --selector-args "-theme ~/.config/rofi/config-emoji.rasi"')
)
hl.bind("ALT + K", hl.dsp.exec_cmd("env XDG_MENU_PREFIX=arch- kbuildsycoca6"))

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 }))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + T", function()
	hl.exec_cmd("hyprctl dispatch workspaceopt allfloat")
end)
-- bind = $mainMod, J, togglesplit                                                             # Toggle split
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
-- bind = $mainMod, K, swapsplit                                                               # Swapsplit
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(""), { repeating = true })
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { repeating = true })
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.window.pseudo())

-- Actions
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("~/.config/misc/scripts/wlogout.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/wallpaper-automation.sh"))
hl.bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/keybindings.sh"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/toggle.sh"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/loadconfig.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(SCRIPTS .. "/cliphist.sh"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh rofi"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-record.sh"))

-- Volume Actions
hl.bind("ALT + Up", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh up"))
hl.bind("ALT + Down", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh down"))
hl.bind("ALT + M", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh mute"))

-- Mic Actions
hl.bind("CTRL + Left", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh down"))
hl.bind("CTRL + Right", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh up"))
hl.bind("CTRL + SHIFT + M", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh mute"))

-- Headphones
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
-- bind = , mouse:276, exec, playerctl next
-- bind = , mouse:275, exec, playerctl previous

-- Workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + CTRL + 1", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 1"))
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 2"))
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 3"))
hl.bind(mainMod .. " + CTRL + 4", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 4"))
hl.bind(mainMod .. " + CTRL + 5", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 5"))
hl.bind(mainMod .. " + CTRL + 6", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 6"))
hl.bind(mainMod .. " + CTRL + 7", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 7"))
hl.bind(mainMod .. " + CTRL + 8", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 8"))
hl.bind(mainMod .. " + CTRL + 9", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 9"))
hl.bind(mainMod .. " + CTRL + 0", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 10"))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))
