--[[
NOTE: There are many options enabled by default in comparison to vim
  :help vim-differences

  Default Plugins
    "man.lua" plugin is enabled, so `:Man` is available by default.
    "matchit" plugin is enabled. To disable it in your config: >

  Default Mappings:
  https://github.com/neovim/neovim/blob/5732aa706c639b3d775573d91d1139f24624629c/runtime/lua/vim/_editor.lua#L870
    map('n', 'Y', 'y$')
    -- Use normal! <C-L> to prevent inserting raw <C-L> when using i_<C-O>. #17473
    map('n', '<C-L>', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>')
    map('i', '<C-U>', '<C-G>u<C-U>')
    map('i', '<C-W>', '<C-G>u<C-W>')
    map('x', '*', 'y/\\V<C-R>"<CR>')
    map('x', '#', 'y?\\V<C-R>"<CR>')
    -- Use : instead of <Cmd> so that ranges are supported. #19365
    map('n', '&', ':&&<CR>')


SUGGESTION: use pre-installed colorscheme 'habamax' instead of default it is much
more pleasant for the eyes

  :colorscheme habamax
--]]
-- [[Options]]
-- Print the line number in front of each line.
vim.o.number = true

-- List mode: Useful to see the difference between tabs and spaces and for
-- trailing blanks. Further changed by the 'listchars' option.
vim.o.list = true
-- Strings to use in 'list' mode and for the `:list` command.  It is a
-- comma-separated list of string settings.
--     (default: "tab:> ,trail:-,nbsp:+")
vim.opt.listchars:append { tab = "▸ ", eol = "¬", space = "·" }

-- Highlight the text line of the cursor with CursorLine `hl-CursorLine`.
vim.o.cursorline = true

-- Ignore case in search patterns.  Also used when searching in the tags file.
vim.o.ignorecase = true
-- Override the 'ignorecase' option if the search pattern contains upper case
-- characters.  Only used when the search pattern is typed and 'ignorecase'
-- option is on.
vim.o.smartcase = true
-- This option specifies how case is handled when searching the tags file:
--     match: Match case
vim.o.tagcase = "match"

-- When on, the ":substitute" flag 'g' is default on.  This means that all
-- matches in a line are substituted instead of one.
vim.o.gdefault = true

-- When on, splitting a window will put the new window right of the current
-- one.
vim.o.splitright = true
-- When on, splitting a window will put the new window below the current one.
vim.o.splitbelow = true

-- When on, Vim automatically saves undo history to an undo file when writing
-- a buffer to a file, and restores undo history from the same file on buffer
-- read.
vim.o.undofile = true

-- [[Providers]]
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- [[Package Manager]]
--
-- https://github.com/folke/lazy.nvim#-installation
-- TODO: should I use `stdpath("data")/site` as recommended in `:help runtimepath`?
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to set `mapleader` before lazy so your mappings are correct
--
-- To define a mapping which uses the "g:mapleader" variable, the special string
-- "<Leader>" can be used.  It is replaced with the string value of "g:mapleader".
-- If "g:mapleader" is not set or empty, a backslash is used instead.
vim.g.mapleader = " "

require("lazy").setup {
  -- https://github.com/direnv/direnv.vim
  "direnv/direnv.vim",
  -- https://github.com/editorconfig/editorconfig-vim
  "editorconfig/editorconfig-vim",
  -- https://github.com/junegunn/fzf/blob/master/README-VIM.md#installation
  { dir = vim.fn.system("brew --prefix fzf"):gsub("\n", "") },
  -- https://github.com/junegunn/fzf.vim
  -- TODO: Check if we want to use https://github.com/ibhagwan/fzf-lua instead
  {
    "junegunn/fzf.vim",
    keys = {
      -- TODO: understand why we are using <C-U> instead of <Cmd>
      { "<Leader>tt", ":<C-U>Files .<CR>", desc = "FZF Files" },
      { "<Leader>tl", ":<C-U>Buffers<CR>", desc = "FZF Buffers" },
      { "<Leader>tr", ":<C-U>History<CR>", desc = "FZF History" },
      { "<Leader>tp", ":<C-U>Tags<CR>", desc = "FZF Tags" },
      { "<Leader>tw", ":<C-U>Windows<CR>", desc = "FZF Windows" },
    },
  },
  -- https://github.com/roxma/vim-tmux-clipboard
  -- TODO: check if we can just use g:clipboard
  "roxma/vim-tmux-clipboard",
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}

-- [[Mappings]]
--   :help vim.keymap.set()

local map = vim.keymap.set

-- Keep selection when indenting
--
-- Shift the highlighted lines
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Emacs like keys for the command line
--
-- Cursor to beginning of command-line
map("c", "<C-A>", "<Home>")
-- Do not lose default mapping
--
-- All names that match the pattern in front of the cursor are inserted.
map("c", "<C-B>", "<C-A>")

-- Use CTRL-G u to first break undo, so that you can undo each i_<CR> separately
--
-- Begin new line.
map("i", "<CR>", "<C-G>u<CR>")

-- [[TreeSitter]]
-- :help nvim-treesitter-quickstart
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "vim", "help", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  -- :help nvim-treesitter-highlight-mod
  highlight = { enable = true },
  -- :help nvim-treesitter-incremental-selection-mod
  -- - keymaps:
  --   - init_selection: in normal mode, start incremental selection.
  --     Defaults to `gnn`.
  --   - node_incremental: in visual mode, increment to the upper named parent.
  --     Defaults to `grn`.
  --   - scope_incremental: in visual mode, increment to the upper scope
  --     (as defined in `locals.scm`). Defaults to `grc`.
  --   - node_decremental: in visual mode, decrement to the previous named node.
  --     Defaults to `grm`.
  incremental_selection = { enable = true },
  -- :help nvim-treesitter-indentation-mod
  indent = { enable = true },
}

-- XXX: remove this
vim.cmd.colorscheme "habamax"
