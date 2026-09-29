#!/usr/bin/env bash

set -euo pipefail

# ── Requirements ──────────────────────────────────────────────────────────────

for cmd in powerprofilesctl rofi; do
  command -v "$cmd" &>/dev/null || exit 1
done

# ── Appearance ────────────────────────────────────────────────────────────────

profile_icon() {
  case "$1" in
  performance) echo "󰓅" ;; # nf-md-speedometer
  balanced) echo "󰗑" ;;    # nf-md-scale_balance
  power-saver) echo "󱊣" ;; # nf-md-battery_high
  *) echo "󰁹" ;;           # nf-md-battery
  esac
}

profile_color() {
  case "$1" in
  performance) echo "#fabd2f" ;;
  balanced) echo "#bdae93" ;;
  power-saver) echo "#b8bb26" ;;
  *) echo "#83a598" ;;
  esac
}

# ── Profiles ──────────────────────────────────────────────────────────────────

current=$(powerprofilesctl get)

mapfile -t profiles < <(
  powerprofilesctl list |
    sed -nE 's/^[[:space:]]*\*?[[:space:]]*([[:alnum:]_-]+):$/\1/p'
)

((${#profiles[@]})) || exit 1

# Find current profile's row.
selected_row=0

for i in "${!profiles[@]}"; do
  if [[ "${profiles[$i]}" == "$current" ]]; then
    selected_row=$i
    break
  fi
done

# ── Menu ──────────────────────────────────────────────────────────────────────

options=""

for profile in "${profiles[@]}"; do
  icon=$(profile_icon "$profile")
  color=$(profile_color "$profile")

  if [[ "$profile" == "$current" ]]; then
    options+="<span foreground='$color'><b>● $icon  $profile</b></span>\n"
  else
    options+="<span foreground='$color'>  $icon  $profile</span>\n"
  fi
done

row=$(
  printf '%b' "$options" |
    rofi \
      -dmenu \
      -markup-rows \
      -format i \
      -selected-row "$selected_row" \
      -theme powerprofile.rasi \
      -p "Power Profile"
) || exit 0

# Rofi's `-format i` gives us the selected zero-based row.
if [[ "$row" =~ ^[0-9]+$ ]] && ((row < ${#profiles[@]})); then
  chosen="${profiles[$row]}"
else
  exit 1
fi

# ── Apply ─────────────────────────────────────────────────────────────────────

[[ "$chosen" == "$current" ]] && exit 0

if powerprofilesctl set "$chosen"; then
  notify-send \
    -a "Power Profile" \
    "Power profile changed" \
    "$(profile_icon "$chosen")  $chosen" \
    2>/dev/null || true
else
  notify-send \
    -a "Power Profile" \
    "Failed to change power profile" \
    "Could not switch to $chosen" \
    2>/dev/null || true
  exit 1
fi
