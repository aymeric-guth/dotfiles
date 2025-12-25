#!/bin/sh

mpd_stack="${XDG_STATE_HOME:-$HOME/.local/state}/mpd-stack.tsv"

[ -s "$mpd_stack" ] || { echo "stack vide" >&2; exit 1; }

line="$(tail -n 1 "$mpd_stack")"
snap="$(printf "%s" "$line" | cut -f1)"
pos="$(printf "%s" "$line" | cut -f2)"
elapsed="$(printf "%s" "$line" | cut -f3)"

echo snap: $snap
echo pos: $pos
echo elapsed: $elapsed
sed -i '$d' "$mpd_stack"

mpc --quiet clear
mpc --quiet load "$snap"
mpc --quiet play "$pos"
[ -n "$elapsed" ] && mpc --quiet seek "$elapsed"
