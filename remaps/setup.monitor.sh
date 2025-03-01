#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto
# reintializing keymaps
setxkbmap
xmodmap -e "pointer = 3 2 1"

if /usr/bin/xrandr | grep '^DP-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	"$DOTFILES"/remaps/xrandr.clamshell.sh
	# xrdb -merge "$HOME/.Xresources"
else
	echo "laptop"
	"$DOTFILES"/remaps/xrandr.laptop.sh
	# xrdb -merge "$HOME/.Xresources.laptop"
fi
