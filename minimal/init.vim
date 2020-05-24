set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hidden

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list
" Strings to use in 'list' mode and for the :list command.
set listchars+=tab:▸\ \,eol:¬,space:·


if empty(glob("~/.config/nvim/autoload/plug.vim"))
  execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'jnurmine/Zenburn'

call plug#end()

colorscheme zenburn
