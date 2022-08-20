#!/bin/sh

_cleanup_docker() {
    ### Docker
    yes | docker container prune;
    yes | docker image prune -a;
    yes | docker network prune;
    yes | docker volume prune;
    yes | docker builder prune;
}

_cleanup_macports() {
    ### Macports -- slow
    echo "cleaning MacPorts cache"
    sudo port uninstall leaves
    sudo port -f uninstall inactive
    sudo port -f clean --all all
}

_cleanup_homebrew() {
    ### Homebrew
    echo "cleaning Homebrew cache"
    brew autoremove;
    brew cleanup --prune=all;
}

_cleanup_python() {
    ### Python
    echo "cleaning pip cache"
    python3 -m pip cache purge;
}

_cleanup_cargo() {
    ### Rust
    echo "cleaning cargo cache"
    # remove crates that are not referenced in a Cargo.toml from the cache
    cargo cache clean-unref
    # Removes crate source checkouts and git repo checkouts
    cargo cache --autoclean
}

_cleanup_npm() {
    ### JS/TS
    echo "cleaning npm cache"
    sudo npm prune
    sudo npm cache clean --force
}

_cleanup_apt() {
    sudo apt autoremove
    sudo apt-get clean
}
