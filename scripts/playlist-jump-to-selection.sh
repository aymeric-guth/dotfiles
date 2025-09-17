#!/bin/sh

file="$(mpc playlist | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
mpc searchplay "$file"
