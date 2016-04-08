" This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way.
set nocompatible

" Detect filetype and enable plugin and indentation
filetype plugin indent on

"This option specifies a function to be used for Insert mode omni completion with CTRL-X CTRL-O.
set omnifunc=syntaxcomplete#Complete

" Show (partial) command in the last line of the screen.
set showcmd

" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
set wildmenu

" Bash like compleation
" use :h
set wildmode=list:longest

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set backspace=2

" Influences when the last window will have a status line.
set laststatus=2

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list

" Strings to use in 'list' mode and for the |:list| command.
set listchars=tab:▸\ ,eol:¬

" Set additional keymap for using <Ctrl>+^ to switch in instert mode
set keymap=mac-russian-colemak
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" A comma separated list of options for Insert mode completion ins-completion.
set completeopt=longest,menu,preview


" Colemak remap
"" set langmap=jk,kj

" Remap :
"" noremap : ;
"" noremap ; :

" Use ctrl+h in insert mode
" ctrl+o in insert mode turns comand mode for one comand
""imap <C-h> <C-o>h
""imap <C-j> <C-o>j
""imap <C-k> <C-o>k
""imap <C-l> <C-o>l

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>


" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" indent when moving to the next line while writing code
set autoindent

" show a visual line under the cursor's current line 
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" Font and colorscheme
set guifont=Menlo:h12
color zenburn 


" NERDTree
let NERDTreeIgnore = ['\.pyc$']

" https://github.com/mbrochh/vim-as-a-python-ide/blob/master/.vimrc

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>

" Usually you shouldn't do this but for now it's ok
set clipboard=unnamed


" Enable syntax highlighting
" You need to reload this file for the change to apply
syntax on

" Showing line numbers and length
""set relativenumber
set number " show line numbers
"" set tw=79 " width of document (used by gd)
"" set nowrap " don't automatically wrap on load
"" set fo-=t " don't automatically wrap text when typing
"" set colorcolumn=120
"" highlight ColorColumn ctermbg=233

