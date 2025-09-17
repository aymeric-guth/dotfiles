#!/bin/sh

file="$(fd . "/home/yul/Music/$1" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
mpc add "$file"
mpc play
notify-send "AV/mplayer append: ${file}"
