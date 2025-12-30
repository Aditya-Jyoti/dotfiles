-- Set filetype specific commands
vim.cmd("filetype indent on") -- filetype specific indenting
vim.cmd("display+=lastline") -- try to always show last line of the paragraph
vim.cmd("autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2")
vim.cmd("autocmd BufRead,BufNewFile *.js,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2")

-- Options configuration
local opt = vim.opt

-- Indenting options
opt.autoindent = true -- inherit indenting of past line in new line
opt.expandtab = true -- convert tab to spaces
opt.shiftwidth = 4 -- indent using 4 spaces when shifting
opt.shiftround = true -- round indentation to nearest "shiftwidth"
opt.tabstop = 4 -- indent using 4 spaces
opt.smarttab = true -- insert "tabstop" number of spaces on "tab" press
opt.breakindent = true -- line gets visually indented

-- Search options
opt.hlsearch = true -- enable search highlighting
opt.ignorecase = true -- ignore case while searching
opt.incsearch = true -- incremental search that shows partial matches
opt.smartcase = true -- switch to case sensitive when uppercase character is added

-- Performance options
opt.timeoutlen = 500 -- time to wait for a mapped sequence (in ms)
opt.updatetime = 300 -- faster completion (4000ms by default)
opt.writebackup = false -- stop a file from being edited if open elsewhere
opt.backup = false -- disables file backup on write
opt.undofile = true -- enable persistent undo
opt.lazyredraw = false -- don't update screen during macro/script execution

-- Text rendering options
opt.encoding = "utf-8" -- set utf-8 as default encoding
opt.linebreak = true -- avoid wrapping in the middle of a word
opt.wrap = true -- enable line wrapping
opt.scrolloff = 8 -- lines before the cursor
opt.sidescrolloff = 5 -- columns beside the cursor

-- UI options
opt.showmode = false -- don't show mode info
opt.cmdheight = 0 -- command line height
opt.pumheight = 10 -- pop up menu height
opt.laststatus = 2 -- always show status bar
opt.ruler = true -- always show cursor position
opt.wildmenu = true -- command-line completion as a menu
opt.cursorline = true -- highlight line under cursor
opt.number = true -- show line numbers
opt.relativenumber = true -- enable relative numbers
opt.numberwidth = 4 -- set line number column width
opt.signcolumn = "yes" -- always show sign column
opt.errorbells = false -- disable error beeps
opt.visualbell = true -- flash screen on error
opt.mouse = "a" -- enable mouse usage
opt.title = true -- set window title
opt.termguicolors = true -- enable 24-bit RGB colors
opt.foldmethod = "indent" -- fold based on indentation
opt.foldnestmax = 3 -- limit fold levels
opt.foldenable = false -- disable code folding by default

-- floating window colours
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" })