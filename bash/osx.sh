source $HOME/Development/dotfiles/bash/base.sh

export HOMEBREW_PREFIX="$(brew --prefix)"
# coreutlis -  as default command line tools
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH:$HOMEBREW_PREFIX/sbin"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

# completion
if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then
    source $HOMEBREW_PREFIX/etc/bash_completion
fi

source $HOME/Development/dotfiles/bash/aliases.sh

