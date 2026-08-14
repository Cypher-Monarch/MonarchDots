#!/bin/bash

RESPONSE=$(printf '{"action":"STATUS"}' |
  nc -U /run/cyphergate/cyphergated.sock)

started_at=$(jq -r '.started_at // empty' <<<"$RESPONSE")

if [[ -z "$started_at" ]]; then
  echo "No VPN process running"
  exit 0
fi

started_at=${started_at%%.*}
now=$(date +%s)
uptime=$((now - started_at))

days=$((uptime / 86400))
hours=$(((uptime % 86400) / 3600))
minutes=$(((uptime % 3600) / 60))
seconds=$((uptime % 60))

printf 'uptime: '

((days > 0)) && printf '%dd ' "$days"
((hours > 0 || days > 0)) && printf '%dh ' "$hours"
((minutes > 0 || hours > 0 || days > 0)) && printf '%dm ' "$minutes"
printf '%ds\n' "$seconds"
