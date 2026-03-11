#!/usr/bin/env bash
# pick region once
REGION=$(slurp) || { notify-send "📸 Screenshot canceled"; exit 1; }
if [ -z "$REGION" ]; then
    notify-send "📸 Screenshot canceled"
    exit 1
fi

# ensure folder exists
mkdir -p "$HOME/Pictures/Screenshots"

# save to file
FILENAME="$HOME/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
grim -g "$REGION" "$FILENAME"

# copy to clipboard from file
wl-copy < "$FILENAME"

notify-send "📸 Screenshot saved to ~/Pictures/Screenshots and copied to clipboard"

