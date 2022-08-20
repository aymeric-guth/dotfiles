#!/bin/sh

is_git_repo() {
    ! test -z "$(find "${1:-$PWD}" -mindepth 1 -maxdepth 1 -type d -iname ".git")"
}

append_to_path() {
    # echo "append_to_path: $1"
    # echo "PATH: $PATH"
    if ! echo "$PATH" | grep -q "$1"; then
        export PATH="$PATH:$1"
    fi
}

prepend_to_path() {
    # echo "prepend_to_path: $1"
    # echo "PATH: $PATH"
    if ! echo "$PATH" | grep -q "$1"; then
        export PATH="$1:$PATH"
    fi
}
