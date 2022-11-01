#!/bin/sh

[ -f "$PWD/.venv/bin/activate" ] && export VIRTUAL_ENV="$PWD/.venv" && export PATH="$VIRTUAL_ENV/bin:$PATH"
