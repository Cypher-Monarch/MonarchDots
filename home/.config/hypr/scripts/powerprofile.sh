#!/bin/bash

options="<span foreground='#fabd2f'>performance ⚡</span>\n<span foreground='#bdae93'>balanced 🟰</span>\n<span foreground='#b8bb26'>power-saver 🌱</span>"

chosen=$(echo -e "$options" | rofi -dmenu -markup-rows -theme powerprofile.rasi -p "Power Profile")

# strip markup before passing to powerprofilesctl
chosen=$(echo "$chosen" | sed -E 's/<[^>]+>//g' | awk '{print $1}')

if [[ -n "$chosen" ]]; then
  powerprofilesctl set "$chosen"
fi
