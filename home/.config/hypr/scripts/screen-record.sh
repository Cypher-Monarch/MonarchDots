#!/bin/bash
# Hyprland Rofi screen recording script — CypherMonarch style
# ------------------------------------------------------------

# Load config
record_folder="$HOME/Videos/Screen-Recordings" 
audio_enabled=false
rofi_config="$HOME/.config/rofi/config-screenshot.rasi"

# Temp rofi theme for input prompt with inputbar
rofi_input_config="/tmp/rofi-input-config.rasi"
sed 's/^ *main-children:.*/    main-children: [ "inputbar", "listbox" ];/' "$rofi_config" > "$rofi_input_config"

# Options
option_1="Immediate"
option_2="Delayed"
option_capture_1="Capture Everything"
option_capture_2="Capture Active Display"
option_capture_3="Capture Selection"
option_time_1="5s"
option_time_2="10s"
option_time_3="20s"
option_time_4="30s"
option_time_5="60s"

# Rofi wrappers
rofi_cmd() { rofi -dmenu -config "$rofi_config" -i -no-show-icons -width 30 -p "Record Screen"; }
timer_cmd() { rofi -dmenu -config "$rofi_config" -i -no-show-icons -width 30 -p "Choose Timer"; }
type_cmd() { rofi -dmenu -config "$rofi_config" -i -no-show-icons -width 30 -p "Recording Area"; }

# Selections
select_mode() {
    echo -e "$option_1\n$option_2" | rofi_cmd
}
select_type() {
    echo -e "$option_capture_1\n$option_capture_2\n$option_capture_3" | type_cmd
}
select_timer() {
    echo -e "$option_time_1\n$option_time_2\n$option_time_3\n$option_time_4\n$option_time_5" | timer_cmd
}

# Countdown notifier
run_countdown() {
    secs=$1
    if [[ $secs -gt 10 ]]; then
        notify-send -t 1000 "🎬 Starting in $secs seconds..."
        sleep $((secs - 10))
        secs=10
    fi
    while [[ $secs -gt 0 ]]; do
        notify-send -t 1000 "🎬 $secs..."
        sleep 1
        secs=$((secs - 1))
    done
}

# Clean up title metadata
clean_metadata() {
    ffmpeg -i "$1" -metadata title="" -c copy "${1%.mp4}_clean.mp4" -loglevel quiet && mv "${1%.mp4}_clean.mp4" "$1"
}

    # Actual recording logic
    start_recording() {
        local type=$1
        local delay=$2

        mkdir -p "$record_folder"

    # 📛 Ask for filename
    custom_name=$(rofi -dmenu -config "$rofi_input_config" -p "Recording name" -l 1 -lines 0 -mesg "Leave blank to use timestamp")

    # Trim whitespace
    custom_name=$(echo "$custom_name" | xargs)

    # Fallback to timestamp if blank
    if [[ -z "$custom_name" ]]; then
        custom_name="recording_$(date +'%Y-%m-%d_%H-%M-%S')"
    fi

    output="$record_folder/${custom_name}.mp4"


    # 📷 Build wf-recorder command
    cmd=(wf-recorder -f "$output")

    if [[ "$type" == "$option_capture_3" ]]; then
        notify-send "🖱️ Select area..."
        region=$(slurp)
        [[ -z "$region" ]] && notify-send "❌ Cancelled" && exit 1
        cmd+=(-g "$region")
    elif [[ "$type" == "$option_capture_2" ]]; then
        monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
        [[ -z "$monitor" ]] && notify-send "❌ No active monitor" && exit 1
        cmd+=(-o "$monitor")
    fi

    [[ "$audio_enabled" == "true" ]] && cmd+=(-a)
    [[ "$delay" -gt 0 ]] && run_countdown "$delay"

    # 🔴 Start recording
    notify-send "🔴 Recording started..."
    "${cmd[@]}"
    notify-send "⏹️ Recording saved to $output"

    # 🧼 Remove metadata title
    clean_metadata "$output"
}

# 🎯 Stop logic if already recording
if pgrep -x wf-recorder > /dev/null; then
    stop_choice=$(echo -e "🛑 Stop Recording\n❌ Cancel" | rofi -dmenu -config "$rofi_config" -i -no-show-icons -width 30 -p "Recording in progress")
    case "$stop_choice" in
        "🛑 Stop Recording")
            pkill -INT wf-recorder && notify-send "🛑 Recording stopped"
            exit 0
            ;;
        *) exit 0 ;;
    esac
fi

# 🧠 Main flow
mode=$(select_mode)
[[ -z "$mode" ]] && exit

area=$(select_type)
[[ -z "$area" ]] && exit

delay=0
if [[ "$mode" == "$option_2" ]]; then
    timer=$(select_timer)
    case "$timer" in
        "$option_time_1") delay=5 ;;
        "$option_time_2") delay=10 ;;
        "$option_time_3") delay=20 ;;
        "$option_time_4") delay=30 ;;
        "$option_time_5") delay=60 ;;
        *) exit ;;
    esac
fi

start_recording "$area" "$delay"
