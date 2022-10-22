#!/bin/sh

cd /tmp || exit 1
rm -rf lua-language-server 
git clone --depth 1 https://github.com/sumneko/lua-language-server
cd lua-language-server || exit 1
git submodule update --depth 1 --init --recursive
if [ -d "$DOTFILES/buildscripts/patches/lua-language-server" ]; then
    cp -r "$DOTFILES/buildscripts/patches/lua-language-server" ..
fi
cd ./3rd/luamake || exit 1
./compile/install.sh || exit 1
cd ../..
./3rd/luamake/luamake rebuild || exit 1

cd /tmp/lua-language-server || exit 1
dest="$TOOLZ/lib/lua-language-server"
sudo rm -rf "$dest" || exit 1
sudo rm -f "$TOOLZ/bin/lua-language-server" || exit 1
sudo mkdir -p "$dest" || exit 1
sudo cp -r bin "$dest" || exit 1
sudo cp debugger.lua "$dest" || exit 1
sudo cp -r locale "$dest" || exit 1
sudo cp main.lua "$dest" || exit 1
sudo cp -r meta "$dest" || exit 1
sudo cp -r script "$dest" || exit 1
printf "#!/bin/sh\neval \"\$TOOLZ/lib/lua-language-server/bin/lua-language-server \$*\"" | sudo tee "$TOOLZ/bin/lua-language-server" > /dev/null || exit 1
sudo chmod +x "$TOOLZ/bin/lua-language-server" || exit 1
sudo chown -R root:root "$dest" || exit 1
