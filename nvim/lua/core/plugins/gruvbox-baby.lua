return {
  'luisiacc/gruvbox-baby',
  config = function()
    vim.g.gruvbox_baby_background_color = 'dark'
    vim.g.gruvbox_baby_transparent_mode = true
    vim.g.gruvbox_baby_telescope_theme = true
    vim.cmd([[colorscheme gruvbox-baby]])
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  end,
}
