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

__venv_ps1() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if [[ "$VIRTUAL_ENV" == *.venv ]]; then
            echo "($(basename $(dirname $(dirname $VIRTUAL_ENV)))) "
        else
            echo "($(basename $VIRTUAL_ENV)) "
        fi
    else
        echo ""
    fi
}

__dotfiles_ps1() {
    if [[ -n "$DIRENV_DIR" ]]; then
        echo "{$(basename ${DIRENV_DIR:1})} "
    else
        echo ""
    fi
}

eval "$(direnv hook bash)"

# prompt customization
export PS1=" \[\e[1;32m\]\$(__venv_ps1)\[\e[m\]\[\e[1;35m\]\$(__dotfiles_ps1)\[\e[m\]\\[\e[1;33m\]\[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$(__hg_ps1)\[\e[m\]\\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]\[\e[1;37m\]|\D{%H:%M:%S %d-%b-%y}|\[\e[m\]\n ❯ "

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER=$nvim
export PIPENV_VENV_IN_PROJECT=1
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -g ''"
export PYENV_ROOT="$(pyenv root)"
export PATH="$PYENV_ROOT/bin:$PATH"
