#!/bin/sh

python_venv_gen() {
  ( project-env-valid ) || return 1
  echo "deleting previous venv"
  [ -d .venv ] && rm -rf .venv
  echo "creating new venv"
  python3 -m virtualenv .venv || return 1
  echo "installing requirements"
  [ -f requirements.txt ] && .venv/bin/python -m pip install -r requirements.txt
  echo "reloading direnv"
  [ -n "${commands[direnv]}" ] && direnv reload
}

project_clean() {
  ( ! env-check-project ) && return 1
  # .venv
  # .pytest_cache
  # .mypy_cache
  # __pycache__

  rm -rf .venv
  rm -rf .mypy_cache
  rm -rf .pytest_cache
  return 0
}
