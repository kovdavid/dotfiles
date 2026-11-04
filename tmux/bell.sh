#!/bin/bash

WINDOW_ID=$1
LOCKFILE="/tmp/.tmux_notify_lock_$WINDOW_ID"

# Open file descriptor 200 and point it to the lock file
exec 200> "$LOCKFILE"

if ! flock -n 200; then
    exit 0
fi

LOG=/tmp/bell.txt

echo "$(date '+%s') - $0 $@" >> $LOG

PANE_TITLE=$(tmux display-message -p -t $WINDOW_ID "#{q:pane_title}")
SESSION=$(tmux display-message -p -t $WINDOW_ID "#{session_name}:#{window_index} #{window_name}")

echo "$(date '+%s') - PANE_TITLE:$PANE_TITLE SESSION:$SESSION" >> $LOG

if [[ "$PANE_TITLE" != Claude* ]]; then
    exit 0
fi

# -t 3000 \
notify-send \
    -a "tmux" \
    -u normal \
    -i "/usr/share/icons/oxygen/base/64x64/actions/autocorrection.png" \
    -h string:category:tmux \
    "$PANE_TITLE" "<span foreground='#89b4fa' weight='bold'>SESSION</span>  <span foreground='#cdd6f4'>$SESSION</span>"

sleep 3
