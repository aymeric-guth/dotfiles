local status, _ = pcall(require, 'lspconfig')
if not status then
  return
end

require('av.lsp.handlers').setup({})
require('av.lsp.null-ls')
require('av.lsp.installer')
