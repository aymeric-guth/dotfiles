# #!/bin/sh

HISTFILE="$ZDATA/.zsh_history"
setopt appendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# cd -> pushd
# setopt auto_pushd

# beeping is annoying
unsetopt BEEP

# completions
export ZSH_COMPDUMP=$ZDATA/.zcompdump
autoload -Uz compinit
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDATA/.zcompcache"
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots) # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

export ZPLUGINS="$ZDATA/plugins"
export ZFUNCTIONS="$ZDOTDIR/functions"
export ZENVS="$ZDOTDIR/zshenvs"
export ZALIASES="$ZDOTDIR/aliases"
export ZPROMPTS="$ZDOTDIR/prompts"
export ZCOMPLETIONS="$ZDOTDIR/completions"


case "$(uname -s)" in
    Darwin)
        # Imports
        source "$ZENVS/zshenv-macos"
        source "$ZALIASES/zsh-aliases-macos"
        source "$ZFUNCTIONS/zsh-functions-macos"
        source "$ZPROMPTS/zsh-prompt"
        # https://github.com/junegunn/fzf
        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        [ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source /opt/local/share/fzf/shell/key-bindings.zsh
        [ -f /opt/local/share/fzf/shell/completion.zsh ] && source /opt/local/share/fzf/shell/completion.zsh
        [ -f $ZCOMPLETIONS/_fnm ] && fpath+="$ZCOMPLETIONS/"
        ;;
    Linux)
        # Imports
        source "$ZENVS/zshenv-linux"
        source "$ZALIASES/zsh-aliases-linux"
        source "$ZFUNCTIONS/zsh-functions-linux"
        source "$ZPROMPTS/zsh-prompt"
        # https://github.com/junegunn/fzf
        [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
        [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
        [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
        [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        [ -f $ZCOMPLETIONS/_fnm ] && fpath+="$ZCOMPLETIONS/"
        ;;
    *)
        ;;
esac

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

# kube-ps1 @0.7.0_5
# zsh_add_plugin "MichaelAquilina/zsh-auto-notify"
# zsh_add_plugin MichaelAquilina/zsh-you-should-use
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions: https://github.com/zsh-users/zsh-completions

# Key-bindings
# bindkey -s '^o' 'ranger^M'
# bindkey -s '^f' 'zi^M'
# bindkey -s '^s' 'ncdu^M'
# bindkey -s '^n' 'nvim $(fzf)^M'
# bindkey -s '^v' 'nvim\n'
# bindkey -s '^z' 'zi^M'
# bindkey '^[[P' delete-char
# bindkey "^p" up-line-or-beginning-search # Up
# bindkey "^n" down-line-or-beginning-search # Down
# bindkey "^k" up-line-or-beginning-search # Up
# bindkey "^j" down-line-or-beginning-search # Down
# bindkey -r "^u"
# bindkey -r "^d"

zle -N history-substring-search-up
zle -N history-substring-search-down
zle -N tmux-sessionizer
zle -N fzf-path

bindkey -s '^f' "tmux-sessionizer\n"
bindkey -s '^x' "fzf-path\n"

bindkey "^[[5~" beginning-of-line
bindkey "^[[6~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

compinit -d $ZDATA/.zcompdump-$ZSH_VERSION

# Completion
source "$ZCOMPLETIONS/.minikube-completion"
fpath=($ZCOMPLETIONS $fpath)
zstyle ':completion:*:*:git:*' script $ZCOMPLETIONS/git-completion.bash
# source "$ZCOMPLETIONS/git-completion.bash"
# source "$ZCOMPLETIONS/git-completion.zsh"


# direnv hook
eval "$(direnv hook zsh)"
# export EDITOR=nano
export EDITOR=$HOME/bin/editor


#determines search program for fzf
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
elif type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-file $DOTCONF/.gitignore'
fi

# source $ZDOTDIR/vim-mode.sh

export PATH
