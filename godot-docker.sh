#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Set log file path relative to script location
LOGFILE="$SCRIPT_DIR/godot-docker.log"
# Redirect stdout and stderr to the log file
exec >"$LOGFILE" 2>&1

# Find HDMI card and device (example parsing)
device_info=$(aplay -l | grep -A 1 'HDMI' | grep 'device' | head -n 1 | awk '{print $2}' | tr -d ':')
card_num=$(echo "$device_info" | cut -d',' -f1 | sed 's/card//')
dev_num=$(echo "$device_info" | cut -d',' -f2 | sed 's/device//')

# Fallback if nothing found
card_num=${card_num:-0}
dev_num=${dev_num:-9}

cat > ./asound.conf <<EOF
pcm.!default {
    type plug
    slave.pcm "plughw:$card_num,$dev_num"
}
ctl.!default {
    type hw
    card $card_num
}
EOF

echo "Generated asound.conf with card $card_num and device $dev_num"

# Allow Docker to access X server
xhost +local:docker

cd ~/Apps/godot-docker || exit 1

# Run the Docker container
docker-compose up --build -d

exit 0