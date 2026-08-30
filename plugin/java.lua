vim.pack.add({
  vim.g.local_plugin .. "nvim-dap",
  vim.g.local_plugin .. "nvim-jdtls",
  vim.g.local_plugin .. "sonarqube.nvim",
})

local sonarlint_base_path = vim.fn.stdpath('data') .. '/lsp/sonarlint-ls'

require('sonarqube').setup({
    lsp = {
        cmd = { 
            'java',
            '-Dsonarlint.telemetry.disabled=true',
            '-jar',
            sonarlint_base_path .. '/server/sonarlint-ls.jar',
            '-stdio',
            '-analyzers',
            sonarlint_base_path .. '/analyzers/sonarjava.jar',
            sonarlint_base_path .. '/analyzers/sonarjavasymbolicexecution.jar',
        },
        -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
        -- log_level = "OFF",
        -- handlers = {
        --     -- Custom handler to show rule description
        --     -- The `res` argument contains various keys containing html that can be rendered in your favourite neovim html plugin 
        --     -- Alternatively, open the rule in the browser using your favourite sonarqube rule website (example below)
        --     ["sonarlint/showRuleDescription"] = function(err, res, ctx, cfg)
        --         local uri = "https://rules.sonarsource.com/%s/RSPEC-%s"
        --         local lang = res.languageKey
        --         local spec = string.match(res.key, "S(%d+)")
        --         vim.ui.open(string.format(uri, lang, spec))
        --     end,
        -- },
    },
    -- rules = { enabled = true },
    java = { enabled = true, await_jdtls = true },
    csharp = { enabled = false },
    go = { enabled = false },
    html = { enabled = false },
    iac = { enabled = false },
    javascript = { enabled = false },
    php = { enabled = false },
    python = { enabled = false },
    text = { enabled = false },
    xml = { enabled = false },
})

-- local server = require("sonarqube.lsp.server")
--
-- server.register_handler("sonarlint/getTokenForServer", function()
--   return vim.trim(vim.fn.readfile(vim.fn.expand("~/.config/nvim/sonarqube_token"))[1])
-- end)
--
-- server.settings = {
--   sonarlint = {
--     connectedMode = {
--       connections = {
--         sonarqube = {
--           { connectionId = "username", serverUrl = "https://sonarqube.example.com" }
--         },
--       },
--       project = { connectionId = "username", projectKey = "project" },
--     },
--   },
-- }
