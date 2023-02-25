--[[
SUGGESTION: use pre-installed colorscheme 'habamax' instead of default it is much
more pleasant for the eyes

  :colorscheme habamax
--]]
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
