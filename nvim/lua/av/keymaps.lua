local opts = { noremap = true, silent = true }

local nnoremap = function(lhs, rhs)
  return vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs)
  return vim.api.nvim_set_keymap('v', lhs, rhs, { noremap = true, silent = true })
end

local nvnoremap = function(lhs, rhs)
  return vim.keymap.set({ 'n', 'v' }, lhs, rhs, opts)
end

--[[
-- h j k l H J K L
--]]
-- <Alt-key>
-- <Alt-S-key>
-- <C-key>
-- <C-Alt-key>
-- <C-Alt-S-key>
-- <C-S-key>
-- <Alt-j>
nvnoremap('<M-j>', '}')
nvnoremap('∆', '}')
-- <Alt-k>
nvnoremap('<M-k>', '{')
nvnoremap('˚', '{')

-- Basic
--]]
nvnoremap(';', ':')
nnoremap(',p', '"0p')
nnoremap(',P', '"0P')

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = '[e]xplore' })
vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<CR>', { desc = '[s]ymbols [o]utline' })
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = '[u]ndotree' })

vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = '-> buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = '<- buffer' })

--[[
Telescope
--]]
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files(require('telescope.themes').get_dropdown({ previewer = false }))
end, { desc = '[f]ind [f]iles' })

vim.keymap.set('n', '<leader>fF', function()
  builtin.find_files({
    no_ignore = true,
    hidden = true,
    no_ignore_vcs = true,
    no_ignore_parent = true,
  })
end, { desc = '[f]ind [F]files (no ignore)' })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep' })
vim.keymap.set('n', '<leader>fG', function()
  builtin.live_grep({
    additional_args = function(opts)
      return { '--no-ignore' }
    end,
  })
end, { desc = '[f]ind live [G]rep (no ignore)' })

vim.keymap.set('n', '<leader>fB', builtin.buffers, { desc = '[f]ind [B]uffers (all)' })
vim.keymap.set(
  'n',
  '<leader>fb',
  builtin.current_buffer_fuzzy_find,
  { desc = '[f]ind [b]uffer (current)' }
)
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[f]ind [s]tring' })
-- vim.keymap.set(
--   'n',
--   '<leader>fwt',
--   require('telescope').extensions.git_worktree.git_worktrees,
--   { desc = '[f]ind [w]ork[t]ree' }
-- )

-- Help
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = '[f]ind [m]an pages' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]help tags' })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[f]ind [c]ommands' })
vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = '[f]ind vim [o]ptions' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[f]ind [r]egisters' })
vim.keymap.set('n', '<leader>fa', builtin.autocommands, { desc = '[f]ind [a]utocommands' })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = '[f]ind [t]reesitter' })

vim.keymap.set(
  'n',
  '<leader>fld',
  builtin.lsp_document_symbols,
  { desc = '[f]ind [l]sp [d]ocument' }
)
vim.keymap.set(
  'n',
  '<leader>flw',
  builtin.lsp_workspace_symbols,
  { desc = '[f]ind [l]sp [w]orkspace' }
)

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

--[[
-- Harpoon
--]]
vim.keymap.set('n', '<leader>a', function()
  require('harpoon.mark').add_file()
end)
vim.keymap.set('n', '<C-e>', function()
  require('harpoon.ui').toggle_quick_menu()
end)
vim.keymap.set('n', '<C-h>', function()
  require('harpoon.ui').nav_file(1)
end)
vim.keymap.set('n', '<C-t>', function()
  require('harpoon.ui').nav_file(2)
end)
vim.keymap.set('n', '<C-n>', function()
  require('harpoon.ui').nav_file(3)
end)
vim.keymap.set('n', '<C-s>', function()
  require('harpoon.ui').nav_file(4)
end)

-- [[
-- TreeSitter
-- ]]
vim.keymap.set(
  'n',
  '<leader>tp',
  vim.cmd.TSPlaygroundToggle,
  { desc = '[t]ree-sitter [p]layground' }
)

-- [[
-- Misc
-- ]]
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves selected text in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves selected text in visual mode' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'keeps cursor in place when deleting newline' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'keeps cursor centered when jumping' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'keeps cursor centered when jumping' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = 'deletes to void buffer' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'deletes to void buffer' })

vim.keymap.set('n', '<leader>bx', function()
  vim.cmd([[%!xxd]])
end, { desc = '[b]in he[x]' })

vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[g]it [s]tatus' })
vim.keymap.set('n', '<leader>p', '"_sP')

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')
