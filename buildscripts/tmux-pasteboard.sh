#!/bin/sh

cd /tmp || exit 1
sudo rm -rf tmux-MacOSX-pasteboard
git clone --depth 1 https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
cd tmux-MacOSX-pasteboard || exit 1
