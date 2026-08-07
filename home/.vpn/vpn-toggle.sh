#!/bin/bash

SOCKET="/run/cyphergate/cyphergated.sock"

echo "[INFO] Querying CypherGate daemon..."

RESPONSE=$(printf '{"action":"STATUS"}' | nc -U "$SOCKET")

status=$(jq -r '.status' <<<"$RESPONSE")
ipv6_disabled=$(jq -r '.ipv6_disabled' <<<"$RESPONSE")

echo "[INFO] VPN Status: $status"
echo "[INFO] IPv6 Disabled: $ipv6_disabled"

case "$status" in
CONNECTED | CONNECTING)
  echo "[INFO] VPN is active. Initiating disconnect..."

  if [ "$ipv6_disabled" = "true" ]; then
    echo "[INFO] Re-enabling IPv6..."
    printf '{"action":"ENABLE_IPV6"}' | nc -U "$SOCKET"
  else
    echo "[INFO] IPv6 already enabled."
  fi

  echo "[INFO] Sending STOP_VPN request..."
  printf '{"action":"STOP_VPN"}' | nc -U "$SOCKET"

  echo "[INFO] Disconnect request sent."
  ;;

*)
  echo "[INFO] VPN is not active."

  if pgrep -x "cyphergate" >/dev/null; then
    echo "[INFO] CypherGate is already running."
    notify-send "CypherGate" "CypherGate is already running."
  else
    echo "[INFO] Launching CypherGate..."
    gtk-launch CypherGate.desktop
  fi
  ;;
esac
