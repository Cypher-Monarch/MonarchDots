#!/bin/bash

RESPONSE=$(printf '{"action":"STATUS"}' | nc -U /run/cyphergate/cyphergated.sock)

started_at=$(jq -r '.started_at' <<<"$RESPONSE" | cut -d. -f1)
now=$(date +%s)

uptime=$((now - started_at))

days=$((uptime / 86400))
hours=$(((uptime % 86400) / 3600))
minutes=$(((uptime % 3600) / 60))
seconds=$((uptime % 60))

echo "$days d $hours h $minutes m $seconds s"
