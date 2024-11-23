#!/bin/sh

TARGET_DIR=$1

[ -z "$TARGET_DIR" ] && { echo "Usage: $0 <target_dir>"; exit 1; }
[ -d "$TARGET_DIR" ] || { echo "Error: $TARGET_DIR is not a directory"; exit 1; }

for dir in "$TARGET_DIR"/*; do
    cd "$dir" || { echo "Error: $dir is not a directory"; continue ; }
    echo "Fetching $dir ..."
    git fetch --prune --tags --force;
    cd - || { echo "Error: failed to change directory"; exit 1; }
done
