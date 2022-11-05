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

python_project_clean() {
  ( project-env-valid ) || return 1
  rm -rf .pytest_cache || return 1
  rm -rf .mypy_cache || return 1
  rm -rf .venv || return 1
  python_clean || return 1
}

python_clean() {
  ( project-env-valid ) || return 1
  rm -rf dist || return 1
  rm -rf build || return 1
  rm -rf "${PROJECT_NAME}.egg-info" || return 1
}

python_build() {
  ( project-env-valid ) || return 1
  [ ! -f .venv/bin/python ] && return 1
  [ -z "$VIRTUAL_ENV" ] && return 1
  python_clean || return 1
  .venv/bin/python -m build . --wheel || return 1
}

python_deploy() {
  ( project-env-valid ) || return 1
  python_build || return 1
  eggname="$(generate_eggname "py3-none-any.whl")" || return 1
  .venv/bin/python -m pip install --force-reinstall "dist/${eggname}" || return 1
}

python_tools_gen() {
  ( project-env-valid ) || return 1
  [ -f pyproject.toml ] && return 1
  expand_toml < "$DOTFILES/starters/python/pyproject.toml" > "$WORKSPACE/pyproject.toml" || return 1
}
