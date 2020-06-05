#!/bin/zsh

export PROMPT="%~ %# "

# use vi mode
bindkey -v

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
# this is where pipx is installed
export LOCAL_VENV="$XDG_DATA_HOME/venv"
export PIPX_HOME="$XDG_DATA_HOME/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"

# show hidden files
export FZF_DEFAULT_COMMAND='find . -type f'

# clean home dir
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

export PATH="$LOCAL_VENV/bin:$PATH:$PIPX_BIN_DIR"

. "$XDG_CONFIG_HOME/zsh/local.zsh"
