#!/bin/sh

if ! command go 2>/dev/null; then
	return 1
fi
if ! command docker 2>/dev/null; then
	return 1
fi
tmp="$(mktemp -d -t ci-XXXXXXXXXX)"
cd "$tmp" || exit 1
git clone --depth 1 https://github.com/k3s-io/k3s.git
mkdir -p build/data || return 1
make download
make generate
SKIP_VALIDATE=true make -j8
