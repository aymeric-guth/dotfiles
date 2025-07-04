#!/bin/sh

# zmodload zsh/zprof
# hack to avoid OSX related PATH duplication
[ -f /etc/zprofile ] && export PATH= && export MANPATH= && . "/etc/zprofile"
# hack to set PATH for non - interractive shell
[ -f /etc/zshenv ] && . "/etc/zshenv"
[ -f /etc/zsh/zshenv ] && . "/etc/zsh/zshenv"

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

export MANWIDTH=999

hostname="$(uname -n)"
[ -f "$DOTFILES/env/.env-$hostname" ] && source "$DOTFILES/env/.env-$hostname"

[ -z "$TMUX_CONFIG" ] && export TMUX_CONFIG="$DOTFILES/tmux/tmux.conf"
[ -n "$TOOLDIR" ] && append-to-path "$TOOLDIR"/bin
[ -n "$GOPATH" ] && append-to-path "$GOPATH"/bin
[ -d "$HOME/.local/bin" ] && prepend-to-path "$HOME/.local/bin"
[ -d "/usr/local/go/bin" ] && append-to-path "/usr/local/go/bin"

export PROJECTS="$PERSONAL_PROJECTS $WORK_PROJECTS"

case "$(uname -s)" in
    Darwin)
        # export CLICOLOR=1
        source /opt/local/share/fzf/shell/key-bindings.zsh
        source /opt/local/share/fzf/shell/completion.zsh
        source "$ZDOTDIR/aliases-macos"
        ;;

    Linux)
        source "$ZDOTDIR/aliases-linux"
        ;;

    *)
        exit 1
        ;;
esac

# prompt
if command -v starship 1>/dev/null; then
    export STARSHIP_CONFIG="$DOTFILES/starship.toml"
    eval "$(starship init zsh)"
elif [ -d "$REPODIR/pure" ]; then
    fpath+=("$REPODIR/pure")
    autoload -U promptinit; promptinit
    zstyle :prompt:pure:prompt:success color green
    prompt pure
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
	bindkey -v -s "^O" "tmux-start $TMUXP_CONFIGDIR/anonymous\n"
	bindkey -v -s "^S" "tmux-attach\n"
fi

if command -v fzf 1>/dev/null; then
	prepend-to-path "$REPODIR/fzf/bin"
	[ -f "$REPODIR/fzf/shell/completion.zsh" ] && source "$REPODIR/fzf/shell/completion.zsh"
	[ -f "$REPODIR/fzf/shell/key-bindings.zsh" ] && source "$REPODIR/fzf/shell/key-bindings.zsh"

    my-zsh-add-plugin "Aloxaf/fzf-tab"
    if type fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
    elif type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden'
    fi
fi

# Vi mode
bindkey -v
# export KEYTIMEOUT=1

# Plugins
# my-zsh-add-plugin "zdharma-continuum/fast-syntax-highlighting"
# zsh-add-plugin "zsh-users/zsh-syntax-highlighting"
# my-zsh-add-plugin "zsh-users/zsh-autosuggestions"
# my-zsh-add-plugin "hlissner/zsh-autopair"
# my-zsh-add-plugin "zsh-users/zsh-history-substring-search"
# my-zsh-add-plugin "jeffreytse/zsh-vi-mode"


# POST LOAD
# everything else is loaded
# direnv hook
source <(direnv hook zsh)

# preview
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${realpath}'
export LESSOPEN='|"$DOTFILES/zsh/.lessfilter" '%s''

export MANPATH
export PATH
