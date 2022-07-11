require("packer").init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]

return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    -- Configurations for Nvim LSP
    use("neovim/nvim-lspconfig") 
    -- Telescope + deps: fuzzy finder
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")

    -- LSP
    use("p00f/clangd_extensions.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("folke/trouble.nvim")
    use("pappasam/jedi-language-server")

    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("jose-elias-alvarez/null-ls.nvim")
    -- Format
    -- use("vim-autoformat/vim-autoformat")
    -- use("sbdchd/neoformat")

--    use {
--        'kyazdani42/nvim-tree.lua',
--        requires = {
--            'kyazdani42/nvim-web-devicons', -- optional, for file icons
--        },
--        tag = 'nightly' -- optional, updated every week. (see issue #1193)
--    }
    -- Simple plugins can be specified as strings
    -- use("TimUntersberger/neogit")

    -- TJ created lodash of neovim
    -- use("nvim-lua/plenary.nvim")
    -- use("nvim-lua/popup.nvim")
    -- use("nvim-telescope/telescope.nvim")

    -- All the things
    -- use("neovim/nvim-lspconfig")
    -- use("hrsh7th/cmp-nvim-lsp")
    -- use("hrsh7th/cmp-buffer")
    -- use("hrsh7th/nvim-cmp")
    -- use("tzachar/cmp-tabnine", { run = "./install.sh" })
    -- use("onsails/lspkind-nvim")
    -- use("nvim-lua/lsp_extensions.nvim")
    -- use("glepnir/lspsaga.nvim")
    -- use("simrat39/symbols-outline.nvim")
    -- use("L3MON4D3/LuaSnip")
    -- use("saadparwaiz1/cmp_luasnip")

    -- Primeagen doesn"t create lodash
    -- use("ThePrimeagen/git-worktree.nvim")
    -- use("ThePrimeagen/harpoon")

    -- use("mbbill/undotree")

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use("luisiacc/gruvbox-baby")

    -- TreeSitter + deps
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")
    -- use("theHamsta/nvim-dap-virtual-text")

	--[[
    --
	-- Lazy loading:
	-- Load on specific commands
	use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
	-- Load on an autocommand event
	use {'andymass/vim-matchup', event = 'VimEnter'}
	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
	use {
	'w0rp/ale',
	ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
	cmd = 'ALEEnable',
	config = 'vim.cmd[[ALEEnable]]--[['
	}
	-- Plugins can have dependencies on other plugins
	use {
	'haorenW1025/completion-nvim',
	opt = true,
	requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
	}
	-- Plugins can also depend on rocks from luarocks.org:
	use {
	'my/supercoolplugin',
	rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
	}
	-- You can specify rocks in isolation
	use_rocks 'penlight'
	use_rocks {'lua-resty-http', 'lpeg'}
	-- Local plugins can be included
	use '~/projects/personal/hover.nvim'
	-- Plugins can have post-install/update hooks
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
	-- Post-install/update hook with neovim command
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	-- Post-install/update hook with call of vimscript function with argument
	use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
	-- Use specific branch, dependency and run lua file after load
	use {
	'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
	requires = {'kyazdani42/nvim-web-devicons'}
	}
	-- Use dependency and run lua function after load
	use {
	'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
	config = function() require('gitsigns').setup() end
	}
	-- You can specify multiple plugins in a single call
	use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
	-- You can alias plugin names
	use {'dracula/vim', as = 'dracula'}
	end)
	--]]
end)
