require('remap')
require('set')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out =
      vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  require('plugins'),
}, {})

-- vim.cmd([[colorscheme retrobox]])
vim.cmd([[colorscheme vague]])

-- LSP
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp
--https://neovim.io/doc/user/news-0.11.html
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    vim.keymap.set(
      'n',
      'gd',
      vim.lsp.buf.definition,
      { buffer = bufnr, remap = false, desc = '[g]o [d]efinition' }
    )
    vim.keymap.set(
      'n',
      'gi',
      vim.lsp.buf.implementation,
      { buffer = bufnr, remap = false, desc = '[g]o [i]mplementation' }
    )
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = 'hover' })
    vim.keymap.set(
      'n',
      '<leader>lws',
      vim.lsp.buf.workspace_symbol,
      { buffer = bufnr, remap = false, desc = '[l]sp [w]ork[s]pace' }
    )
    vim.keymap.set(
      'n',
      '<leader>ld',
      vim.diagnostic.open_float,
      { buffer = bufnr, remap = false, desc = '[l]sp [d]iagnostics' }
    )
    vim.keymap.set(
      'n',
      '[d',
      vim.diagnostic.goto_next,
      { buffer = bufnr, remap = false, desc = '[d] next diagnostic' }
    )
    vim.keymap.set(
      'n',
      ']d',
      vim.diagnostic.goto_prev,
      { buffer = bufnr, remap = false, desc = '[d] prev diagnostic' }
    )
    vim.keymap.set(
      'n',
      '<leader>lca',
      vim.lsp.buf.code_action,
      { buffer = bufnr, remap = false, desc = '[l]sp [c]ode [a]ction' }
    )
    vim.keymap.set(
      'n',
      '<leader>lrr',
      vim.lsp.buf.references,
      { buffer = bufnr, remap = false, desc = '[l]sp [r]efe[r]ences' }
    )
    vim.keymap.set(
      'n',
      '<leader>lrn',
      vim.lsp.buf.rename,
      { buffer = bufnr, remap = false, desc = '[l]sp [r]e[n]ame' }
    )
    vim.keymap.set(
      'n',
      '<leader>ls',
      vim.lsp.buf.signature_help,
      { buffer = bufnr, remap = false, desc = '[l]sp [s]ignature help' }
    )
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
      filter = function(client)
        return client.name ~= 'clangd'
      end,
    })
  end,
})
-- https:// github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.diagnostic.config({ virtual_text = true })
local lspconfig = require('lspconfig')
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--fallback-style=none',
    '--offset-encoding=utf-8',
    '--compile-commands-dir=' .. '"' .. os.getenv('HOME') .. '/baby steps' .. '"',
  },
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
-- vim.lsp.config('lua_ls', {})
-- vim.lsp.config('basedpyright', {})
-- vim.lsp.config('ruff', {})

-- https:// github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
-- https:// github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cppcheck.with({
      extra_args = {
        '--enable=warning,style,performance,portability',
        '--template=gcc',
        '$FILENAME',
      },
    }),
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
vim.lsp.enable('ts_ls')
