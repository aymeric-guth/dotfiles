-- vim.lsp.config['lua-language-server']
-- vim.lsp.config('luals', {})
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim' }, -- Optional
  },
  config = function()
    vim.lsp.enable('lua_ls')
    local lsp_servers = {
      'basedpyright',
      'lua_ls',
      'bashls',
      'dockerls',
      'ansiblels',
      'gopls',
      'golangci_lint_ls',
      'eslint',
      'ts_ls',
      'clangd',
    }
  end
}
