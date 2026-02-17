#!/bin/bash

# Check dependencies
for cmd in curl base64 whiptail openvpn notify-send; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is not installed. Install it and retry." >&2
    exit 1
  fi
done

# Directories
VPN_ROOT="$HOME/.vpn"
PROFILE_DIR="$VPN_ROOT/servers"
LOG_DIR="$VPN_ROOT/logs"
CACHE_DIR="$VPN_ROOT/cache"
mkdir -p "$PROFILE_DIR" "$LOG_DIR" "$CACHE_DIR"

# Files
LOG_FILE="$LOG_DIR/vpn$(date).log"
CSV_URL="http://www.vpngate.net/api/iphone/"
CSV_FILE=$(mktemp)
CSV_CACHE="$CACHE_DIR/serverlist.csv"
COUNTRY_FILE="$VPN_ROOT/countries.conf"

# Ensure countries.conf exists
if [[ ! -f "$COUNTRY_FILE" ]]; then
  notify-send "⚠️ VPN" "Generating default countries.conf"
  cat <<EOF >"$COUNTRY_FILE"
Japan
United States
Germany
Singapore
India
Canada
France
Netherlands
South Korea
Australia
Brazil
United Kingdom
EOF
  echo "[INFO] Created default $COUNTRY_FILE" >>"$LOG_FILE"
fi

# Notify: starting
notify-send "🔐 VPN" "Fetching VPN server list..."

# Try to fetch server list
TRIES=3
SUCCESS=0

for i in $(seq 1 $TRIES); do
  curl -s --max-time 20 "$CSV_URL" -o "$CSV_FILE"
  if [[ -s "$CSV_FILE" ]]; then
    cp "$CSV_FILE" "$CSV_CACHE"
    SUCCESS=1
    break
  fi
  sleep 2
done

# Fallback to cache if needed
if [[ $SUCCESS -eq 0 ]]; then
  if [[ -f "$CSV_CACHE" ]]; then
    notify-send "⚠️ VPN" "Using cached VPN server list."
    cp "$CSV_CACHE" "$CSV_FILE"
    echo "[WARN] Using cached CSV at $(date)" >>"$LOG_FILE"
  else
    notify-send "❌ VPN" "Failed to get VPN list. No cache available."
    echo "[ERROR] No server list. Exiting." >>"$LOG_FILE"
    exit 1
  fi
fi

# Parse country list
declare -A countries
while read -r country; do
  [[ -n "$country" ]] && countries["$country"]=1
done <"$COUNTRY_FILE"

# Parse CSV
declare -A saved
while IFS= read -r line; do
  [[ "$line" == \** || -z "$line" ]] && continue
  IFS=',' read -ra FIELDS <<<"$line"
  Country="${FIELDS[5]}"
  OpenVPN_Base64="${FIELDS[-1]}"

  if [[ ${countries[$Country]} ]] && [[ -z ${saved[$Country]} ]]; then
    OVPN_PATH="$PROFILE_DIR/$Country.ovpn"
    echo "$OpenVPN_Base64" | tr -d '\r\n' | base64 -d >"$OVPN_PATH" 2>/dev/null

    if [[ $? -eq 0 ]]; then
      grep -q "^data-ciphers" "$OVPN_PATH" &&
        sed -i 's/^data-ciphers.*/data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC/' "$OVPN_PATH" ||
        echo "data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC" >>"$OVPN_PATH"

      grep -q "^cipher" "$OVPN_PATH" || echo "cipher AES-128-CBC" >>"$OVPN_PATH"

      echo "[INFO] Saved and patched config for $Country" >>"$LOG_FILE"
      saved[$Country]=1
    fi
  fi

  [[ ${#saved[@]} -eq ${#countries[@]} ]] && break
done < <(tail -n +2 "$CSV_FILE")

rm "$CSV_FILE"

[[ ${#saved[@]} -eq 0 ]] && {
  notify-send "❌ VPN" "No valid servers found."
  echo "[ERROR] No valid configs found at $(date)" >>"$LOG_FILE"
  exit 1
}

# Whiptail menu
MENU_OPTIONS=()
for country in "${!saved[@]}"; do
  MENU_OPTIONS+=("$country" "VPNGate Server from $country")
done

CHOICE=$(whiptail --title "VPNGate Servers" --menu "Select a VPN server to connect:" 15 60 6 "${MENU_OPTIONS[@]}" 3>&1 1>&2 2>&3)

if [[ -z "$CHOICE" ]]; then
  notify-send "VPN" "❎ No server selected. Aborted."
  echo "[INFO] No selection made at $(date)" >>"$LOG_FILE"
  exit 0
fi

notify-send "VPN" "🔄 Connecting to $CHOICE..."
echo "[INFO] Connecting to $CHOICE at $(date)" >>"$LOG_FILE"

# Connect
sudo openvpn --config "$PROFILE_DIR/$CHOICE.ovpn" >>"$LOG_FILE" 2>&1 &

VPN_PID=$!
sleep 5

# Get external IP
IP=$(curl -s --max-time 10 https://ipinfo.io/ip)
[[ -n "$IP" ]] && {
  notify-send "🔒 VPN Connected" "Location: $CHOICE\nIP: $IP"
  echo "[INFO] VPN connected to $CHOICE with IP: $IP" >>"$LOG_FILE"
} || {
  notify-send "⚠️ VPN" "Connected to $CHOICE, but IP fetch failed."
  echo "[WARN] Connected, but IP fetch failed." >>"$LOG_FILE"
}

# Wait until disconnected
wait $VPN_PID
notify-send "📴 VPN" "Disconnected from $CHOICE."
echo "[INFO] VPN disconnected at $(date)" >>"$LOG_FILE"
