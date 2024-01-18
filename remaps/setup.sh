#!/bin/sh

/usr/bin/xrandr --auto

if xinput | grep MoErgo >/dev/null 2>&1; then
	echo "glove80"
	/home/yul/dev/personal/dotfiles/remaps/xmodmap.glove80.sh
else
	echo "tuxedo"
	/home/yul/dev/personal/dotfiles/remaps/xmodmap.laptop.sh
fi

if /usr/bin/xrandr | grep '^DP-1-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	/home/yul/dev/personal/dotfiles/remaps/xrandr.clamshell.sh
else
	echo "laptop"
	/home/yul/dev/personal/dotfiles/remaps/xrandr.laptop.sh
fi
