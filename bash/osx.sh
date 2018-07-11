source $HOME/Development/dotfiles/bash/base.sh

export HOMEBREW_PREFIX="$(brew --prefix)"
# coreutlis -  as default command line tools
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH:$HOMEBREW_PREFIX/sbin"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"


# completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

if [ -x "$(command -v git)" ]; then
    source <(doctl completion bash)
fi

source $HOME/Development/dotfiles/bash/aliases.sh
source $HOME/Development/dotfiles/bash/functions.sh
source $HOME/Development/dotfiles/bash/completions.sh

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate
fi
