-- Taken from https://github.com/neovim/nvim-lspconfig/issues/1792#issuecomment-1352782205

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})
