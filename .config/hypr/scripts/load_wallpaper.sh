#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$HOME/.config/hypr/wallpaper_state"
# Your Hyprland output name is eDP-1, based on previous output.
# If you have multiple monitors, consider using '*' or defining them here.
OUTPUT_NAME='eDP-1' 

# --- Restore Logic ---

if [ -f "$STATE_FILE" ]; then
    WALLPAPER_TYPE=$(head -n 1 "$STATE_FILE")
    
    if [ "$WALLPAPER_TYPE" = "Animated" ]; then
        FULLPATH=$(tail -n 1 "$STATE_FILE")
        
        # 1. FIX: Added 'eDP-1' as the required output argument.
        # 2. FIX: Used 'nohup ... >/dev/null 2>&1 &' for reliable backgrounding.
        nohup mpvpaper -p -o "--loop --no-audio" "$OUTPUT_NAME" "$FULLPATH" >/dev/null 2>&1 &
        exit 0
    fi
    
    # If WALLPAPER_TYPE is "Static" or "None", the script falls through here.
    # The static wallpaper persistence is handled by the hyprpaper.conf
    # which is automatically loaded by the command below.
fi

# --- Static/Default Fallback Logic ---
# This command handles:
# 1. If the state was 'Static': hyprpaper loads the correct path from hyprpaper.conf (written by your selector script).
# 2. If the state was 'None' or the state file is missing: hyprpaper starts with its default config.

if ! pgrep -x "hyprpaper" >/dev/null; then
    hyprpaper -c ~/.config/hypr/hyprpaper.conf &
fi
