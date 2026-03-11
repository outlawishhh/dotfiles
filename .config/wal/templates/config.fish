# ~/.config/fish/config.fish

if status is-interactive
    
    # Pywal Theme Regeneration (Startup)
    # ------------------------------------
    # Force regeneration of the color scheme from the static image.
    rm -f ~/.cache/wal/config.fish

    # Load the fresh color scheme into the current shell session.
    if test -f ~/.cache/wal/config.fish
        source ~/.cache/wal/config.fish
    end

    # Hyprland Environment Variables (Exported)
    # ---------------------------------------------
    # Set necessary XDG variables for Wayland and desktop portals.
    set -x XDG_CURRENT_DESKTOP Hyprland
    set -x XDG_SESSION_TYPE wayland
    set -x XDG_DESKTOP_PORTAL xdg-desktop-portal-hyprland

    # Shell Appearance
    # --------------------
    # Remove default fish greeting for a cleaner look.
    set -g fish_greeting ""
end
