#!/usr/bin/env bash

set -u

#  _   _                      _               _
# | | | |_   _ _ __  _ __ ___| |__   __ _  __| | ___
# | |_| | | | | '_ \| '__/ __| '_ \ / _` |/ _` |/ _ \
# |  _  | |_| | |_) | |  \__ \ | | | (_| | (_| |  __/
# |_| |_|\__, | .__/|_|  |___/_| |_|\__,_|\__,_|\___|
#        |___/|_|

readonly SETTINGS_FILE="$HOME/.config/misc/settings/hyprshade.sh"
readonly ROFI_CONFIG="$HOME/.config/rofi/hyprshade.rasi"
readonly DEFAULT_FILTER="blue-light-filter-50"

notify() {
  notify-send "Hyprshade" "$1"
}

# Return the currently configured filter.
get_configured_filter() {
  local filter="$DEFAULT_FILTER"

  if [[ -f "$SETTINGS_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$SETTINGS_FILE"

    filter="${hyprshade_filter:-$DEFAULT_FILTER}"
  fi

  # Normalize whitespace from old/broken config files.
  filter="$(printf '%s' "$filter" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"

  printf '%s\n' "$filter"
}

# hyprshade ls currently outputs filter names with indentation.
# Strip that whitespace before using the names as arguments.
get_filters() {
  hyprshade ls |
    sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//' |
    sed '/^$/d'
}

# Make the Rofi menu a little nicer with Nerd Font icons.
filter_icon() {
  case "$1" in
  blue-light-filter-25)
    printf '󰌵'
    ;;
  blue-light-filter-50)
    printf '󰌵'
    ;;
  blue-light-filter-75)
    printf '󰌵'
    ;;
  invert-colors)
    printf '󰍉'
    ;;
  off)
    printf '󰂭'
    ;;
  *)
    printf '󰘳'
    ;;
  esac
}

# ─────────────────────────────────────────────
# Rofi selector
# ─────────────────────────────────────────────

if [[ "${1:-}" == "rofi" ]]; then

  # Make sure required programs exist.
  if ! command -v hyprshade >/dev/null 2>&1; then
    notify "hyprshade is not installed."
    exit 1
  fi

  if ! command -v rofi >/dev/null 2>&1; then
    notify "rofi is not installed."
    exit 1
  fi

  mapfile -t filters < <(get_filters)

  # Always provide the option to disable the shader.
  filters+=("off")

  # Build the Rofi menu.
  options=""

  for filter in "${filters[@]}"; do
    icon="$(filter_icon "$filter")"
    options+="${icon}  ${filter}"$'\n'
  done

  # Determine which filter is currently configured.
  current_filter="$(get_configured_filter)"

  # Find its row so Rofi opens with the current choice selected.
  selected_row=0

  for i in "${!filters[@]}"; do
    if [[ "${filters[$i]}" == "$current_filter" ]]; then
      selected_row="$i"
      break
    fi
  done

  choice="$(
    printf '%s' "$options" |
      rofi \
        -dmenu \
        -replace \
        -config "$ROFI_CONFIG" \
        -i \
        -no-show-icons \
        -p "Hyprshade" \
        -selected-row "$selected_row" \
        -format i
  )"

  # User pressed Escape / closed Rofi.
  if [[ -z "$choice" ]]; then
    exit 0
  fi

  # -format i gives us the selected row number.
  choice="${filters[$choice]}"

  # Save the selected filter.
  mkdir -p "$(dirname "$SETTINGS_FILE")"
  printf 'hyprshade_filter=%q\n' "$choice" >"$SETTINGS_FILE"

  if [[ "$choice" == "off" ]]; then
    hyprshade off
    notify "Hyprshade deactivated"
    echo ":: hyprshade turned off"
  else
    notify "Changing Hyprshade to $choice" \
      "Toggle shader with SUPER+SHIFT+H"

    echo ":: hyprshade filter set to $choice"
  fi

  exit 0
fi

# ─────────────────────────────────────────────
# Toggle mode
# ─────────────────────────────────────────────

if ! command -v hyprshade >/dev/null 2>&1; then
  echo ":: hyprshade is not installed"
  exit 1
fi

hyprshade_filter="$(get_configured_filter)"

# If the configured filter is "off", make absolutely sure
# hyprshade isn't running.
if [[ "$hyprshade_filter" == "off" ]]; then
  hyprshade off
  echo ":: hyprshade turned off"
  exit 0
fi

# Check whether a shader is currently active.
current_filter="$(hyprshade current 2>/dev/null || true)"

if [[ -z "$current_filter" ]]; then

  echo ":: hyprshade is not running"
  echo ":: starting with $hyprshade_filter"

  if ! hyprshade on "$hyprshade_filter"; then
    notify "Failed to activate Hyprshade" \
      "Could not load '$hyprshade_filter'"
    exit 1
  fi

  current_filter="$(hyprshade current 2>/dev/null || true)"

  notify "Hyprshade activated" \
    "with ${current_filter:-$hyprshade_filter}"

  echo ":: hyprshade started with ${current_filter:-$hyprshade_filter}"

else

  echo ":: Current hyprshade: $current_filter"
  echo ":: Switching hyprshade off"

  hyprshade off

  notify "Hyprshade deactivated"

fi
