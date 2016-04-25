alias ls='ls --color -la'
alias watch='watch --color'
alias grep='grep --color'
alias vim='nvim'
alias venv='source venv/bin/activate'
alias cal='gcal'
alias noveo_connect='sshfs noveo:$HOME/Development ~/Noveo/Remote/'
alias noveo_disconnect='umount ~/Noveo/Remote/'
function venv_create() { virtualenv venv -p python --prompt=" \[\e[1;30m\]($1)\[\e[m\]"; }
alias venv_create=venv_create
alias docker_rm='docker rm $(docker ps -a -q)'
alias docker_rmi='docker rmi $(docker images -q -f dangling=true)'
