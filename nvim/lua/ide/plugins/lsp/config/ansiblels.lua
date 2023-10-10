local M = {}

M.settings = {
  ansible = {
    ansible = {
      path = 'ansible',
      useFullyQualifiedCollectionNames = true,
    },
    ansibleLint = {
      enabled = true,
      path = 'ansible-lint',
    },
    executionEnvironment = {
      enabled = false,
    },
    python = {
      interpreterPath = 'python3',
    },
    completion = {
      provideRedirectModules = true,
      provideModuleOptionAliases = true,
    },
  },
}

return M
