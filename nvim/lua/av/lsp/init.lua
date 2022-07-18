local status, _ = pcall(require, 'lspconfig')
if not status then
  return
end

require('av.lsp.clangd')
require('av.lsp.pylsp')
require('av.lsp.pyright')
require('av.lsp.sumneko')
require('av.lsp.symbols-outline')
require('av.lsp.taplo')
require('av.lsp.null-ls')
require('av.lsp.handlers').setup()
