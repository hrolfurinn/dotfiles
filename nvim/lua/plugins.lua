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
require("lazy").setup({
  -- Vscode-like pictograms
  {
    "onsails/lspkind.nvim",
    event = { VimEnter },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "lspkind.nvim" },
    config = function()
      require("config.nvim-cmp")
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "nvim-cmp" } },
  { "hrsh7th/cmp-buffer", dependencies = { "nvim-cmp" } }, -- buffer auto-completion
  { "hrsh7th/cmp-path", dependencies = { "nvim-cmp" } }, -- path auto-completion
  { "hrsh7th/cmp-cmdline", dependencies = { "nvim-cmp" } }, -- cmdline auto-completion
  -- Code snippet engine
  {
  	"L3MON4D3/LuaSnip",
  	version = "v2.*",
  },
  --LSP manager
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  --Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  -- Themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
})
