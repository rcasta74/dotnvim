local bufnr = vim.api.nvim_get_current_buf()

-- Save and restore the search pattern
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = bufnr,
  callback = function()
    vim.b[bufnr].old_search_pattern = vim.fn.getreg("/")
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  buffer = bufnr,
  callback = function()
    vim.fn.setreg("/", vim.b[bufnr].old_search_pattern or "")
  end,
})

local opts = {
  buffer = bufnr,
  silent = true,
  noremap = true,
}

-- Navigate tag references
vim.keymap.set("n", "<Tab>", [[/|\zs\S\{-}|<CR>]], opts)
vim.keymap.set("n", "<S-Tab>", [[?|\zs\S\{-}|<CR>]], opts)

-- Navigate command references
vim.keymap.set("n", "<C-Down>", [[/\`\zs\S\{-}\`<CR>]], opts)
vim.keymap.set("n", "<C-Up>", [[?\`\zs\S\{-}\`<CR>]], opts)

-- Navigate option references
vim.keymap.set("n", "<C-Right>", [[/\'\zs\S\{-}\'<CR>]], opts)
vim.keymap.set("n", "<C-Left>", [[?\'\zs\S\{-}\'<CR>]], opts)

-- Go to tag, command, or option help
vim.keymap.set("n", "<CR>", "<C-]>", opts)

