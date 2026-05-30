--    ___       __           __           __
--   / _ |__ __/ /____  ___ / /____ _____/ /_
--  / __ / // / __/ _ \(_-</ __/ _ `/ __/ __/
-- /_/ |_\_,_/\__/\___/___/\__/\_,_/_/  \__/
--

-- Setup XDG for screen sharing and start waypaper and waybar

-- Start Polkit

-- Load Wallpaper

-- Load Notification Daemon

-- Load GTK settings

-- Using hypridle to start hyprlock

-- Load cliphist history

-- Start autostart cleanup

-- Dock
-- exec-once = ~/.config/nwg-dock-hyprland/launch.sh

--AWWW

--Gnome Keyring

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper-restore.sh")
    hl.exec_cmd("swaync")
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)

