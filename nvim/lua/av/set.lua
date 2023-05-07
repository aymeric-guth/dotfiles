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
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

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

vim.keymap.set('', '<Space>', '<nop>')
vim.g.mapleader = ' '
vim.g.loaded_perl_provider = 0
