#!/bin/sh

rm -f /home/yul/.config/alacritty/alacritty.toml
ln -rs "$DOTFILES"/alacritty/alacritty-linux-clamshell.toml /home/yul/.config/alacritty/alacritty.toml

xrandr \
	--output eDP-1 --off \
	--output HDMI-1 --off \
	--output DP-1 --primary --mode 3840x2160 --rate 165.00 --pos 0x0 --rotate normal \
	--output HDMI-1 --off

# --dpi 220
