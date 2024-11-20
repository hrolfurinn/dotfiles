--must be called before we call require("lazy)

-- Inital setup taken from https://martinlwx.github.io/en/config-neovim-from-scratch/

-- define common options
local opts = {
  noremap = true,      -- non-recursive
  silent = true,       -- do not show message
}

vim.g.mapleader = " "        --idea taken from lazy nvim example
-- vim.g.maplocalleader = "\\"  --idea taken from lazy nvim example

-----------------
-- Normal mode --
-----------------
-- Adjust scrolling behavior
vim.keymap.set('n', '<C-d>', '<C-d>M', opts)
vim.keymap.set('n', '<C-u>', '<C-u>M', opts)

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<Left>', '<C-w>h', opts)
vim.keymap.set('n', '<Down>', '<C-w>j', opts)
vim.keymap.set('n', '<Up>', '<C-w>k', opts)
vim.keymap.set('n', '<Right>', '<C-w>l', opts)

vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<Leader><Down>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Leader><Up>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Leader><Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Leader><Right>', ':vertical resize +2<CR>', opts)

-- Telescope
-- taken from the offical README.md
-- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#usage
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
-- vim.keymap.set('v', '<', '<gv', opts)
-- vim.keymap.set('v', '>', '>gv', opts)

