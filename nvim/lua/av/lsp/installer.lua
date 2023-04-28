local servers = {
  'clangd',
  'pyright',
  'lua_ls',
  'taplo',
  'bashls',
  'dockerls',
  'ansiblels',
  -- 'gopls',
  -- 'solidity',
  -- 'golangci_lint_ls',
  -- 'marksman',
  -- 'bufls',
}

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = servers,
})

local handlers = require('av.lsp.handlers')

-- handlers.capabilities.textDocument.formatting = nil
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
