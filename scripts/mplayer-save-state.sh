#!/bin/sh

mkdir -p "$HOME/.cache/mpd"
mpd_state="__state_$(date +%s%N)"

systemctl --user stop mpd
cp "$HOME"/.local/state/mpd/state "$HOME"/.cache/mpd/"${mpd_state}"
systemctl --user start mpd
mpc stop
mpc clear
