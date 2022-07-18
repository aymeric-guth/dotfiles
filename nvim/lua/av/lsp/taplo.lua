local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return
end

if not lspconfig.taplo then
  return
end

local handlers = require('av.lsp.handlers')

lspconfig.taplo.setup({
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  lsp_flags = handlers.lsp_flags,
  --settings = {
  --	taplo = {},
  --},
})
