#!/bin/zsh

export PROMPT="%~ %# "

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER="$nvim -R"

alias vim='nvim'

export PIPENV_VENV_IN_PROJECT=1

export XDG_DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"
export LOCAL_VENV="$XDG_DATA_DIR/venv"
export PIPX_HOME="$XDG_DATA_DIR/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"
# clean home dir
export PYTHONSTARTUP="$HOME/.config/python/pythonrc"
export LESSHISTFILE="$HOME/.cache/less/lesshst"

export PATH="$LOCAL_VENV/bin:$PATH:$PIPX_BIN_DIR"

. "$HOME/.config/zsh/local.zsh"
