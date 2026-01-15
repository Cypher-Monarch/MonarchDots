#!/bin/bash

killall nwg-dock-hyprland
sleep 0.5
nwg-dock-hyprland -i 28 -w 3 -mb 5 -ml 5 -mr 5 -x -s style.css -c "rofi -show drun"
