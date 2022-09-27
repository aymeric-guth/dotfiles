local status, null_ls = pcall(require, 'null-ls')
if not status then
  return
end

local handlers = require('av.lsp.handlers')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
-- handlers.capabilities.textDocument.formatting = true
-- handlers.capabilities.offsetEncoding = { 'utf-16' }

local null_ls_opts = {

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

  diagnostics.cppcheck.with({
    filetypes = { 'c', 'cpp' },
    extra_args = {
      '--enable=all',
      -- '--cppcheck-build-dir=$ROOT',
      '--suppress=missingIncludeSystem',
      '--std=c11',
      '--platform=unix64',
    },
  }),

  formatting.black.with({
    filetypes = { 'python' },
    extra_args = { '--fast' },
  }),

  formatting.rustfmt.with({
    filetypes = { 'rust' },
  }),
  formatting.dart_format.with({
    filetypes = { 'dart' },
  }),
  -- formatting.remark.with({
  --   filetypes = { 'markdown' },
  -- }),

  -- formatting.mdformat.with({
  --   filetypes = { 'markdown' },
  -- }),

  -- markdown code-block formatter
  -- formatting.cbfmt.with({
  --   filetypes = { 'markdown' },
  -- }),

  -- diagnostics.markdownlint.with({
  --   filetypes = { 'markdown' },
  -- }),

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
  -- diagnostics.yamllint.with({ filetypes = { 'yaml' } }),
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
