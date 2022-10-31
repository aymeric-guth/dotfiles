#!/bin/sh

# hack to avoid OSX related PATH duplication
[ -f /etc/zprofile ] && export PATH= && export MANPATH= && . "/etc/zprofile"

export ZDOTDIR="$DOTFILES/zsh"
export ZDATA="$HOME/.local/share/zsh" && [ ! -d "$ZDATA" ] && mkdir -p "$ZDATA"
export ZCACHE="$HOME/.cache/zsh" && [ ! -d "$ZCACHE" ] && mkdir -p "$ZCACHE"

export HISTFILE="$ZDATA/.zsh_history"
setopt appendhistory

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

# direnv hook
source <(direnv hook zsh)


export MANPATH
export PATH

# HACK source .func
if [ -n "$TMUX" ]; then
  if [ -f "$WORKSPACE/.func.sh" ]; then
      source "$WORKSPACE/.func.sh"
  fi
fi
