local ok, _ = pcall(require, 'lspconfig')
if not ok then
  error('lspconfig not found aborting')
  return
end

local ok, mason = pcall(require, 'mason')
if not ok then
  error('mason not found aborting')
  return
end

local ok, _ = pcall(require, 'mason-lspconfig')
if not ok then
  error('mason-lspconfig not found aborting')
  return
end

-- local ok, _ = pcall(require, 'neodev')
-- if ok then
--   require('neodev').setup({})
-- end

require('av.lsp.handlers').setup()
mason.setup({
  install_root_dir = vim.fn.stdpath('data') .. '/mason',
  PATH = 'prepend',
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

require('av.lsp.installer')
require('av.lsp.null-ls')
require('av.lsp.symbols-outline')
