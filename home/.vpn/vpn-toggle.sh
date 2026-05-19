#!/bin/bash

VPN_PROC_NAME="openvpn"

if pgrep -x "openvpn" >/dev/null; then
  python -c "import json, socket                     
  sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
  sock.connect('/tmp/cyphergate-root-handler.sock')
  sock.send(json.dumps({'action':'STOP_VPN'}).encode())
  sock.send(json.dumps({'action':'ENABLE_IPV6'}).encode())
  sock.close()"
else
  if pgrep -x "cyphergate" >/dev/null; then
    notify-send "You've got cyphergate running" "Open it!"
  else
    gtk-launch CypherGate.desktop
  fi
fi
