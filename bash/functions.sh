dotfiles() {
    case $1 in
        find)
            if [ "$2" == "/" ]; then
                return 1
            fi
            if [ -z $2 ]; then
                local cur_dir=$PWD
            else
                local cur_dir=$2
            fi
            DOTFILES="$cur_dir/.dotfiles/.bashrc"
            if [ -f "$DOTFILES" ]; then
                source $DOTFILES
                return 0
            else
                dotfiles find $(dirname $cur_dir)
            fi
        ;;
        create)
            local bashrc=".dotfiles/.bashrc"
            local vimrc=".dotfiles/nvim/init.vim"
            mkdir -p $(dirname $vimrc)
            touch $bashrc
            touch $vimrc
        ;;
    esac
}


venv() {
    case $1 in
        "")
            source venv/bin/activate
            dotfiles find
            if [ -n "$TMUX" ]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
                tmux set-environment DOTFILES $DOTFILES
            fi
        ;;
        create)
            local prompt=$2
            if [ -z $prompt ]; then
                prompt=$(basename $(pwd))
                shift 1
            else
                shift 2
            fi
            virtualenv venv --prompt=" \[\e[1;30m\]($prompt)\[\e[m\]" "$@"
            venv
            if [ -f requirements.txt ]; then
                pip install -U -r requirements.txt
            fi
        ;;
    esac
}


swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
