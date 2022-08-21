#!/bin/sh

# case "$(uname -s)" in
# Darwin)
#     export CC=
#     export CXX=
#     ;;
# Linux)
#     ;;
# *)
#     echo "Platform not supported"
#     exit 1;
#     ;;
# esac

tmp="$(mktemp -d -t ci-XXXXXXXXXX)"
cd "$tmp" || exit 1
git clone --depth 1 https://github.com/tmux/tmux
cd tmux || exit 1
./autogen.sh
./configure \
    --prefix="$TOOLZ" \
    --enable-utf8proc
make -j8
sudo make install
