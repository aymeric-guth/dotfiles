return {
  settings = {
    project = os.getenv('DOTFILES') .. '/pyrightconfig.json',
    pyright = {
      disableLanguageServices = false,
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
}
