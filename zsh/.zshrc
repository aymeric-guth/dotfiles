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

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
# setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
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

source "$ZDOTDIR/zshenv"
. "$ZDOTDIR/func/zsh-functions"
. "$ZDOTDIR/func/find.sh"
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

# Prompt
if command -v starship 1>/dev/null; then
    export STARSHIP_CONFIG="$DOTFILES/starship.toml"
    eval "$(starship init zsh)"
elif [ -d "$REPODIR/pure" ]; then
    fpath+=("$REPODIR/pure")
    autoload -U promptinit; promptinit
    zstyle :prompt:pure:prompt:success color green
    prompt pure
elif [ -f "$ZDOTDIR/prompt" ]; then
    source "$ZDOTDIR/prompt"
fi

# eval "$(starship init zsh)"

[ -f "$ZDOTDIR/zcomp" ] && [ -n "$ZCOMP" ] && source "$ZDOTDIR/zcomp"

if [ -n "$FZF" ]; then
    my-zsh-add-plugin "Aloxaf/fzf-tab"
    # my-zsh-add-plugin "Freed-Wu/fzf-tab-source"
    # my-zsh-add-plugin "lincheney/fzf-tab-completion"
    # determines search program for fzf
    
    if type fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
    elif type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden'
    fi
fi
# Plugins
# my-zsh-add-plugin "zdharma-continuum/fast-syntax-highlighting"
# zsh-add-plugin "zsh-users/zsh-syntax-highlighting"
my-zsh-add-plugin "zsh-users/zsh-autosuggestions"
my-zsh-add-plugin "hlissner/zsh-autopair"
my-zsh-add-plugin "zsh-users/zsh-history-substring-search"
# my-zsh-add-plugin "jeffreytse/zsh-vi-mode"


[ -f "$ZDOTDIR/keybinds" ] && source "$ZDOTDIR/keybinds"

# POST LOAD
# everything else is loaded
# direnv hook
source <(direnv hook zsh)


# HACK source .func
# preferer JK
source-func() { emulate -L zsh; [ -f .func.sh ] && source .func.sh; }
add-zsh-hook precmd source-func
# if [[ $commands[direnv] ]]; then
#     source <(direnv hook zsh)
#     direnv_prompt() {
#       [ -n "$DIRENV_DIFF" ] && psvar[12]="(${psvar[12]})"
#     }
#     add-zsh-hook precmd direnv_prompt
# fi


zle-line-pre-redraw() { ( auto-keybind $BUFFER ) && zle accept-line; }
zle -N zle-line-pre-redraw

# if [ -n "$ZSH_HIST" ]; then
#     zsh_hist() {
#         env && echo $PWD
#         echo $1 | zshist add --format raw --database ~/db.sqlite
#     }
    
#     add-zsh-hook zshaddhistory zsh_hist
# fi

# function preexec() {
#   timer=$(($(gdate +%s%0N)/1000000))
# }

# function precmd() {
#   if [ $timer ]; then
#     now=$(($(gdate +%s%0N)/1000000))
#     elapsed=$(($now-$timer))
# 
#     export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
#     unset timer
#   fi
# }


# obsidian shell extension
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${realpath}'
export LESSOPEN='|"$DOTFILES/zsh/.lessfilter" '%s''

export MANPATH
export PATH
