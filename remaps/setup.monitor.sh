#!/bin/sh

# reintializing screen resizing
/usr/bin/xrandr --auto
# reintializing keymaps
setxkbmap
xmodmap -e "pointer = 3 2 1"

if /usr/bin/xrandr | grep '^DP-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	rm -f /home/yul/.config/alacritty/alacritty.toml
	ln -rs "$DOTFILES"/alacritty/alacritty-linux-clamshell.toml "$HOME"/.config/alacritty/alacritty.toml
	xrandr \
		--output eDP-1 --off \
		--output HDMI-1 --off \
		--output DP-1 --primary --mode 3840x2160 --rate 165.00 --pos 0x0 --rotate normal \
		--output HDMI-1 --off
else
	echo "laptop"
	rm -f "$HOME"/.config/alacritty/alacritty.toml
	ln -rs "$DOTFILES"/alacritty/alacritty-linux.toml "$HOME"/.config/alacritty/alacritty.toml
	xrandr \
		--output eDP-1-1 --primary --mode 1920x1080 --rate 144.00*+ --pos 0x0 --rotate normal --scale 0.75x0.75 \
		--output HDMI-1-1 --off \
		--output DP-1-1 --off \
		--output HDMI-1-2 --off
fi
