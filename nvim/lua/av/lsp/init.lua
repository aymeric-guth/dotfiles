local ok, _ = pcall(require, 'neodev')
if ok then
  require('neodev').setup({})
end

local ok, _ = pcall(require, 'lspconfig')
if not ok then
  return
end

require('av.lsp.handlers').setup()
require('av.lsp.null-ls')
require('av.lsp.installer')
require('av.lsp.symbols-outline')
-- require('av.lsp.rust-tools')
