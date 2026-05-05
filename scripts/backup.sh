#!/bin/sh

cd /home/yul/Documents/vault101
if git status --porcelain; then
	git add . && git commit -m "$(date)"
fi

cp /home/yul/.local/share/zsh/.zsh_history "/home/yul/Backup/zsh/$(date '+%Y-%m-%d')_zsh_history"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/History "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_History"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/Bookmarks "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_Bookmarks"
7z a -p"$(cat ~/.archive_pass)" -mhe=on /home/yul/Backup/ssh/$(date "+%Y-%m-%d")_ssh.7z /home/yul/.ssh

cd /home/yul/Music
find music.inbox | sort > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_music.inbox"
find music | sort > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_music"
find chiptunes.inbox | sort > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_chiptunes.inbox"
find chiptunes.lib | sort > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_chiptunes.lib"
find playlists | sort > "/home/yul/Backup/Music/$(date '+%Y-%m-%d')_playlists"
