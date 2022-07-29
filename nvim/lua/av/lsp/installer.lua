local lspconfig = require('lspconfig')
local servers = {
  'clangd',
  'pylsp',
  'pyright',
  'sumneko_lua',
  'taplo',
}
local handlers = require('av.lsp.handlers')

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    lsp_flags = handlers.lsp_flags,
  }
  local lsp = require('av.lsp.config.' .. server)
  opts = vim.tbl_deep_extend('force', lsp, opts)
  lspconfig[server].setup(opts)
end
