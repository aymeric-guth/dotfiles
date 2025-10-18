#!/bin/sh

cd /home/yul/Documents/vault101
if git status --porcelain; then
	git add . && git commit -m "$(date)"
fi

cp /home/yul/.local/share/zsh/.zsh_history "/home/yul/Backup/zsh/$(date '+%Y-%m-%d')_zsh_history"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/History "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_History"
cp /home/yul/.config/BraveSoftware/Brave-Browser/Default/Bookmarks "/home/yul/Backup/Brave/$(date '+%Y-%m-%d')_Bookmarks"
