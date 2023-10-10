vim.keymap.set('n', '<leader>e', '<cmd>Lexplore | vert res 30<CR>', { desc = '[e]xplore' })
-- vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = '[e]xplore' })
-- vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = '[u]ndotree' })

vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = '-> buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = '<- buffer' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves selected text in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves selected text in visual mode' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'keeps cursor in place when deleting newline' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'keeps cursor centered when jumping' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'keeps cursor centered when searching' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'keeps cursor centered when searching' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = 'deletes to void buffer' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'deletes to void register' })
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>bx', function()
  vim.cmd([[%!xxd]])
end, { desc = '[b]in he[x]' })

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')


-- --[[
-- -- Trouble
-- --]]
-- vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
-- vim.keymap.set(
--   'n',
--   '<leader>xw',
--   '<cmd>TroubleToggle workspace_diagnostics<cr>',
--   { desc = '[x] [w]orkspace', silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   'n',
--   '<leader>xd',
--   '<cmd>TroubleToggle document_diagnostics<cr>',
--   { desc = '[x] [d]iagnostics', silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   'n',
--   '<leader>xl',
--   '<cmd>TroubleToggle loclist<cr>',
--   { desc = '[x] [l]oclist', silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   'n',
--   '<leader>xq',
--   '<cmd>TroubleToggle quickfix<cr>',
--   { desc = '[x] [q]uickfix', silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   'n',
--   'gR',
--   '<cmd>TroubleToggle lsp_references<cr>',
--   { desc = '[g]o [R]eferences', silent = true, noremap = true }
-- )
--
-- --[[
-- -- Harpoon
-- --]]
-- vim.keymap.set('n', '<leader>a', function()
--   require('harpoon.mark').add_file()
-- end)
-- vim.keymap.set('n', '<C-e>', function()
--   require('harpoon.ui').toggle_quick_menu()
-- end)
-- vim.keymap.set('n', '<C-h>', function()
--   require('harpoon.ui').nav_file(1)
-- end)
-- vim.keymap.set('n', '<C-t>', function()
--   require('harpoon.ui').nav_file(2)
-- end)
-- vim.keymap.set('n', '<C-n>', function()
--   require('harpoon.ui').nav_file(3)
-- end)
-- vim.keymap.set('n', '<C-s>', function()
--   require('harpoon.ui').nav_file(4)
-- end)
--
-- -- [[
-- -- TreeSitter
-- -- ]]
-- vim.keymap.set(
--   'n',
--   '<leader>tp',
--   vim.cmd.TSPlaygroundToggle,
--   { desc = '[t]ree-sitter [p]layground' }
-- )
--

-- vim.keymap.set('n', '<leader>tn', '<cmd>FloatermNew<CR>', { desc = '[t]erminal [n]ew' })
-- vim.keymap.set('n', '<leader>tt', '<cmd>FloatermToggle<CR>', { desc = '[t]erminal [t]oggle' })
-- vim.keymap.set('n', '<leader>tk', '<cmd>FloatermKill<CR>', { desc = '[t]erminal [k]ill' })
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[g]it [s]tatus' })
