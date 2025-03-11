return {
  'tpope/vim-fugitive',
  'windwp/nvim-autopairs',
  -- 'tpope/vim-sleuth',
  -- 'tpope/vim-commentary',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/tokyonight.nvim' },
  -- { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true },
  require('core.plugins.telescope'),
  require('core.plugins.treesitter'),
  require('core.plugins.treesitter-context'),
  require('core.plugins.gitsigns'),
  require('core.plugins.undotree'),
  require('core.plugins.lualine'),
  require('core.plugins.gruvbox-baby'),
  require('core.plugins.indent-blankline'),
  require('core.plugins.oil'),
}
