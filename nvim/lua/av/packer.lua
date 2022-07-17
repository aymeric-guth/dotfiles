local stdpath = vim.fn.stdpath

-- local install_path = stdpath("data") .. "/site/pack/packer.nvim"
local install_path = stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- :PackerSync on_save
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]])

packer.init({
  ensure_dependencies = true, -- Should packer install plugin dependencies?
  snapshot = nil, -- Name of the snapshot you would like to load at startup
  snapshot_path = stdpath('cache') .. '/packer.nvim', -- Default save directory for snapshots
  package_root = stdpath('data') .. '/site/pack',
  compile_path = stdpath('data') .. '/plugin/packer_compiled.lua',
  plugin_package = 'packer', -- The default package for plugins
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  disable_commands = false, -- Disable creating commands
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  transitive_opt = true, -- Make dependencies of opt plugins also opt by default
  transitive_disable = true, -- Automatically disable dependencies of disabled plugins
  auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
  git = {
    cmd = 'git', -- The base command for git operations
    subcommands = { -- Format strings for git subcommands
      update = 'pull --ff-only --progress --rebase=false',
      install = 'clone --depth %i --no-single-branch --progress',
      fetch = 'fetch --depth 999999 --progress',
      checkout = 'checkout %s --',
      update_branch = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt = '%%h %%s (%%cr)',
      get_rev = 'rev-parse --short HEAD',
      get_msg = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules = 'submodule update --init --recursive --progress',
    },
    depth = 1, -- Git clone depth
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    default_url_format = 'https://github.com/%s', -- Lua format string used for "aaa/bbb" style plugins
  },
  display = {
    non_interactive = false, -- If true, disable display windows for all operations
    open_fn = function() -- An optional function to open a window for packer's display
      return require('packer.util').float({ border = 'rounded' })
    end,
    open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
    working_sym = '⟳', -- The symbol for a plugin being installed/updated
    error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
    done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '-', -- The symbol for an unused plugin which was removed
    moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '━', -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = 'double', -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = 'q',
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    },
  },
  luarocks = {
    python_cmd = 'python', -- Set the python command to use for running hererocks
  },
  log = { level = 'warn' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
  profile = {
    enable = false,
    threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
  },
  autoremove = true, -- Remove disabled or unused plugins without prompting the user
})

return require('packer').startup(function(use)
  use('kyazdani42/nvim-web-devicons')
  use('nvim-lualine/lualine.nvim')
  use('dstein64/vim-startuptime')
  -- use({ 'SidOfc/carbon.nvim' })
  -- Packer
  use('wbthomason/packer.nvim')

  -- General dependencies
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')

  -- Configurations for Nvim LSP
  use('neovim/nvim-lspconfig')
  use('jose-elias-alvarez/null-ls.nvim')

  -- Telescope + deps: fuzzy finder
  use({
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', branch = 'main', run = 'make' })
  use('nvim-telescope/telescope-file-browser.nvim')
  -- binary: sqlite3 @3.39.0
  use({
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require('telescope').load_extension('frecency')
    end,
    requires = { 'tami5/sqlite.lua' },
  })

  --[[
  -- Navigation
  --]]
  -- use({
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icons
  --   },
  --   tag = 'nightly', -- optional, updated every week. (see issue #1193)
  -- })
  use({ 'akinsho/bufferline.nvim', branch = 'main', requires = 'kyazdani42/nvim-web-devicons' })
  use({ 'moll/vim-bbye', branch = 'master' })
  use({ 'ThePrimeagen/harpoon', branch = 'master' })
  use('mbbill/undotree')

  use('simrat39/symbols-outline.nvim')
  --[[
  -- LSP
  --]]
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')
  -- patched installer to force tabnine in .local
  use({
    'tzachar/cmp-tabnine',
    run = '$DOTCONF/patches/tabnine/install.sh',
    requires = 'hrsh7th/nvim-cmp',
  })
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('folke/trouble.nvim')

  -- Colorschemes
  use('gruvbox-community/gruvbox')
  use('folke/tokyonight.nvim')
  use('luisiacc/gruvbox-baby')

  -- Autopairs
  use('windwp/nvim-autopairs')

  -- TreeSitter + deps
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    branch = 'master',
  })
  -- use('nvim-treesitter/playground')
  use({ 'nvim-treesitter/nvim-treesitter-context', branch = 'master' })

  -- git
  use('lewis6991/gitsigns.nvim')

  if PACKER_BOOTSTRAP then
    -- :autocmd User MyPlugin echom 'got MyPlugin event'
    -- :doautocmd User MyPlugin
    require('packer').sync()
    -- PackerComplete
    vim.cmd([[
      augroup packer_bootstrap
      autocmd!
      autocmd User PackerComplete quitall
      augroup end
    ]])
  end
end)
