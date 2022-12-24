local ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not ok then
  error('mason_null_ls is not installed')
  return
end

local servers = {
  'ltrs',
  'astyle',
  'shellcheck',
  'shfmt',
  'cppcheck',
  'black',
  'rustfmt',
  'ruff',
  'prettierd',
  'stylua',
  'taplo',
  'yamllint',
  'hadolint',
  'ansiblelint',
  'cmake_format',
}

require('mason-null-ls').setup({
  ensure_installed = servers,
})

local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local handlers = require('av.lsp.handlers')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
-- handlers.capabilities.textDocument.formatting = true
-- handlers.capabilities.offsetEncoding = { 'utf-16' }

local null_ls_opts = {
  code_actions.ltrs.with({
    filetypes = { 'text', 'markdown' },
  }),

  formatting.astyle.with({
    filetypes = { 'c', 'cpp', 'cxx' },
    extra_args = {
      '--options=' .. require('os').getenv('DOTFILES') .. '/.astylerc',
      -- '--project=none',
    },
  }),

  code_actions.shellcheck.with({
    filetypes = { 'sh' },
  }),

  -- https://github.com/mvdan/sh
  formatting.shfmt.with({
    filetypes = { 'sh' },
  }),

  diagnostics.cppcheck.with({
    filetypes = { 'c', 'cpp' },
    extra_args = {
      '--enable=all',
      -- '--cppcheck-build-dir=$ROOT',
      '--suppress=missingIncludeSystem',
      '--std=c11',
      '--platform=unix64',
      -- '--project=' .. require('os').getenv('WORKSPACE') .. '/build/compile_commands.json',
      -- '--addon=' .. require('os').getenv('DOTFILES') .. '/cppcheck/addons.json',
    },
  }),

  formatting.black.with({
    filetypes = { 'python' },
    extra_args = { '--fast' },
  }),

  formatting.rustfmt.with({
    filetypes = { 'rust' },
  }),

  diagnostics.ruff.with({
    filetypes = { 'python' },
  }),

  formatting.prettierd.with({
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'css',
      'scss',
      'less',
      'html',
      'json',
      'jsonc',
      -- 'yaml',
      -- 'markdown',
      'graphql',
      'handlebars',
    },
  }),

  formatting.stylua.with({
    filetypes = { 'lua' },
  }),

  formatting.taplo.with({ filetypes = { 'toml' } }),
  diagnostics.yamllint.with({ filetypes = { 'yaml' } }),
  diagnostics.hadolint.with({ filetypes = { 'dockerfile' } }),
  diagnostics.ansiblelint.with({ filetypes = { 'yaml.ansible' } }),
  formatting.cmake_format.with({ filetypes = { 'cmake' } }),
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  debug = true,
  capabilities = handlers.capabilities,
  lsp_flags = handlers.lsp_flags,
  sources = null_ls_opts,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWrite', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.format({ bufnr = bufnr })
          -- vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
