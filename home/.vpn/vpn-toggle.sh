#!/bin/bash

VPN_PROC_NAME="openvpn"

if pgrep -x "openvpn" >/dev/null; then
  pkexec killall openvpn
  pkexec /usr/bin/sysctl -w net.ipv6.conf.all.disable_ipv6=0
else
  if pgrep -x "cyphergate.elf" >/dev/null; then
    notify-send "You've got cyphergate running" "Open it!"
  else
    gtk-launch CypherGate.desktop
  fi
fi
