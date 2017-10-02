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

__dotfiles_ps1() {
    if [ -n "$DOTFILES" ]; then
        echo "{$(basename $(dirname $(dirname $DOTFILES)))} "
    else
        echo ""
    fi
}

# prompt customization
export PS1=" \[\e[1;35m\]\$(__dotfiles_ps1)\[\e[m\]\\[\e[1;33m\]\[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$(__hg_ps1)\[\e[m\]\\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]\[\e[1;32m\]|\D{%H:%M:%S %d-%b-%y}|\[\e[m\]\n ❯ "

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER=$nvim

if [ -n "$DOTFILES" ]; then
    source $DOTFILES;
fi
