#!/bin/sh

if [ -z "$TOOLZ" ]; then
    exit 1
fi

_reset_env() {
    sudo rm -rf "$TOOLZ"
    sudo mkdir -p "$TOOLZ/bin" "$TOOLZ/lib" "$TOOLZ/share"
    if [ ! -d "$TOOLZ/bin" ]; then
        exit 1
    fi
    if [ ! -d "$TOOLZ/lib" ]; then
        exit 1
    fi
    if [ ! -d "$TOOLZ/share" ]; then
        exit 1
    fi
}

