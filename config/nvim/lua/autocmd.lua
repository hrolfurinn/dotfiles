-- Taken from https://github.com/neovim/nvim-lspconfig/issues/1792#issuecomment-1352782205

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})

-- Taken from nvim-lint setup guide, with fixes from ChatGPT to restrict filetype
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        local ft = vim.bo.filetype
        local linters = require("lint").linters_by_ft[ft]
        if linters and #linters > 0 then
            require("lint").try_lint()
        end
    end,
})
