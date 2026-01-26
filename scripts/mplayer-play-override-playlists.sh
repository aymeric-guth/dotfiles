#!/bin/sh

file="$(find /home/yul/Music/playlists/ -maxdepth 1 | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
mpc stop
mpc clear

if [ -f /home/yul/Music/"$file" ]; then
  mpc load "$(basename -s .m3u "$file")"
else
  mpc listall "$file" | sort -V | while IFS= read -r f; do
    mpc add "$f"
  done
fi

mpc play
