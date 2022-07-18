local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return
end

if not lspconfig.sumneko_lua then
  return
end

local handlers = require('av.lsp.handlers')

lspconfig.sumneko_lua.setup({
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  lsp_flags = handlers.lsp_flags,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'use' } },
      format = { enable = false },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = { enable = false },
    },
  },
})
