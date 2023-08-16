return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    vim.cmd([[
      augroup ColorizeBuffer
      autocmd!
      au BufRead,BufNewFile * ColorizerAttachToBuffer
      augroup END
    ]])
  end,
}
