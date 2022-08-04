local utils = require('av.utils')
local noremap = utils.noremap

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.loaded_perl_provider = 0

-- Windows Navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-i>", "<C-w>i", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- <Alt-h>
-- keymap('n', '˙', '', opts)
-- <Alt-S-h>
-- keymap('n', 'Ó', '', opts)
-- <Alt-l>
-- keymap('n', '¬', '', opts)
-- <Alt-S-l>
-- keymap('n', 'Ò', '', opts)

--[[
-- h j k l H J K L
--]]
-- <Alt-j>
vim.keymap.set({ 'n' }, '<M-j>', '}', opts)
-- compatibility Laptop, not sure why M- does not work
vim.keymap.set({ 'n' }, '∆', '}', opts)
keymap('n', '<M-S-j>', '<S-g>', opts)
-- <Alt-S-j>

-- <Alt-k>
keymap('n', '<M-k>', '{', opts)
-- compatibility Laptop, not sure why M- does not work
keymap('n', '˚', '{', opts)
keymap('n', '<M-S-k>', 'gg', opts)
-- <Alt-S-k>
-- keymap('n', '', '', opts)

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>r', ':SymbolsOutline<CR>', opts)
keymap('n', '<leader>z', ':UndotreeToggle<CR>', opts)

keymap('n', '<C-=>', '<Nop>', opts)
keymap('n', '^=', ':resize +2<CR>', opts)
keymap('n', '<C-->', '<Nop>', opts)
keymap('n', '<C-->', ':resize -2<CR>', opts)
keymap('n', '<C-+>', '<Nop>', opts)
keymap('n', '<C-+>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-_>', ':vertical resize -2<CR>', opts)

keymap('n', '<leader>c', '"*yy', opts)
keymap('n', '<leader>p', '"*p', opts)
-- Naviagate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)
keymap('n', '<leader>q', ':Bdelete<CR>', opts)

--[[
Telescope
--]]
keymap(
  'n',
  '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  opts
)
-- keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)

keymap('n', '<leader>ft', ':Telescope current_buffer_fuzzy_find<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
-- Help
keymap('n', '<leader>fm', ':Telescope man_pages<CR>', opts)
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- keymap('n', '<leader>e', ':Telescope file_browser<CR>', opts)
-- keymap(
--   'n',
--   '<leader>e',
--   "<cmd>lua require('telescope').extensions.file_browser.file_browser(require('telescope.themes').get_dropdown{ previewer = false})<cr>",
--   opts
-- )

-- keymap('n', '<leader>ft', ':Telescope treesitter<CR>', opts)
-- builtin.git_files search through git ls-files
-- builtin.grep_string search under cursor in cwd

-- builtin.treesitter fuction, variable name from tree-sitter

-- keymap('n', '<leader>ps', ':lua require("telescope.builtin").grep_string()',)
-- keymap(
-- 	"n",
-- 	"<leader>ps",
-- 	":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ')})<cr>",
-- 	opts
-- )

keymap('n', '<leader>d', ':TroubleToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>xw',
  '<cmd>Trouble workspace_diagnostics<cr>',
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>xd',
  '<cmd>Trouble document_diagnostics<cr>',
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>xl',
  '<cmd>Trouble loclist<cr>',
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>xq',
  '<cmd>Trouble quickfix<cr>',
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  'n',
  'gR',
  '<cmd>Trouble lsp_references<cr>',
  { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>tc',
  '<cmd>TSContextToggle<CR>',
  { silent = true, noremap = true }
)
