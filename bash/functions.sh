function find_dotfiles() {
    if [ "$1" == "/" ]; then
        return 1;
    fi
    if [ -z $1 ]; then
        local cur_dir=$PWD;
    else
        local cur_dir=$1;
    fi
    DOTFILES="$cur_dir/.dotfiles/.bashrc";
    if [ -f "$DOTFILES" ]; then
        source $DOTFILES;
        return 0;
    else
        find_dotfiles $(dirname $cur_dir);
    fi
}

function venv() {
    case $1 in
        "")
            source venv/bin/activate;
            find_dotfiles;
            if [ -n "$TMUX" ]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV;
                tmux set-environment DOTFILES $DOTFILES;
            fi
        ;;
        create)
            local prompt=$2;
            shift 2;
            virtualenv venv --prompt=" \[\e[1;30m\]($prompt)\[\e[m\]" "$@"
        ;;
    esac
}

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
