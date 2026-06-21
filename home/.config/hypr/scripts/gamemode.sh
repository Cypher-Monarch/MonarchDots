#!/bin/bash
#   ____                                          _
#  / ___| __ _ _ __ ___   ___ _ __ ___   ___   __| | ___
# | |  _ / _` | '_ ` _ \ / _ \ '_ ` _ \ / _ \ / _` |/ _ \
# | |_| | (_| | | | | | |  __/ | | | | | (_) | (_| |  __/
#  \____|\__,_|_| |_| |_|\___|_| |_| |_|\___/ \__,_|\___|
#
#

if [ -f $HOME/.config/misc/settings/gamemode-enabled ]; then
  hyprctl reload
  rm $HOME/.config/misc/settings/gamemode-enabled
  notify-send "Gamemode deactivated" "Animations and blur enabled"
else
  hyprctl eval '
    hl.config({
        animations = {
            enabled = false,
        },
        decoration = {
            rounding = 0,
            shadow = { enabled = false },
            blur = { enabled = false },
        },
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 1,
        },
    })'
  touch $HOME/.config/misc/settings/gamemode-enabled
  notify-send "Gamemode activated" "Animations and blur disabled"
fi
