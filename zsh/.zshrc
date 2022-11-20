#!/bin/sh

# zmodload zsh/zprof
# hack to avoid OSX related PATH duplication
[ -f /etc/zprofile ] && export PATH= && export MANPATH= && . "/etc/zprofile"


export ZDOTDIR="$DOTFILES/zsh"
export ZDATA="$HOME/.local/share/zsh" && [ ! -d "$ZDATA" ] && mkdir -p "$ZDATA"
export ZCACHE="$HOME/.cache/zsh" && [ ! -d "$ZCACHE" ] && mkdir -p "$ZCACHE"

### Dotfile (Re)Compilation
# autoload -U zrecompile
# zrecompile -pq "$ZDOTDIR/.zshrc"
# zrecompile -pq "$ZDOTDIR/aliases"
# zrecompile -pq "$ZDOTDIR/keybind"
# zrecompile -pq "$ZDOTDIR/zcomp"
# zrecompile -pq "$ZDOTDIR/zshenv"
# zrecompile -pq "$ZDOTDIR/func/cleanup.sh"
# zrecompile -pq "$ZDOTDIR/func/upgrade.sh"
# zrecompile -pq "$ZDOTDIR/func/zsh-functions"
# zrecompile -pq "$ZCACHE/.zcompdump-$ZSH_VERSION"
# zrecompile -pq "$ZDOTDIR/.zfunc.zwc" $ZDOTDIR/.zfunc/*
# zrecompile -pq "$ZDOTDIR/.completions.zwc" $ZDOTDIR/completions/*

export HISTFILE="$ZDATA/.zsh_history"
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
stty start undef # Disable ctrl-q to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP

# loads functions in .zfunc
fpath=("$ZDOTDIR/.zfunc" "${fpath[@]}")
autoload -U -z $fpath[1]/*(.:t)

# Completion Engine config
fpath=("$ZDOTDIR/completions" $fpath)
autoload -U -z compinit
# autoload -U +X bashcompinit
compinit -u -d "$ZCACHE/.zcompdump-$ZSH_VERSION"
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZCACHE/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line
autoload -Uz colors && colors

source "$ZDOTDIR/zshenv"

case "$(uname -s)" in
    Darwin)
        # export CLICOLOR=1
        source "$ZDOTDIR/func/zsh-functions-macos"
        source "$ZDOTDIR/aliases-macos"
        export COMPOSE_CMD="docker compose"
        ;;

    Linux)
        source "$ZDOTDIR/func/zsh-functions-linux"
        source "$ZDOTDIR/aliases-linux"
        export COMPOSE_CMD="docker-compose"
        ;;

    *)
        exit 1
        ;;
esac

# Prompt
if [ -d "$GITHUB_REPOS/pure" ]; then
    fpath+=("$GITHUB_REPOS/pure")
    autoload -U promptinit; promptinit
    zstyle :prompt:pure:prompt:success color green
    prompt pure
elif [ -f "$ZDOTDIR/prompt" ]; then
    source "$ZDOTDIR/prompt"
fi

[ -f "$ZDOTDIR/zcomp" ] && [ -n "$ZCOMP" ] && source "$ZDOTDIR/zcomp"

# Plugins
my-zsh-add-plugin "zdharma-continuum/fast-syntax-highlighting"
# zsh-add-plugin "zsh-users/zsh-syntax-highlighting"
my-zsh-add-plugin "zsh-users/zsh-autosuggestions"
my-zsh-add-plugin "hlissner/zsh-autopair"
my-zsh-add-plugin "zsh-users/zsh-history-substring-search"
if [ -n "$FZF" ]; then
    my-zsh-add-plugin "Aloxaf/fzf-tab"
    # determines search program for fzf
    if type fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
    elif type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden'
    fi
fi

[ -f "$ZDOTDIR/keybinds" ] && source "$ZDOTDIR/keybinds"

# POST LOAD
# everything else is loaded
# direnv hook
source <(direnv hook zsh)


export MANPATH
export PATH

# HACK source .func
source-func() { emulate -L zsh; [ -f .func.sh ] && source .func.sh; }
add-zsh-hook precmd source-func

if [ -n "$FRE" ]; then
    fre_chpwd() {
      fre --store $DOTFILES/.local/share/fre/fre.json --add "$(pwd)"
    }
    typeset -gaU chpwd_functions
    chpwd_functions+=fre_chpwd
fi

zle-line-pre-redraw() { ( auto-keybind $BUFFER ) && zle accept-line; }
zle -N zle-line-pre-redraw

