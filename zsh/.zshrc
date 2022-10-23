#!/bin/sh

# hack to avoid OSX related PATH duplication
[ -f /etc/zprofile ] && export PATH= && export MANPATH= && . "/etc/zprofile"

export ZDOTDIR="$DOTFILES/zsh"
export ZDATA="$HOME/.local/share/zsh"
[ ! -d "$ZDATA" ] && mkdir -p "$ZDATA"
export ZCACHE="$HOME/.cache/zsh"
[ ! -d "$ZCACHE" ] && mkdir -p "$ZCACHE"

export HISTFILE="$ZDATA/.zsh_history"
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
stty start undef # Disable ctrl-q to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP

fpath=("$ZDOTDIR/.zfunc" "${fpath[@]}")
autoload -U -z $fpath[1]/*(.:t)

# COMPLETIONS
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

# Colors
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

if [ -d "$GITHUB_REPOS/pure" ]; then
    fpath+=("$GITHUB_REPOS/pure")
    autoload -U promptinit; promptinit
    zstyle :prompt:pure:prompt:success color green
    prompt pure
elif [ -f "$ZDOTDIR/prompt" ]; then
    source "$ZDOTDIR/prompt"
fi

# Completion
# source <(minikube completion zsh)
# This config allows minikube to run kubernetes with the docker container locally
# eval $(minikube docker-env)

if command -v kubetcl 1> /dev/null; then
    source <(kubectl completion zsh)
fi

if command -v k3s 1> /dev/null; then
    source <(k3s completion zsh)
fi

if command -v rustup 1> /dev/null; then
    eval $(rustup completions zsh)
fi

[ -f "$ZDOTDIR/completions/_croc" ] && PROG=croc _CLI_ZSH_AUTOCOMPLETE_HACK=1 source "$ZDOTDIR/completions/_croc"

# eval "$(_TMUXP_COMPLETE=zsh_source tmuxp)"
# eval $(register-python-argcomplete ansible)
# eval $(register-python-argcomplete ansible-config)
# eval $(register-python-argcomplete ansible-console)
# eval $(register-python-argcomplete ansible-doc)
# eval $(register-python-argcomplete ansible-galaxy)
# eval $(register-python-argcomplete ansible-inventory)
# eval $(register-python-argcomplete ansible-playbook)
# eval $(register-python-argcomplete ansible-pull)
# eval $(register-python-argcomplete ansible-vault)

# Plugins
my-zsh-add-plugin "Aloxaf/fzf-tab"
my-zsh-add-plugin "zdharma-continuum/fast-syntax-highlighting"
# zsh-add-plugin "zsh-users/zsh-syntax-highlighting"
my-zsh-add-plugin "zsh-users/zsh-autosuggestions"
my-zsh-add-plugin "hlissner/zsh-autopair"
my-zsh-add-plugin "zsh-users/zsh-history-substring-search"

[ -f "$ZDOTDIR/keybinds" ] && source "$ZDOTDIR/keybinds"

# direnv hook
source <(direnv hook zsh)

# determines search program for fzf
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
elif type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

export MANPATH
export PATH
