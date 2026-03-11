#!/bin/sh

. "$HOME/.cache/wal/colors.sh"

sed \
  -e "s/{color0}/$color0/g" \
  -e "s/{color2}/$color2/g" \
  -e "s/{color7}/$color7/g" \
  -e "s/{color8}/$color8/g" \
  -e "s/{color12}/$color12/g" \
  -e "s/{color15}/$color15/g" \
  "$HOME/.config/Kvantum/pywal/pywal.kvconfig.template" \
> "$HOME/.config/Kvantum/pywal/pywal.kvconfig"

kvantummanager --set pywal >/dev/null 2>&1

