#!/bin/bash
set -e

GODOT_BIN="./Godot_v4.4.1-stable_mono_linux_x86_64/Godot_v4.4.1-stable_mono_linux.x86_64"

echo "Starting Godot Project Manager..."
$GODOT_BIN
echo "Project Manager exited."

# Give editor some time to start (if it will)
sleep 3

GODOT_EDITOR_PID=$(pgrep -f "Godot_v4.4.1-stable_mono_linux.x86_64")

if [ -z "$GODOT_EDITOR_PID" ]; then
  echo "Godot editor not running. Exiting container."
  exit 0
else
  echo "Godot editor is running with PID $GODOT_EDITOR_PID. Waiting for it to close..."
  while kill -0 $GODOT_EDITOR_PID 2>/dev/null; do
    sleep 2
  done
  echo "Godot editor closed. Exiting container."
  exit 0
fi
