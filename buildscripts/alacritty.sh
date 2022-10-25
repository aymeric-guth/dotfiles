#!/bin/sh

git clone --depth 1 https://github.com/alacritty/alacritty
# linux build X11
cargo build --release --no-default-features --features=x11
