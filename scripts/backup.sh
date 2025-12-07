#!/bin/sh

cd /home/yul/Documents/vault101
if git status --porcelain; then
	git add . && git commit -m "$(date)"
fi

cp /home/yul/.local/share/zsh/.zsh_history "/home/yul/Backup/zsh/$(date '+%Y-%m-%d')_zsh_history"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/History "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_History"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/Bookmarks "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_Bookmarks"

cd /home/yul/Music
find music.inbox > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_music.inbox"
find music > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_music"
find chiptunes.inbox > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_chiptunes.inbox"
find chiptunes.lib > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_chiptunes.lib"
find playlists > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_playlists"
