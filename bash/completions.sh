__init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref cur prev words cword
}
source /usr/local/etc/bash_completion.d/git-prompt.sh
