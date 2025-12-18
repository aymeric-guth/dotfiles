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
vim.g.clipboard = 'osc52'

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
vim.o.timeoutlen = 500

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
vim.opt.cursorline = true

vim.opt.scrolloff = 10
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

--  [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.opt.verbose = 20
-- vim.opt.verbose = 0
-- vim.opt.verbosefile = nil

vim.cmd([[colorscheme retrobox]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.foldenable = false

-- Créer une commande EvalExpr
vim.api.nvim_create_user_command('EvalExpr', function(opts)
  -- opts.line1/line2 = plage si utilisée
  local range = string.format('%d,%d', opts.line1, opts.line2)
  vim.cmd(range .. [[s/\v(\d[0-9\.\+\-\*\/]*)/\=eval(submatch(1))/g]])
end, { range = true })

-- Mapping pour lancer la commande
-- <leader>e en mode normal = sur tout le buffer
vim.keymap.set(
  { 'n', 'v' },
  '<leader>e',
  '<cmd>EvalExpr<CR>',
  { desc = 'Évaluer les expressions numériques' }
)

vim.opt.winborder = 'rounded'

vim.keymap.set(
  { 'n', 'v' },
  '<leader>m',
  '<cmd>:call PlayFileUnderCursor()<CR>',
  { desc = 'play file' }
)

local mpv_socket = '/tmp/mpv-nvim-' .. vim.fn.getpid() .. '.sock'

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.fn.jobstart({
      'mpv',
      '--idle=yes',
      '--no-terminal',
      '--force-window=no',
      '--input-ipc-server=' .. mpv_socket,
    }, {
      on_exit = function(_, code, _)
        if code ~= 0 then
          vim.schedule(function()
            vim.notify("mpv s'est terminé (code " .. code .. ')', vim.log.levels.WARN)
          end)
        end
      end,
    })
  end,
})

local function mpv_send(cmd)
  local payload = vim.fn.json_encode({ command = cmd }) .. '\n'

  local pipe = vim.loop.new_pipe(false)
  pipe:connect(mpv_socket, function(err)
    if err then
      pipe:close()
      vim.schedule(function()
        vim.notify('mpv IPC erreur: ' .. err, vim.log.levels.ERROR)
      end)
      return
    end

    pipe:write(payload, function(werr)
      if werr then
        vim.schedule(function()
          vim.notify('mpv IPC write: ' .. werr, vim.log.levels.ERROR)
        end)
      end
      pipe:shutdown(function()
        pipe:close()
      end)
    end)
  end)
end

local function mpv_loadfile(path)
  -- mpv_ensure()

  local payload = vim.fn.json_encode({
    command = { 'loadfile', path, 'replace' },
  }) .. '\n'

  local pipe = vim.loop.new_pipe(false)

  pipe:connect(mpv_socket, function(err)
    if err then
      vim.schedule(function()
        vim.notify('mpv: connexion échouée: ' .. err, vim.log.levels.ERROR)
      end)
      pipe:close()
      return
    end

    pipe:write(payload, function(werr)
      if werr then
        vim.schedule(function()
          vim.notify('mpv: écriture échouée: ' .. werr, vim.log.levels.ERROR)
        end)
      end
      pipe:shutdown(function()
        pipe:close()
      end)
    end)
  end)
end

local function mpc_loadfile(path)
  -- mpc clear
  -- mpc add "$file"
  -- mpc play
  vim.fn.jobstart({ 'mpc', 'clear' })
  vim.fn.jobstart({ 'mpc', 'add', path })
  vim.fn.jobstart({ 'mpc', 'play' })
end

local function play_file_under_cursor()
  local entry = require('oil').get_cursor_entry()
  local file = entry.name
  local dir = require('oil').get_current_dir()

  if file == nil or file == '' then
    vim.notify('Aucun fichier sous le curseur', vim.log.levels.WARN)
    return
  end

  vim.notify(file)
  vim.notify(dir)

  local is_audio = file:match('%.mp3$')
      or file:match('%.flac$')
      or file:match('%.wav$')
      or file:match('%.ogg$')
      or file:match('%.m4a$')

  if not is_audio then
    vim.notify('Pas un fichier audio : ' .. file, vim.log.levels.INFO)
    return
  end

  local path = dir .. file
  -- mpv_loadfile(path)
  mpc_loadfile(string.sub(path, 17))

  vim.notify('Lecture : ' .. string.sub(path, 17), vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd('VimLeavePre', {
  once = true,
  callback = function()
    pcall(os.remove, mpv_socket)
  end,
})

vim.keymap.set('n', '<leader>m', play_file_under_cursor, {
  desc = 'Lire le fichier audio sous le curseur',
})
vim.keymap.set('n', '<leader>p', function()
  mpv_send({ 'cycle', 'pause' })
end, { desc = 'mpv play/pause' })

vim.keymap.set('n', '<leader>l', function()
  mpv_send({ 'seek', 30, 'relative' })
end, { desc = 'mpv +10s' })

vim.keymap.set('n', '<leader>h', function()
  mpv_send({ 'seek', -30, 'relative' })
end, { desc = 'mpv -10s' })

vim.keymap.set('n', '<leader>k', function()
  mpv_send({ 'add', 'volume', 10 })
end, { desc = 'mpv volume +5' })

vim.keymap.set('n', '<leader>j', function()
  mpv_send({ 'add', 'volume', -10 })
end, { desc = 'mpv volume -5' })

--vim.opts.rocks.enabled = false
--vim.opts.rocks.hererocks = false
