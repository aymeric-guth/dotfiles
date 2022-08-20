local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

local nnoremap = function(lhs, rhs)
  return vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end
local inoremap = function(lhs, rhs)
  return vim.api.nvim_set_keymap('i', lhs, rhs, { noremap = true, silent = true })
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

nnoremap('<leader>e', ':NvimTreeToggle<CR>')
nnoremap('<leader>so', ':SymbolsOutline<CR>')
nnoremap('<leader>z', ':UndotreeToggle<CR>')

nnoremap('<leader>y', '"+yy')
vnoremap('<leader>y', '"+yy')
nnoremap('<leader>p', '"+p')
nnoremap('<leader>P', '"+P')

-- Naviagate buffers
nnoremap('<S-l>', ':bnext<CR>')
nnoremap('<S-h>', ':bprevious<CR>')
nnoremap('<leader>q', ':Bdelete<CR>')

--[[
Telescope
--]]
-- nnoremap geh <cmd>Telescope find_files hidden=true<cr>
nnoremap(
  '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>"
)
nnoremap('<leader>fg', ':Telescope live_grep<CR>')
nnoremap('<leader>fb', ':Telescope current_buffer_fuzzy_find<CR>')
nnoremap('<leader>fB', ':Telescope buffers<CR>')
nnoremap('<leader>fs', ':Telescope grep_string<CR>')
-- Help
nnoremap('<leader>fm', ':Telescope man_pages<CR>')
nnoremap('<leader>fh', ':Telescope help_tags<CR>')

--[[
-- Trouble
--]]
nnoremap('<leader>do', ':TroubleToggle<CR>')
nnoremap('<leader>xx', '<cmd>Trouble<cr>')
nnoremap('<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
nnoremap('<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
nnoremap('<leader>xl', '<cmd>Trouble loclist<cr>')
nnoremap('<leader>xq', '<cmd>Trouble quickfix<cr>')
nnoremap('gR', '<cmd>Trouble lsp_references<cr>')
nnoremap('<leader>tc', '<cmd>TSContextToggle<CR>')

--[[
-- Harpoon
--]]
nnoremap('<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>")
nnoremap('<C-e>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
nnoremap('<C-h>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
nnoremap('<C-t>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
nnoremap('<C-n>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
nnoremap('<C-s>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
