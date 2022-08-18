#!/bin/sh

cd /tmp || exit 1
rm -rf lua-language-server 
git clone --depth 1 https://github.com/sumneko/lua-language-server
cd lua-language-server || exit 1
git submodule update --depth 1 --init --recursive
if [ -d "$ENV/buildscripts/patches/lua-language-server" ]; then
    cp -r "$ENV/buildscripts/patches/lua-language-server" ..
fi
cd ./3rd/luamake || exit 1
./compile/install.sh || exit 1
cd ../..
./3rd/luamake/luamake rebuild || exit 1

sudo rm -rf "$TOOLZ/share/lua-language-server"
sudo rm -f "$TOOLZ/bin/lua-language-server"
sudo mkdir -p "$TOOLZ/share/lua-language-server"
sudo cp bin/main.lua "$TOOLZ/share/lua-language-server"
sudo mv bin "$TOOLZ/share/lua-language-server"
sudo rm -f "$TOOLZ/bin/lua-language-server"
printf "#!/bin/sh\neval \"\$TOOLZ/share/lua-language-server/bin/lua-language-server \$*\"" | sudo tee "$TOOLZ/bin/lua-language-server" > /dev/null
sudo chmod +x "$TOOLZ/bin/lua-language-server"
