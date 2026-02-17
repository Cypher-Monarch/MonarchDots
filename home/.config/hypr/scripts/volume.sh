#!/usr/bin/env bash

STEP=1
SINK="@DEFAULT_SINK@"

get_vol() {
  pactl get-sink-volume "$SINK" | awk -F'/' '{print $2}' | tr -d ' %'
}

case "$1" in
up)
  vol=$(get_vol)
  if [ "$vol" -lt 100 ]; then
    pactl set-sink-volume "$SINK" +${STEP}%
  fi
  ;;
down)
  pactl set-sink-volume "$SINK" -${STEP}%
  ;;
mute)
  pactl set-sink-mute "$SINK" toggle
  ;;
esac
