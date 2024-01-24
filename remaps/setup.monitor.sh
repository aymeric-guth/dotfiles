#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto

if /usr/bin/xrandr | grep '^DP-1-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	"$DOTFILES"/remaps/xrandr.clamshell.sh
else
	echo "laptop"
	"$DOTFILES"/remaps/xrandr.laptop.sh
fi
