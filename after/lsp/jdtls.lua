
local function get_jdtls_bin_dir()
    return vim.fn.stdpath('data') .. '/lsp/jdtls/server/bin'
end

local function get_jdtls_bundle_dir()
    return vim.fn.stdpath('data') .. '/lsp/jdtls/bundles'
end

local function get_jdtls_cache_dir()
    return vim.fn.stdpath('cache') .. '/jdtls'
end

local function get_jdtls_jvm_args()
    local env = os.getenv('JDTLS_JVM_ARGS')
    local args = {}
    for a in string.gmatch((env or ''), '%S+') do
        local arg = string.format('--jvm-arg=%s', a)
        table.insert(args, arg)
    end
    return unpack(args)
end

local root_markers1 = {
    '.git',
}
local root_markers2 = {
    'pom.xml',
}

local bundles = {
    vim.fn.glob(get_jdtls_bundle_dir() .. "/java-debug/com.microsoft.java.debug.plugin-*.jar", 1),
}

local java_test_bundles = vim.split(vim.fn.glob(get_jdtls_bundle_dir() .. "/java-test/*.jar", 1), "\n")
local excluded = {
  "com.microsoft.java.test.runner-jar-with-dependencies.jar",
  "jacocoagent.jar",
}
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ":t")
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end

---@type vim.lsp.Config
return {
    ---@param dispatchers? vim.lsp.rpc.Dispatchers
    ---@param config vim.lsp.ClientConfig
    cmd = function(dispatchers, config)
        local data_dir = get_jdtls_cache_dir()
    
        if config.root_dir then
            data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
        end
    
        local config_cmd = {
            get_jdtls_bin_dir() .. '/jdtls',
            '-data',
            data_dir .. "/workspace",
            '--configuration',
            data_dir .. "/config",
            get_jdtls_jvm_args(),
        }
    
        return vim.lsp.rpc.start(config_cmd, dispatchers, {
            cwd = config.cmd_cwd,
            env = config.cmd_env,
            detached = config.detached,
        })
    end,
    filetypes = { 'java' },
    root_markers = { root_markers1, root_markers2 },
    init_options = { bundles = bundles },
}
