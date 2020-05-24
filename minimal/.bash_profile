export PS1="\w > "

# https://github.com/tmux/tmux/issues/120#issuecomment-143375064
# setting explicitly for cli programs behave properly
export TERM=xterm-256color

# set default editor to nvim
nvim=$(which nvim)
export EDITOR=$nvim
export VIEWER="$nvim -R"

alias vim='nvim'
alias ls='ls -G'
