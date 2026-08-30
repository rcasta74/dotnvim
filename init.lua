vim.g.repo_path = vim.fn.expand("~/nvim_repo/")
vim.g.local_plugin = "file://" .. vim.g.repo_path .. "plugins/"

require('autocmds')
require('keymaps')
require('options')
require('lsp')

