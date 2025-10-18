#!/bin/sh

file=$(fd --max-depth=2 . "/home/yul/Music/music.ready" | sort | rofi -p "del " -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi) || exit 0
if [ -d "$file" ]; then
	# /usr/bin/alacritty -qq --class e2696752-512f-11f0-ae75-ab75b60c01aa /usr/bin/nvim "${file}"
  /usr/bin/kitty --app-id e2696752-512f-11f0-ae75-ab75b60c01aa  /usr/bin/nvim "${file}"
else
	rm -f "$file"
fi
systemd-run --user ~/dev/personal/dotfiles/scripts/sync.sh
