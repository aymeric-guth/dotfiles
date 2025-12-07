#!/bin/sh

# file="$(fd -t d . "/home/yul/Music/$1" \
# 	-x bash -c 'printf "%s\t%s\n" "$(stat -c %Y "$1")" "${1#/home/yul/Music/}"' sh {} |
# 	sort -n |
# 	cut -f2- |
# 	rofi -p "play" -dmenu -i -l 10 -config "$DOTFILES/rofi/mplayer.rasi")" || exit 0
file="$(fd -t d . "/home/yul/Music/$1" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0

mpc clear
mpc add "$file"
mpc play
notify-send "AV/mplayer playing: ${file}"
