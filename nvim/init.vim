" Change init.vim with auto reload
"" autocmd BufWritePost init.vim source $MYVIMRC

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
" Show the line number relative to the line with the cursor in front of each line.
set relativenumber

" If the 'ignorecase' option is on, the case of normal letters is ignored.
set ignorecase
set smartcase
set tagcase=match

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
set expandtab

" When on, the ':substitute' flag 'g' is default on.
set gdefault

" (Nvim by default) indent when moving to the next line while writing code
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

" Use one space, not two, after punctuation.
set nojoinspaces

set encoding=utf-8


set foldcolumn=1
" set foldmethod=syntax
" Enable the use of the mouse.
set mouse=a

" show ctrl+X tooltip
"" set shortmess-=c

" enable all Python syntax highlighting features
let python_highlight_all = 1

" To define a mapping which uses the mapleader variable.
let mapleader = "\<Space>"

map <Leader>m <Esc>:marks<CR>

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
cabbrev man vertical Man


" Emacs like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

nnoremap <C-K> k

" http://andrewradev.com/2011/06/08/vim-and-ctags/
function! JumpToTagWithList()
  let l:word = expand("<cword>")
  let l:taglist_len = len(taglist('^'.l:word.'$'))
  if  l:taglist_len == 0
    echom "No tags found"
  elseif l:taglist_len == 1
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
      exe "set runtimepath+=" . a:dirname . "/.direnv/nvim"
      set undodir+=.direnv/nvim/undo
      set tags+=.direnv/tags
      let g:fzf_history_dir = ".direnv/nvim/fzf-history"
      let g:miniyank_filename = ".direnv/nvim/.miniyank.mpack"
  endif
endfunction

if empty(glob("~/.config/nvim/autoload/plug.vim"))
  execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

" base
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" keymap
Plug 'imomaliev/mac-russian-colemak.vim'

" Visual
" Plug '/Users/batiskaf/Development/Vim/zenburn.vim'
Plug 'imomaliev/zenburn.vim'
Plug 'itchyny/lightline.vim'
" Plug 'ryanoasis/vim-devicons'

" IDE
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'ambv/black'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
" Plug 'severin-lemaignan/vim-minimap'

" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/context_filetype.vim'

" Edit
Plug 'Raimondi/delimitMate'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-endwise'
Plug 'imomaliev/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-repeat'
Plug 'tweekmonster/braceless.vim'
Plug 'vim-scripts/camelcasemotion'
Plug 'mkomitee/vim-gf-python'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'ervandew/supertab'
Plug 'maksimr/vim-jsbeautify'
" Plug 'imomaliev/registers.vim'
Plug 'bfredl/nvim-miniyank'
Plug 'roxma/vim-tmux-clipboard'
" https://robots.thoughtbot.com/align-github-flavored-markdown-tables-in-vim
Plug 'junegunn/vim-easy-align'

" Vcs
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'mhinz/vim-signify'

" Filetype plugins
Plug 'tmux-plugins/vim-tmux'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'vim-scripts/python_match.vim'
Plug 'niftylettuce/Vim-Jinja2-Syntax'
Plug 'cespare/vim-toml'

" https://github.com/junegunn/vim-plug/issues/300#issuecomment-149173517
""call ApplyLocalSettings(expand('.'), '/.direnv/nvim/plugins.vim')

call plug#end()

" fix camelcase mapping
noremap ,, ,

" https://robots.thoughtbot.com/faster-grepping-in-vim
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ -U\ -p\ \".direnv/.agignore\"\ $*

  function! s:agwildignore()
    let ignore = join(map(split(&wig, ','), '"--ignore \"".v:val."\""'), ' ')
  endfunction

  call s:agwildignore()

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
    let l:cmd = 'Grep "\b'.l:word.'\b"'
    execute cmd
    call histadd(':', l:cmd)
    botright cwindow
    redraw!
    normal <C-W>W
  else
    echom "cword is too short!"
  endif
endfunction

function! GrepVisualSelection()
  let l:word = GetVisualSelection()
  if len(l:word) > 3
    let l:cmd = 'Grep "'.l:word.'"'
    execute cmd
    call histadd(':', l:cmd)
    botright cwindow
    redraw!
    normal <C-W>W
  else
    echom "selection is too short!"
  endif
endfunction

function! GrepCurrentFileName()
  execute 'Grep "'.expand("%:t:r").'"'
  botright cwindow
  redraw!
  normal <C-W>W
endfunction

command! GrepCurrentFileName call GrepCurrentFileName()

" bind K to grep word under cursor
" http://stackoverflow.com/a/12170748/3627387
nnoremap <silent> K :call GrepWordUnderCursor()<CR>
vnoremap <silent> K :call GrepVisualSelection()<CR>

" bind \ (backward slash) to grep shortcut
""command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Font and colorscheme
""set termguicolors
" let g:zenburn_high_Contrast = 1
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

" Denite
map <Leader>r <Esc>:Denite miniyank<CR>
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
" Miniyank
let g:miniyank_maxitems = 100
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" Unnamedplus register mappings
map <Leader>p "+p
map <Leader>P "+P
map <Leader>y "+y
map <Leader>Y "+Y
map <Leader>d "+d
map <Leader>D "+D

nnoremap <F1> :mksession!<CR>
imap <F1> <C-O>:mksession!<CR>

nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

nnoremap <F3> :vert sb #<CR>
imap <F3> <C-O>:vert sb #<CR>

nnoremap <F4> :TagbarToggle<CR>
imap <F4> <C-O>:TagbarToggle<CR>

" http://vim.wikia.com/wiki/Copy_filename_to_clipboard
map <Leader><Leader>yf <Esc>:let @+=expand("%:t")<CR>
map <Leader><Leader>yF <Esc>:let @+=expand("%:p")<CR>
map <Leader><Leader>yl <Esc>:let @+=expand("%:t").':'.line(".")<CR>

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

" http://vim.wikia.com/wiki/Search_and_replace_in_a_visual_selection
" https://stackoverflow.com/a/3196630/3627387
vnoremap <Leader>" :s/'\([^']*\)'/"\1"/<CR>
vnoremap <Leader>' :s/"\([^"]*\)"/'\1'/<CR>
" https://stackoverflow.com/questions/7652590/is-it-possible-to-map-c-to-in-vim
" mapping for <C-/> typed with <C-V><C-/>
"" vnoremap  <C-O>/\%V

let g:python_host_prog = '/Users/batiskaf/.config/nvim/python2/bin/python'
let g:python3_host_prog = '/Users/batiskaf/.config/nvim/python3/bin/python'

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

function! GetCtagsPaths()
  if $VIRTUAL_ENV =~ $PWD
    return ". ".GetPythonStandardLibiraryPath()
  else
    return ". "."$VIRTUAL_ENV ".GetPythonStandardLibiraryPath()
  endif
endfunction
" spelling mappings
map <Leader>ss <Esc>:setlocal spell!<CR>
" always forget what mapping for adding spelling
map <Leader>sa zg
map <Leader>sc <Esc>:setlocal nospell!<CR>

" Terminal
command! Terminal :call termopen("bash -l", {"pty": 1}) | startinsert

" Grep
" http://vim.wikia.com/wiki/Using_normal_command_in_a_script_for_searching
" http://vim.wikia.com/wiki/Search_using_quickfix_to_list_occurrences
command! -nargs=1 LocalGrep :normal! /\v<args> | :silent lvimgrep <args> %
command! -nargs=+ Grep :silent grep! <args> | botright cwindow | redraw! | normal <C-W>W
map <Leader>? :LocalGrep<Space>
map <Leader>/ :Grep<Space>

" Plugins Configuration
" NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = '.direnv/nvim/.NERDTreeBookmarks'
let g:NERDTreeShowLineNumbers = 1
nnoremap <Leader>nn <Esc>:NERDTreeToggle<CR>
nnoremap <Leader>nf <Esc>:NERDTreeFind<CR>
nnoremap <Leader>nc <Esc>:NERDTreeClose<CR>

" FZF
let g:fzf_layout = { 'down': '~30%' }

function FZFClose()
  let buffers = filter(range(1, bufnr('$')), 'bufname(v:val) =~# ";#FZF"')
  for i in buffers
    " Delete buffer by ID
    execute 'bw! ' . i
  endfor
  " we need to sleep here so fzf will be focused properly
  sleep 10m
endfunction

command! -nargs=0 -bar CloseAll :lclose | cclose | helpclose | NERDTreeClose | UndotreeHide | call FZFClose()

" https://github.com/junegunn/fzf.vim/issues/113
nnoremap <Leader>tt <Esc>:CloseAll \| Files<CR>
nnoremap <Leader>tp <Esc>:CloseAll \| Tags<CR>
nnoremap <Leader>tl <Esc>:CloseAll \| Buffers<CR>
nnoremap <Leader>tf <Esc>:CloseAll \| History<CR>

" tags mappings
map <Leader>gg <Esc>:execute "!ctags ".GetCtagsPaths()<CR>
map <Leader>gc :CloseAll<CR>

" Surround
let g:surround_{char2nr('c')} = "```\r```"
let g:surround_{char2nr('d')} = "\"\"\"\r\"\"\""
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

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
\ 'python': ['jedi', 'buffer'],
\})

" Lightline
function! LightlineMode()
  return expand('%:t') ==# '__Tagbar__.1' ? 'Tagbar':
        \ expand('%:t') ==# 'NERD_tree_1' ? 'NERDTree' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction

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
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
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

" HighlightedyankRegion
let g:highlightedyank_highlight_duration = 1000

" Neomake
" This setting will open the location-list or quickfix list (depending on
" whether it is operating on a file) when adding entries. A value of 2 will
" preserve the cursor position when the location-list or quickfix window is
" opened.
let g:neomake_open_list = 0

" https://github.com/neomake/neomake/issues/1859
" Adding args to existing maker
" let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint().args + ['--rcfile=backend/pylintrc']

" Black
" let g:black_skip_string_normalization = 1
" let g:black_linelength = 100
let g:black_virtualenv = '/Users/batiskaf/.config/nvim/python3/'

" Isort
command! -range=% Isort :silent <line1>,<line2>! isort -

" Use bash syntax as default for shell scripts
let g:is_bash = 1


augroup configgroup
  autocmd!
  " This option specifies a function to be used for Insert mode omni completion with CTRL-X CTRL-O.
  " Set completion to this script only if a specific plugin does not already exist for that filetype.
  if has("autocmd") && exists("+omnifunc")
    autocmd Filetype * if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  endif
  " Automaticaly open quickfix findow
  " http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
  " wincmd p switch to previous window
  "" autocmd QuickFixCmdPost [^l]* nested botright cwindow | redraw! | wincmd p
  "" autocmd QuickFixCmdPost    l* nested lwindow | redraw! | wincmd p
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
  " autocmd BufWritePre *.py execute ':Black'
  " autocmd BufWritePre *.py execute ':Isort'
  autocmd FileType python BracelessEnable +indent
  autocmd FileType jinja,jinja.html setlocal commentstring={#\ %s\ #}
  autocmd FileType dosini setl ts=4 sw=4 sts=4 et commentstring=#\ %s
  autocmd FileType dosini let b:caw_oneline_comment = '#'

  autocmd FileType typescript setl ts=2 sw=2 sts=2 et
  autocmd BufRead,BufNewFile Dockerfile* setl filetype=dockerfile ts=4 sw=4 sts=4 et
  autocmd BufRead,BufNewFile Pipfile setl filetype=toml
  autocmd BufRead,BufNewFile Pipfile.lock setl filetype=json
  " autocmd BufRead,BufNewFile docker-compose*.{yaml,yml}* setl ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile .circleci/config.yml setlocal ts=2 sw=2 sts=2 et
  autocmd BufRead,BufNewFile .travis.yml setlocal ts=2 sw=2 sts=2 et
  autocmd FileType conf setlocal ts=4 sw=4 sts=4 et
  autocmd BufNewFile,BufRead default.template set filetype=conf

  " 'formatoptions' This is a sequence of letters which describes how automatic formatting is to be done.
  autocmd FileType * set fo-=o fo-=c
  autocmd TermOpen * setlocal nolist
  autocmd FileType fzf nnoremap <buffer> q :bd!<CR>
  autocmd FileType fzf nnoremap <buffer> <C-C> :bd!<CR>
  autocmd FileType fzf tnoremap <buffer> <C-6> <Nop>
  autocmd FileType fzf tnoremap <buffer> <C-^> <Nop>
  " autocmd BufLeave fzf :bd!

  " Autoresize windows
  autocmd VimResized * :wincmd =
augroup END

call ApplyLocalSettings(expand('.'), '/.direnv/nvim/init.vim')
