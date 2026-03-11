#!/bin/bash
# Save as: ~/.local/bin/update-discord-theme.sh
# Make executable: chmod +x ~/.local/bin/update-discord-theme.sh

# Paths
WAL_COLORS="$HOME/.cache/wal/colors.sh"
DISCORD_CSS="$HOME/.config/vesktop/settings/quickCss.css"
WALLPAPER=$(cat "$HOME/.cache/wal/wal")

# Source pywal colors
source "$WAL_COLORS"

# Create the Quick CSS with embedded colors
cat > "$DISCORD_CSS" << EOF
/**
 * @name ClearVision V7 - Pywal Edition
 * @author ClearVision Team (Modified for Pywal)
 * @version 7.0.1-pywal
 * @description Dynamic pywal colors - Auto-generated
 */

/* IMPORT BASE CSS */
@import url("https://clearvision.github.io/ClearVision-v7/main.css");
@import url("https://clearvision.github.io/ClearVision-v7/vencord.css");

/* PYWAL COLORS - Auto-generated from wallpaper */
:root {
  /* Color Palette */
  --wal-color0: ${color0};
  --wal-color1: ${color1};
  --wal-color2: ${color2};
  --wal-color3: ${color3};
  --wal-color4: ${color4};
  --wal-color5: ${color5};
  --wal-color6: ${color6};
  --wal-color7: ${color7};
  --wal-color8: ${color8};
  --wal-color9: ${color9};
  --wal-color10: ${color10};
  --wal-color11: ${color11};
  --wal-color12: ${color12};
  --wal-color13: ${color13};
  --wal-color14: ${color14};
  --wal-color15: ${color15};
  
  /* Special Colors */
  --wal-background: ${background};
  --wal-foreground: ${foreground};
  --wal-cursor: ${cursor};
  
  /* Transparency Variations */
  --wal-background-alpha: ${color0}cc;
  --wal-background-light: ${color0}40;
  --wal-background-dark: ${color0}e6;
  --wal-foreground-alpha: ${color15}0d;
}

/* APPLY PYWAL COLORS TO THEME */
:root {
  /* ACCENT COLORS */
  --main-color: var(--wal-color1);
  --hover-color: var(--wal-color9);
  --success-color: var(--wal-color2);
  --danger-color: var(--wal-color1);
  
  /* BACKGROUND */
  --background-shading-percent: 100%;
  --background-image: url(https://i.imgur.com/zKIEnL6.jpeg);
  --background-position: center;
  --background-size: cover;
  --background-attachment: fixed;
  --background-filter: saturate(1);
  
  /* POPOUTS & MODALS */
  --user-popout-image: var(--background-image);
  --user-popout-position: var(--background-position);
  --user-popout-size: var(--background-size);
  --user-popout-attachment: var(--background-attachment);
  --user-popout-filter: var(--background-filter);
  
  --user-modal-image: var(--background-image);
  --user-modal-position: var(--background-position);
  --user-modal-size: var(--background-size);
  --user-modal-attachment: var(--background-attachment);
  --user-modal-filter: var(--background-filter);
  
  /* HOME ICON */
  --home-icon: url(https://clearvision.github.io/icons/discord.svg);
  --home-size: cover;
  
  /* FONTS */
  --main-font: "gg sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  --code-font: Consolas, "gg mono", "Liberation Mono", Menlo, Courier, monospace;
  
  /* CHANNEL COLORS */
  --channel-normal: var(--wal-color7);
  --channel-muted: var(--wal-color8);
  --channel-hover: var(--wal-color15);
  --channel-selected: var(--wal-color15);
  --channel-selected-bg: var(--main-color);
  --channel-unread: var(--main-color);
  --channel-unread-hover: var(--hover-color);
  
  /* ACCESSIBILITY */
  --focus-color: var(--main-color);
  
  /* SHADING */
  --background-shading: var(--wal-background-alpha);
  --card-shading: var(--wal-background-light);
  --popout-shading: var(--wal-background-dark);
  --modal-shading: var(--wal-background-alpha);
  --input-shading: var(--wal-foreground-alpha);
  --normal-text: var(--wal-color15);
  --muted-text: var(--wal-color8);
}

/* ADDITIONAL STYLING */

.channelTextArea_a7d72e {
  background-color: var(--wal-background-light) !important;
}

.sidebar_a4d4d9 {
  background-color: var(--wal-background-alpha) !important;
}

.message_d5deea:hover {
  background-color: var(--wal-background-light) !important;
}

::-webkit-scrollbar-thumb {
  background-color: var(--wal-color1) !important;
}

::-webkit-scrollbar-thumb:hover {
  background-color: var(--wal-color9) !important;
}

.lookFilled_dd4f85.colorBrand_dd4f85 {
  background-color: var(--wal-color1) !important;
}

.lookFilled_dd4f85.colorBrand_dd4f85:hover {
  background-color: var(--wal-color9) !important;
}

a {
  color: var(--wal-color4) !important;
}

a:hover {
  color: var(--wal-color12) !important;
}
EOF

echo "✓ Discord theme updated with pywal colors!"
echo "  Restart Discord/Vesktop to see changes."
