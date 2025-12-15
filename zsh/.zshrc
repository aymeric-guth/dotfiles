#!/bin/sh

export ZDOTDIR="$DOTFILES/zsh"
export ZDATA="$HOME/.local/share/zsh" && [ ! -d "$ZDATA" ] && mkdir -p "$ZDATA"
export ZCACHE="$HOME/.cache/zsh" && [ ! -d "$ZCACHE" ] && mkdir -p "$ZCACHE"

export HISTFILE="$ZDATA/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTDUP=erase

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
setopt sharehistory

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
autoload -U +X bashcompinit
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
autoload -Uz add-zsh-hook

. "$DOTFILES/shell/common"

# prompt
if [ -d "$HOME/.local/share/pure" ]; then
    fpath+=("$HOME/.local/share/pure")
    autoload -U promptinit; promptinit
    zstyle :prompt:pure:prompt:success color green
    prompt pure
elif command -v starship 1>/dev/null; then
    eval "$(starship init zsh)"
fi

zle -N edit-command-line
zle -N my-backward-delete-word

bindkey "^W" my-backward-delete-word
bindkey -v "^E" edit-command-line
bindkey -v "^Y" autosuggest-accept

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

if command -v tmux 1>/dev/null; then
	bindkey -v -s "^F" "tmux-start\n"
	bindkey -v -s "^S" "tmux-attach\n"
fi

if command -v fzf 1>/dev/null; then
    source <(fzf --zsh)

    my-zsh-add-plugin "Aloxaf/fzf-tab"
    if type fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
    elif type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden'
    fi
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${realpath}'
fi

# VI mode
function vi-yank-osc52 {
    zle vi-yank
    osc52-copy "$CUTBUFFER"
}

zle -N vi-yank-osc52
bindkey -M vicmd 'y' vi-yank-osc52
bindkey -v

source <(direnv hook zsh)

export PROJECTS="$PERSONAL_PROJECTS $WORK_PROJECTS"
export LESSOPEN='|"$DOTFILES/.lessfilter" '%s''
export MANPATH
export PATH
alias tg=tag-reader
