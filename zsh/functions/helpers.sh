#!/bin/sh

is_git_repo() {
    ! test -z "$(find "${1:-$PWD}" -mindepth 1 -maxdepth 1 -type d -iname ".git")"
}

addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}
