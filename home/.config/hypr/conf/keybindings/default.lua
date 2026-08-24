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
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(TERMINAL)) -- Open the terminal
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(BROWSER)) -- Open the browser
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FILEMANAGER)) -- Open the filemanager
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(CALCULATOR)) -- Open the calculator
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("discord")) -- Open Discord
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e nvim")) -- Open NVIM
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/launch-music.sh")) -- Open the default music player
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd("obs")) -- Open OBS studio
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen 'https://web.whatsapp.com'")) -- Open whatsapp web
hl.bind(mainMod .. " + CTRL + V", hl.dsp.exec_cmd("~/.vpn/vpn-toggle.sh")) -- Open custom vpn utility
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.config/nwg-dock-hyprland/launch.sh")) -- Toggle the dock
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("eww open --toggle music-widget"))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("swaync-client -t")) -- Toggle swaync-client
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd("kitty -e btop-root")) -- Open btop
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/powerprofile.sh")) -- powerprofile
hl.bind("ALT + P", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprpicker.sh")) -- Open Hyprpicker
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("krunner --replace")) -- krunner
hl.bind(mainMod .. " + CTRL + o", hl.dsp.exec_cmd("onlyoffice-desktopeditors")) -- Open Onlyoffice
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("playerctl previous")) -- Previous song
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("playerctl next")) -- Next song
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("playerctl play-pause")) -- Toggle player play - pause
hl.bind(
	mainMod .. " + PERIOD",
	hl.dsp.exec_cmd('rofimoji --selector rofi --selector-args "-theme ~/.config/rofi/config-emoji.rasi"')
) -- open the emoji picker
hl.bind("ALT + K", hl.dsp.exec_cmd("env XDG_MENU_PREFIX=arch- kbuildsycoca6")) -- Reset KDE app cache
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("~/.local/bin/nf-glyph")) -- open nerd glyph picker

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Kill active window
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill")) -- Quit active window and all open instances
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" })) -- Set active window to fullscreen
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" })) -- Maximize Window
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 })) -- Toggle floating fullscreen
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" })) -- Toggle active windows into floating mode
hl.bind(mainMod .. " + SHIFT + T", function()
	hl.exec_cmd("hyprctl dispatch workspaceopt allfloat")
end) -- Toggle all windows into floating mode
-- bind = $mainMod, J, togglesplit                                                             # Toggle split
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" })) -- Move focus left
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" })) -- Move focus right
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" })) -- Move focus up
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" })) -- Move focus down
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag()) -- Move window with the mouse
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize()) -- Resize window with the mouse
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true })) -- Increase window width with keyboard
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true })) -- Reduce window width with keyboard
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true })) -- Increase window height with keyboard
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true })) -- Reduce window height with keyboard
hl.bind(mainMod .. " + G", hl.dsp.group.toggle()) -- Toggle window group
-- bind = $mainMod, K, swapsplit                                                               # Swapsplit
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" })) -- Swap tiled window left
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" })) -- Swap tiled window right
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" })) -- Swap tiled window up
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" })) -- Swap tiled window down
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(""), { repeating = true }) -- Cycle between windows
hl.bind("ALT + Tab", hl.dsp.window.bring_to_top(), { repeating = true }) -- Bring active window to the top
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.window.pseudo()) -- Toggle pseudo tile

-- Actions
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload")) -- Reload Hyprland configuration
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh")) -- Toggle animations
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh")) -- Take a screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copy area")) -- Take a screenshot
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("grimblast copy screen")) -- Take a screenshot
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("~/.config/misc/scripts/wlogout.sh")) -- Start wlogout
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper --random")) -- random wallpaper
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("waypaper")) -- Open wallpaper selector
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/wallpaper-automation.sh")) -- Start random wallpaper script
hl.bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("pkill rofi || rofi -show drun")) -- Open application launcher
hl.bind(mainMod .. " + CTRL + K", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/keybindings.sh")) -- Show keybindings
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh")) -- Reload waybar
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/toggle.sh")) -- Toggle waybar
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/loadconfig.sh")) -- Reload hyprland config
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(SCRIPTS .. "/cliphist.sh")) -- Open clipboard manager
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh")) -- Open waybar theme switcher
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh")) -- Toggle screenshader
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh rofi")) -- Toggle screenshader
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh")) -- Toggle game mode
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock")) -- Start wlogout
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-record.sh")) -- Start screen recording

-- Volume Actions
hl.bind("ALT + Up", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh up")) -- increment volume
hl.bind("ALT + Down", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh down")) -- decrement volume
hl.bind("ALT + M", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/volume.sh mute")) -- mute speakers

-- Mic Actions
hl.bind("CTRL + Left", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh down")) -- increment mic volume
hl.bind("CTRL + Right", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh up")) -- decrement mic volume
hl.bind("CTRL + SHIFT + M", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/mic.sh mute")) -- mute microphone

-- Headphones
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
-- bind = , mouse:276, exec, playerctl next
-- bind = , mouse:275, exec, playerctl previous

-- Workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 })) -- Open workspace 1
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 })) -- Open workspace 2
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 })) -- Open workspace 3
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 })) -- Open workspace 4
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 })) -- Open workspace 5
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 })) -- Open workspace 6
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 })) -- Open workspace 7
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 })) -- Open workspace 8
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 })) -- Open workspace 9
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 })) -- Open workspace 10

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 })) -- Move active window to workspace 1
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 })) -- Move active window to workspace 2
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 })) -- Move active window to workspace 3
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 })) -- Move active window to workspace 4
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 })) -- Move active window to workspace 5
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 })) -- Move active window to workspace 6
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 })) -- Move active window to workspace 7
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 })) -- Move active window to workspace 8
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 })) -- Move active window to workspace 9
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 })) -- Move active window to workspace 10

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" })) -- Open next workspace
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" })) -- Open previous workspace

hl.bind(mainMod .. " + CTRL + 1", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 1")) -- Move all windows to workspace 1
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 2")) -- Move all windows to workspace 2
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 3")) -- Move all windows to workspace 3
hl.bind(mainMod .. " + CTRL + 4", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 4")) -- Move all windows to workspace 4
hl.bind(mainMod .. " + CTRL + 5", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 5")) -- Move all windows to workspace 5
hl.bind(mainMod .. " + CTRL + 6", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 6")) -- Move all windows to workspace 6
hl.bind(mainMod .. " + CTRL + 7", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 7")) -- Move all windows to workspace 7
hl.bind(mainMod .. " + CTRL + 8", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 8")) -- Move all windows to workspace 8
hl.bind(mainMod .. " + CTRL + 9", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 9")) -- Move all windows to workspace 9
hl.bind(mainMod .. " + CTRL + 0", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh 10")) -- Move all windows to workspace 10

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- Open next workspace
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- Open previous workspace
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Open the next empty workspace

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))
