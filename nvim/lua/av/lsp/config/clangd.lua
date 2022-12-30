local M = {}

M.settings = {
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--compile-commands-dir='
        .. require('os').getenv('WORKSPACE')
        .. '/build/compile_commands.json',
      '--pch-storage=memory',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  },
}

return M
