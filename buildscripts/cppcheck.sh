#!/bin/sh

cd /tmp || exit 1
sudo rm -rf cppcheck
git clone --depth 1 https://github.com/danmar/cppcheck
cd cppcheck || exit 1
mkdir build && cd build || exit 1
cmake -G Ninja \
    -DCMAKE_INSTALL_PREFIX="$TOOLZ" \
    -DCMAKE_BUILD_TYPE=Release \
    -DREGISTER_TESTS=OFF \
    -DENABLE_OSS_FUZZ=OFF \
    -DHAVE_RULES=ON \
    -DUSE_MATCHCOMPILER=ON \
    -DUSE_BOOST=ON \
    ..
ninja
