#!/bin/sh

venv_install() {
    if [ -f requirements.txt ]; then
        .venv/bin/python -m pip install -r requirements.txt
    fi
}

venv_gen() {
    if [ ! -d .venv ]; then
        python3 -m virtualenv .venv
    fi
    venv_install
}

venv_reload() {
    if [ -d .venv ]; then
        rm -rf .venv || return 1
    fi
    venv_gen
}

