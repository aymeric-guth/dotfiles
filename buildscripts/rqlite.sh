#!/bin/sh

tmp="$(mktemp -d -t ci-XXXXXXXXXX)"
cd "$tmp" || exit 1
export GOPATH="$PWD"
mkdir -p src/github.com/rqlite || return 1
cd src/github.com/rqlite || return 1
git clone --depth 1 https://github.com/rqlite/rqlite.git || return 1
cd rqlite || return 1
go install ./...
export GOPATH=
[ -d "$HOME/rqlite" ] && rm -rf "$HOME/rqlite"
cp -r "$tmp"/bin ~/rqlite
