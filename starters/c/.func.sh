#!/bin/sh
[ -f "$DOTFILES/funcs/project_c.sh" ] && . "$DOTFILES/funcs/project_c.sh"

clean() {
	c_project_clean || return 1
	c_clean_cmake || return 1
}

build() {
	clean || return 1
	c_build_cmake || return 1
}

run() {
	build || return 1
	[ -x "$BIN" ] && "$BIN" "$WORKSPACE/data/.zsh_history"
}

debug() {
	[ -x "$BIN" ] && ggdb "$BIN"
}
