#!/bin/sh

file="$(find "/home/yul/Music/playlists" -maxdepth 1 | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
. ~/dev/personal/dotfiles/scripts/mplayer-save-state.sh
mpc clear
echo $file

if [ -f /home/yul/Music/"$file" ]; then
  mpc load "$(basename -s .m3u "$file")"
else
  mpc add "$file"
fi
mpc play
