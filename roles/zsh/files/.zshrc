#!/bin/zsh

# https://stackoverflow.com/a/41139331/3627387
# Commands output encoding
export LC_ALL=en_US.UTF-8
# Deafult language
export LANG=en_US.UTF-8

# use emacs mode
bindkey -e

eval "$(/opt/homebrew/bin/brew shellenv)"

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VISUAL=$nvim
# for mc
export VIEWER="$nvim -R"

alias vim='nvim'
# Use ANSI color sequences to distinguish file types.
export CLICOLOR=1

export PIPENV_VENV_IN_PROJECT=1
export PIPENV_IGNORE_VIRTUALENVS=1


# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
if [ "$(uname)" = "Darwin" ]; then
    export HOMEBREW_PREFIX=$(brew --prefix)
fi

# show hidden files
export FZF_DEFAULT_COMMAND='find . -type f'

# clean home dir
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# The following lines were added by compinstall
# zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

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
