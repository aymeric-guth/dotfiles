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
  require('plugins.telescope'),
  require('plugins.treesitter'),
  require('plugins.treesitter-context'),
  require('plugins.gitsigns'),
  require('plugins.undotree'),
  require('plugins.lualine'),
  require('plugins.gruvbox-baby'),
  require('plugins.indent-blankline'),
  require('plugins.oil'),
  require('plugins.harpoon'),
  require('plugins.illuminate'),
  require('plugins.nvim-colorizer'),
  require('plugins.luasnip'),
  -- require('plugins.trouble'),
  (function()
    if os.getenv('WORKSPACE') ~= nil then
      return require('plugins.lsp-zero')
    else
      print('WORKSPACE is not defined')
      return {}
    end
  end)(),
}
