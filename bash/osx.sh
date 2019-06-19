source $HOME/Development/dotfiles/bash/base.sh

export HOMEBREW_PREFIX="$(brew --prefix)"
# coreutlis -  as default command line tools
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH:$HOMEBREW_PREFIX/sbin"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"


# completion
[[ -f /usr/local/share/bash-completion/bash_completion ]] && . /usr/local/share/bash-completion/bash_completion

source $HOME/Development/dotfiles/bash/aliases.sh
source $HOME/Development/dotfiles/bash/functions.sh
source $HOME/Development/dotfiles/bash/completions.sh

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate
fi

# added by travis gem
[[ -f /Users/batiskaf/.travis/travis.sh ]] && . $HOME/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[[ -f "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
[[ -f "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion" ]] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
