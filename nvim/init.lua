vim.cmd([[
  :set number
]])

-- "bootstrapping" lazy.nvim from https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- this must come below the lazy.nvim bootstrapping
-- ATTN: vim.g.mapleader and vim.g.maplocalleader must be set before this is called
require("lazy").setup({})
