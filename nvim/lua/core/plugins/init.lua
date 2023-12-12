return {
  'tpope/vim-fugitive',
  'windwp/nvim-autopairs',
  -- 'tpope/vim-sleuth',
  -- 'tpope/vim-commentary',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/tokyonight.nvim' },
  require('core.plugins.telescope'),
  require('core.plugins.treesitter'),
  require('core.plugins.gitsigns'),
  require('core.plugins.undotree'),
  require('core.plugins.lualine'),
  require('core.plugins.gruvbox-baby'),
  require('core.plugins.indent-blankline'),
  -- require('core.plugins.nvim-osc52'),
  require('core.plugins.oil'),
}
