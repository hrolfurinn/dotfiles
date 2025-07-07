-- Taken from the guide at https://martinlwx.github.io/en/config-neovim-from-scratch/
-- with further code taken from the repo https://github.com/MartinLwx/dotfiles/blob/main/nvim/lua/lsp.lua
require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  -- log_level = vim.log.levels.DEBUG,
})

require('mason-lspconfig').setup({
  -- A list of servers to automatically install if they're not already installed
  -- full list of options at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  ensure_installed = { 'pylsp', 'lua_ls', 'rust_analyzer', 'ts_ls', 'bashls', 'eslint', 'ruff' },
})

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require("lspconfig")

local project_root = vim.fn.getcwd()
extra_paths = { project_root }

lspconfig.pylsp.setup({
  cmd = { 'python3', '-m', 'pylsp' },
})

lspconfig.lua_ls.setup({})

lspconfig.ruff.setup({
  cmd = { 'python3', '-m', 'ruff', 'lsp' },
})

lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        -- Whether to show inlay hints after a closing } to indicate what item it belongs to.
        closingBraceHints = true,
      },
    },
  },
})

lspconfig.ts_ls.setup({
  handlers = {
    ["workspace/executeCommand"] = function(_err, result, ctx, _config)
      if ctx.params.command ~= "_typescript.goToSourceDefinition" then
        return
      end
      if result == nil or #result == 0 then
        return
      end
      vim.lsp.util.jump_to_location(result[1], "utf-8")
    end,
  },
})

lspconfig.eslint.setup({})

lspconfig.bashls.setup({
})
