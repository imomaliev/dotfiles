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
""setlocal iskeyword-=_


iabbrev pdb import pdb; pdb.set_trace()
iabbrev ipdb import ipdb; ipdb.set_trace()
iabbrev rpdb import rpdb; rpdb.set_trace()
iabbrev npdb import nose; nose.tools.set_trace()


" http://vim.wikia.com/wiki/VimTip1546
" python << EOF
" import os
" import sys
" import vim
" for p in sys.path:
"     # Add each directory in sys.path, if it exists.
"     if os.path.isdir(p):
"         # Command 'set' needs backslash before each space.
"         vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
" EOF

" https://github.com/jmcantrell/vim-virtualenv
" https://github.com/tudorprodan/pyfinder.vim
" https://github.com/mkomitee/vim-gf-python
let s:current_script_dir = expand("<sfile>:p:h")

if has('python')
  exec "pyfile ".s:current_script_dir."/"."python.py"
  nnoremap <buffer> gf :python python_goto_file()<cr>
endif
if has('python3')
  exec "py3file ".s:current_script_dir."/"."python.py"
  nnoremap <buffer> gf :python3 python_goto_file()<cr>
endif
