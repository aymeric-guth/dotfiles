local util = require('lspconfig.util')

return {
  filetypes = { 'yaml.ansible' },
  root_dir = util.root_pattern('ansible.cfg'),
  single_file_support = true,
  settings = {
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
        interpreterPath = 'python',
      },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
    },
  },
} -- return {
--   setup = {
--     ansible = {
--       ansible = {
--         path = 'ansible',
--       },
--       ansibleLint = {
--         enabled = true,
--         path = 'ansible-lint',
--       },
--       executionEnvironment = {
--         enabled = false,
--       },
--       python = {
--         interpreterPath = 'python',
--       },
--     },
--   },
-- }
