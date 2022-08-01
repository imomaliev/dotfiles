" Enable the use of the mouse.
set mouse=a

set number

" allow swtiching buffer when not saved
set hidden

" automaticall determine search case
set ignorecase
set smartcase
set tagcase=match

" all matches in a line are substituted instead of one
set gdefault

" When on, splitting a window will put the new window right and below of the current one.
set splitright
set splitbelow

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list
" Strings to use in 'list' mode and for the :list command.
set listchars=trail:-,nbsp:+,tab:▸\ \,eol:¬,space:·

" show a visual line under the cursor's current line
set cursorline

" Completion mode that is used for the character specified with 'wildchar'.
set wildmode=longest:full,full

" A comma separated list of options for Insert mode completion ins-completion.
" default: menu,preview
" https://stackoverflow.com/a/15698653/3627387
set completeopt+=longest

" undohistory
set undofile

" To define a mapping which uses the mapleader variable.
let mapleader = "\<Space>"

" Maps for magic mode in search
nnoremap <Leader>/ /\v
vnoremap <Leader>/ /\v
nnoremap <Leader>? ?\v
vnoremap <Leader>? ?\v

" make Y consistent with D, C
nnoremap Y y$

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Reselect last-pasted text
" https://vim.fandom.com/wiki/Selecting_your_pasted_text
nnoremap <expr> <Leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" https://hg.stevelosh.com/dotfiles/file/tip/vim/vimrc#l421
" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Some for CTRL-W
inoremap <C-W> <C-G>u<C-W>
inoremap <CR> <C-G>u<CR>

" Emacs like keys for the command line
cnoremap <C-A> <Home>
" do not lose default mapping
cnoremap <C-B> <C-A>


let g:node_host_prog = stdpath('data') . '/node/node_modules/.bin/neovim-node-host'
:let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = stdpath('data') . '/python3/bin/python'


" Open tag in location window and jump to first occurence
" https://vi.stackexchange.com/a/16805/7820
" http://andrewradev.com/2011/06/08/vim-and-ctags/
function! JumpToTagWithLocationList()
  let l:word = expand("<cword>")
  let l:taglist_len = len(taglist('^'.l:word.'$'))
  if  l:taglist_len == 0
    echohl ErrorMsg | echo "E426: tag not found: " . l:word | echohl None
  elseif l:taglist_len == 1
    execute 'tag ' . l:word
  else
    execute 'ltag ' . l:word . ' | lopen | wincmd p'
  endif
endfunction

function! SplitJumpToTagWithLocationList()
  let l:word = expand("<cword>")
  let l:taglist_len = len(taglist('^'.l:word.'$'))
  if  l:taglist_len == 0
    echohl ErrorMsg | echo "E426: tag not found: " . l:word | echohl None
  elseif l:taglist_len == 1
    execute 'vertical stag ' . l:word
  else
    execute 'vertical stag ' . l:word . ' | ltag ' . l:word . ' | lopen | wincmd p'
  endif
endfunction

nnoremap <expr> <C-W>} '<Esc>:topleft ptag ' . expand("<cword>") . '<CR>'


if executable('rg')
  let g:rg_command = 'rg --no-ignore --hidden --glob="!.git" --glob="!__pycache__" --glob="!.direnv/tags" --glob="!.direnv/nvim/fzf-history" --glob="!.DS_Store" --glob="!*.png" --glob="!.mypy_cache" --glob="!.pytest_cache" --glob="!*.sql"'
  let &grepprg=g:rg_command . ' --vimgrep'
  " https://github.com/jremmen/vim-ripgrep/blob/ec87af6b69387abb3c4449ce8c4040d2d00d745e/plugin/vim-ripgrep.vim#L12
  set grepformat=%f:%l:%c:%m
  let $FZF_DEFAULT_COMMAND=g:rg_command . ' --files'
endif

command! -nargs=+ Grep execute 'silent lgrep! <args>' | lopen

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
"
" most configs are set in ~/.config/ctags/default.ctags
let g:ctags_command = 'ctags -f .direnv/tags .'
command! Ctags execute 'silent !' . g:ctags_command

" Spell
set spelllang=en,ru
" It may also be a comma separated list of names.  A count before the 'zg' and 'zw'
" commands can be used to access each
let &spellfile=stdpath('config') . "/spell/en.utf-8.add," . stdpath('config') . "/spell/ru.utf-8.add"
" spelling mappings
map <Leader>ss <Esc>:setlocal spell!<CR>
" always forget what mapping for adding spelling
" map <Leader>sa zg
" map <Leader>sc <Esc>:setlocal nospell!<CR>


" netrw
" https://github.com/deepredsky/dotfiles/commit/2784bf650d3212d1674ec820db74f862c0dbe3fb
nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>

function! Scratch()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

command! -nargs=0 Scratch call Scratch()

" Plugins
" Pack
" packadd! matchit  " Loaded automatically
packadd cfilter  " Quickfix list and Location list filter

" Plug
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  " https://github.com/junegunn/vim-plug#neovim
  execute '!curl -fLo ' . stdpath('data') . '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute ':source $MYVIMRC'
  execute ':PlugInstall'
endi

call plug#begin(stdpath('data') . '/plugged')

" Keymap
Plug 'imomaliev/mac-russian-colemak.vim'

" UI
Plug 'jnurmine/Zenburn'
Plug 'machakann/vim-highlightedyank'
Plug 'wellle/context.vim'

" Operators
Plug 'machakann/vim-sandwich'
Plug 'Shougo/context_filetype.vim'
Plug 'tyru/caw.vim'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'

" Editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'editorconfig/editorconfig-vim'
Plug 'direnv/direnv.vim'
Plug 'preservim/tagbar'
Plug 'godlygeek/tabular'
" open files on specific line in traceback format
Plug 'wsdjeg/vim-fetch'
Plug 'nicwest/vim-camelsnek'

" Filetypes
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1
let g:python_highlight_class_vars = 0
let g:python_highlight_func_calls = 0
Plug 'posva/vim-vue'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'neomutt/neomutt.vim'
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
" TODO: use g:go_bin_path
" Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }

call plug#end()


" Keymap
set keymap=mac-russian-colemak
set iminsert=0
" -1  the value of 'iminsert' is used, makes it look like 'iminsert' is also used when typing a search pattern
set imsearch=-1

function! LangMapToggle()
  if &iminsert == 0
    set iminsert=1
  else
    set iminsert=0
  endif
endfunction

nnoremap <Leader>^ :call LangMapToggle()<CR>


" Colorscheme
colorscheme zenburn


" Statusline
" Emulating default statusline
function IsWordMotion()
  if g:wordmotion_disable_default_mappings == 0
    return '<wm> '
  endif
  return ''
endfunction

function IsLangMap()
  if &iminsert == 1
    return '<' . b:keymap_name . '> '
  endif
  return ''
endfunction

" https://github.com/neovim/neovim/blob/8665a96b92553b26c8c9c215900964b8a898595f/src/nvim/screen.c#L5039
" https://unix.stackexchange.com/a/518439
" probably default
" set statusline=%<%f\ %h%w%m%r%=%k\ %-14.(%l,%c%V%)\ %P

" Buffer number
set statusline=%n:
" Where to truncate line if too long
set statusline+=%<
" Path to the file in the buffer, as typed or relative to current directory
set statusline+=%f
set statusline+=\ " whitespace
" Help buffer flag, text is "[help]"
set statusline+=%h
" Preview window flag, text is "[Preview]"
set statusline+=%w
" Modified flag, text is "[+]"; "[-]" if 'modifiable' is off
set statusline+=%m
" Readonly flag, text is "[RO]"
set statusline+=%r
" https://github.com/scrooloose/vimfiles/blob/a9689e8eace5b38d9fb640294e6e4b681e18981a/vimrc#L175
" display a warning if &paste is set
set statusline+=%{&paste?'[paste]':''}
" Separation point between alignment sections
set statusline+=%=
set statusline+=%{IsWordMotion()}
set statusline+=%{IsLangMap()}
" - Where to truncate line if too long.
" l Line number
" c Column number
" V Virtual column number as -{num}
set statusline+=%-14.(%l,%c%V%)
set statusline+=\ " whitespace
" Percentage through file of displayed window
set statusline+=%P


" vim-highlightedyank
let g:highlightedyank_highlight_duration = 200


" vim-sandwitch
" use vim-surround mappings
runtime macros/sandwich/keymap/surround.vim
let g:sandwich#recipes += [
\  {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
\  {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
\  {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
\  {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['{']},
\  {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['[']},
\  {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['(']},
\ ]


" FZF
nnoremap <Leader>tt :<C-U>Files .<CR>
nnoremap <Leader>tl :<C-U>Buffers<CR>
nnoremap <Leader>tr :<C-U>History<CR>
nnoremap <Leader>tp :<C-U>Tags<CR>
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist([], ' ', { 'title': 'FZF Selected', 'items': map(copy(a:lines), '{ "filename": v:val, "lnum": 1, "text": v:val }') })
  copen
  cc
endfunction

let g:fzf_action = {
\  'ctrl-q': function('s:build_quickfix_list'),
\  'ctrl-t': 'tab split',
\  'ctrl-x': 'split',
\  'ctrl-v': 'vsplit',
\  }


" Signify
" Make colors more visible
highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE


" Wordmotion
let g:wordmotion_disable_default_mappings = 1

function! WordMotionToggle()
  if g:wordmotion_disable_default_mappings == 0
    let g:wordmotion_disable_default_mappings = 1
  else
    let g:wordmotion_disable_default_mappings = 0
  endif
  unlet g:loaded_wordmotion
  runtime plugin/wordmotion.vim
endfunction

nnoremap <silent> <Leader>, :call WordMotionToggle()<cr>


" Context
let g:context_filetype_blacklist = ['help']
" " https://github.com/wellle/context.vim/issues/23
" let g:context_nvim_no_redraw = 1
let g:context_enabled = 0


" Tagbar
" disaable sort
let g:tagbar_sort = 0


" Autocommands config
augroup config
  autocmd!
  autocmd Filetype * if &filetype != 'help' | nnoremap <buffer> <C-]> <Cmd>call JumpToTagWithLocationList()<CR> | nnoremap <buffer> <C-W>] <Cmd>call SplitJumpToTagWithLocationList()<CR> | endif
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType sh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType zsh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType vue setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType jinja.html setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab comments=s:{#,ex:#} commentstring={#\ %s\ #} | let b:caw_wrap_oneline_comment = ['{#', '#}']
  autocmd Filetype dockerfile setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd Filetype terraform setlocal expandtab
  autocmd FileType cfg setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType toml setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType markdown setlocal nofoldenable
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType gohtmltmpl setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab comments=s:{{/*,ex:*/}} commentstring={{/*\ %s\ */}} | let b:caw_wrap_oneline_comment = ['{{/*', '*/}}']
  " Autoresize windows
  autocmd VimResized * :wincmd =
augroup END

" append to neovim's internal group for file type detection
augroup filetypedetect
  autocmd BufRead,BufNewFile Pipfile setlocal filetype=toml
  autocmd BufRead,BufNewFile Pipfile.lock setlocal filetype=json
  autocmd BufRead,BufNewFile *.tmux setlocal filetype=bash
  autocmd BufRead,BufNewFile .dprint.json setlocal filetype=jsonc
  autocmd BufRead,BufNewFile .ansible-lint setlocal filetype=yaml
  " autocmd BufRead,BufNewFile Dockerfile* setlocal filetype=dockerfile
  " autocmd BufRead,BufNewFile *.muttrc setlocal filetype=neomuttrc
  " https://vi.stackexchange.com/questions/9962/get-filetype-by-extension-or-filename-in-vimscript
  autocmd BufRead,BufNewFile *.template execute "doautocmd filetypedetect BufRead " . fnameescape(expand("<afile>:r"))
augroup END
