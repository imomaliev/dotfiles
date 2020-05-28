" Enable the use of the mouse.
set mouse=a

set number

" allow swtiching buffer when not saved
set hidden

" automaticall determine search case
set ignorecase
set smartcase

" When on, splitting a window will put the new window right and below of the current one.
set splitright
set splitbelow

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list
" Strings to use in 'list' mode and for the :list command.
set listchars=trail:-,nbsp:+,tab:▸\ \,eol:¬,space:·

" show a visual line under the cursor's current line
set cursorline

" use normal regex for search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" make Y consistent with D, C
nnoremap Y y$

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
"
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Some for CTRL-W
inoremap <C-W> <C-G>u<C-W>
inoremap <CR> <C-G>u<CR>


" Plug
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  " https://github.com/junegunn/vim-plug#neovim
  execute '!curl -fLo ' . stdpath('data') . '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute ':source $MYVIMRC'
  execute ':PlugInstall'
endi

call plug#begin(stdpath('data') . '/plugged')

Plug 'jnurmine/Zenburn'

Plug 'machakann/vim-highlightedyank'
" Editor
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Filetypes
Plug 'posva/vim-vue'

call plug#end()

colorscheme zenburn

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 200


augroup config
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType sh setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END
