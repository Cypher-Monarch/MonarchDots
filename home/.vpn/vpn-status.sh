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

  echo " $flag $country"
else
  echo " VPN OFF"
fi
