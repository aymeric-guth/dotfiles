#!/bin/sh

# cmp-tabnine/lua/cmp_tabnine/source.lua
SRC=$DOTFILES/patches/tabnine/source.lua;
DST=$XDG_DATA_HOME/nvim/site/pack/packer/start/cmp-tabnine
#DST=$XDG_DATA_HOME/nvim/site/pack/packer/start/cmp-tabnine/lua/cmp_tabnine/source.lua
cp $SRC $DST/lua/cmp_tabnine/source.lua;
$DST/install.sh;
chomd +x $DST/binaries
