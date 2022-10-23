#!/bin/sh

SRC="$DOTFILES/patches/tabnine/source.lua"
DST="$HOME/.local/share/nvim/site/pack/packer/start/cmp-tabnine"
cp "$SRC" "$DST/lua/cmp_tabnine/source.lua" || return 1
"$DST/install.sh"
chmod +x -R "$DST/binaries"
