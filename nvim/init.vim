" Change nvimrc with auto reload
"" autocmd BufWritePost .nvimrc source %

" Detect filetype and enable plugin and indentation.
filetype plugin indent on

" Switch syntax highlighting on according to the current value of the 'filetype' option.
syntax on

" Show (partial) command in the last line of the screen.
set showcmd

"This option specifies a function to be used for Insert mode omni completion with CTRL-X CTRL-O.
set omnifunc=syntaxcomplete#Complete

" Completion mode that is used for the character specified with 'wildchar'.
set wildmode=longest:full,full

" When set case is ignored when completing file names and directories.
set wildignorecase

" A file that matches with one of these patterns is ignored when expanding wildcards.
set wildignore+=*.pyc

" Files with these suffixes get a lower priority when multiple files match a wildcard.
set suffixes+=.pyc

" Print the line number in front of each line.
set number

" If the 'ignorecase' option is on, the case of normal letters is ignored.
set smartcase

"Show the line number relative to the line with the cursor in front of each line.
""set relativenumber

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" Influences when the last window will have a status line.
set laststatus=2

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list

" Strings to use in 'list' mode and for the :list command.
set listchars=tab:▸\ ,eol:¬

" A comma separated list of options for Insert mode completion ins-completion.
set completeopt=longest,menu,preview

" When on, lines longer than the width of the window will not wrap and displaying will not continue on the next line.
set nowrap

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Netrw configuartion
" Comma separated pattern list for hiding files
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'

" Set the default listing style: tree
let g:netrw_liststyle=3

" :vimgrep/:grep configuartion
" Program to use for the :grep command.
""set grepprg=ag\ --vimgrep\ $*
""set grepformat=%f:%l:%c:%m

" Remap :
"" noremap : ;
"" noremap ; :

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Move by row not by line when 'wrap' set
nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

nnoremap $ g$
nnoremap g$ $

nnoremap ^ g^
nnoremap g^ ^

" indent when moving to the next line while writing code
set autoindent

" show a visual line under the cursor's current line 
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" When on, splitting a window will put the new window right of the current one.
set splitright

" enable all Python syntax highlighting features
let python_highlight_all = 1

set nobackup
set nowritebackup

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <PageUp> <nop>
noremap <PageDown> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <PageUp> <nop>
inoremap <PageDown> <nop>


function! InstallPlug()
    if empty(glob("~/.config/nvim/autoload/plug.vim"))
        execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
endfunction

function! UninstallPlug()
    if !empty(glob("~/.config/nvim/autoload/plug.vim"))
        execute '!rm -rf ~/.config/nvim/autoload/ ~/.config/nvim/plugged/'
    endif
endfunction


" recursively search up from dirname, sourcing all .dotfiles/.vimrc files along the way
function! ApplyLocalSettings(dirname)
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    " walk to the top of the dir tree
    let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
    if isdirectory(l:parentDir)
        call ApplyLocalSettings(l:parentDir)
    endif

    " now walk back down the path and source .vimsettings as you find them.
    " child directories can inherit from their parents
    let l:settingsFile = a:dirname . '/.dotfiles/.vimrc'
    if filereadable(l:settingsFile)
        exec ':source' . l:settingsFile
    endif
endfunction


if !empty(glob("~/.config/nvim/autoload/plug.vim"))
    call plug#begin('~/.config/nvim/plugged')

    Plug 'jnurmine/Zenburn'
    Plug 'imomaliev/mac-russian-colemak.vim'

    Plug 'ctrlpvim/ctrlp.vim' | Plug 'mattn/ctrlp-register'
    Plug 'scrooloose/nerdtree'

    Plug 'tpope/vim-surround'
""    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

    Plug 'mitsuhiko/vim-jinja'

    call plug#end()
endif

" https://robots.thoughtbot.com/faster-grepping-in-vim
" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ -p\ \"./.dotfiles/.agignore\"

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Font and colorscheme
color zenburn


" Set additional keymap for using <Ctrl>+^ to switch in instert mode
""unmap <C-Space>
imap <C-Space> <C-^>
set keymap=mac-russian-colemak
set iminsert=0
set imsearch=0

" To define a mapping which uses the mapleader variable.
let mapleader = " "
map <Leader>r <Esc>:registers<CR>
map <Leader>m <Esc>:marks<CR>
map <Leader>p "+p
map <Leader>P "+P
map <Leader>y "+y
map <Leader>n <Esc>:NERDTreeToggle<CR>
map <Leader>t <Esc>:!ctags<CR>
map <Leader>b <Esc>:CtrlPBuffer<CR>
map <Leader>/ :Ag<SPACE>

" Plugins Configuration
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" show ctrl+X tooltip
"" set shortmess-=c


call ApplyLocalSettings(expand('.'))
