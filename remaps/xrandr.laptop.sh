#!/bin/sh
rm -f ~/.config/alacritty/alacritty.toml
ln -rs "$DOTFILES"/alacritty/alacritty-linux.toml ~/.config/alacritty/alacritty.toml
xrandr \
	--output eDP-1-1 --primary --mode 1920x1080 --rate 144.00*+ --pos 0x0 --rotate normal --scale 0.75x0.75 \
	--output HDMI-1-1 --off \
	--output DP-1-1 --off \
	--output HDMI-1-2 --off
