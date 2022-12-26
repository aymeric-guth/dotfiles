local ok, _ = pcall(require, 'lspconfig')
if not ok then
  error('lspconfig not found aborting')
  return
end

local ok, _ = pcall(require, 'mason')
if not ok then
  error('mason not found aborting')
  return
end

local ok, _ = pcall(require, 'mason-lspconfig')
if not ok then
  error('mason-lspconfig not found aborting')
  return
end

local ok, _ = pcall(require, 'neodev')
if ok then
  require('neodev').setup({})
end

require('av.lsp.handlers').setup()
local mason = require('mason')
mason.setup({
  -- The directory in which to install packages.
  install_root_dir = vim.fn.stdpath('data') .. '/mason',
  PATH = 'prepend',
})

require('av.lsp.installer')
require('av.lsp.null-ls')
require('av.lsp.symbols-outline')
