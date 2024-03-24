#!/bin/sh

cp ~/.local/share/zsh/.zsh_history ~/dev/backup/zsh_history/"$(date --rfc-3339=seconds)"_"$(hostname)"_zsh_history
