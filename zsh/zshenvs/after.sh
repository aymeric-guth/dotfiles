#!/bin/sh

export NEOVIM="$NEOVIM_OPTS $NEOVIM_BIN"
### Addition environment variables
export PERSONAL_PROJECTS="$DEV $DEV/Network $DEV/zoltron_stack $DOTCONF $ENV $TMUXINATOR_CONFIG"
export WORK_PROJECTS="$RSN $HOME/Desktop/Novall $HOME/Desktop/Novall/Novold"

export TMUXINATOR_CONFIG="${TMUXINATOR_CONFIG:-"~/.config/tmuxinator"}"
