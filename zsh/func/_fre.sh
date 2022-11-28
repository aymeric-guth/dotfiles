#!/bin/sh

fre_init() {
	[ ! -f "$HOME/.cache/fre.json" ] && fre --store "$HOME/.cache/fre.json" --add .
}

fre_jumpstart() {
	fre_init
	find $(echo $PROJECTS) -mindepth 1 -maxdepth 1 -type d \( -not -iname "_*" -not -iname ".*" \) -print0 |
		xargs -n1 -0 fre --store "$HOME/.cache/fre.json" --add
	fre.py save <"$HOME/.cache/fre.json" >"$DOTFILES/env/fre.json"
}

fre_save() {
	fre_init
	[ -z "$1" ] && return 1
	fre --store "$HOME/.cache/fre.json" --add "$1"
	fre.py save <"$HOME/.cache/fre.json" >"$DOTFILES/env/fre.json"
}

fre_load() {
	fre_init
	fre.py load <"$DOTFILES/env/fre.json" >"$HOME/.cache/fre.json"
	fre --store "$HOME/.cache/fre.json" --sorted
}
