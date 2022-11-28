#!/bin/sh

_syncthing_target_valid() {
	[ ! -d "$1" ] && {
		echo "$1 is not a valid dir"
		return 1
	}
	[ ! -d "$1/.stfolder" ] && {
		echo "stfolder not found"
		return 1
	}
	return 0
}

syncthing_clean_conflict() {
	set -- "${1:-$PWD}"
	# echo "\$1=$1"
	(_syncthing_target_valid "$1") || return 1
	find . -iname "*sync-conflict*" -type f -print0 2>/dev/null | xargs -0 -n1 rm
	# echo "dry-run"
	# return 1
}

syncthing_clean_stversions() {
	set -- "${1:-$PWD}"
	# echo "\$1=$1"
	(_syncthing_target_valid "$1") || return 1
	[ ! -d "$1/.stversions" ] && return 1
	find "$1/.stversions" -maxdepth 1 -mindepth 1 -print0 2>/dev/null | xargs -0 -n1 rm -rf
}

syncthing_clean() {
	syncthing_clean_conflict "$DEV/work"
	syncthing_clean_stversions "$DEV/work"
	syncthing_clean_conflict "$DEV/personal"
	syncthing_clean_stversions "$DEV/personal"
	syncthing_clean_conflict "$DEV/learning"
	syncthing_clean_stversions "$DEV/learning"
}
