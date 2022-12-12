local lspconfig = require('lspconfig')
local servers = {
  'clangd',
  -- 'pylsp',
  'pyright',
  'sumneko_lua',
  'taplo',
  'bashls',
  'dockerls',
  'ansiblels',
  -- 'csharp_ls',
  -- 'dartls',
  -- 'gopls',
  -- 'golangci_lint_ls',
  'rust_analyzer',
  -- 'ccls',
}
local handlers = require('av.lsp.handlers')

for _, server in pairs(servers) do
  -- if vim.fn.executable(server) == 0 then
  --   goto continue
  -- end

  local capabilities = handlers.capabilities
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = capabilities,
    lsp_flags = handlers.lsp_flags,
  }

  -- if (server == "dartls") then
  --   opts.capabilities.textDocument.formatting = vim.lsp.util.make_formatting_params()
  -- end
  local lsp = require('av.lsp.config.' .. server)
  opts = vim.tbl_deep_extend('force', lsp, opts)
  lspconfig[server].setup(opts)
  ::continue::
end
