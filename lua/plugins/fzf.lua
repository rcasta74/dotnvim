vim.pack.add({
  vim.g.local_plugin .. "fzf-lua",
})

--require('fzf-lua').setup({'fzf-vim'})

require("fzf-lua").setup({
  winopts = {
    height = 0.85,
    width = 0.85,
    row = 0.35,
    col = 0.5,
    border = "rounded",
  },

  keymap = {
    builtin = {
      ["<Esc>"] = "hide",
      ["<C-c>"] = "abort",
    },
  },

  lsp = {
    code_actions = {
      winopts = {
        height = 0.50,
        width = 0.70,
      },
    },
  },
})

