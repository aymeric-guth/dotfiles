#!/bin/sh

if [ -f /etc/zprofile ]; then
    PATH=""
    MANPATH=""
    . /etc/zprofile
fi

export ZDOTDIR="$DOTFILES/zsh"
export ZDATA="$HOME/.local/share/zsh"

HISTFILE="$ZDATA/.zsh_history"
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
stty start undef # Disable ctrl-q to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP

fpath=("$ZDOTDIR/.zfunc" "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

# COMPLETIONS
fpath=("$ZDOTDIR/completions" $fpath)

autoload -U -z compinit
# autoload -U +X bashcompinit
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDATA/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
compinit -u -d "$ZDATA/.zcompdump-$ZSH_VERSION"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

# Colors
autoload -Uz colors && colors

case "$(uname -s)" in
    Darwin)
        export CLICOLOR=1
        source "$ZDOTDIR/func/zsh-functions-macos"
        source "$ZDOTDIR/zshenv"
        source "$ZDOTDIR/aliases-macos"
        export COMPOSE_CMD="docker compose"

        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        [ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source /opt/local/share/fzf/shell/key-bindings.zsh
        # [ -f "$ZDOTDIR/keybinds.zsh" ] && source "$ZDOTDIR/keybinds.zsh"
        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        ;;

    Linux)
        source "$ZDOTDIR/func/zsh-functions-linux"
        source "$ZDOTDIR/zshenv"
        source "$ZDOTDIR/aliases-linux"
        export COMPOSE_CMD="docker-compose"

        [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
        [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
        [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
        [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        ;;

    *)
        exit 1
        ;;
esac

source "$ZDOTDIR/prompt"

# source <(kubectl completion zsh)
# source <(minikube completion zsh)
# This config allows minikube to run kubernetes with the docker container locally
# eval $(minikube docker-env)

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

zle -N history-substring-search-up
zle -N history-substring-search-down
zle -N edit-command-line
zle -N my-backward-delete-word

# push-line
bindkey -r "^Q" 
bindkey -r "^[Q"
bindkey -r "^[q"
bindkey -s "^X" "fzf-path\n"
bindkey -s "^S" "tmux-attach\n"
bindkey -s "^K" "exit\n"
bindkey "^w" my-backward-delete-word

bindkey -s "^F" "tmuxp-start\n"
bindkey -s "^N" "tmuxp-edit\n"
bindkey -s "^G" "tmuxp debug-info | editor -R\n"
bindkey -s "^A" "tmuxp-start $TMUXP_CONFIGDIR/anonymous\n"

bindkey "^[[5~" beginning-of-line
bindkey "^[[6~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^E" edit-command-line
bindkey "^ " autosuggest-accept

bindkey -r "^R"
bindkey "^H" fzf-history-widget
bindkey -s "^R" "run\n"
bindkey -s "^B" "build\n"

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
