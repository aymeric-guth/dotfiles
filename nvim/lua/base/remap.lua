vim.keymap.set('n', '<leader>e', '<cmd>Lexplore | vert res 30<CR>', { desc = '[e]xplore' })

vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = '-> buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = '<- buffer' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'keeps cursor in place when deleting newline' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves selected text in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves selected text in visual mode' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'keeps cursor centered when jumping' })
-- vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'keeps cursor centered when jumping' })
-- vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'keeps cursor centered when jumping' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'keeps cursor centered when searching' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'keeps cursor centered when searching' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = 'deletes to void register' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'deletes to void register' })
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>bx', function()
  vim.cmd([[%!xxd]])
end, { desc = '[b]in he[x]' })

vim.keymap.set('n', 'Q', '<nop>')

-- vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
-- vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>]', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>[', vim.diagnostic.goto_prev)

vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'g]it [s]tatus' })

vim.keymap.set('n', '<leader>sb', '<cmd>buffers<CR>', { desc = '[s]tats[b]uffers' })
vim.keymap.set('n', '<leader>sj', '<cmd>jumps<CR>', { desc = '[s]tats[j]umps' })
