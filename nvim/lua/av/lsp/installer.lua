local mason = require('mason')
mason.setup({
  -- The directory in which to install packages.
  install_root_dir = vim.fn.stdpath('data') .. '/mason',
  PATH = 'prepend',
})

local servers = {
  'clangd',
  'pyright',
  'sumneko_lua',
  'taplo',
  'bashls',
  'dockerls',
  'ansiblels',
}

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = servers,
})

local handlers = require('av.lsp.handlers')

mason_lspconfig.setup_handlers({
  function(server_name)
    local server = require('av.lsp.config.' .. server_name)

    require('lspconfig')[server_name].setup({
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
      lsp_flags = handlers.lsp_flags,
      settings = server.settings,
    })
  end,
})
