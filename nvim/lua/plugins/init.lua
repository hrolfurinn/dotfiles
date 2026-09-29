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
    { "hrsh7th/cmp-buffer",   dependencies = { "nvim-cmp" } }, -- buffer auto-completion
    { "hrsh7th/cmp-path",     dependencies = { "nvim-cmp" } }, -- path auto-completion
    { "hrsh7th/cmp-cmdline",  dependencies = { "nvim-cmp" } }, -- cmdline auto-completion
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    }, -- Bufferline (tabs displayed in typical GUI IDE manner)
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    --File system
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
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
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_enable_italic = false
            vim.g.everforest_diagnostic_text_highlight = true
            vim.g.everforest_disable_italic_comment = true
        end
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    --Telescope finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    },
    -- Linter manager (for mypy)
    {
        "mfussenegger/nvim-lint",
    },
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',

            -- a completion engine
            'hrsh7th/nvim-cmp',

            'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
            -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
            -- 'andrewradev/switch.vim',        -- for switch support
            -- 'tomtom/tcomment_vim',           -- for commenting
        },

        -- @type lean.Config
        opts = { -- see below for full configuration options
            mappings = true,
        }
    },
    -- LaTeX compiler
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        init = function()
            local function build_dir(info)
                local cache = vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache")
                return cache .. "/latex" .. info.root
            end
            vim.g.vimtex_view_method = "zathura_simple"
            vim.g.vimtex_compiler_latexmk = { aux_dir = build_dir, out_dir = build_dir }
            -- vim.g.vimtex_view_zathura_use_synctex = 0  -- if D-Bus won't cooperate
        end
    } })
