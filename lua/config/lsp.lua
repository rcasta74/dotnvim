require("plugins/fzf")
local fzf = require("fzf-lua")

local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      desc = desc,
    })
  end

  -- Navigation
  map("n", "gd", fzf.lsp_definitions, "LSP definitions")
  map("n", "gD", fzf.lsp_declarations, "LSP declarations")
  map("n", "gi", fzf.lsp_implementations, "LSP implementations")
  map("n", "gr", fzf.lsp_references, "LSP references")
  map("n", "gt", fzf.lsp_typedefs, "LSP type definitions")

  -- Symbols
  map("n", "<leader>ds", fzf.lsp_document_symbols, "Document symbols")
  map("n", "<leader>ws", fzf.lsp_workspace_symbols, "Workspace symbols")

  -- Calls
  map("n", "<leader>ci", fzf.lsp_incoming_calls, "Incoming calls")
  map("n", "<leader>co", fzf.lsp_outgoing_calls, "Outgoing calls")

  -- Diagnostics
  map("n", "<leader>dd", fzf.diagnostics_document, "Document diagnostics")
  map("n", "<leader>dw", fzf.diagnostics_workspace, "Workspace diagnostics")

  -- LSP actions
  map("n", "<leader>ca", fzf.lsp_code_actions, "Code actions")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

  -- Native LSP UI/actions
  map("n", "K", vim.lsp.buf.hover, "Hover documentation")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")

end

return M
