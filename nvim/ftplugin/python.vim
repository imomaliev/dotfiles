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

setlocal shiftround
setlocal nosmartindent

" A file that matches with one of these patterns is ignored when expanding wildcards.
setlocal wildignore+=*.pyc

" Files with these suffixes get a lower priority when multiple files match a wildcard.
setlocal suffixes+=.pyc


iabbrev pdb import pdb; pdb.set_trace()
iabbrev ipdb import ipdb; ipdb.set_trace()
iabbrev rpdb import rpdb; rpdb.set_trace()
iabbrev npdb import nose; nose.tools.set_trace()
