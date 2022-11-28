#!/bin/sh

OS=$(uname -s)
ARCH=$(uname -m)
BIN="formater-$OS-$ARCH"

[ -f "$DOTFILES/bin/$BIN" ] && rm "$DOTFILES/bin/$BIN"
clang -O3 formater.c -o "$BIN"
# clang formater.c -g -O0 -ggdb
mv "$BIN" "$DOTFILES/bin/$BIN"
