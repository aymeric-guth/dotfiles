#!/bin/sh

hyprctl reload
kill -s USR1 $(pgrep kitty)
kill -s USR2 $(pgrep waybar)
