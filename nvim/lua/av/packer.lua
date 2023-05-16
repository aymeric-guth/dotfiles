-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- local is_bootstrap = false
-- 
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   is_bootstrap = true
--   vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
--   vim.cmd([[packadd packer.nvim]])
-- end

vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
    augroup end
]])

require('packer').startup({
  function(use)
    -- Packer
    use('wbthomason/packer.nvim')

    -- General dependencies
    use('nvim-lua/plenary.nvim')
    use('kyazdani42/nvim-web-devicons')

    --[[
    -- Telescope
    --]]
    use({
      'nvim-telescope/telescope.nvim',
      branch = 'master',
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', branch = 'main', run = 'make' })
    -- binary: sqlite3 @3.39.0
    use({
      'nvim-telescope/telescope-frecency.nvim',
      requires = { 'tami5/sqlite.lua' },
    })

    --[[
    -- Navigation
    --]]
    use({
      'kyazdani42/nvim-tree.lua',
    })
    use({ 'ThePrimeagen/harpoon' })
    use({ 'simrat39/symbols-outline.nvim' })
    use({ 'mbbill/undotree' })

    if os.getenv('NEOVIM_FULL') ~= nil then
      --[[
      -- LSP
      --]]
      use('neovim/nvim-lspconfig')
      use('jose-elias-alvarez/null-ls.nvim')
      use({ 'williamboman/mason-lspconfig.nvim' })
      use({ 'williamboman/mason.nvim' })
      use({ 'jayp0521/mason-null-ls.nvim' })
      -- use('simrat39/rust-tools.nvim')

      --[[
      -- CMP
      --]]
      use({ 'hrsh7th/cmp-nvim-lsp', branch = 'main' })
      use({ 'hrsh7th/cmp-buffer', branch = 'main' })
      use({ 'hrsh7th/cmp-path', branch = 'main' })
      use({ 'hrsh7th/cmp-cmdline', branch = 'main' })
      use({ 'hrsh7th/nvim-cmp', branch = 'main' })
      use({ 'zbirenbaum/copilot.lua' })
      use({ 'zbirenbaum/copilot-cmp' })
      use({ 'hrsh7th/cmp-nvim-lsp-document-symbol' })
      use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
      use({ 'ray-x/cmp-treesitter' })

      use({ 'L3MON4D3/LuaSnip', branch = 'master' })
      use({ 'saadparwaiz1/cmp_luasnip', branch = 'master' })
      --[[
      -- DAP
      --]]
      --[[
      -- Misc
      --]]
      use({ 'SmiteshP/nvim-navic' })
      use({ 'RRethy/vim-illuminate' })
      use({ 'folke/trouble.nvim' })
      use({ 'onsails/lspkind.nvim' })
      use('j-hui/fidget.nvim')
    end

    -- TreeSitter
    use({
      'nvim-treesitter/nvim-treesitter',
      run = function()
        pcall(require('nvim-treesitter.install').update({ with_sync = true }))
      end,
    })
    use({ 'nvim-treesitter/playground' })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })

    -- git
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end,
    })
    use({ 'tpope/vim-fugitive' })

    --[[
    -- UI
    --]]
    use({ 'luisiacc/gruvbox-baby', branch = 'main' })
    use({
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })
    use({
      'norcalli/nvim-colorizer.lua',
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = {
        show_end_of_line = true,
        char = '┊',
        show_trailing_blankline_indent = true,
      },
    })

    -- [[
    -- Misc
    -- ]]
    use({ 'ojroques/nvim-osc52' })
    use('windwp/nvim-autopairs')
    use({ 'tpope/vim-commentary' })

    -- [[
    -- Packer boostraping
    -- ]]
      if packer_bootstrap then
        require('packer').sync()
      end
     -- if is_bootstrap then
     --   require('packer').sync()
     --   vim.cmd([[
     --   augroup packer_bootstrap
     --   autocmd!
     --   autocmd User PackerComplete quitall
     --   augroup end
     -- ]])
     -- end
  end,
  config = {
    snapshot_path = vim.fn.stdpath('cache') .. '/packer.nvim', -- Default save directory for snapshots,
    package_root = vim.fn.stdpath('data') .. '/site/pack',
    compile_path = vim.fn.stdpath('data') .. '/plugin/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
