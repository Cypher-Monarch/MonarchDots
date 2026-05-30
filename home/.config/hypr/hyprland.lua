--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- -----------------------------------------------------
-- Monitor
-- -----------------------------------------------------

-- Source: ~/.config/hypr/conf/monitor.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.monitor")

-- -----------------------------------------------------
-- Cursor
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/cursor.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.cursor")

-- -----------------------------------------------------
-- Environment
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/environment.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.environment")

-- -----------------------------------------------------
-- Keyboard
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/keyboard.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.keyboard")

-- -----------------------------------------------------
-- Autostart
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/autostart.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.autostart")

-- -----------------------------------------------------
-- Load configuration files
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/window.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.window")
-- Source: ~/.config/hypr/conf/decoration.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.decoration")
-- Source: ~/.config/hypr/conf/layout.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.layout")
-- Source: ~/.config/hypr/conf/workspace.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.workspace")
-- Source: ~/.config/hypr/conf/misc.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.misc")
-- Source: ~/.config/hypr/conf/keybinding.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.keybinding")
-- Source: ~/.config/hypr/conf/windowrule.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.windowrule")

-- -----------------------------------------------------
-- Animation
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/animation.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.animation")

-- -----------------------------------------------------
-- Environment for xdg-desktop-portal-hyprland
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Custom
-- -----------------------------------------------------
-- Source: ~/.config/hypr/conf/custom.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("conf.custom")

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

