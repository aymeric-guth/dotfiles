#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto
# reintializing keymaps
setxkbmap
setxkbmap -layout custom

if /usr/bin/xrandr | grep '^DP-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	xmodmap -e "pointer = 1 2 3"
	# xmodmap -e "pointer = 3 2 1"
	rm -f "$HOME"/.Xresources
	ln -rs "$DOTFILES"/remaps/.Xresources.clamshell "$HOME"/.Xresources
	xrdb -merge "$HOME"/.Xresources
	xrandr \
		--output eDP-1 --off \
		--output HDMI-1 --off \
		--output DP-1 --primary --mode 3840x2160 --rate 165.00 --pos 0x0 --dpi 220 --rotate normal \
		--output HDMI-1 --off
else
	echo "laptop"
	xmodmap -e "pointer = 1 2 3"
	rm -f "$HOME"/.Xresources
	ln -rs "$DOTFILES"/remaps/.Xresources.laptop "$HOME"/.Xresources
	xrdb -merge "$HOME"/.Xresources
	xrandr \
		--output eDP-1 --primary --mode 1920x1080 --rate 144.00*+ --pos 0x0 --rotate normal --scale 0.75x0.75 \
		--output HDMI-1 --off \
		--output DP-1 --off \
		--output HDMI-1 --off
fi
