#!/bin/sh

file="$(find /home/yul/Music/playlists/ -maxdepth 2 -mindepth 2 | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
if [ -z $file ]; then
  return 1;
fi

mpc stop
mpc clear

notify-send "file: ${file}"
if [ -f /home/yul/Music/"$file" ]; then
  playlist="labels/$(basename -s .m3u "$file")"
  mpc load "$playlist"
  notify-send "playlist: ${playlist}"
else
  mpc listall "$file" | sort -V | while IFS= read -r f; do
    mpc add "$f"
  done
fi

mpc play
