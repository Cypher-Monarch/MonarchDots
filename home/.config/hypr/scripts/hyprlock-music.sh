#!/usr/bin/env bash

CACHE_DIR="${XDG_RUNTIME_DIR:-/tmp}/hyprlock-music"
ART="$CACHE_DIR/cover.jpg"
mkdir -p "$CACHE_DIR"

get_art() {
    local url
    url="$(playerctl metadata mpris:artUrl 2>/dev/null)"

    [[ -z "$url" ]] && return 1

    # Local artwork
    if [[ "$url" == file://* ]]; then
        url="${url#file://}"
        url="${url//%20/ }"

        [[ -f "$url" ]] || return 1

        printf '%s\n' "$url"
        return 0
    fi

    # Remote artwork
    local hash
    hash="$(printf '%s' "$url" | sha256sum | cut -d' ' -f1)"
    local cached="$CACHE_DIR/$hash"

    if [[ ! -f "$cached" ]]; then
        curl \
            --silent \
            --show-error \
            --fail \
            --location \
            --max-time 5 \
            "$url" \
            -o "$cached.tmp" 2>/dev/null || {
                rm -f "$cached.tmp"
                return 1
            }

        mv "$cached.tmp" "$cached"
    fi

    printf '%s\n' "$cached"
}

case "$1" in

    title)
        playerctl metadata \
            --format '{{ title }}' \
            2>/dev/null
        ;;

    artist)
        playerctl metadata \
            --format '{{ artist }}' \
            2>/dev/null
        ;;

    album)
        playerctl metadata \
            --format '{{ album }}' \
            2>/dev/null
        ;;

    status)
        playerctl status 2>/dev/null
        ;;

    position)
        playerctl position \
            --format '{{ duration(position) }}' \
            2>/dev/null
        ;;

    duration)
        playerctl metadata \
            --format '{{ duration(mpris:length) }}' \
            2>/dev/null
        ;;

    art)
        get_art
        ;;

    player)
        playerctl metadata \
            --format '{{ playerName }}' \
            2>/dev/null
        ;;

    *)
        echo "usage: $0 {title|artist|album|status|position|duration|art|player}"
        exit 1
        ;;

esac
