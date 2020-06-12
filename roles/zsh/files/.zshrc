#!/bin/zsh

# use emacs mode
bindkey -e

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VISUAL=$nvim
# for mc
export VIEWER="$nvim -R"

alias vim='nvim'

export PIPENV_VENV_IN_PROJECT=1

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
if [ "$(uname)" = "Darwin" ]; then
    export HOMEBREW_PATH=$(brew --prefix)
fi

# show hidden files
export FZF_DEFAULT_COMMAND='find . -type f'

# clean home dir
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"


# The following lines were added by compinstall
# zstyle :compinstall filename "$HOME/.config/.zshrc"

# run: compaudit | xargs chmod g-w
autoload -Uz compinit
compinit
# End of lines added by compinstall

# https://github.com/denysdovhan/spaceship-prompt#example
fpath=( "$XDG_CONFIG_HOME/zsh/functions" $fpath )
autoload -Uz promptinit
promptinit
prompt dotfiles

. "$XDG_CONFIG_HOME/zsh/local.zsh"
