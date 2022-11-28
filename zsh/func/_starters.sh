#!/bin/sh

starter_python() {
	(project-env-valid) || return 1
	starter="$DOTFILES/starters/python"
	[ ! -f "$WORKSPACE/.func.sh" ] && cp "$starter/.func.sh" "$WORKSPACE/.func.sh"
	[ ! -f "$WORKSPACE/.envrc" ] && cp "$starter/.envrc" "$WORKSPACE/.envrc"
	[ ! -f "$WORKSPACE/.env" ] && cp "$starter/.env" "$WORKSPACE/.env"
	[ ! -f "$WORKSPACE/setup.py" ] && cp "$starter/setup.py" "$WORKSPACE/setup.py"
	[ ! -f "$WORKSPACE/setup.cfg" ] && cp "$starter/setup.cfg" "$WORKSPACE/setup.cfg"
	[ ! -f "$WORKSPACE/requirements.txt" ] && cp "$starter/requirements.txt" "$WORKSPACE/requirements.txt"
	direnv allow .envrc
	[ ! -f .venv/bin/python ] && python_venv_gen
	python_tools_gen || return 1

}

starter_c() {
	(project-env-valid) || return 1
	starter="$DOTFILES/starters/c"
	[ ! -f "$WORKSPACE/.func.sh" ] && cp "$starter/.func.sh" "$WORKSPACE/.func.sh"
	[ ! -f "$WORKSPACE/.envrc" ] && cp "$starter/.envrc" "$WORKSPACE/.envrc"
	mkdir -p "$WORKSPACE/usr/bin" "$WORKSPACE/usr/lib" "$WORKSPACE/usr/include"
	direnv allow .envrc
}
