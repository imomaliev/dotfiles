" Use the appropriate number of spaces to insert a <Tab>.
setlocal expandtab

" Number of spaces that a <Tab> in the file counts for.
setlocal tabstop=4

" Number of spaces that a <Tab> counts for while performing editing operations.
setlocal softtabstop=4

" Number of spaces to use for each step of (auto)indent.
setlocal shiftwidth=4

" Maximum width of text that is being inserted.
"" setlocal textwidth=80

setlocal smarttab
setlocal shiftround
setlocal modeline
setlocal nosmartindent

" :vimgrep/:grep configuartion
" Program to use for the :grep command.
""setlocal grepprg=ag\ --vimgrep\ --python\ $*

" A file that matches with one of these patterns is ignored when expanding wildcards.
setlocal wildignore+=.pyc

" Files with these suffixes get a lower priority when multiple files match a wildcard.
setlocal suffixes+=.pyc
