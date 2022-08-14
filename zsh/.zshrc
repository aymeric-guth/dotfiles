# #!/bin/sh

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
export ZENVS="$ZDOTDIR/zshenvs"
export ZALIASES="$ZDOTDIR/aliases"
export ZPROMPTS="$ZDOTDIR/prompts"
export ZCOMPLETIONS="$ZDOTDIR/completions"
export ZSH_COMPDUMP=$ZDATA/.zcompdump

# completions
fpath=($ZCOMPLETIONS $fpath)
fpath=("/Users/yul/Desktop/Repos/zsh-completions/src" $fpath)
autoload -Uz compinit
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDATA/.zcompcache"
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
compinit -d $ZDATA/.zcompdump-$ZSH_VERSION

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

# Colors
autoload -Uz colors && colors

case "$(uname -s)" in
    Darwin)
        source "$ZENVS/zshenv-macos"
        source "$ZFUNCTIONS/zsh-functions-macos"
        source "$ZPROMPTS/zsh-prompt"
        source "$ZALIASES/zsh-aliases-macos"

        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        [ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source /opt/local/share/fzf/shell/key-bindings.zsh
        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        ;;

    Linux)
        source "$ZENVS/zshenv-linux"
        source "$ZFUNCTIONS/zsh-functions-linux"
        source "$ZPROMPTS/zsh-prompt"
        source "$ZALIASES/zsh-aliases-linux"

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

source "$ZENVS/after.sh"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

zle -N history-substring-search-up
zle -N history-substring-search-down
zle -N edit-command-line

bindkey -s '^x' "fzf-path\n"
bindkey -s "^s" "tmux attach\n"
bindkey -s "^v" "editor .\n"
bindkey -s "^k" "exit\n"
bindkey -s '^f' "tmuxinator-start\n"
bindkey -s "^n" "tmuxinator-edit\n"
bindkey -s "^g" "tmuxinator-debug\n"
bindkey -s "^q" "hello-world\n"
bindkey -s "\eq" "hello-world\n"
bindkey -s '\eh' '^l hello'
bindkey '\eg' clear-screen

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

# source $ZDOTDIR/vim-mode.sh

export PATH
