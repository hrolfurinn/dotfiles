-- Taken from the guide at https://martinlwx.github.io/en/config-neovim-from-scratch/
-- with further code taken from the repo https://github.com/MartinLwx/dotfiles/blob/main/nvim/lua/lsp.lua


-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require("lspconfig")

-- Default options for Mason LSP setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    require('keymaps').lsp_keymaps(bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end
local function make_config(opts)
    return vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, opts or {})
end

local function get_configured_servers()
    local configs = require("lspconfig.configs")
    return vim.tbl_keys(configs)
end

local project_root = vim.fn.getcwd()
extra_paths = { project_root }

lsp_overrides = {
    pylsp = {
        cmd = { 'python', '-m', 'pylsp' },
        settings = {
            pylsp = {
                plugins = {
                    -- CUse ruff for linting
                    jedi = {
                        extra_paths = { project_root },
                        environment = vim.env.VIRTUAL_ENV,
                    },
                    -- Use ruff for linting
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = false },
                }
            }
        }
    },

    ruff = {
        -- This uses the active Python binary on neovim launch, i.e. if the venv is enabled, it uses that.
        cmd = { 'python', '-m', 'ruff', 'server' },
    },

    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                inlayHints = {
                    -- Whether to show inlay hints after a closing } to indicate what item it belongs to.
                    closingBraceHints = true,
                },
            },
        },
    },

    ts_ls = {
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
    },
    -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
    -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
    -- source: https://github.com/Feel-ix-343/markdown-oxide/blob/6dcf444da28b7c9564988e4d6bbf29cdf9bd5778/docs/Markdown%20Oxide%20Docs/README.md?plain=1#L85
    markdown_oxide = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            }
        }
    }
}

lsp_servers = { 'pylsp', 'lua_ls', 'rust_analyzer', 'ts_ls', 'bashls', 'eslint', 'ruff', 'texlab', 'markdown_oxide' }

for _, server_name in ipairs(lsp_servers) do
    vim.lsp.config(server_name, make_config(lsp_overrides[server_name]))
end

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

-- TODO: There's a default lspconfig now
require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    -- full list of options at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    ensure_installed = lsp_servers,
})

vim.diagnostic.config({
    virtual_text = true, -- show inline errors
    signs = true,      -- show signs in the gutter
    underline = true,  -- underline errors
    update_in_insert = false,
})


-- NVIM lint
-- TODO: should this be in a new file?

require('lint').linters_by_ft = {
    python = { 'mypy', 'pylint' },
}

-- attempt to use venv
local mypy = require('lint').linters.mypy
mypy.cmd = 'python'
mypy.args = vim.list_extend({ '-m', 'mypy' }, mypy.args)

local pylint = require('lint').linters.pylint
pylint.cmd = 'python'
pylint.args = vim.list_extend({ '-m', 'pylint' }, pylint.args)
