export XDG_CONFIG_HOME="$HOME/.config"

# Commands output encoding
export LC_ALL=en_US.UTF-8

# Deafult language
export LANG=en_US.UTF-8

# Avoid duplicates in your bash history
export HISTCONTROL="erasedups:ignoreboth"

# A colon-separated list of patterns used to decide which command lines should be saved on the history list.
##export HISTIGNORE="history*:ls*"

hg_branch() {
    hg branch 2> /dev/null | awk '{print "["$1"] " }'
}

# prompt customization
export PS1=" \[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$(hg_branch)\[\e[m\]\\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]\n❯ "

# Use vi mode
set -o vi

# show all possible compleations
bind "set show-all-if-ambiguous on"

# tab cycle through files
## bind "TAB:menu-complete"

# case insensitive completion
bind "set completion-ignore-case on"

# set default editor to nvim
export EDITOR=$(which nvim)
export VIEWER=$(which nvim)

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi
