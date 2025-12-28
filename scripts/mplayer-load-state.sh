#!/bin/sh

[ -d "$HOME/.cache/mpd" ] || { echo "stack vide" >&2; exit 1; }

mpd_state="$(find $HOME/.cache/mpd -iname '__state_*' | sort --reverse | head -n 1)"
[ -s "$mpd_state" ] || { notify-send "mplayer: stack empty" >&2; exit 1; }

systemctl --user stop mpd
cp "${mpd_state}" "$HOME"/.local/state/mpd/state
systemctl --user start mpd
rm "$mpd_state"
