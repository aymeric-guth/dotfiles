#!/bin/sh

/usr/bin/kitty --app-id e2696752-512f-11f0-ae75-ab75b60c01aa  /usr/bin/nvim "/home/yul/Music" \
    "+vsplit | split" \
    "+lua vim.wait(50, function() return false end)" \
    '+execute "normal 6j\<CR>"' \
    "+lua vim.wait(10, function() return false end)" \
    '+execute "normal \<C-w>j8j\<CR>"' \
    "+lua vim.wait(10, function() return false end)" \
    '+execute "normal \<C-w>l7j\<CR>"'
systemd-run --user ~/dev/personal/dotfiles/scripts/mplayer-sync.sh
