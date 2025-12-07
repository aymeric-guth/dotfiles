#!/bin/sh

/usr/bin/kitty --app-id e2696752-512f-11f0-ae75-ab75b60c01aa  /usr/bin/nvim "/home/yul/Music/music.inbox"
systemd-run --user ~/dev/personal/dotfiles/scripts/sync.sh
