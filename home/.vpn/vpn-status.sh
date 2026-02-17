#!/bin/bash

process=$(pgrep -a openvpn | grep -i openvpn)

if [ -n "$process" ]; then
  country=$(echo "$process" | grep -oP '[^/]+(?=\.ovpn$)')
  country=${country//_/ }

  case "$country" in
  Japan) flag="🇯🇵" ;;
  United\ States) flag="🇺🇸" ;;
  India) flag="🇮🇳" ;;
  Germany) flag="🇩🇪" ;;
  Brazil) flag="🇧🇷" ;;
  Viet\ Nam) flag="🇻🇳" ;;
  Korea\ Republic\ of) flag="🇰🇷" ;;
  Russian\ Federation) flag="🇷🇺" ;;
  Thailand) flag="🇹🇭" ;;
  *) flag="🌐" ;;
  esac

  echo " $flag $country"
else
  echo " VPN OFF"
fi
