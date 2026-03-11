#!/bin/bash

# --- EDITED TO USE BAT1 ---
BATTERY_ID="BAT1"
BATTERY_PATH="/sys/class/power_supply/$BATTERY_ID"

# Check if the battery path exists (Prevents silent failures)
if [ ! -d "$BATTERY_PATH" ]; then
    # Output an error message instead of failing on cat
    echo "Error: $BATTERY_ID not found!"
    exit 1
fi

# Get the current battery percentage
battery_percentage=$(cat "$BATTERY_PATH/capacity")

# Get the battery status (Charging or Discharging)
battery_status=$(cat "$BATTERY_PATH/status")

# Define the battery icons for each 10% segment (assuming Nerd Font icons)
# 0-9% 10-19% 20-29% 30-39% 40-49% 50-59% 60-69% 70-79% 80-89% 90-100%
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icon="󰂄"

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Cap the index at the max array index (9) for 100%
if [ "$icon_index" -ge ${#battery_icons[@]} ]; then
    icon_index=$((${#battery_icons[@]} - 1))
fi

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging or full
if [ "$battery_status" = "Charging" ] || [ "$battery_status" = "Full" ]; then
    battery_icon="$charging_icon"
fi

# Output the battery percentage and icon (This is the critical line)
echo "$battery_percentage% $battery_icon"
