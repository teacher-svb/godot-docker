#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Set log file path relative to script location
LOGFILE="$SCRIPT_DIR/godot-docker.log"
# Redirect stdout and stderr to the log file
exec >"$LOGFILE" 2>&1

# Allow Docker to access X server
xhost +local:docker

cd ~/Apps/godot-docker || exit 1

export UID=$(id -u)
export GID=$(id -g)

# Run the Docker container
docker-compose up --build -d

exit 0