
-- Remove Global Default Key mapping
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
    
        map('n', 'K', vim.lsp.buf.hover, 'LSP Hover')
        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('n', 'gr', vim.lsp.buf.references, 'References')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, 'Format buffer')
    end,
})

vim.lsp.enable({
    "jdtls",
    -- "sonarlint-ls",
})
