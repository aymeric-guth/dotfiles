#!/bin/sh

is_git_repo() {
    ! test -z "$(find "${1:-$PWD}" -mindepth 1 -maxdepth 1 -type d -iname ".git")"
}
