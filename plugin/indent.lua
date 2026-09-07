vim.pack.add({
  vim.g.local_plugin .. "indent-blankline.nvim"
})

require("ibl").setup({
    indent = {
        char = "¦",
    },
})

