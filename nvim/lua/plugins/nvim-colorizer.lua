return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    -- vim.cmd([[
    --   augroup ColorizeBuffer
    --   autocmd!
    --   au BufRead,BufNewFile * ColorizerAttachToBuffer
    --   augroup END
    -- ]])
    require('colorizer').setup({}, { mode = 'foreground', names = false })
  end,
}
