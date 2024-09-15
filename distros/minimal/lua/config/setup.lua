-- Setup leader keys. <LocalLeader> is to be used for mappings which are local to a buffer.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Enable line numbers and relative position
vim.opt.number = true
vim.opt.relativenumber = false

-- Highlight current line
vim.opt.cursorline = true

-- Highlight on search
vim.opt.hlsearch = true

-- Number of spaces that a <Tab> in the file counts for.
vim.opt.tabstop = 4

-- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
vim.opt.softtabstop = 4

-- Number of spaces to use for each step of (auto)indent.
vim.opt.shiftwidth = 4

vim.opt.clipboard = 'unnamedplus'

-- menu		only shown when there is more than one match
-- menuone	when there is only one match.
-- preview	show extra information about the currently selected completion in the preview window.
vim.opt.completeopt = {'menu', 'menuone', 'preview', 'noselect'}

-- Mouse support for [a]ll Vim modes
vim.opt.mouse = 'a'

-- Save undo history
vim.opt.undofile = true

-- vim.g.loaded_netrw = 0 -- disable netrw
-- vim.g.loaded_netrwPlugin = 0 -- disable netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_preview = 1
vim.g.netrw_winsize = 80

-- Always show sign column
vim.opt.signcolumn = 'yes'

-- Case of normal letters is ignored
vim.opt.ignorecase = true

-- Override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.smartcase = true

-- Enables 24-bit RGB colors
vim.opt.termguicolors = true

-- Spell checking, if words are not recognized they are highlighted see `:help spell`
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Split orientation
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Save all changes when pressing Ctrl+s
-- vim.keymap.set('i', '<C-s>', '<Esc>:wa<CR>')
vim.keymap.set({'n', 'i', 'v', 's'}, '<C-s>', '<CMD>wa<CR><ESC>')

-- Change from insert to normal mode inside terminal buffer
vim.keymap.set('t', '<Esc>', '<C-\\><c-n>')

-- Move current/selected lines
vim.keymap.set("n", "<C-j>", "<CMD>m . +1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", "<CMD>m . -2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
