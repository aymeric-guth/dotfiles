local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Windows Navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-i>", "<C-w>i", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":NvimTreeToggle <CR>", opts)
keymap("n", "<leader>r", ":SymbolsOutline<CR>", opts)
keymap("n", "<leader>d", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>z", ":UndotreeToggle<CR>", opts)

keymap("n", "<C-=>", "<Nop>", opts)
keymap("n", "^=", ":resize +2<CR>", opts)
keymap("n", "<C-->", "<Nop>", opts)
keymap("n", "<C-->", ":resize -2<CR>", opts)
keymap("n", "<C-+>", "<Nop>", opts)
keymap("n", "<C-+>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-_>", ":vertical resize -2<CR>", opts)

keymap(
	"n",
	"<leader>ps",
	":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ')})<cr>",
	opts
)
