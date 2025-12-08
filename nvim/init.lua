require('remap')
require('set')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  require('plugins'),
}, {})

-- LSP
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp
--https://neovim.io/doc/user/news-0.11.html
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    local clients = vim.lsp.get_clients({ bufnr = args.buf })

    -- for _, client in ipairs(clients) do
    --   vim.notify(client.name, vim.log.levels.ERROR)
    -- end

    vim.lsp.buf.format({
      bufnr = args.buf,
      async = false,
    })
  end,
})
-- https:// github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.diagnostic.config({ virtual_text = true })
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--fallback-style=none' },
  filetypes = { 'c' },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
vim.lsp.config('lua_ls', {})
vim.lsp.config('basedpyright', {})
vim.lsp.config('ruff', {})

-- https:// github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
--https:// github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.astyle.with({
      extra_args = {
        '--options=' .. os.getenv('DOTFILES') .. '/.astylerc',
      },
    }),
    null_ls.builtins.formatting.black,
  },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('basedpyright')
vim.lsp.enable('clangd')
vim.lsp.enable('ruff')
