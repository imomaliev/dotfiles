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


let g:node_host_prog = '$HOME/.local/share/nvim/node/node_modules/.bin/neovim-node-host'
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = '$HOME/.local/share/nvim/python3/bin/python'


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

nnoremap <C-]> :call JumpToTagWithLocationList()<CR>
nnoremap <C-W>] :call SplitJumpToTagWithLocationList()<CR>
nnoremap <expr> <C-W>} ':topleft ptag ' . expand("<cword>") . '<CR>'


command! -nargs=+ Grep execute 'silent lgrep! <args>' | lopen


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

" Filetypes
Plug 'posva/vim-vue'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

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

" probably default
" set statusline=%<%f\ %h%m%r%=%k\ %-14.(%l,%c%V%)\ %P

set statusline=%<
set statusline+=%f
set statusline+=\ "whitespace
set statusline+=%h
set statusline+=%m
set statusline+=%r
" https://github.com/scrooloose/vimfiles/blob/a9689e8eace5b38d9fb640294e6e4b681e18981a/vimrc#L175
" display a warning if &paste is set
set statusline+=%{&paste?'[paste]':''}
" right part
set statusline+=%=
set statusline+=%{IsWordMotion()}
set statusline+=%{IsLangMap()}
set statusline+=%-14.(%l,%c%V%)
set statusline+=\ "whitespace
set statusline+=%P


" vim-highlightedyank
let g:highlightedyank_highlight_duration = 200


" vim-sandwitch
" use vim-surround mappings
runtime macros/sandwich/keymap/surround.vim
let g:sandwich#recipes += [
      \   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
      \   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
      \   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
      \   {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['{']},
      \   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['[']},
      \   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['(']},
      \ ]


" FZF
nnoremap <Leader>tt :<C-U>Files .<CR>
nnoremap <Leader>tl :<C-U>Buffers<CR>
nnoremap <Leader>tr :<C-U>History<CR>
nnoremap <Leader>tp :<C-U>Tags<CR>
let $FZF_DEFAULT_COMMAND='find -E . -type f -not -regex ".*\.(pyc)"'


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


" Autocommands config
augroup config
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType sh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType vue setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd Filetype dockerfile setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd Filetype terraform setlocal expandtab
  autocmd BufRead,BufNewFile Dockerfile* setlocal filetype=dockerfile
  autocmd BufRead,BufNewFile Pipfile setlocal filetype=toml
  autocmd BufRead,BufNewFile Pipfile.lock setlocal filetype=json
  " Autoresize windows
  autocmd VimResized * :wincmd =
augroup END
