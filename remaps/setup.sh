#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto
# reintializing keymaps
setxkbmap

if xinput | grep MoErgo >/dev/null 2>&1; then
	echo "glove80"
	xmodmap "$DOTFILES"/remaps/.Xmodmap.glove80
	# /home/yul/dev/personal/dotfiles/remaps/xmodmap.glove80.sh
else
	echo "tuxedo"
	xmodmap "$DOTFILES"/remaps/.Xmodmap.laptop
	# /home/yul/dev/personal/dotfiles/remaps/xmodmap.laptop.sh
fi

if /usr/bin/xrandr | grep '^DP-1-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	"$DOTFILES"/remaps/xrandr.clamshell.sh
else
	echo "laptop"
	"$DOTFILES"/remaps/xrandr.laptop.sh
fi
