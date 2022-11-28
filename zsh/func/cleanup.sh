#!/bin/sh

_cleanup_docker() {
	### Docker
	yes | docker container prune
	yes | docker image prune -a
	yes | docker network prune
	yes | docker volume prune
	yes | docker builder prune
}

_cleanup_macports() {
	### Macports -- slow
	echo "cleaning MacPorts cache"
	sudo port uninstall leaves
	sudo port -f uninstall inactive
	sudo port -f clean --all all
}

_cleanup_homebrew() {
	### Homebrew
	echo "cleaning Homebrew cache"
	brew autoremove
	brew cleanup --prune=all
}

_cleanup_python() {
	### Python
	echo "cleaning pip cache"
	python3 -m pip cache purge
}

_cleanup_cargo() {
	### Rust
	echo "cleaning cargo cache"
	# remove crates that are not referenced in a Cargo.toml from the cache
	cargo cache clean-unref
	# Removes crate source checkouts and git repo checkouts
	cargo cache --autoclean
}

_cleanup_npm() {
	### JS/TS
	echo "cleaning npm cache"
	sudo npm prune
	sudo npm cache clean --force
}

_cleanup_apt() {
	sudo apt autoremove
	sudo apt-get clean
}

project_clean() {
	[ -z "$WORKSPACE" ] && {
		echo "WORKSPACE is undefined"
		return 1
	}
	[ -z "$PROJECT_NAME" ] && {
		echo "PROJECT_NAME is undefined"
		return 1
	}
	[ "$(PWD)" != "$WORKSPACE" ] && {
		echo "CWD does not match WORKSPACE"
		return 1
	}
	[ "$(basename "$(PWD)")" != "$PROJECT_NAME" ] && {
		echo "Current dirname does not match PROJECT_NAME"
		return 1
	}
	(! git-is-repo) && {
		echo "CWD is not a .git repo"
		return 1
	}
	return 0
}

nvim_clean() {
	[ -d "$HOME/.cache/nvim" ] && rm -rf "$HOME/.cache/nvim"
	[ -d "$HOME/.local/share/nvim" ] && rm -rf "$HOME/.local/share/nvim"
	[ -d "$HOME/.local/state/nvim" ] && rm -rf "$HOME/.local/state/nvim"
}

zsh_clean() {
	[ -d "$ZCACHE" ] && rm -rf "$ZCACHE"
	# [ -d "$ZDATA" ] && rm -rf "$ZDATA"
	find $ZDOTDIR -type f \( -iname \*.zwc -o -iname \*.zwc.old \) -print0 2>/dev/null | xargs -0 -n1 rm -f
}
