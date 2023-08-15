-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('', '<Space>', '<nop>')

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.wildignore = {
  '*.pyc',
  '*_build/*',
  '**/coverage/*',
  '**/node_modules/*',
  '**/android/*',
  '**/ios/*',
  '**/.git/*',
  'TabNine',
  '.stfolder',
  '.venv',
  '.mypy_cache',
  '.pytest_cache',
  '.DS_Store',
  '__pycache__',
  '.local',
}

vim.opt.encoding = 'utf-8'
vim.opt.guifont = 'monospace:h17'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undodir'

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append('c')

vim.opt.colorcolumn = '80'

vim.g.python3_host_prog = 'python3'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.o.formatoptions = 'rqnj'
-- vim.o.listchars = 'eol:\\u21b5,space:.,tab:>~'
vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↴')

vim.lsp.set_log_level('warn')

vim.g.loaded_perl_provider = 0

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.cmd([[
--   augroup ColorizeBuffer
--   autocmd!
--   au BufRead,BufNewFile * ColorizerAttachToBuffer
--   augroup END
-- ]])
