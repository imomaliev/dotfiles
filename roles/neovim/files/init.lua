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

-- [Options]
-- Print the line number in front of each line.
vim.o.number = true

-- List mode: Useful to see the difference between tabs and spaces and for
-- trailing blanks. Further changed by the 'listchars' option.
vim.o.list = true
-- Strings to use in 'list' mode and for the `:list` command.  It is a
-- comma-separated list of string settings.
--   (default: "tab:> ,trail:-,nbsp:+")
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
--   match: Match case
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

-- [Providers]
-- TODO: if providers needed store them in stdpath("data")/providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Enables 24-bit RGB color in the "TUI"
vim.o.termguicolors = true

-- Completion mode that is used for the character specified with 'wildchar'.
-- default: "full"
vim.opt.wildmode = { "longest:full", "full" }

-- A comma-separated list of options for Insert mode completion 'ins-completion'.
-- default: "menu,preview"
-- https://stackoverflow.com/a/15698653/3627387
vim.opt.completeopt:append { "longest" }

-- [Package Management]

-- [[Pack]]

-- Quickfix list and Location list filter
vim.cmd "packadd cfilter"

-- [[Lazy]]

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

require("lazy").setup({
  {
    "jnurmine/Zenburn",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "zenburn"
      -- TODO: use nvim_set_hl
      vim.cmd "highlight WinSeparator guifg=#2e3330 ctermfg=236"
      -- TODO: deprecated: need to remove later
      vim.cmd "highlight VertSplit guifg=#2e3330 ctermfg=236"
    end,
  },
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
      { "<Leader>tt", ":<C-U>GitFiles<CR>", desc = "FZF: GitFiles" },
      { "<Leader>tf", ":<C-U>Files .<CR>", desc = "FZF: Files" },
      { "<Leader>tl", ":<C-U>Buffers<CR>", desc = "FZF: Buffers" },
      { "<Leader>tr", ":<C-U>History<CR>", desc = "FZF: History" },
      { "<Leader>tp", ":<C-U>Tags<CR>", desc = "FZF: Tags" },
      { "<Leader>tw", ":<C-U>Windows<CR>", desc = "FZF: Windows" },
    },
  },
  -- https://github.com/roxma/vim-tmux-clipboard
  -- TODO: check if we can just use g:clipboard
  "roxma/vim-tmux-clipboard",
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- https://github.com/nvim-treesitter/nvim-treesitter-context
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
  },
  -- https://github.com/numToStr/Comment.nvim#-installation
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  -- https://github.com/kylechui/nvim-surround#package-installation
  {
    "kylechui/nvim-surround",
    config = true,
  },
  -- NOTE: This is where your plugins related to LSP can be installed.
  -- The configuration is done below. Search for lspconfig to find it below.
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
  },
}, {
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "zenburn", "habamax" },
  },
})

-- [Mappings]
--   :help vim.keymap.set()

local map = vim.keymap.set

-- Keep selection when indenting
map(
  "v",
  ">",
  ">gv",
  { desc = "Shift {motion} lines one 'shiftwidth' rightwards and keep selection" }
)
map(
  "v",
  "<",
  "<gv",
  { desc = "Shift {motion} lines one 'shiftwidth' leftwards and keep selection" }
)

-- Emacs like keys for the command line
map("c", "<C-A>", "<Home>", { desc = "Cursor to beginning of command-line" })
-- Do not lose default mapping
map(
  "c",
  "<C-B>",
  "<C-A>",
  { desc = "All names that match the pattern in front of the cursor are inserted." }
)

-- Use CTRL-G u to close undo sequence and start new change, so that you can undo each
-- i_<CR> separately
map(
  "i",
  "<CR>",
  "<C-G>u<CR>",
  { desc = "Begin new line and close undo sequence, start new change" }
)

-- The normal use of S is covered by cc, so don't worry about shadowing it.
-- https://hg.stevelosh.com/dotfiles/file/tip/vim/vimrc#l421
map("n", "S", "i<cr><esc>", { desc = "[S]plit line" })

-- Redraw, line [count] at center of window for some jumps
map("n", "n", "nzz", {
  desc = 'Repeat the latest "/" or "?" [count] times and redraw, line [count] at center of window',
})
map("n", "N", "Nzz", {
  desc = 'Repeat the latest "/" or "?" [count] times in opposite direction and redraw, line [count] at center of window',
})

-- [[FZF]]
if vim.fn.executable "rg" then
  -- TODO rewrite in lua form
  -- TODO: make lazy call
  local rg_command = "rg --no-ignore --hidden "
  local rg_ignores = {
    ".git",
    ".DS_Store",
    "*.png",
    "*.sql",
    "tags",
    ".direnv/tags",
    ".direnv/nvim/fzf-history",
    "__pycache__",
    ".mypy_cache",
    ".pytest_cache",
  }

  for _, ignore in ipairs(rg_ignores) do
    rg_command = rg_command .. string.format(" --glob=!%q", ignore)
  end
  vim.o.grepprg = rg_command .. " --vimgrep"
  -- https://github.com/jremmen/vim-ripgrep/blob/ec87af6b69387abb3c4449ce8c4040d2d00d745e/plugin/vim-ripgrep.vim#L12
  vim.o.grepformat = "%f:%l:%c:%m"
  vim.env.FZF_DEFAULT_COMMAND = rg_command .. " --files"
end

local command = vim.api.nvim_create_user_command

command("Grep", "execute 'silent lgrep! <args>' | lopen", {
  desc = "Call lgrep and open location list",
  bang = true,
  nargs = "+",
  complete = "file",
})

-- [TreeSitter]
-- :help nvim-treesitter-quickstart
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "lua",
    "vim",
    "help",
    "python",
    "toml",
    "terraform",
    "markdown",
    "go",
    "yaml",
    "bash",
  },

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

  -- :help nvim-treesitter-text-objects
  -- https://github.com/nvim-lua/kickstart.nvim/blob/72364ad9acb35bb44d7e0af64f977f2a4b3c59db/init.lua#L307
  textobjects = {
    -- :help nvim-treesitter-text-objects-select-submod
    select = {
      enable = true,
      -- Automatically jump forward to textobjects, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },

    -- :help nvim-treesitter-text-objects-swap-submod
    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ["<leader>a"] = "@parameter.inner",
    --   },
    --   swap_previous = {
    --     ["<leader>A"] = "@parameter.inner",
    --   },
    -- },

    -- :help nvim-treesitter-text-objects-move-submod
    move = {
      enable = true,
      -- whether to set jumps in the jumplist
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    -- TODO: :help nvim-treesitter-textobjects-lsp_interop-submod
  },
}

-- [LSP]
-- Diagnostic settings
-- https://neovim.discourse.group/t/disable-inline-diagnostics/1263/2
vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = false,
}
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pyright", "gopls" },
}
-- LSP settings.
-- This function gets run when an LSP connects to a particular buffer.
-- https://github.com/nvim-lua/kickstart.nvim/blob/72364ad9acb35bb44d7e0af64f977f2a4b3c59db/init.lua#L359
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set(
      "n",
      keys,
      func,
      { remap = true, silent = true, buffer = bufnr, desc = desc }
    )
  end

  -- :help lspconfig-keybindings
  -- nmap("gd", vim.lsp.buf.declaration, "Jumps to the declaration of the symbol under the cursor.")
  nmap(
    "<C-]>",
    vim.lsp.buf.definition,
    "Jumps to the definition of the type of the symbol under the cursor."
  )
  nmap(
    "<Leader>*",
    vim.lsp.buf.references,
    "Lists all the references to the symbol under the cursor in the quickfix window"
  )
  -- FIXME: this does not search in virtualenv by default
  -- nmap("<Leader>tp", vim.lsp.buf.workspace_symbol, "List Symbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
end

-- :help setup_handlers
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
    }
  end,
}

-- [Autocommands]
-- :help nvim_create_augroup
local augroup = vim.api.nvim_create_augroup
-- :help nvim_create_autocmd
local autocmd = vim.api.nvim_create_autocmd

-- Append to neovim's internal group for file type detection
local filetype_detect_group = augroup("filetypedetect", { clear = false })

autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_detect_group,
  pattern = ".ansible-lint",
  desc = "Set yaml filetype for .ansible-lint file",
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_detect_group,
  pattern = { "*.bkp", "*.template" },
  desc = "Auto detect original filetype for .bkp and .template files",
  callback = function()
    -- https://vi.stackexchange.com/questions/9962/get-filetype-by-extension-or-filename-in-vimscript
    -- TODO: rewrite in lua
    vim.cmd(
      "doautocmd filetypedetect BufRead "
        .. vim.fn.fnameescape(vim.fn.expand "<afile>:r")
    )
  end,
})

-- :help vim.highlight.on_yank()
local yank_highlight_group = augroup("YankHighlight", {})
autocmd("TextYankPost", {
  group = yank_highlight_group,
  pattern = "*",
  desc = "Highlight on yank (default 150ms)",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Personal configuration
local config_group = augroup("Config", {})

autocmd("VimResized", {
  group = config_group,
  pattern = "*",
  desc = "Autoresize windows when window size changes",
  callback = function()
    vim.cmd "wincmd ="
  end,
})
