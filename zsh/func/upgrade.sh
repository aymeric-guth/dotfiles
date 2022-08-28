#!/bin/sh

_upgrade_nvim_plugins() {
    if ! command -v nvim 1> /dev/null; then
        return 1
    fi
    editor --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
    editor --headless -c "TSUpdateSync" -c "qa" > /dev/null 2>&1
}

_bootstrap_nvim() {
    #editor --headless -c \"autocmd User PackerComplete quitall\";
    editor --headless -c 'TSInstallSync python lua rust c cpp' -c 'qa' &> /dev/null
}

_upgrade_python_packages() {
    python3 -m pip install --upgrade pip;
    tmp="$(mktemp)"
    python3 -m pip freeze --user > "$tmp"
    python3 -m pip uninstall -y -r "$tmp"
    # bash version
    # python3 -m pip uninstall -y -r <(python3 -m pip freeze --user);
    python3 -m pip install --user -r "$DOTFILES/requirements.txt"
}

_upgrade_zsh_plugins() {
    find "$ZDATA/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q;
}

_upgrade_npm_packages() {
    sudo npm install npm@latest -g
    sudo npm update -g
}

_upgrade_cargo_crates() {
    # list installed crates
    # cargo install --list
    # upgrade all installed crates with plugin install-all
    LIBSSH2_SYS_USE_PKG_CONFIG=whatever cargo install-update --all
}

_upgrade_macports() {
    sudo port selfupdate
    sudo port upgrade outdated
}

_upgrade_homebrew() {
    brew upgrade
}

_upgrade_apt() {
    sudo apt-get update && sudo apt-get upgrade -y
}
