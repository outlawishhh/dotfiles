#!/usr/bin/env bash
# pick region once
REGION=$(slurp) || { notify-send "📋 Screenshot canceled"; exit 1; }
if [ -z "$REGION" ]; then
    notify-send "📋 Screenshot canceled"
    exit 1
fi

# copy region to clipboard
grim -g "$REGION" - | wl-copy

notify-send "📋 Screenshot copied to clipboard"

