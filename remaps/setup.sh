#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto
# reintializing keymaps
setxkbmap
xmodmap -e "pointer = 3 2 1"
# xmodmap -e "pointer = 1 2 3"

# if xinput | grep MoErgo >/dev/null 2>&1; then
# 	echo "glove80"
# 	xmodmap "$DOTFILES"/remaps/.Xmodmap.glove80
# 	# /home/yul/dev/personal/dotfiles/remaps/xmodmap.glove80.sh
# else
# 	echo "tuxedo"
# 	xmodmap "$DOTFILES"/remaps/.Xmodmap.laptop
# 	# /home/yul/dev/personal/dotfiles/remaps/xmodmap.laptop.sh
# fi

if /usr/bin/xrandr | grep '^DP-1-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	"$DOTFILES"/remaps/xrandr.clamshell.sh
  xrdb -merge "$HOME/.Xresources"
else
	echo "laptop"
	"$DOTFILES"/remaps/xrandr.laptop.sh
  xrdb -merge "$HOME/.Xresources.laptop"
fi
