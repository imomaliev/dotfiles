_source_dotfiles() {
    local cur_dir=$1
    DOTFILES="$cur_dir/.dotfiles/.bashrc"
    if [[ -f "$DOTFILES" ]]; then
        source $DOTFILES
        if [[ -n "$TMUX" ]]; then
            tmux set-environment DOTFILES $DOTFILES
        fi
        return 0
    else
        dotfiles source $(dirname $cur_dir)
    fi
}

dotfiles() {
    case $1 in
        "")
            _source_dotfiles $PWD
        ;;
        source)
            if [[ "$2" == "/" ]]; then
                return 1
            fi
            if [[ -z $2 ]]; then
                _source_dotfiles $PWD
            else
                _source_dotfiles $2
            fi
        ;;
        create)
            local dotfiles_dir=".dotfiles/"
            local dotfiles_nvim_dir=".dotfiles/nvim/"
            if [[ ! -d "$dotfiles_dir" ]]; then
                mkdir -p $dotfiles_dir
            fi
            touch "$dotfiles_dir.bashrc"
            touch "$dotfiles_dir.agignore"
            if [[ ! -d "$dotfiles_nvim_dir" ]]; then
                mkdir -p $dotfiles_nvim_dir
            fi
            touch "$dotfiles_nvim_dir.init.vim"
        ;;
        delete)
            if [[ -n "$TMUX" ]]; then
                tmux set-environment -u DOTFILES
            fi
            rm -rf .dotfiles/
        ;;
    esac
}


_create_venv() {
    local prompt=$1
    if [[ -z $prompt ]] || [[ $prompt == -* ]]; then
        prompt=$(basename $(pwd))
    else
        shift 1
    fi
    virtualenv venv --prompt=" \[\e[1;30m\]($prompt)\[\e[m\]" "$@"
    venv
    if [[ -f requirements.txt ]]; then
        pip install -U -r requirements.txt
    fi
}

_deactivate_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
    if [[ -n "$TMUX" ]]; then
        tmux set-environment -u VIRTUAL_ENV
    fi
}

venv() {
    case $1 in
        "")
            source venv/bin/activate
            dotfiles
            if [[ -n "$TMUX" ]]; then
                tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
            fi
        ;;
        create)
            shift 1
            _create_venv "$@"
        ;;
        create3)
            shift 1
            _create_venv "$@" -p python3
        ;;
        deactivate)
            _deactivate_venv
        ;;
        delete)
            _deactivate_venv
            rm -rf venv/
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
