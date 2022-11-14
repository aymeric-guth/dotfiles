#!/bin/sh

python_venv_gen() {
  ( project-env-valid ) || return 1
  echo "deleting previous venv"
  [ -d .venv ] && rm -rf .venv
  echo "creating new venv"
  # TODO: problématique quand déjà dans un venv, utiliser la ref à l'interpreteur sys
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
  # a test
  # find . -type d -name "__pycache__" -print0 | xargs -0 -I {} /bin/rm -rf "{}"
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
  .venv/bin/python -m build . --wheel || return 1
}

python_deploy_global() {
  ( project-env-valid ) || return 1
  eggname="$(generate_eggname "py3-none-any.whl")" || return 1
  /opt/local/bin/python3.11 -m pip install --force-reinstall "dist/${eggname}" || return 1
  echo "besoin d'un bon moyen de localiser avec fiabilité l'interpreteur sys"
  # echo "besoin d'un bon moyen de localiser avec fiabilité l'interpreteur sys" && return 1
  # .venv/bin/python -m pip install --force-reinstall "dist/${eggname}" || return 1
}

python_deploy_venv() {
  ( project-env-valid ) || return 1
  eggname="$(generate_eggname "py3-none-any.whl")" || return 1
  .venv/bin/python -m pip install --force-reinstall "dist/${eggname}" || return 1
}

python_tools_gen() {
  ( project-env-valid ) || return 1
  [ -f pyproject.toml ] && return 1
  expand_toml < "$DOTFILES/starters/python/pyproject.toml" > "$WORKSPACE/pyproject.toml" || return 1
}

python_test_pytest() {
  ( project-env-valid ) || return 1
  [ ! -f .venv/bin/python ] && return 1
  [ -z "$VIRTUAL_ENV" ] && return 1
  [ -n "${commands[pytest]}" ] && pytest tests || return 1
}
