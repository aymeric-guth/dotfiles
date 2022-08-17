# #!/bin/sh

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

export ZPLUGINS="$ZDATA/plugins"
export ZFUNCTIONS="$ZDOTDIR/functions"
export ZCOMPLETIONS="$ZDOTDIR/completions"
export ZSH_COMPDUMP="$ZDATA/.zcompdump"

# completions
fpath=($ZCOMPLETIONS $fpath)
#fpath=("/Users/yul/Desktop/Repos/zsh-completions/src" $fpath)
autoload -U bashcompinit
# bashcompinit

autoload -Uz compinit
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_COMPDUMP"
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
compinit -d "$ZDATA/.zcompdump-$ZSH_VERSION"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

# Colors
autoload -Uz colors && colors

case "$(uname -s)" in
    Darwin)
        source "$ZDOTDIR/zshenv-macos"
        source "$ZFUNCTIONS/zsh-functions-macos"
        source "$ZDOTDIR/aliases-macos"

        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        [ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source /opt/local/share/fzf/shell/key-bindings.zsh
        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        ;;

    Linux)
        source "$ZDOTDIR/zshenv-linux"
        source "$ZFUNCTIONS/zsh-functions-linux"
        source "$ZDOTDIR/aliases-linux"

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

source "$ZDOTDIR/zshenv-after"
source "$ZDOTDIR/prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

zle -N history-substring-search-up
zle -N history-substring-search-down
zle -N edit-command-line
zle -N my-backward-delete-word

bindkey -s '^x' "fzf-path\n"
bindkey -s "^s" "tmux attach\n"
bindkey -s "^v" "editor .\n"
bindkey -s "^k" "exit\n"
bindkey '^W' my-backward-delete-word

bindkey -s '^f' "tmuxp-start\n"
bindkey -s "^n" "tmuxp-edit\n"
bindkey -s "^g" "tmuxp debug-info | editor -R\n"
bindkey -s "^a" "tmuxp-start $TMUXP_CONFIGDIR/anonymous\n" 
#bindkey -s "^g" "tmuxp-debug\n"

bindkey "^[[5~" beginning-of-line
bindkey "^[[6~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^e" edit-command-line

# direnv hook
eval "$(direnv hook zsh)"

# determines search program for fzf
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
elif type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

eval "$(_TMUXP_COMPLETE=zsh_source tmuxp)"
eval $(register-python-argcomplete ansible)
eval $(register-python-argcomplete ansible-config)
eval $(register-python-argcomplete ansible-console)
eval $(register-python-argcomplete ansible-doc)
eval $(register-python-argcomplete ansible-galaxy)
eval $(register-python-argcomplete ansible-inventory)
eval $(register-python-argcomplete ansible-playbook)
eval $(register-python-argcomplete ansible-pull)
eval $(register-python-argcomplete ansible-vault)

# source $ZDOTDIR/vim-mode.sh

export PATH
