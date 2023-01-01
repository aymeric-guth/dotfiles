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

-- Leader Key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.loaded_perl_provider = 0

-- Windows Navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-i>", "<C-w>i", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

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

--[[
-- Basic
--]]
nvnoremap(';', ':')
nnoremap(',p', '"0p')
nnoremap(',P', '"0P')

-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 25

nnoremap('<leader>e', ':NvimTreeToggle<CR>')
nnoremap('<leader>so', ':SymbolsOutline<CR>')
nnoremap('<leader>u', ':UndotreeToggle<CR>')

nnoremap('<leader>y', '"+yy')
vnoremap('<leader>y', '"+yy')
nnoremap('<leader>p', '"+p')
nnoremap('<leader>P', '"+P')

-- Naviagate buffers
nnoremap('<S-l>', ':bnext<CR>')
nnoremap('<S-h>', ':bprevious<CR>')

--[[
Telescope
--]]
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files(require('telescope.themes').get_dropdown({ previewer = false }))
end, { desc = '[f]ind [f]files' })

vim.keymap.set('n', '<leader>fF', function()
  builtin.find_files({
    no_ignore = true,
    hidden = true,
    no_ignore_vcs = true,
    no_ignore_parent = true,
  })
end, { desc = '[f]ind [F]files no ignore' })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep' })
vim.keymap.set('n', '<leader>fG', function()
  builtin.live_grep({
    additional_args = function(opts)
      return { '--no-ignore' }
    end,
  })
end, { desc = '[f]ind [G]rep no ignore' })

vim.keymap.set('n', '<leader>fB', builtin.buffers, { desc = '[f]ind [B]uffers' })
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = '[f]ind [b]uffer' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[f]ind [s]tring' })
-- Help
-- vim.keymap
nnoremap('<leader>fm', ':Telescope man_pages<CR>')
nnoremap('<leader>fh', ':Telescope help_tags<CR>')
nnoremap('<leader>fc', ':Telescope commands<CR>')
nnoremap('<leader>fo', ':Telescope vim_options<CR>')
nnoremap('<leader>fr', ':Telescope registers<CR>')
nnoremap('<leader>fa', ':Telescope autocommands<CR>')
nnoremap('<leader>ft', ':Telescope treesitter<CR>')

vim.keymap.set('n', '<leader>fld', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>flw', builtin.lsp_workspace_symbols)

--[[
-- Trouble
--]]
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.keymap.set(
  'n',
  '<leader>xw',
  '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xd',
  '<cmd>TroubleToggle document_diagnostics<cr>',
  { silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xl',
  '<cmd>TroubleToggle loclist<cr>',
  { silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  '<leader>xq',
  '<cmd>TroubleToggle quickfix<cr>',
  { silent = true, noremap = true }
)
vim.keymap.set(
  'n',
  'gR',
  '<cmd>TroubleToggle lsp_references<cr>',
  { silent = true, noremap = true }
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
nnoremap('<C-h>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
nnoremap('<C-t>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
nnoremap('<C-n>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
nnoremap('<C-s>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

--[[
-- Glow
--]]
nnoremap('<leader>rmd', '<cmd>:Glow<cr>')

-- [[
-- TreeSitter
-- ]]
vim.keymap.set('n', '<leader>tp', vim.cmd.TSPlaygroundToggle)

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- moves selected text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- keeps cursor in place when deleting newline
vim.keymap.set('n', 'J', 'mzJ`z')

-- keeps cursor centered when jumping <C-d> <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- deletes to void buffer
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- converts buffer to hex
vim.keymap.set('n', '<leader>bx', function()
  vim.cmd([[%!xxd]])
end)

vim.keymap.set('n', '<leader>gpt', ':ChatGPT<CR>')
