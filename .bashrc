export HOMEBREW_PREFIX=$(brew --prefix)
# coreutlis -  as default command line tools
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH:$HOMEBREW_PREFIX/sbin"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export XDG_CONFIG_HOME="$HOME/.config"

# Commands output encoding
export LC_ALL=en_US.UTF-8

# Deafult language
export LANG=en_US.UTF-8

# Avoid duplicates in your bash history
export HISTCONTROL='erasedups:ignoreboth'

# A colon-separated list of patterns used to decide which command lines should be saved on the history list.
##export HISTIGNORE="history*:ls*"

# terminfo and coloring
## export TERM=screen-256color
## export CLICOLOR=1
## export LSCOLORS=ExGxCxDxBxegedabagacad

hg_branch() {
    hg branch 2> /dev/null | awk '{print "["$1"] " }'
}

# prompt customization
export PS1=" \[\e[1;34m\]\w\[\e[m\] \[\e[1;33m\]\$(hg_branch)\[\e[m\]\\[\e[1;33m\]\$(__git_ps1 '[%s] ')\[\e[m\]\$ "

# Use vi mode
set -o vi

# show all possible compleations
bind "set show-all-if-ambiguous on"

# tab cycle through files
## bind "TAB:menu-complete"

# case insensitive completion
bind "set completion-ignore-case on"

if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
    source $HOMEBREW_PREFIX/etc/bash_completion
fi

if [ -f ~/.bash_aliases ]; then
   source ~/.bash_aliases
fi
