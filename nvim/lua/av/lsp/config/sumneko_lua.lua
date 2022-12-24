local M = {}

M.settings = {
  Lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = { globals = { 'vim', 'use', 'require', 'pairs' } },
    format = { enable = false },
    workspace = {
      checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
    },
    telemetry = { enable = false },
  },
}

return M
