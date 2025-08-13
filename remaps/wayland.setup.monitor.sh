if /usr/bin/xrandr | grep '^DP-1 connected' >/dev/null 2>&1; then
	echo "clamshell"
	xmodmap -e "pointer = 1 2 3"
	# xmodmap -e "pointer = 3 2 1"
	swaymsg 'output eDP-1 disable'
	swaymsg 'output DP-1 mode 3840x2160@165Hz scale 2.0'
else
	echo "laptop"
	xmodmap -e "pointer = 1 2 3"
	swaymsg 'output eDP-1 enable'
fi
