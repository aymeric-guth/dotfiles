
--[[
-- Trouble
--]]
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.keymap.set(
  'n',
  '<leader>xw',
  '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { desc = '[x] [w]orkspace', silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xd',
  '<cmd>TroubleToggle document_diagnostics<cr>',
  { desc = '[x] [d]iagnostics', silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xl',
  '<cmd>TroubleToggle loclist<cr>',
  { desc = '[x] [l]oclist', silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xq',
  '<cmd>TroubleToggle quickfix<cr>',
  { desc = '[x] [q]uickfix', silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  'gR',
  '<cmd>TroubleToggle lsp_references<cr>',
  { desc = '[g]o [R]eferences', silent = true, noremap = true }
)
