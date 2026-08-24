#!/bin/bash

status=$(printf '{"action": "STATUS"}' | nc -U /run/cyphergate/cyphergated.sock)

if [[ $(jq -r '.status' <<<"$status") == "CONNECTED" ]]; then
  country=$(jq -r '.country' <<<"$status")

  case "$country" in
  Japan) flag="🇯🇵" ;;
  "United States") flag="🇺🇸" ;;
  India) flag="🇮🇳" ;;
  Germany) flag="🇩🇪" ;;
  Brazil) flag="🇧🇷" ;;
  "Viet Nam") flag="🇻🇳" ;;
  "Korea Republic of") flag="🇰🇷" ;;
  "Russian Federation") flag="🇷🇺" ;;
  Thailand) flag="🇹🇭" ;;
  China) flag="🇨🇳" ;;
  *) flag="🌐" ;;
  esac

  uptime=$(~/.vpn/vpn-uptime.sh)

  jq -cn \
    --arg text " $flag $country" \
    --arg tooltip "$uptime" \
    '{text: $text, tooltip: $tooltip, class: "connected"}'
else
  jq -cn \
    --arg text " VPN OFF" \
    --arg tooltip "VPN is not connected" \
    '{text: $text, tooltip: $tooltip, class: "disconnected"}'
fi
