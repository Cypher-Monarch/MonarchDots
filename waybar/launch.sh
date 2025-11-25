#!/bin/bash
#                    __
#  _    _____ ___ __/ /  ___ _____
# | |/|/ / _ `/ // / _ \/ _ `/ __/
# |__,__/\_,_/\_, /_.__/\_,_/_/
#            /___/
#
# -----------------------------------------------------
# Quit all running waybar instances
# -----------------------------------------------------
pkill waybar
killall waybar
sleep 0.01

# -----------------------------------------------------
# Default theme: /THEMEFOLDER;/VARIATION
# -----------------------------------------------------
themestyle="/Monarch;/Monarch"

# -----------------------------------------------------
# Get current theme information from ~/.config/misc/settings/waybar-theme.sh
# -----------------------------------------------------
if [ -f ~/.config/misc/settings/waybar-theme.sh ]; then
  themestyle=$(cat ~/.config/misc/settings/waybar-theme.sh)
else
  touch ~/.config/misc/settings/waybar-theme.sh
  echo "$themestyle" >~/.config/misc/settings/waybar-theme.sh
fi

IFS=';' read -ra arrThemes <<<"$themestyle"
echo ":: Theme: ${arrThemes[0]}"

if [ ! -f ~/.config/waybar/themes${arrThemes[1]}/style.css ]; then
  themestyle="/misc;/misc/light"
fi

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------
config_file="config"
style_file="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f ~/.config/waybar/themes${arrThemes[0]}/config-custom ]; then
  config_file="config-custom"
fi
if [ -f ~/.config/waybar/themes${arrThemes[1]}/style-custom.css ]; then
  style_file="style-custom.css"
fi

# Check if waybar-disabled file exists
if [ ! -f $HOME/.config/misc/settings/waybar-disabled ]; then
  pgerp -x waybar >/dev/null || waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
else
  echo ":: Waybar disabled"
fi
