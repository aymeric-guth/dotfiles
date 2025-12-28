#!/bin/sh

file="$(fd -t d . "/home/yul/Music/$1" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
. ~/dev/personal/dotfiles/scripts/mplayer-save-state.sh
mpc clear
mpc add "$file"
mpc play
notify-send "AV/mplayer playing: ${file}"
