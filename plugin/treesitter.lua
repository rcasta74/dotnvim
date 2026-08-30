vim.pack.add({
  vim.g.local_plugin .. "nvim-treesitter",
  vim.g.local_plugin .. "nvim-treesitter-textobjects",
})

local function last_path_component(url)
  -- Remove trailing slashes, then an optional .git suffix.
  return url
    :gsub("/+$", "")
    :match("([^/]+)%.git$") -- handles URLs ending in .git
    or url:gsub("/+$", ""):match("([^/]+)$")
end

local grammar_uri = vim.g.repo_path .. "grammars/%s"

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    for language, config in pairs(require('nvim-treesitter.parsers')) do
      local install_info = config.install_info
      if install_info and install_info.url then
        install_info.path = grammar_uri:format(last_path_component(install_info.url))
        install_info.url = nil
      end
    end
  end,
})

require("nvim-treesitter").install({
  'vim',
  "regex",
  "lua",
  "bash",
  "markdown",
  "markdown_inline",
  -- "java",
})
