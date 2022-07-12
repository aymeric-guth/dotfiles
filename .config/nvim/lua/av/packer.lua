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
    -- General dependencies
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")

    -- Configurations for Nvim LSP
    use("neovim/nvim-lspconfig") 
    use("jose-elias-alvarez/null-ls.nvim")

    -- Telescope + deps: fuzzy finder
    use("nvim-telescope/telescope.nvim")

    -- LSP
--    use("p00f/clangd_extensions.nvim")
--    use("kyazdani42/nvim-web-devicons")
--    use("folke/trouble.nvim")
    use("pappasam/jedi-language-server")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use("luisiacc/gruvbox-baby")

    -- Autopairs
    use("windwp/nvim-autopairs")
    -- TreeSitter + deps
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")
end)
