local M = {}
M.settings = {
  project = os.getenv('DOTFILES') .. '/pyrightconfig.json',
  pyright = {
    disableLanguageServices = false,
    disableOrganizeImports = true,
  },
  python = {
    analysis = {
      autoImportCompletions = true,
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
}
return M
