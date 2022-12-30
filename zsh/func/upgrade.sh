#!/bin/sh

_upgrade_python_packages() {
	requirement_file="$DOTFILES/env/requirements-$(uname -n).txt"
	[ ! -f "$requirement_file" ] && return 1
	python3 -m pip install --upgrade pip
	tmp="$(mktemp)"
	python3 -m pip freeze --user >"$tmp"
	python3 -m pip uninstall -y -r "$tmp"
	# bash version
	# python3 -m pip uninstall -y -r <(python3 -m pip freeze --user);
	python3 -m pip install --user -r "$requirement_file"
}

_upgrade_snap() {
	sudo snap refresh
}
