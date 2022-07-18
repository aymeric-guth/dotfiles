local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return
end

if not lspconfig.pyright then
  return
end

local handlers = require('av.lsp.handlers')

lspconfig.pyright.setup({
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  lsp_flags = handlers.lsp_flags,
  settings = {
    enabled = false,
    pyright = {
      disableLanguageServices = true,
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoImportCompletions = false,
        diagnosticMode = 'workspace',
        --diagnosticSeverityOverrides = {}
        --extraPaths = {},
        --logLevel = "Information",
        --stubPath = {},
        --typeCheckingMode = "strict",
        --typeshedPaths = {},
        useLibraryCodeForTypes = true,
      },
    },
  },
})
