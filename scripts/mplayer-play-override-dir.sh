#!/bin/sh

file="$(fd -t d . "/home/yul/Music/$1" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
mpc stop
mpc clear

mpc listall "$file" | sort -V | while IFS= read -r f; do
  mpc add "$f"
done

mpc play
notify-send "Playing: $file"
