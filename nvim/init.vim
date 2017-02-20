" Change init.vim with auto reload
"" autocmd BufWritePost init.vim source $MYVIMRC

" (Nvim by default) Detect filetype and enable plugin and indentation.
""filetype plugin indent on

" (Nvim by default) Switch syntax highlighting on according to the current value of the 'filetype' option.
""syntax on

" Show (partial) command in the last line of the screen.
set showcmd

" This option specifies a function to be used for Insert mode omni completion with CTRL-X CTRL-O.
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
set ignorecase
set smartcase
set tagcase=match

" Show the line number relative to the line with the cursor in front of each line.
""set relativenumber

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" (Nvim by default) Influences when the last window will have a status line.
""set laststatus=2

" Show tabs as CTRL-I is displayed, display $ after end of line.
set list

" Strings to use in 'list' mode and for the :list command.
set listchars=tab:▸\ ,eol:¬,space:·

" A comma separated list of options for Insert mode completion ins-completion.
set completeopt=longest,menu

" When on, lines longer than the width of the window will not wrap and displaying will not continue on the next line.
set nowrap

set tabstop=4
set softtabstop=4
set shiftwidth=4
""set expandtab

" When on, the ':substitute' flag 'g' is default on.
set gdefault

" (Nvim by default) indent when moving to the next line while writing code
""set autoindent
set smartindent

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" When on, splitting a window will put the new window right of the current one.
set splitright

" When on, splitting a window will put the new window below of the current one.
set splitbelow

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=999
" backup
set nobackup
set nowritebackup

" switching buffer configs
set hidden

" undohistory
set undofile

" (Nvim by default) auto load and save files
""set autoread
set autowriteall

" show ctrl+X tooltip
"" set shortmess-=c

" enable all Python syntax highlighting features
let python_highlight_all = 1

" Netrw configuartion
" Comma separated pattern list for hiding files
let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'

" Set the default listing style: tree
let g:netrw_liststyle=3

" use normal regex for search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" noremap ' `
" noremap ` '

" Remap :
"" noremap : ;
"" noremap ; :

" make Y consistent with D, C
nnoremap Y y$

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" https://bitbucket.org/sjl/dotfiles/src/1ff33bef59847fa2fcec2e172e16c010080923dd/vim/vimrc?at=default&fileviewer=file-view-default
" Reselect last-pasted text
nnoremap gvv gv
nnoremap gvp `[v`]

nnoremap gG <C-End>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Some for CTRL-W
inoremap <C-W> <C-G>u<C-W>

inoremap <CR> <C-G>u<CR>
" nnoremap <CR> o<Esc>

" with scrolloff!=0 'H' and 'L' are useless so we map them to start and end of line
noremap <expr> H (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> L (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
" do not include endofline in visual selection
vnoremap <expr> L (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')

" virtual editing means that the cursor can be positioned where there is no actual character.
" onemore: Allow the cursor to move just past the end of the line
nnoremap g<C-V> :setl virtualedit=block<CR><C-V>
nnoremap <C-V> :setl virtualedit=<CR><C-V>

" turn on paste when inserting in INSERT mode and turn it off again after paste
" http://vim.wikia.com/wiki/Pasting_registers
" http://stackoverflow.com/questions/26997172/passing-argument-to-vim-map
" inoremap <expr> <C-R> '<C-G>u<C-O>:set paste<CR><C-R>'.nr2char(getchar()).'<C-O>:set nopaste<CR>'

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
noremap <F1> <Nop>
" Disable ex-mode mapping
noremap Q <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
inoremap <F1> <Nop>

" terminal mapping
tnoremap <Esc> <C-\><C-N>

" http://stackoverflow.com/a/2605181/3627387
cabbrev cc cclose
cabbrev lc lclose
cabbrev hc helpclose
cabbrev te Terminal

" Emacs like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

nnoremap <C-K> k

" http://andrewradev.com/2011/06/08/vim-and-ctags/
function! JumpToTagWithList()
  let l:word = expand("<cword>")
  if len(taglist(l:word)) == 0
    echom "No tags found"
  elseif len(taglist(l:word)) == 1
    execute 'ltag '.l:word
  else
    execute 'ltag '.l:word.' | lopen'
    " h expr-string vs literal-string
    execute "normal! \<CR>"
  endif
endfunction

nnoremap <C-]> :call JumpToTagWithList()<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" recursively search up from 'dirname', sourcing all 'filename' files along the way
function! ApplyLocalSettings(dirname, filename)
  " convert windows paths to unix style
  let l:curDir = substitute(a:dirname, '\\', '/', 'g')

  " walk to the top of the dir tree
  let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
  if isdirectory(l:parentDir)
      call ApplyLocalSettings(l:parentDir)
  endif

  " now walk back down the path and source .vimsettings as you find them.
  " child directories can inherit from their parents
  let l:settingsFile = a:dirname . a:filename
  if filereadable(l:settingsFile)
      exe ':source' . l:settingsFile
      exe "set runtimepath+=" . a:dirname . "/.dotfiles/nvim"
      set undodir+=.dotfiles/nvim/undo
      set tags+=.dotfiles/tags
      let g:ctrlp_cache_dir = ".dotfiles/nvim/.cache/ctrlp"
  endif
endfunction

if empty(glob("~/.config/nvim/autoload/plug.vim"))
  execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

" keymap
Plug 'imomaliev/mac-russian-colemak.vim'

" Visual
Plug 'imomaliev/zenburn.vim'
Plug 'itchyny/lightline.vim'

" IDE
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'neomake/neomake'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'

" Edit
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tweekmonster/braceless.vim'
Plug 'vim-scripts/camelcasemotion'
" Plug 'imomaliev/registers.vim'
" Plug 'vim-scripts/YankRing.vim'

" Vcs
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'mhinz/vim-signify'

" Filetype plugins
Plug 'tmux-plugins/vim-tmux'
Plug 'digitaltoad/vim-pug'
Plug 'vim-scripts/python_match.vim'
Plug 'niftylettuce/Vim-Jinja2-Syntax'

" https://github.com/junegunn/vim-plug/issues/300#issuecomment-149173517
""call ApplyLocalSettings(expand('.'), '/.dotfiles/nvim/plugins.vim')

call plug#end()

" fix camelcase mapping
noremap ,, ,

" https://robots.thoughtbot.com/faster-grepping-in-vim
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ -U\ -p\ \".dotfiles/.agignore\"\ $*

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor -p ".dotfiles/.agignore" -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  ""let g:ctrlp_use_caching = 1
endif

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! GrepWordUnderCursor()
  let l:word = expand("<cword>")
  if len(l:word) > 3
    execute 'grep! "\b'.l:word.'\b"'
  else
    echom "cword is too short!"
  endif
endfunction

function! GrepVisualSelection()
  let l:word = GetVisualSelection()
  if len(l:word) > 3
    execute 'grep! "'.l:word.'"'
  else
    echom "selection is too short!"
  endif
endfunction

function! GrepCurrentFileName()
  execute 'grep! "'.expand("%:t:r").'"'
endfunction

" bind K to grep word under cursor
" http://stackoverflow.com/a/12170748/3627387
nnoremap <silent> K :call GrepWordUnderCursor()<CR>
vnoremap <silent> K :call GrepVisualSelection()<CR>

" bind \ (backward slash) to grep shortcut
""command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Font and colorscheme
""set termguicolors
let g:zenburn_force_dark_Background = 1
color zenburn

" vim-indent colors
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" Set additional keymap for using <Ctrl>+^ to switch in instert mode
""unmap <C-Space>
""imap <C-Space> <C-^>
set keymap=mac-russian-colemak
set iminsert=0
set imsearch=0

" To define a mapping which uses the mapleader variable.
let mapleader = "\<Space>"

map <Leader>r <Esc>:registers<CR>
map <Leader>m <Esc>:marks<CR>

" Unnamedplus register mappings
map <Leader>p "+p
map <Leader>P "+P
map <Leader>y "+y
map <Leader>Y "+Y
map <Leader>d "+d
map <Leader>D "+D

" http://vim.wikia.com/wiki/Copy_filename_to_clipboard
map <Leader><Leader>yf <Esc>:let @+=expand("%:t")<CR>
map <Leader><Leader>yF <Esc>:let @+=expand("%:p")<CR>

map <Leader>; <Esc>@:
map <Leader>w <Esc>:w<CR>

" Quickfix window mappings
map <Leader>co <Esc>:cwindow<CR>
map <Leader>cp <Esc>:cprevious<CR>
map <Leader>cn <Esc>:cnext<CR>
map <Leader>cc <Esc>:cclose<CR>

" Location window mappings
map <Leader>lo <Esc>:lwindow<CR>
map <Leader>lp <Esc>:lprevious<CR>
map <Leader>ln <Esc>:lnext<CR>
map <Leader>lc <Esc>:lclose<CR>


function! GetPythonStandardLibiraryPath()
  " https://github.com/neovim/neovim/blob/v0.1.7/runtime/autoload/health/provider.vim#L275
  let python_version = split(system("python -V"))[1][0:2]
  let python_bin_name = 'python'.python_version[0]
  let python_bin = exepath(python_bin_name)
  let python_multiple = []
  if exists('$PATH')
    for path in split($PATH, ':')
      let path_bin = path.'/'.python_bin_name
      if path_bin != python_bin && index(python_multiple, path_bin) == -1
            \ && executable(path_bin)
        call add(python_multiple, path_bin)
      endif
    endfor
  endif
  if len(python_multiple)
    let python_bin = python_multiple[-1]
  endif
  return fnamemodify(resolve(python_bin), ':h:h').'/lib/python'.python_version
endfunction


" tags mappings
map <Leader>gg <Esc>:execute "!ctags . ".GetPythonStandardLibiraryPath()<CR>
map <Leader>gc :lclose <Bar> cclose <Bar> helpclose <Bar> NERDTreeClose <Bar> UndotreeHide<CR>

" spelling mappings
map <Leader>ss <Esc>:setlocal spell!<CR>
map <Leader>sc <Esc>:setlocal nospell!<CR>

" Terminal
command! Terminal :call termopen("bash -l", {"pty": 1}) | startinsert

" Grep
" http://vim.wikia.com/wiki/Using_normal_command_in_a_script_for_searching
" http://vim.wikia.com/wiki/Search_using_quickfix_to_list_occurrences
command! -nargs=1 LocalGrep :normal! /\v<args> | :silent lvimgrep <args> %
command! -nargs=+ Grep :silent grep! <args>
map <Leader>? :LocalGrep<Space>
map <Leader>/ :Grep<Space>

" Plugins Configuration
" NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = '.dotfiles/.NERDTreeBookmarks'
nnoremap <Leader>nn <Esc>:NERDTreeToggle<CR>
nnoremap <Leader>nf <Esc>:NERDTreeFind<CR>
nnoremap <Leader>nc <Esc>:NERDTreeClose<CR>


" CtrlP
let g:ctrlp_cmd = ':NERDTreeClose\|CtrlP'
nnoremap <Leader>tp <Esc>:NERDTreeClose \| CtrlPTag<CR>
nnoremap <Leader>tl <Esc>:NERDTreeClose \| CtrlPBuffer<CR>
nnoremap <Leader>tf <Esc>:NERDTreeClose \| CtrlPMRUFiles<CR>
let g:ctrlp_map = '<Leader>tt'
" -'r' here so it will work properly when there is sub vcs
let g:ctrlp_working_path_mode = 'a'

" Surround
" function call manipulation
nmap dsf diw"_ds(:silent! call repeat#set("dsf")<CR>
nmap <expr> daf 'viwl%"'.v:register.'d:silent! call repeat#set("daf")<CR>'
nmap <expr> dif 'f("'.v:register.'di(:silent! call repeat#set("dif")<CR>'
" nmap csf ciw<C-O>:silent! call repeat#set("csf")<CR>
nmap <expr> caf 'viwl%"'.v:register.'c<C-O>:silent! call repeat#set("caf")<CR>'
nmap <expr> cif 'f("'.v:register.'ci(<C-O>:silent! call repeat#set("dif")<CR>'
nmap caf diwca(<C-O>:silent! call repeat#set("caf")<CR>
nmap cif f(ci(<C-O>:silent! call repeat#set("cif")<CR>
" nmap ysf yiw:silent! call repeat#set("csf")<CR>
" http://stackoverflow.com/questions/18536511/vim-how-to-append-yanked-text-to-unnamed-register
" http://stackoverflow.com/questions/14632109/passing-register-name-in-mapping-to-an-ex-command
" http://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively
nmap <expr> yaf 'viwl%"'.v:register.'y:silent! call repeat#set("yaf")<CR>'
nmap <expr> yif 'f("'.v:register.'yi(:silent! call repeat#set("yif")<CR>'

vmap af iwl%
vmap if vf(vi(

" YouCompleteMe
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1,
      \ 'po': 1
      \}
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'po': 1
      \}
let g:ycm_autoclose_preview_window_after_insertion = 1
" https://code.djangoproject.com/wiki/UsingVimWithDjango
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" Lightline
let g:lightline = {
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'relativepath', 'modified' ],
        \           [ 'tagbar' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'inactive': {
        \ 'left': [ [ 'relativepath' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ] ]
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \ }
\}

" Tagbar
let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" signify
let g:signify_vcs_list              = [ 'git', 'hg' ]

augroup configgroup
  autocmd!
  " Automaticaly open quickfix findow
  " http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
  autocmd QuickFixCmdPost [^l]* nested botright cwindow | redraw!
  autocmd QuickFixCmdPost    l* nested lwindow | redraw!
  " Cursor position handling
  " http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
  autocmd BufLeave * if !&diff | let b:winview = winsaveview() | endif
  autocmd BufEnter * if exists("b:winview") && !&diff | call winrestview(b:winview) | unlet! b:winview | endif
  " open original file instead of symlink
  autocmd BufEnter * if getftype(expand("%")) == 'link' | execute 'file '.system('readlink '.expand('%')) | endif
  " :h restore-cursor
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " autocmd TextChanged,InsertLeave * if &buftype != 'nofile' | :lockmarks write
  " autocmd BufWritePost,BufEnter * Neomake
  autocmd BufWritePost * Neomake
  autocmd FileType python BracelessEnable +indent
  autocmd FileType jinja setlocal commentstring={#\ %s\ #}

  " 'formatoptions' This is a sequence of letters which describes how automatic formatting is to be done.
  autocmd FileType * set fo-=o fo-=c
  autocmd TermOpen * setlocal nolist

  " Autoresize windows
  autocmd VimResized * :wincmd =
augroup END

call ApplyLocalSettings(expand('.'), '/.dotfiles/nvim/init.vim')
