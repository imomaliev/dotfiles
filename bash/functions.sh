function find_dotfiles() {
    if [ "$1" == "/" ]; then
        return 0;
    fi
    if [ -z $1 ]; then
        cur_dir=$PWD;
    else
        cur_dir=$1;
    fi
    if [ -f "$cur_dir/.dotfiles/.bashrc" ]; then
        DOTFILES="$cur_dir/.dotfiles/.bashrc";
        return 1;
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
                source $DOTFILES;
            fi
            if [ -n "$TMUX" ]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV;
                tmux set-environment DOTFILES $DOTFILES;
            fi
        ;;
        create)
            virtualenv venv -p python --prompt=" \[\e[1;30m\]($2)\[\e[m\]";
        ;;
    esac
}

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
