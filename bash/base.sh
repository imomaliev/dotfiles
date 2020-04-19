export XDG_CONFIG_HOME="$HOME/.config"

# Commands output encoding
export LC_ALL=en_US.UTF-8

# Deafult language
export LANG=en_US.UTF-8

# Avoid duplicates in your bash history
export HISTCONTROL="erasedups:ignoreboth"

# A colon-separated list of patterns used to decide which command lines should be saved on the history list.
##export HISTIGNORE="history*:ls*"

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

__jobs_ps1() {
    if [ -n "$(jobs -p)" ]; then echo {$(jobs -p | wc -l)}; fi
}

__bash_prompt_command() {
    BASE_PROMPT="\[\e[m\]\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]\[\e[1;37m\]|\D{%H:%M:%S %d-%b-%y}|\[\e[m\] \[\e[1;35m\]\$(__jobs_ps1)\[\e[m\]\n ❯ "
    if [[ -n "$DIRENV_DIR" ]]; then
        export PS1=" \[\e[1;32m\]\$(__venv_ps1)\[\e[m\]\[\e[1;33m\]\[\e[1;34m\]\[\e[4m\]\w\[\e[m\]\[\e[m\] \[\e[1;33m\]$BASE_PROMPT"
    else
        export PS1=" \[\e[1;32m\]\$(__venv_ps1)\[\e[m\]\[\e[1;33m\]\[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]$BASE_PROMPT"
    fi
}

export PROMPT_COMMAND=__bash_prompt_command

eval "$(direnv hook bash)"

# prompt customization

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER="$nvim -R"
export PIPENV_VENV_IN_PROJECT=1
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -g ''"
export PYENV_ROOT="$(pyenv root)"
export PATH="$PYENV_ROOT/bin:$PATH"
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
export NPM_CONFIG_PREFIX=$HOME/.local/npm
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
