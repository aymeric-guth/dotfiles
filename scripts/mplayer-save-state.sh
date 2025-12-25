#!/bin/sh
mpd_stack="${XDG_STATE_HOME:-$HOME/.local/state}/mpd-stack.tsv"
snap="__stack_$(date +%s%N)"
mkdir -p "$(dirname "$mpd_stack")"

mpc --quiet save "$snap"

pos="$(mpc current --format '%position%')"
elapsed="$(mpc status | sed -n '2s/.* \([0-9:]\+\)\/.*/\1/p')"

printf "%s\t%s\t%s\n" "$snap" "$pos" "$elapsed" >> "$mpd_stack"
