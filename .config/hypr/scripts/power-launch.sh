#!/bin/bash
# Prevent double-triggering when the power key fires twice
LOCKFILE="/tmp/powerbutton.lock"

if [ -f "$LOCKFILE" ]; then
    exit 0
fi

touch "$LOCKFILE"

# Launch all three floating kitty windows
hyprctl dispatch exec "[float; move 50 60; size 430 280] kitty cmatrix"
hyprctl dispatch exec "[float; move 500 60; size 520 280] kitty --hold tty-clock -Ssc -C 1 -f %d/%m/%Y"
hyprctl dispatch exec "[float; move 50 350; size 970 500] kitty"

# Clean up the lock after a short delay
sleep 1
rm -f "$LOCKFILE"

