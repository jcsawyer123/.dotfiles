-- [[ Setting options ]]
-- See `:help vim.opt`

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.winbar = '' -- Remove window bar at top of splits

-- Set global statusline
vim.opt.laststatus = 3 -- Value of 3 means global status line

-- Behavior
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 10

-- Folds
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false     -- Disable folding at startup
vim.opt.foldlevel = 99         -- High fold level to keep folds open

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Preview substitutions
vim.opt.inccommand = 'split'

-- vim: ts=2 sts=2 sw=2 et
