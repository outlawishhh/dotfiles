#!/usr/bin/env bash
set -euo pipefail

# Directories
STATIC_DIR="$HOME/Pictures/Wallpapers/static"
ANIM_DIR="$HOME/Pictures/Wallpapers/animated"
ANIM_THUMB_DIR="$ANIM_DIR/thumbsforselector"
STATIC_THUMB_DIR="$STATIC_DIR/thumbsforselector"
STATE_DIR="$HOME/.config/hypr"
STATE_FILE="$STATE_DIR/wallpaper_state"

mkdir -p "$ANIM_THUMB_DIR" "$STATIC_THUMB_DIR" "$STATE_DIR"

# Rofi theme settings with FIXED HEIGHT - prevents window from growing
ROFI_SELECTOR_THEME=(
    "-show-icons"
    "-theme-str" 
    "window {width: 30em; height: 20em;} listview {columns: 1; lines: 8; fixed-height: true; scrollbar: true;} element-icon {size: 96px;}"
)

# --- Thumbnail Generation (async in background) ---
(
    find "$ANIM_DIR" -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.webm" \) | while read -r video; do
        base=$(basename "$video")
        thumb="$ANIM_THUMB_DIR/${base%.*}.jpg"
        if [ ! -f "$thumb" ] || [ "$video" -nt "$thumb" ]; then
            ffmpeg -y -i "$video" -vf "thumbnail,scale=480:-1" -frames:v 1 "$thumb" >/dev/null 2>&1 || :
        fi
    done

    find "$STATIC_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r image; do
        base=$(basename "$image")
        thumb="$STATIC_THUMB_DIR/${base%.*}.jpg"
        if [ ! -f "$thumb" ] || [ "$image" -nt "$thumb" ]; then
            ffmpeg -y -i "$image" -vf "scale=480:-1" "$thumb" >/dev/null 2>&1 || :
        fi
    done
) &

# --- Main Script Logic ---

# Detect current wallpaper backend
if pgrep -x "mpv" >/dev/null || pgrep -x "mpvpaper" >/dev/null; then
    current="Animated"
elif pgrep -x "hyprpaper" >/dev/null; then
    current="Static"
else
    current="None"
fi

# Rofi menu for wallpaper type
choice=$(printf "🖼️ Static (hyprpaper)\n🎞️ Animated (mpvpaper)\n🧹 Stop Wallpaper" | \
    rofi -dmenu -p "Wallpaper [$current]" -theme-str 'window {width: 20em;}')

case "$choice" in
    *Static*)
        # Stop mpvpaper if running
        killall mpvpaper mpv 2>/dev/null || true
        
        # Build menu with image thumbnails
        mapfile -t images < <(find "$STATIC_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)
        
        menu=""
        for img in "${images[@]}"; do
            name=$(basename "$img")
            base_name="${name%.*}"
            thumb="$STATIC_THUMB_DIR/${base_name}.jpg"
            
            icon="$thumb"
            [ ! -f "$thumb" ] && icon="$img" 
            menu+="$name\x00icon\x1f$icon\n"
        done
        
        selected=$(echo -e "$menu" | rofi -dmenu -p "Select Wallpaper" "${ROFI_SELECTOR_THEME[@]}")
        
        if [ -n "$selected" ]; then
            fullpath="$STATIC_DIR/$selected"
            
            if ! pgrep -x "hyprpaper" >/dev/null; then
                hyprpaper &
                sleep 0.3
            fi
            
            # Set wallpaper
            hyprctl hyprpaper preload "$fullpath"
            hyprctl hyprpaper wallpaper ",$fullpath"
	           
            # Pywal integration (fast, keep synchronous)
            wal -i "$fullpath" > /dev/null 2>&1
            wpg -a "$fullpath" > /dev/null 2>&1
            wpg -s "$fullpath" > /dev/null 2>&1
            
            # Update hyprpaper.conf for persistence
            HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
            cat > "$HYPRPAPER_CONF" << EOF
preload = $fullpath
wallpaper = ,$fullpath
splash = false
ipc = on
EOF
            
            printf '%s\n%s\n' "Static" "$fullpath" > "$STATE_FILE"
            
            # Launch each theme updater with MAXIMUM detachment
            # Each gets: setsid + nohup + background + disown + stderr/stdout redirect
            
            # Keyboard lights
	    walcolor=$(head -n 2 ~/.cache/wal/colors | tail -n 1 | sed 's/#//')
            echo "$walcolor"
	    setsid nohup asusctl aura static -c "$walcolor"
	    asusctl -k high
	    disown -a
            
            # Kitty theme - fast, use setsid for complete detachment
            setsid bash -c '/usr/bin/kitty @ set-colors -a "$HOME/.config/kitty/kitty.conf"' >/dev/null 2>&1 &
            
            # Discord theme - fully detached
            setsid nohup bash ~/.local/bin/update-discord-theme.sh </dev/null >/dev/null 2>&1 &
            disown -a
            
            # Gedit theme - fully detached
            setsid nohup bash ~/.local/bin/update-gedit-theme.sh </dev/null >/dev/null 2>&1 &
            disown -a
                
            # Quickshell - fully detached
            setsid nohup bash ~/.local/bin/update-quickshell-colors.sh </dev/null >/dev/null 2>&1 &
            disown -a
                              
            # Kvantum - fully detached
            setsid nohup bash ~/.local/bin/update-kvantum-colors.sh </dev/null >/dev/null 2>&1 &
            disown -a
                
            # Dolphin restart - fully detached
            setsid bash -c 'if pgrep -x dolphin >/dev/null; then pkill dolphin 2>/dev/null; sleep 0.5; dolphin 2>/dev/null & fi' </dev/null >/dev/null 2>&1 &
            disown -a
                
            # Firefox - fully detached
            setsid nohup bash ~/.local/bin/update-firefoxandgtk-colors.sh </dev/null >/dev/null 2>&1 &
            disown -a
            
            # Spicetify - MAXIMUM detachment (Spotify is the problematic one)
            setsid nohup bash -c 'bash ~/.local/bin/update-spicetify-theme.sh' </dev/null >/dev/null 2>&1 &
            disown -a
            
        fi
        ;;
    *Animated*)
        # Stop hyprpaper
        killall hyprpaper 2>/dev/null || true
        killall mpvpaper mpv 2>/dev/null || true 
        
        # Build menu with thumbnails
        mapfile -t videos < <(find "$ANIM_DIR" -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.webm" \) | sort)
        menu=""
        for v in "${videos[@]}"; do
            name=$(basename "$v")
            icon="$ANIM_THUMB_DIR/${name%.*}.jpg"

            if [ -f "$icon" ]; then
                menu+="$name\x00icon\x1f$icon\n"
            else
                menu+="$name\x00icon\x1fimage-missing\n" 
            fi
        done
        
        video=$(echo -e "$menu" | rofi -dmenu -p "Select Video" "${ROFI_SELECTOR_THEME[@]}" )
        
        if [ -n "$video" ]; then
            fullpath="$ANIM_DIR/$video"
            
            # mpvpaper command - maximum detachment
            setsid nohup mpvpaper -p -o "--loop --no-audio" 'eDP-1' "$fullpath" </dev/null >/dev/null 2>&1 &
            disown -a
            
            printf '%s\n%s\n' "Animated" "$fullpath" > "$STATE_FILE"
        fi
        ;;
    *Stop*)
        killall mpvpaper mpv hyprpaper 2>/dev/null || true
        printf '%s\n' "None" > "$STATE_FILE"
        ;;
esac
