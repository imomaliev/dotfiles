__init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref cur prev words cword
}


_venv()
{
    local cur prev words cword;
    if declare -F _init_completions >/dev/null 2>&1; then
        _init_completion
    else
        __init_completion
    fi
    opts="create create3 deactivate delete"
    if [[ $cword -eq 1 ]]; then
        COMPREPLY=($( compgen -W "${opts}" -- "$cur" ));
        return 0
    fi
}

complete -F _venv venv


_dotfiles()
{
    local cur prev words cword;
    if declare -F _init_completions >/dev/null 2>&1; then
        _init_completion
    else
        __init_completion
    fi
    opts="create delete source"
    if [[ $cword -eq 1 ]]; then
        COMPREPLY=($( compgen -W "${opts}" -- "$cur" ));
        return 0
    fi
}

complete -F _dotfiles dotfiles
