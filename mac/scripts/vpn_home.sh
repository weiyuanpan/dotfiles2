#!/bin/sh

SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_NAME=$(basename "$SCRIPT_PATH")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

# start home vpn by using apple script
echo "Starting home vpn..."
osascript "$SCRIPT_DIR"/start_home_vpn.scpt
