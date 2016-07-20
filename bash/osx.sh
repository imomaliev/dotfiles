source $HOME/Development/dotfiles/bash/base.sh

export HOMEBREW_PREFIX="$(brew --prefix)"
# coreutlis -  as default command line tools
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH:$HOMEBREW_PREFIX/sbin"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"


# completion
# bash-compleation 2 need to `brew tap homebrew/versions
# if [ -f $HOMEBREW_PREFIX/share/bash-completion/bash_completion ]; then
#     . $HOMEBREW_PREFIX/share/bash-completion/bash_completion
# fi
if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
    source $HOMEBREW_PREFIX/etc/bash_completion
fi

source $HOME/Development/dotfiles/bash/aliases.sh
source $HOME/Development/dotfiles/bash/functions.sh
source $HOME/Development/dotfiles/bash/completions.sh
