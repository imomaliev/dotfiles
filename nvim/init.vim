" Change nvimrc with auto reload
"" autocmd BufWritePost .nvimrc source %

" Detect filetype and enable plugin and indentation.
filetype plugin indent on

" Switch syntax highlighting on according to the current value of the 'filetype' option.
syntax on

" To define a mapping which uses the mapleader variable.
let mapleader = " "
map <Leader>r :registers<CR>
map <Leader>m :marks<CR>
map <Leader>p "+p
map <Leader>P "+P
map <Leader>y "+y

" Show (partial) command in the last line of the screen.
set showcmd

"This option specifies a function to be used for Insert mode omni completion with CTRL-X CTRL-O.
set omnifunc=syntaxcomplete#Complete

" Completion mode that is used for the character specified with 'wildchar'.
set wildmode=longest:full,full

" When set case is ignored when completing file names and directories.
set wildignorecase

" A file that matches with one of these patterns is ignored when expanding wildcards.
set wildignore+=.pyc

" Files with these suffixes get a lower priority when multiple files match a wildcard.
set suffixes+=.pyc

" Print the line number in front of each line.
set number

" If the 'ignorecase' option is on, the case of normal letters is ignored.
set smartcase

"Show the line number relative to the line with the cursor in front of each line.
"""set relativenumber

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" Influences when the last window will have a status line.
set laststatus=2

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list

" Strings to use in 'list' mode and for the :list command.
set listchars=tab:▸\ ,eol:¬

" Set additional keymap for using <Ctrl>+^ to switch in instert mode
""unmap <C-Space>
imap <C-Space> <C-^>
set keymap=mac-russian-colemak
set iminsert=0
set imsearch=0

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
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'

" Set the default listing style: tree
let g:netrw_liststyle=3

" :vimgrep/:grep configuartion
" Program to use for the :grep command.
""set grepprg=ag\ --vimgrep\ $*
""set grepformat=%f:%l:%c:%m

" Remaps
" Colemak remap
"" set langmap=jk,kj

" Remap :
"" noremap : ;
"" noremap ; :

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>


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

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

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

" Font and colorscheme
color zenburn

set nobackup
set nowritebackup

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


if !empty(glob("~/.config/nvim/autoload/plug.vim"))
    call plug#begin('~/.config/nvim/plugged')

    Plug 'ctrlpvim/ctrlp.vim' | Plug 'mattn/ctrlp-register'

    Plug 'imomaliev/registers.vim'

    Plug 'tpope/vim-surround'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

    call plug#end()

endif

" show ctrl+X tooltip
"" set shortmess-=c

" Usually you shouldn't do this but for now it's ok
""set clipboard=unnamed
