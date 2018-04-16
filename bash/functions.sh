swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


# remove all files with specified filetype
rmft() {
    for ftype in "$@"; do
        find . -name "*.$ftype" -delete
    done
}

# list all files with specified filetype
lsft() {
    if [[ $# -eq 0 ]]; then
        # https://stackoverflow.com/questions/1842254/how-can-i-find-all-of-the-distinct-file-extensions-in-a-folder-hierarchy
        # https://superuser.com/questions/231704/list-all-unique-extensions-for-files-contained-in-a-directory
        # find . -type f -regextype posix-extended -regex "\./.+[^/%]\.[^/]+" | sed "s/.*\.//" | sort -u
        # FIXME: use something more correct than grep -v
        find . -type f | grep -ve "\.git/" -ve "\.direnv/" -ve "\.hg/" | sed -rn 's|.*/[^/]+\.([^/.]+)$|\1|p' | sort -u
    else
        for ftype in "$@"; do
            find . -name "*.$ftype"
        done
    fi

}

# https://askubuntu.com/questions/596489/how-to-delete-files-listed-in-a-text-file
rmfromfile() {
    for fname in "$@"; do
        xargs -a $fname rm
        find . -name "*.$fname"
    done
}
