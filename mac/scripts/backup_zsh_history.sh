#!/bin/sh

DATETIME=$(date "+%Y%m%d%H%M%S")
BACKUP_FILE="$HOME/.zsh_history"
BACKUP_DST="$HOME/Desktop/shared"
HOSTNAME=$(hostname -s)

if [ -f "$BACKUP_FILE" ] && [ -d "$BACKUP_DST" ]; then
    cp "$BACKUP_FILE" "$BACKUP_DST/zsh_history-$HOSTNAME"
    echo "($DATETIME) Backup $BACKUP_FILE to $BACKUP_DST/zsh_history-$HOSTNAME"
else
    echo "($DATETIME) Error: $BACKUP_FILE or $BACKUP_DST not found"
fi
