#!/usr/bin/env bash
set -euo pipefail

pkill spotify 2>/dev/null || true
echo "killed spotify"
sleep 2

# Apply spicetify theme (this might auto-launch Spotify)
spicetify apply

