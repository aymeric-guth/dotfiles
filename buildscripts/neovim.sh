#!/bin/sh

#export CC=
#export CXX=
tmp="$(mktemp -d -t ci-XXXXXXXXXX)"
cd "$tmp" || exit 1
git clone --depth 1 https://github.com/neovim/neovim
cd neovim || exit 1
mkdir .deps && cd .deps || exit 1
cmake -G Ninja ../cmake.deps
ninja

cd ..
mkdir build && cd build || exit 1
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$TOOLZ" \
  ..
ninja
sudo ninja install
