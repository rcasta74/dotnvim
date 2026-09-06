local lsp = require("config.lsp")

local servers = {
  --"lua_ls",
  --"rust_analyzer",
  "jdtls",
  -- "sonarlint-ls",
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = lsp.on_attach,
  })

  vim.lsp.enable(server)
end

