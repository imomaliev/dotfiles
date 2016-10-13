dotfiles() {
    case $1 in
        source)
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
                if [ -n "$TMUX" ]; then
                    tmux set-environment DOTFILES $DOTFILES
                fi
                return 0
            else
                dotfiles source $(dirname $cur_dir)
            fi
        ;;
        init)
            local bashrc=".dotfiles/.bashrc"
            local agignore=".dotfiles/.agignore"
            local vimrc=".dotfiles/nvim/init.vim"
            touch $bashrc
            touch $agignore
            mkdir -p $(dirname $vimrc)
            touch $vimrc
        ;;
    esac
}


venv() {
    case $1 in
        "")
            source venv/bin/activate
            dotfiles source
            if [ -n "$TMUX" ]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
            fi
        ;;
        init)
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


rmft() {
    find . -name "*.$1" -delete
}
