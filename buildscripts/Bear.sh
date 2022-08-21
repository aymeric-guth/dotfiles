#!/bin/sh

tmp="$(mktemp -d -t ci-XXXXXXXXXX)"
cd "$tmp" || exit 1
git clone --depth 1 https://github.com/rizsotto/Bear
cd Bear || exit 1
mkdir build && cd build || exit 1
cmake \
  -G Ninja \
  -DCMAKE_INSTALL_PREFIX="$TOOLZ" \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_UNIT_TESTS=OFF \
  -DENABLE_FUNC_TESTS=OFF \
  -DENABLE_MULTILIB=OFF \
  .. 
ninja
sudo ninja install
