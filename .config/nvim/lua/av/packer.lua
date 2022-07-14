-- auto install packer if not already installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

require("packer").init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	-- General dependencies
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	-- Configurations for Nvim LSP
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Telescope + deps: fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	use("mbbill/undotree")

	use("simrat39/symbols-outline.nvim")
	-- LSP
	--    use("p00f/clangd_extensions.nvim")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("folke/trouble.nvim")

	-- Colorscheme section
	use("gruvbox-community/gruvbox")
	use("folke/tokyonight.nvim")
	use("luisiacc/gruvbox-baby")

	-- Autopairs
	use("windwp/nvim-autopairs")
	-- TreeSitter + deps
	use("nvim-treesitter/nvim-treesitter", {
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("romgrk/nvim-treesitter-context")

	-- git
	use("lewis6991/gitsigns.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
