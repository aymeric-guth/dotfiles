#!/bin/sh

folder="$(fd -t d . "/home/yul/Music/$1" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
playlist_name="$(fd -t f -d 1 . "/home/yul/Music/playlists" | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0

if [ -z "$folder" ]; then
  /usr/bin/notify-send "folder: ${folder}";
  exit 1;
fi

/usr/bin/notify-send "playlist_name: ${playlist_name}";
if [ -z "$playlist_name" ]; then
  /usr/bin/notify-send "playlist_name: ${playlist_name}";
  exit 1;
fi

if [ ! -f "/home/yul/Music/playlists/$playlist_name" ]; then
  touch "/home/yul/Music/$1/$playlist_name.m3u"
  /usr/bin/notify-send "/home/yul/Music/playlists/$playlist_name.m3u"
fi
