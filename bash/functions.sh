function venv() {
    case $1 in
        "")
            source venv/bin/activate;
            if [ -n "$TMUX" ]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV;
            fi
        ;;
        create)
            virtualenv venv -p python --prompt=" \[\e[1;30m\]($2)\[\e[m\]";
        ;;
    esac
}
