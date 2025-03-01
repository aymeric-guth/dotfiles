return {
  'ledger/vim-ledger',
  -- {
  --   'ecthelionvi/NeoView.nvim',
  --   config = function()
  --     require('NeoView').setup()
  --   end,
  -- },
  require('core.plugins'),
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
  -- (function()
  --   local trouble = require('folke/trouble.nvim')
  --   trouble.setup({})
  -- end)(),
}
