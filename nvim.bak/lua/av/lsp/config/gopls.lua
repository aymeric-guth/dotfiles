local M = {}

M.cmd = { 'gopls', 'serve' }
M.filetypes = { 'go', 'gomod' }
-- M.root_dir = vim.g.util.root_pattern('go.work', 'go.mod', '.git')

M.settings = {
  gopls = {
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
  },
}

return M
