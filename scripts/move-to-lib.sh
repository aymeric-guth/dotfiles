#!/bin/sh

file=$(fd --max-depth=1 --type=directory . "/home/yul/Music/music.ready" | sort | rofi -p "move" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi) || exit 0
[ -d "$file" ] && mv "$file" /home/yul/Music/music/"$(basename "$file")"
systemd-run --user ~/dev/personal/mplayer/commands/sync.sh
