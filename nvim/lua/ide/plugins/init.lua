return {
  'ledger/vim-ledger',
  -- {
  --   'ecthelionvi/NeoView.nvim',
  --   config = function()
  --     require('NeoView').setup()
  --   end,
  -- },
  'tpope/vim-fugitive',
  'windwp/nvim-autopairs',
  -- 'tpope/vim-sleuth',
  -- 'tpope/vim-commentary',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/tokyonight.nvim' },
  -- { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true },
  require('ide.plugins.telescope'),
  require('ide.plugins.treesitter'),
  require('ide.plugins.treesitter-context'),
  require('ide.plugins.gitsigns'),
  require('ide.plugins.undotree'),
  require('ide.plugins.lualine'),
  require('ide.plugins.gruvbox-baby'),
  require('ide.plugins.indent-blankline'),
  require('ide.plugins.oil'),
  require('ide.plugins.harpoon'),
  require('ide.plugins.illuminate'),
  require('ide.plugins.nvim-colorizer'),
  require('ide.plugins.luasnip'),
  -- require('ide.plugins.trouble'),
  (function()
    if os.getenv('WORKSPACE') ~= nil then
      return require('ide.plugins.lsp-zero')
    else
      print('WORKSPACE is not defined')
      return {}
    end
  end)(),
}
