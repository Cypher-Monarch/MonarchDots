#!/usr/bin/env bash

STEP=1
SOURCE="@DEFAULT_SOURCE@"

get_vol() {
  pactl get-source-volume "$SOURCE" | awk -F'/' '{print $2}' | tr -d ' %'
}

case "$1" in
up)
  vol=$(get_vol)
  if [ "$vol" -lt 100 ]; then
    pactl set-source-volume "$SOURCE" +${STEP}%
  fi
  ;;
down)
  pactl set-source-volume "$SOURCE" -${STEP}%
  ;;
mute)
  pactl set-source-mute "$SOURCE" toggle
  ;;
esac
