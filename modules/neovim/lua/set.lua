vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"

vim.cmd.colorscheme "catppuccin-mocha"
-- vim.cmd.colorscheme "vscode"

vim.keymap.set('i', 'jk', '<esc>', {})

vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
vim.keymap.set('n', '<C-Left>', '<C-w>h', {})
vim.keymap.set('n', '<C-Down>', '<C-w>j', {})
vim.keymap.set('n', '<C-Up>', '<C-w>k', {})
vim.keymap.set('n', '<C-Right>', '<C-w>l', {})

-- trigger CursorHold faster. Default is 4000
vim.opt.updatetime = 300

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.termguicolors = true

vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

vim.keymap.set('n', '<leader>sv', '<Cmd>source ~/.config/nvim/init.lua<CR>', { noremap = true })
