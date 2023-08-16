return {
  'tpope/vim-fugitive',
  -- 'tpope/vim-sleuth',
  -- 'tpope/vim-commentary',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'luisiacc/gruvbox-baby',
    config = function ()
      vim.g.gruvbox_baby_background_color = 'dark'
      vim.g.gruvbox_baby_transparent_mode = true
      vim.g.gruvbox_baby_telescope_theme = true
      vim.cmd([[colorscheme gruvbox-baby]])
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      -- vim.cmd.colorscheme ''
    end
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox-baby',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   opts = {
  --     char = '┊',
  --     show_trailing_blankline_indent = false,
  --   },
  -- },
  require 'core.plugins.telescope',
  require 'core.plugins.treesitter',
}
