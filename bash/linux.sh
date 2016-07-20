source $HOME/Development/dotfiles/bash/base.sh

export TERM=xterm-256color

# http://stackoverflow.com/a/791800/3627387
[[ $- == *i* ]] && stty -ixon

source $HOME/Development/dotfiles/bash/aliases.sh
source $HOME/Development/dotfiles/bash/functions.sh
source $HOME/Development/dotfiles/bash/completions.sh
