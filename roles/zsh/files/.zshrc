#!/bin/zsh

export PROMPT="%~ %# "

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER="$nvim -R"

alias vim='nvim'

export PIPENV_VENV_IN_PROJECT=1

export XDG_DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"
# this is where pipx is installed
export LOCAL_VENV="$XDG_DATA_DIR/venv"
export PIPX_HOME="$XDG_DATA_DIR/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"

# show hidden files
export FZF_DEFAULT_COMMAND='find .'

# clean home dir
export INPUTRC="$HOME/.config/readline/inputrc"
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
export LESSHISTFILE="$HOME/.cache/less/history"
export HISTFILE="$HOME/.cache/zsh/history"

export PATH="$LOCAL_VENV/bin:$PATH:$PIPX_BIN_DIR"

. "$HOME/.config/zsh/local.zsh"
