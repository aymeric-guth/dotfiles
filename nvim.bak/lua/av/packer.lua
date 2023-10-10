require('packer').startup({
  function(use)
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
      -- use({ 'zbirenbaum/copilot.lua' })
      -- use({ 'zbirenbaum/copilot-cmp' })
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
      use({ 'folke/trouble.nvim' })
      use({ 'onsails/lspkind.nvim' })
      use({ 'j-hui/fidget.nvim', tag = 'legacy' })

      use({ 'SmiteshP/nvim-navic' })
    end
})
