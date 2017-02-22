export XDG_CONFIG_HOME="$HOME/.config"

# Commands output encoding
export LC_ALL=en_US.UTF-8

# Deafult language
export LANG=en_US.UTF-8

# Avoid duplicates in your bash history
export HISTCONTROL="erasedups:ignoreboth"

# A colon-separated list of patterns used to decide which command lines should be saved on the history list.
##export HISTIGNORE="history*:ls*"

__hg_ps1() {
    hg prompt "[{branch}] " 2> /dev/null
}

# prompt customization
export PS1=" \[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$(__hg_ps1)\[\e[m\]\\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]|\[\e[1;32m\]\D{%H:%M:%S %d-%b-%y}\[\e[m\]|\n ❯ "

# set default editor to nvim
export EDITOR=$(which nvim)
export VIEWER=$(which nvim)

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi

if [ -n "$DOTFILES" ]; then
    source $DOTFILES;
fi
