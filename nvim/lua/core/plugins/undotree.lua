return {
  'mbbill/undotree',
  config = function()
    -- require('undotree').setup({})
    vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = '[u]ndotree' })
  end,
}
