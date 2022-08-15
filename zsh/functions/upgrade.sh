#!/bin/sh

_upgrade_nvim_ext() {
    if ! command -v nvim 1> /dev/null; then
        return 1
    fi
    editor --headless -c "autocmd User PackerComplete quitall" -c "PackerSync";
    editor --headless -c "TSUpdateSync" -c "qa" > /dev/null 2>&1;
}

_bootstrap_nvim() {
    editor --headless -c \"autocmd User PackerComplete quitall\";
    #editor "--headless -c 'TSInstallSync python lua rust c cpp' -c 'qa' &> /dev/null;
}

_upgrade_nvim() {
    cwd="$PWD"
    cd /tmp && sudo rm -rf neovim
    git clone --depth 1 https://github.com/neovim/neovim
    cd neovim && make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd "$cwd" || return
}
