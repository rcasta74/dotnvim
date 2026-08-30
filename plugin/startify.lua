vim.pack.add({
  vim.g.local_plugin .. "alpha-nvim"
})

local startify = require("alpha.themes.startify")
startify.file_icons.enabled = false

require("alpha").setup(startify.config)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

