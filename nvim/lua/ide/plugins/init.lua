return {
  'renerocksai/telekasten.nvim',
  require('core.plugins'),
  require('ide.plugins.nvim-tree'),
  require('ide.plugins.harpoon'),
  require('ide.plugins.illuminate'),
  require('ide.plugins.nvim-colorizer'),
  require('ide.plugins.goto-preview'),
  (function()
    if os.getenv('WORKSPACE') ~= nil then
      return require('ide.plugins.lsp-zero')
    else
      print('WORKSPACE is not defined')
      return {}
    end
  end)(),
}
