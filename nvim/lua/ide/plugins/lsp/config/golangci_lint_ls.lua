local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

if not configs.golangcilsp then
  configs.golangcilsp = {
    default_config = {
      cmd = { 'golangci-lint-langserver' },
      root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
      init_options = {
        command = {
          'golangci-lint',
          'run',
          '--enable-all',
          '--disable',
          'lll',
          '--out-format',
          'json',
          '--issues-exit-code=1',
        },
      },
    },
  }
end

local M = {}
M.setup = {
  filetypes = { 'go', 'gomod' },
}
return M
