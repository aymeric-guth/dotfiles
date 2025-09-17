#!/bin/sh
file="$(fd . "/home/yul/Music/playlists/" | sort | rofi -p "(e) playlist" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
/usr/bin/alacritty -qq --class e2696752-512f-11f0-ae75-ab75b60c01aa --command /usr/bin/nvim "${file}"
